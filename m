Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B673F1492
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhHSHy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:54:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57896 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhHSHy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:54:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17J7sHph119008;
        Thu, 19 Aug 2021 02:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629359657;
        bh=g3NA6TAPmHsiOTu/kQX02ombBmyI8/kC8+scYqlO3kY=;
        h=From:Subject:To:CC:Date;
        b=W04yU6PKB7X++RGrH1xa4JXi8RGK7JPiZ75OIxCeyh8XDpCfa1MnW2KBmBis9LN+S
         PQyn48urUa1Hy7eYxD0k/ore2Gt8m6AYc0Em+5vO+NeFGt9RYWWlWIS1k0GXbxvreD
         i33WBZLrpK4a7VrhH+p3CWIJXKBvFIjbg9U25NLk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17J7sHSj120360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Aug 2021 02:54:17 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 02:54:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 19 Aug 2021 02:54:17 -0500
Received: from [10.250.232.210] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17J7sEnS054719;
        Thu, 19 Aug 2021 02:54:15 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
Subject: [QUERY] Cold plugged USB device to Inateck PCIE USB card is not
 detected
To:     Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <772e4001-178e-4918-032c-6e625bdded24@ti.com>
Date:   Thu, 19 Aug 2021 13:24:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I was trying to test PCIe USB card (Inateck) connected to AM64 EVM and
J7200 EVM. Inateck uses Renesas uPD720201 USB3 host controller.

So if I connect USB pendrive and then boot the board (cold plug), I
don't see the pendrive getting detected. But if I remove and plug it
again, it gets detected.

For the cold plug case, I see this message
	"usb usb1-port3: couldn't allocate usb_device"

It actually fails in
xhci_alloc_dev()->xhci_queue_slot_control()->queue_command()->XHCI_STATE_HALTED

I'm not familiar with xhci but it looks like port event is invoked
before the controller is fully initialized (?).

I tried the following hack which kind of changes the sequence where
xhci_start() and xhci_run_finished() is invoked before port_event() and
with that I could see the pendrive enumerate successfully in cold plug case.

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 228e3d4e1a9f..d19f27c46c6f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1077,7 +1077,7 @@ static void hub_activate(struct usb_hub *hub, enum
hub_activation_type type)
                        INIT_DELAYED_WORK(&hub->init_work, hub_init_func2);
                        queue_delayed_work(system_power_efficient_wq,
                                        &hub->init_work,
-                                       msecs_to_jiffies(delay));
+                                       msecs_to_jiffies(150));

                        /* Suppress autosuspend until init is done */
                        usb_autopm_get_interface_no_resume(

Irrespective of the delay the port status looks correct and the modified
delay only helps to change the flow.

Adding other prints and delays also change the sequence and seems to
detect the connected pendrive.

Can someone provide hints on how to fix this properly?

Thanks in advance!

Regards
Kishon

