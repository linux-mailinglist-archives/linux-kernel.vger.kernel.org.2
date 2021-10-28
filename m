Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1041243E547
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhJ1Pif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJ1Pid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:38:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64878C061570;
        Thu, 28 Oct 2021 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=obEVRh2SUyKsH6wuRZ+MmeBmZXXQKS44Jmrm2Q2wynI=; b=U/Fj/4zSFAfu3ihra5R0kzvttB
        XGcVAR8aLmLHPrjVzDXTsP7lZZEKYxdFievSQRbR5RMKbt8Yu/ZRuc8yYbAUBEzr/7oTN79aMIKXK
        rPEXXE09QDGjMZ1BM9zhfBnfKmg8nY00Zqzrm9m6lIDjIyymDCD0q0pwEEukI8ghiWm2zZy/HuIZT
        boGw9j9RAMlBkz00H0+8QIGhaKxLDDPF2XJildRKicdgzYTY7PXIMkiix1AsCt8eMN4ajOM5gGuEI
        JCbxWGa6C6y5Y2qPSHILdWzOXHAlaZaxtDy5TB7jIv/SkQFgurik7tg5FNImCmARI0g4Gu3MR5p9r
        gDq03WsA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55356)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mg7RQ-0007ix-SD; Thu, 28 Oct 2021 16:35:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mg7RM-0000Rz-JC; Thu, 28 Oct 2021 16:35:40 +0100
Date:   Thu, 28 Oct 2021 16:35:40 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/13] arm: drop an obsolete ifdef with the removed
 config PCI_HOST_ITE8152
Message-ID: <YXrDTMLBAy0Ftai/@shell.armlinux.org.uk>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-5-lukas.bulwahn@gmail.com>
 <CAK8P3a2LhGWer=GXMW_KT-8=nqBeS0xhu6si7Z57WAF0wE_TUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2LhGWer=GXMW_KT-8=nqBeS0xhu6si7Z57WAF0wE_TUA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 04:46:38PM +0200, Arnd Bergmann wrote:
> On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit 6da5238fa384 ("ARM: 8993/1: remove it8152 PCI controller driver")
> > removes the config PCI_HOST_ITE8152, but left a dangling obsolete ifndef
> > in ./arch/arm/kernel/bios32.c.
> >
> > Hence, ./scripts/checkkconfigsymbols.py warns:
> >
> > PCI_HOST_ITE8152
> > Referencing files: arch/arm/kernel/bios32.c
> >
> > Remove this obsolete ifndef.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I wonder if we should just remove this function and use the
> (non-empty) default version instead.
> 
> 96c5590058d7 ("PCI: Pull PCI 'latency timer' setup up into the core")
> introduced that generic version, and I suspect the arm version
> was left out by mistake, but it's not clear from that patch.

That was because PCI_HOST_ITE8152 needed something different from the
"do nothing" default (setting the PCI latency timer to default to 64
as the new generic code did.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
