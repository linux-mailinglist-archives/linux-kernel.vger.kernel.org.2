Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0B34B81C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhC0QOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 12:14:36 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:37562 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhC0QO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 12:14:28 -0400
X-Greylist: delayed 1135 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Mar 2021 12:14:27 EDT
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.93.0.4)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1lQBHa-0006Gy-JO; Sat, 27 Mar 2021 16:55:26 +0100
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: >20 KB URBs + EHCI = bad performance due to stalls
Message-ID: <6f5be7a5-bf82-e857-5c81-322f2886099a@maciej.szmigiero.name>
Date:   Sat, 27 Mar 2021 16:55:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any specific reason that URBs without URB_SHORT_NOT_OK flag that
span multiple EHCI qTDs have Alternate Next qTD pointer set to the dummy
qTD in their every qTD besides the last one (instead of to the first qTD
of the next URB to that endpoint)?

This causes that endpoint queue to stall in case of a short read that
does not reach the last qTD (I guess this condition persists until an
URB is (re)submitted to that endpoint, but I am not sure here).

One of affected drivers here is drivers/net/usb/r8152.c.

If I simply reduce its per-URB transfer buffer to 20 KB (the maximum
that fits in a well-aligned qTD) the RX rate increases from around
100 Mbps to 200+ Mbps (on an ICH8M controller):
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6554,6 +6556,9 @@
                 break;
         }
  
+       if (tp->udev->speed == USB_SPEED_HIGH)
+               tp->rx_buf_sz = min(tp->rx_buf_sz, (u32)20 * 1024);
+
         return ret;
  }

The driver default is to use 32 KB buffers (which span two qTDs),
but the device rarely fully fills the first qTD resulting in
repetitive stalls and more than halving the performance.

As far as I can see, the relevant code in
drivers/usb/host/ehci-q.c::qh_urb_transaction() predates the git era.
The comment in that function before setting the Alternate Next qTD
pointer:
> /*
>  * short reads advance to a "magic" dummy instead of the next
>  * qtd ... that forces the queue to stop, for manual cleanup.
>  * (this will usually be overridden later.)
>  */

...suggests the idea was to override that pointer when
URB_SHORT_NOT_OK is not set, but this is actually done only for
the last qTD from the URB (also, that's the only one that ends
with interrupt flag set).

Looking at OHCI and UHCI host controller drivers the equivalent
limits seem to be different there (8 KB and 2 KB), while I don't
see any specific limit in the XHCI case.

Because of that variance in the URB buffer limit it seems strange
to me that this should be managed by a particular USB device driver
rather than by the host controller driver, because this would mean
every such driver would need to either use the lowest common
denominator for the URB buffer size (which is very small) or
hardcode the limit for every host controller that the device can
be connected to, which seems a bit inefficient.

Thanks,
Maciej
