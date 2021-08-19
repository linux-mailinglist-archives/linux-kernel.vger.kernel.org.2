Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5D3F1A25
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbhHSNQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:16:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:37034 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234695AbhHSNQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:16:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="216545076"
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="216545076"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 06:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="471884141"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2021 06:15:41 -0700
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <772e4001-178e-4918-032c-6e625bdded24@ti.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [QUERY] Cold plugged USB device to Inateck PCIE USB card is not
 detected
Message-ID: <970f741a-54ee-0fa7-46d9-51f77764c6bb@linux.intel.com>
Date:   Thu, 19 Aug 2021 16:18:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <772e4001-178e-4918-032c-6e625bdded24@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.8.2021 10.54, Kishon Vijay Abraham I wrote:
> Hi All,
> 
> I was trying to test PCIe USB card (Inateck) connected to AM64 EVM and
> J7200 EVM. Inateck uses Renesas uPD720201 USB3 host controller.
> 
> So if I connect USB pendrive and then boot the board (cold plug), I
> don't see the pendrive getting detected. But if I remove and plug it
> again, it gets detected.
> 
> For the cold plug case, I see this message
> 	"usb usb1-port3: couldn't allocate usb_device"
> 
> It actually fails in
> xhci_alloc_dev()->xhci_queue_slot_control()->queue_command()->XHCI_STATE_HALTED
> 
> I'm not familiar with xhci but it looks like port event is invoked
> before the controller is fully initialized (?).

Maybe this controller is capable of generating interrupts before it's running?
 
> 
> I tried the following hack which kind of changes the sequence where
> xhci_start() and xhci_run_finished() is invoked before port_event() and
> with that I could see the pendrive enumerate successfully in cold plug case.
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 228e3d4e1a9f..d19f27c46c6f 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -1077,7 +1077,7 @@ static void hub_activate(struct usb_hub *hub, enum
> hub_activation_type type)
>                         INIT_DELAYED_WORK(&hub->init_work, hub_init_func2);
>                         queue_delayed_work(system_power_efficient_wq,
>                                         &hub->init_work,
> -                                       msecs_to_jiffies(delay));
> +                                       msecs_to_jiffies(150));
> 
>                         /* Suppress autosuspend until init is done */
>                         usb_autopm_get_interface_no_resume(
> 
> Irrespective of the delay the port status looks correct and the modified
> delay only helps to change the flow.
> 
> Adding other prints and delays also change the sequence and seems to
> detect the connected pendrive.
> 
> Can someone provide hints on how to fix this properly?

Either keep xHC interrupts disabled until second (usb3) hcd is added, and
host is running. (haven't thought about side effects yet)
Or make sure we don't start polling the usb2 roothub until host is running.

Below code should return before port event handler starts roothub polling if 
any xhci->xhc_state flag is set. 
Untested, does it work for you?

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index e676749f543b..9f4cc5c87b27 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2024,6 +2024,8 @@ static void handle_port_status(struct xhci_hcd *xhci,
        if (bogus_port_status)
                return;
 
+       if (xhci->xhc_state != 0)
+               return;
        /*
         * xHCI port-status-change events occur when the "or" of all the
         * status-change bits in the portsc register changes from 0 to 1.
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index f3dabd02382c..b171558956dd 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -646,9 +646,15 @@ int xhci_run(struct usb_hcd *hcd)
         */
 
        hcd->uses_new_polling = 1;
-       if (!usb_hcd_is_primary_hcd(hcd))
-               return xhci_run_finished(xhci);
-
+       if (!usb_hcd_is_primary_hcd(hcd)) {
+               ret = xhci_run_finished(xhci);
+               if (ret)
+                       return ret;
+               /* start polling usb2 roothub */
+               set_bit(HCD_FLAG_POLL_RH, &xhci->main_hcd->flags);
+               usb_hcd_poll_rh_status(xhci->main_hcd);
+               return ret;
+       }
        xhci_dbg_trace(xhci, trace_xhci_dbg_init, "xhci_run");
 
        ret = xhci_try_enable_msi(hcd);

Thanks
-Mathias


