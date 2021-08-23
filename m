Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207173F4C08
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhHWOBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:01:36 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36721 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229755AbhHWOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:01:36 -0400
Received: (qmail 121444 invoked by uid 1000); 23 Aug 2021 10:00:52 -0400
Date:   Mon, 23 Aug 2021 10:00:52 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Alexander Dahl <ada@thorsis.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rca@thorsis.com
Subject: Re: Enable HSIC Host Port on Atmel/Microchip SAMA5D2
Message-ID: <20210823140052.GA120849@rowland.harvard.edu>
References: <2869763.XZdSvA6Ref@ada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2869763.XZdSvA6Ref@ada>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 11:24:35AM +0200, Alexander Dahl wrote:
> Hello,
> 
> for a new embedded board featuring a Microchip SAMA5D2 SoC (64 MiB SiP variant 
> SAMA5D27C-D5M) we connected the third USB host port (HSIC only) with an 
> USB3503 hub chip. This doesn't work out of the box with the Linux kernel 
> currently, because neither the SoC nor the kernel does enable the HSIC 
> interface by default.
> 
> That SoC has three USB host ports, from the SAMA5D2 Series Datasheet [1] I 
> learned there's a flag in an EHCI register, which has to be set to enable the 
> HSIC interface on port C, the third port. (Section "41.7.14 EHCI: REG08 - HSIC 
> Enable/Disable" of the datasheet.) I suppose that register is vendor specific. 
> The register definitions in '/include/linux/usb/ehci_def.h' do not contain 
> that register.
> 
> Where would I add that register definition and set that flag in the kernel 
> then?  I suppose in the vendor specific ehci driver?  
> That would be 'drivers/usb/host/ehci-atmel.c' right?

That is where you would set the flag.  You might want to put the 
register definition in ehci_def.h, with the other definitions.

> Since that feature is optional (other boards don't need to turn on hsic on 
> that port), some driver specific new device tree binding would be necessary, 
> right?  I suppose that would have to be documented in 'Documentation/
> devicetree/bindings/usb/atmel-usb.txt' right? (Or that would have to be 
> converted to yaml first?)

Yes, it would have to go into the device tree data somehow.  I don't 
know the best way to do this; people who know more about DT may be able 
to tell you.

> Is this the right track?  If yes, I'm going to develop patches for this. 
> Otherwise any hint into the right direction are highly appreciated.

Yes, this is the right approach.

Alan Stern

> FWIW, I'm not the first one struggling [2] with this problem. ;-)
> 
> Greets
> Alex
> 
> [1] https://www.microchip.com/en-us/product/ATSAMA5D27C-D5M#document-table
> [2] https://community.atmel.com/forum/sama5d2-using-hsic-under-linux
