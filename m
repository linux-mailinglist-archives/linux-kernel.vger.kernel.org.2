Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF21230AAB2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhBAPNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhBAPMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:12:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF28664E95;
        Mon,  1 Feb 2021 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612192316;
        bh=plbbhmJLAvPKBd3qsUegFrmdMR5VaLf7V7igSN1vMK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6xWdDyLnnKHqrykiXwGTUHf2qcZbe5KXMOkxBF/tjri3Ehx0z3UqPwLVaWaqdbk2
         TZphkq3gj5xPtVdA4dqCMTFGUl8t8w073x05q6IU6/44ZEndwG4eciCGwKv2GxzOIX
         xny6g0/CanaAu6pmn1rsXP8zXhuMgfS4OeZRLY4dThoUTus4CGwLBlwYfn1ZRTjhX9
         pUC44j5+zVKvDHKBekTB+O/bfR142ULzUnOCMXneCB8wmpqAfcFhFWRM2w48XY6KDQ
         MUOSJnjtjGCEBHb946LsyA++DEhSg3aEKYHDveW9u42KgrDKBtY4/8bNBirPVmHV/I
         CRExGulIElu7g==
Received: by pali.im (Postfix)
        id 6FD1F872; Mon,  1 Feb 2021 16:11:53 +0100 (CET)
Date:   Mon, 1 Feb 2021 16:11:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Peter Chen <peter.chen@nxp.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: host: xhci-plat: fix support for
 XHCI_SKIP_PHY_INIT quirk
Message-ID: <20210201151153.zhk4tq5a3irnkahd@pali>
References: <20201221150903.26630-1-pali@kernel.org>
 <20201223161847.10811-1-pali@kernel.org>
 <20201224055836.GB27629@b29397-desktop>
 <20210113232057.niqamgsqlaw7gojw@pali>
 <88b48c61-65e4-cc24-d90d-5fba92f05f27@linux.intel.com>
 <20210125142028.th4sscs27arhihm2@pali>
 <TY2PR01MB369295E3D3BF6D5700EC50CCD8BC0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <20210126090606.svpamobnrbdxyhgg@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126090606.svpamobnrbdxyhgg@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 January 2021 10:06:06 Pali Rohár wrote:
> On Tuesday 26 January 2021 04:27:37 Yoshihiro Shimoda wrote:
> > Hi Pali,
> > > > I can see the benefit in this.
> > > > In the xhci-plat case usb_create_hcd and usb_add_hcd are separate steps, and
> > > > we could both copy the xhci_plat_priv .quirks and run the .init_qurks before
> > > > adding the hcd.
> > > > I guess the current way is inherited from pci case where the earliest place
> > > > to do this after hcd is created is the hcd->driver->reset callback (which is
> > > > set to xhci_pci_setup() or xhci_plat_setup()).
> > > >
> > > > xhci-rcar.c is using the .init_quirk to load firmware, we need to check with
> > > > them if this change is ok. (added Yoshihiro Shimoda to cc)
> > > 
> > > Yoshihiro, is this change OK?
> > > 
> > > Can we move forward? I really need to now how to handle regression in
> > > xhci-mvebu driver. And one option is with this patch...
> > 
> > Thank you for asking me about this topic. I tested the patch, but unfortunately,
> > this patch is possible to break a rcar platform because a phy initialization is
> > needed before the firmware loading if the platform uses the phy. (Note that
> > upstream code (salvator-common.dtsi) doesn't use the phy for xhci. But,
> > if we use the phy on other board with this patch, the xhci will not work.)
> > 
> > So, I think we need to add a new function pointer for your case.
> 
> Ok, thank you for testing! I will try to come up with other solution to
> mentioned mvebu-xhci issue.

Hello! New version of this patch is in following thread, please review it:
"[PATCH v2] usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720"
https://lore.kernel.org/linux-usb/20210201150803.7305-1-pali@kernel.org/

> > Best regards,
> > Yoshihiro Shimoda
> > 
> > > > Their firmware would be loaded before phy parts are initialized, usb bus
> > > > registered, or roothub device allocated.
> > > >
> > > > Thanks
> > > > -Mathias
