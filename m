Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA913F478C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhHWJa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:30:26 -0400
Received: from mail.thorsis.com ([92.198.35.195]:49180 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhHWJaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:30:24 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Aug 2021 05:30:24 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id EFC3C2985;
        Mon, 23 Aug 2021 11:24:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OJWpy4L88Gne; Mon, 23 Aug 2021 11:24:38 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id CE46B29CF; Mon, 23 Aug 2021 11:24:38 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: microchip.com]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rca@thorsis.com
Subject: Enable HSIC Host Port on Atmel/Microchip SAMA5D2
Date:   Mon, 23 Aug 2021 11:24:35 +0200
Message-ID: <2869763.XZdSvA6Ref@ada>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

for a new embedded board featuring a Microchip SAMA5D2 SoC (64 MiB SiP variant 
SAMA5D27C-D5M) we connected the third USB host port (HSIC only) with an 
USB3503 hub chip. This doesn't work out of the box with the Linux kernel 
currently, because neither the SoC nor the kernel does enable the HSIC 
interface by default.

That SoC has three USB host ports, from the SAMA5D2 Series Datasheet [1] I 
learned there's a flag in an EHCI register, which has to be set to enable the 
HSIC interface on port C, the third port. (Section "41.7.14 EHCI: REG08 - HSIC 
Enable/Disable" of the datasheet.) I suppose that register is vendor specific. 
The register definitions in '/include/linux/usb/ehci_def.h' do not contain 
that register.

Where would I add that register definition and set that flag in the kernel 
then?  I suppose in the vendor specific ehci driver?  
That would be 'drivers/usb/host/ehci-atmel.c' right?

Since that feature is optional (other boards don't need to turn on hsic on 
that port), some driver specific new device tree binding would be necessary, 
right?  I suppose that would have to be documented in 'Documentation/
devicetree/bindings/usb/atmel-usb.txt' right? (Or that would have to be 
converted to yaml first?)

Is this the right track?  If yes, I'm going to develop patches for this. 
Otherwise any hint into the right direction are highly appreciated.

FWIW, I'm not the first one struggling [2] with this problem. ;-)

Greets
Alex

[1] https://www.microchip.com/en-us/product/ATSAMA5D27C-D5M#document-table
[2] https://community.atmel.com/forum/sama5d2-using-hsic-under-linux



