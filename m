Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287F23F2BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbhHTMTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:19:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35690 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbhHTMTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:19:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KCIVU4058964;
        Fri, 20 Aug 2021 07:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629461911;
        bh=a2WPjECC51j4JAWenHsU4+dfR+3Ly43nrbVn+HUqc94=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NmyrPf3hsqlu4k7d95GoBCbHFx+zkxDOEs0yC1xG69/LiUsqDde2nzI9LF1bn2uGp
         QDJvfu+9vMXiJEm35SieDLhVaX/9norQorFOHYRv2rEhoL3x39IGW65thDA42U9rbC
         mV5mw/8OaU98XuPqhd13h/Sln0N2g2vryGxQHP+E=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KCIVCJ061677
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 07:18:31 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 07:18:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 07:18:30 -0500
Received: from [10.250.233.225] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KCIS8l051288;
        Fri, 20 Aug 2021 07:18:28 -0500
Subject: Re: [QUERY] Cold plugged USB device to Inateck PCIE USB card is not
 detected
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <772e4001-178e-4918-032c-6e625bdded24@ti.com>
 <970f741a-54ee-0fa7-46d9-51f77764c6bb@linux.intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <33309da8-b567-55a9-64cf-2f431648960a@ti.com>
Date:   Fri, 20 Aug 2021 17:48:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <970f741a-54ee-0fa7-46d9-51f77764c6bb@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 19/08/21 6:48 pm, Mathias Nyman wrote:
> On 19.8.2021 10.54, Kishon Vijay Abraham I wrote:
>> Hi All,
>>
>> I was trying to test PCIe USB card (Inateck) connected to AM64 EVM and
>> J7200 EVM. Inateck uses Renesas uPD720201 USB3 host controller.
>>
>> So if I connect USB pendrive and then boot the board (cold plug), I
>> don't see the pendrive getting detected. But if I remove and plug it
>> again, it gets detected.
>>
>> For the cold plug case, I see this message
>> 	"usb usb1-port3: couldn't allocate usb_device"
>>
>> It actually fails in
>> xhci_alloc_dev()->xhci_queue_slot_control()->queue_command()->XHCI_STATE_HALTED
>>
>> I'm not familiar with xhci but it looks like port event is invoked
>> before the controller is fully initialized (?).
> 
> Maybe this controller is capable of generating interrupts before it's running?

I don't see any MSI interrupts being raised actually..

