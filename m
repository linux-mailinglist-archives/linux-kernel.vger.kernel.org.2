Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8870447FEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbhKHM6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:58:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238770AbhKHM6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:58:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3F0D610C8;
        Mon,  8 Nov 2021 12:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636376149;
        bh=KBShuSmRq4VtP4VFGYRR4rD6zF5WjNMRIZlMtOiGrnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GALNmkLYjtbgE0rX0pA2PCmPTlzBpShA0SxWZH4YYGPlClFnDol9xXLNUbgp+5Ct6
         pM7khGdh8eHhU5iheRKKlkXN5liJ6MvNYHfXAJO/GkBnjP95xhTulcZlklLobatnbW
         +jp/dbHk43D8hDBefK1RVQYiVsI/3rLEK7kpE678=
Date:   Mon, 8 Nov 2021 13:55:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6IOh5ZCv6IiqKE5pY2sgSHUp?= <huqihang@oppo.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: gadget: composite: Fix null pointer exception
Message-ID: <YYkeUgz1wr4s772X@kroah.com>
References: <20211105104840.159533-1-huqihang@oppo.com>
 <YYUnM0/82FwS5OUE@kroah.com>
 <KU1PR02MB253627CFDBE573DE95F3A09EB0919@KU1PR02MB2536.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KU1PR02MB253627CFDBE573DE95F3A09EB0919@KU1PR02MB2536.apcprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 12:42:24PM +0000, 胡启航(Nick Hu) wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, November 5, 2021 8:45 PM
> > To: 胡启航(Nick Hu) <huqihang@oppo.com>
> > Cc: balbi@kernel.org; peter.chen@kernel.org; linux-usb@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] usb: gadget: composite: Fix null pointer exception
> > 
> > On Fri, Nov 05, 2021 at 06:48:40PM +0800, Qihang Hu wrote:
> > > In the config_ep_by_speed_and_alt function, select the corresponding
> > > descriptor through g->speed, but the function driver may not
> > > support the corresponding speed. So, we need to check whether the
> > > function driver provides the corresponding speed descriptor when
> > > selecting the descriptor.
> > >
> > > [  237.708146]  android_work: sent uevent USB_STATE=CONNECTED
> > > [  237.712464]  kconfigfs-gadget gadget: super-speed config #1: b
> > > [  237.712487]  kUnable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000000
> > 
> > So this is an invalid driver causing this problem?  Or can this be
> > triggered by userspace?
> 
> Yes, if the kernel is loaded with an interface driver that does not support all
> speeds, this problem can be triggered in userspace.

What in-kernel driver does not support all speeds that can trigger this?

Why not fix the drivers?

> > > [  237.712493]  kMem abort info:
> > > [  237.712498]  k  ESR = 0x96000006
> > > [  237.712504]  k  EC = 0x25: DABT (current EL), IL = 32 bits
> > > [  237.712510]  k  SET = 0, FnV = 0
> > > [  237.712515]  k  EA = 0, S1PTW = 0
> > > [  237.712520]  kData abort info:
> > > [  237.712525]  k  ISV = 0, ISS = 0x00000006
> > > [  237.712530]  k  CM = 0, WnR = 0
> > > [  237.712536]  kuser pgtable: 4k pages, 39-bit VAs,
> > pgdp=000000020ef29000
> > > [  237.712541]  k[0000000000000000] pgd=000000020ef2a003,
> > pud=000000020ef2a003, pmd=0000000000000000
> > > [  237.712554]  kInternal error: Oops: 96000006 [#1] PREEMPT SMP
> > > [  237.722067]  kSkip md ftrace buffer dump for: 0x1609e0
> > > [  237.787037]  kWorkqueue: dwc_wq dwc3_bh_work.cfi_jt
> > > [  237.854922]  kpstate: 60c00085 (nZCv daIf +PAN +UAO)
> > > [  237.863165]  kpc : config_ep_by_speed_and_alt+0x90/0x308
> > > [  237.871766]  klr : audio_set_alt+0x54/0x78
> > > [  237.879108]  ksp : ffffffc0104839e0
> > >
> > > Signed-off-by: Qihang Hu <huqihang@oppo.com>
> > 
> > What commit id does this fix?
> 
> I have not submitted a BUG.
> I will study and submit a BUG as soon as possible.

I do not understand what you mean by this.  I am asking what commit
caused this problem so we can mark this one as fixing it.

thnaks,

greg k-h