512:          0          0   ITS-MSI 524288 Edge      xhci_hcd
513:          0          0   ITS-MSI 524289 Edge      xhci_hcd
514:          0          0   ITS-MSI 524290 Edge      xhci_hcd
>  
>>
>> I tried the following hack which kind of changes the sequence where
>> xhci_start() and xhci_run_finished() is invoked before port_event() and
>> with that I could see the pendrive enumerate successfully in cold plug case.
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index 228e3d4e1a9f..d19f27c46c6f 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -1077,7 +1077,7 @@ static void hub_activate(struct usb_hub *hub, enum
>> hub_activation_type type)
>>                         INIT_DELAYED_WORK(&hub->init_work, hub_init_func2);
>>                         queue_delayed_work(system_power_efficient_wq,
>>                                         &hub->init_work,
>> -                                       msecs_to_jiffies(delay));
>> +                                       msecs_to_jiffies(150));
>>
>>                         /* Suppress autosuspend until init is done */
>>                         usb_autopm_get_interface_no_resume(
>>
>> Irrespective of the delay the port status looks correct and the modified
>> delay only helps to change the flow.
>>
>> Adding other prints and delays also change the sequence and seems to
>> detect the connected pendrive.
>>
>> Can someone provide hints on how to fix this properly?
> 
> Either keep xHC interrupts disabled until second (usb3) hcd is added, and
> host is running. (haven't thought about side effects yet)
> Or make sure we don't start polling the usb2 roothub until host is running.
> 
> Below code should return before port event handler starts roothub polling if 
> any xhci->xhc_state flag is set. 
> Untested, does it work for you?

I still see the issue. When root hub is polled again in your code
snippet, PORT_CSC is not set and xhci_hub_status_data() returns 0.

I've printed port status in xhci_hub_status_data() below

[    7.422124] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    7.482282] xhci_hcd 0000:01:00.0: new USB bus registered, assigned
bus number 1
[    7.596587] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version
0x100 quirks 0x0000001100000410
[    7.679626] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.14
[    7.747969] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    7.885643] usb usb1: Product: xHCI Host Controller
[    7.974816] usb usb1: Manufacturer: Linux
5.14.0-rc4-80127-gf061ccba1dcc-dirty xhci-hcd
[    8.004951] usb usb1: SerialNumber: 0000:01:00.0
[    8.016014] hub 1-0:1.0: USB hub found
[    8.020047] hub 1-0:1.0: 4 ports detected
[    8.068702] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    8.142741] xhci_hcd 0000:01:00.0: new USB bus registered, assigned
bus number 2
[    8.196053] usb usb1-port3: couldn't allocate usb_device
[    8.201665] xhci_hub_status_data port=0 status=a0002a0
[    8.206832] xhci_hub_status_data port=1 status=a0002a0
[    8.211977] xhci_hub_status_data port=2 status=c0002e1
[    8.217117] xhci_hub_status_data port=3 status=a0002a0
[    8.259972] xhci_hcd 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[    8.344124] xhci_hub_status_data port=0 status=a0002a0
[    8.349296] xhci_hub_status_data port=1 status=a0002a0
[    8.354439] xhci_hub_status_data port=2 status=c0002e1
[    8.359582] xhci_hub_status_data port=3 status=a0002a0
[    8.458489] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    8.531363] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.14
[    8.559934] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    8.613931] usb usb2: Product: xHCI Host Controller
[    8.695966] usb usb2: Manufacturer: Linux
5.14.0-rc4-80127-gf061ccba1dcc-dirty xhci-hcd
[    8.805694] usb usb2: SerialNumber: 0000:01:00.0
[    8.848261] hub 2-0:1.0: USB hub found
[    8.905741] hub 2-0:1.0: 4 ports detected
[    8.986168] xhci_hub_status_data port=0 status=a0002a0
[    8.991334] xhci_hub_status_data port=1 status=a0002a0
[    8.996477] xhci_hub_status_data port=2 status=a0002a0
[    9.001616] xhci_hub_status_data port=3 status=a0002a0


I'm unable to get the initial port status in the same run, but on a
different run, the initial port status value looks okay

[    9.603444] xhci_hcd 0000:01:00.0: Get port status 1-1 read: 0x2a0,
return 0x100
[    9.611144] xhci_hcd 0000:01:00.0: Get port status 1-2 read: 0x2a0,
return 0x100
[    9.618832] xhci_hcd 0000:01:00.0: Get port status 1-3 read: 0x202e1,
return 0x10101
[    9.626851] xhci_hcd 0000:01:00.0: Get port status 1-4 read: 0x2a0,
return 0x100

Sometime later the port status changes to c0002e1 (not sure what leads
to it).

As an experiment I added PORT_CONNECT to "mask" in
xhci_hub_status_data() and the device seem to get detected after
multiple "usb usb1-port3: couldn't allocate usb_device". But haven't
tested this extensively and also not sure if there are any side effects.

Thanks
Kishon
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index e676749f543b..9f4cc5c87b27 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -2024,6 +2024,8 @@ static void handle_port_status(struct xhci_hcd *xhci,
>         if (bogus_port_status)
>                 return;
>  
> +       if (xhci->xhc_state != 0)
> +               return;
>         /*
>          * xHCI port-status-change events occur when the "or" of all the
>          * status-change bits in the portsc register changes from 0 to 1.
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index f3dabd02382c..b171558956dd 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -646,9 +646,15 @@ int xhci_run(struct usb_hcd *hcd)
>          */
>  
>         hcd->uses_new_polling = 1;
> -       if (!usb_hcd_is_primary_hcd(hcd))
> -               return xhci_run_finished(xhci);
> -
> +       if (!usb_hcd_is_primary_hcd(hcd)) {
> +               ret = xhci_run_finished(xhci);
> +               if (ret)
> +                       return ret;
> +               /* start polling usb2 roothub */
> +               set_bit(HCD_FLAG_POLL_RH, &xhci->main_hcd->flags);
> +               usb_hcd_poll_rh_status(xhci->main_hcd);
> +               return ret;
> +       }
>         xhci_dbg_trace(xhci, trace_xhci_dbg_init, "xhci_run");
>  
>         ret = xhci_try_enable_msi(hcd);
> 
> Thanks
> -Mathias
> 
> 
