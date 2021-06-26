Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED43B4DCC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFZJXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 05:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 05:23:44 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C20C061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5tE7gWvpvwFlyaG2zRUYzBcE9B7dXwCRVgZyQuAA+1k=; b=SyBMxvB2RafWxopZbDER7nZv2
        rWwf/m9jrVM9tPSxLy0FYvUr4vtjcrLfs0qsFb69yN2H32RQpMs+7mO6SK0lSIvPQq580fefQ/uG1
        uGOK3pkHNAOQWFI5S/qlAJHGtyWnRDbgxF6fsn2bESb5QeU38DX33BIPQO/lHY5ls6GiwmWW3+i3d
        CH3DHjtheUWiLXhnfAJizpzvGuN1Qo6HKArk+7ioUzpPL5FVmbC1xavbo9U9KpxWMVA0o/FW6aTFM
        v3L2muixt+zFNcHMnqdk9TfhLmT5RCMf0FzFX7lHnsMGtTRku2pNAY/h0k28ceDdH3Tf+zdy2vwrH
        RxFK8CvPA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45374)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lx4V1-0001d4-Fq; Sat, 26 Jun 2021 10:21:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lx4Uz-0007X1-HF; Sat, 26 Jun 2021 10:21:13 +0100
Date:   Sat, 26 Jun 2021 10:21:13 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jinchao Wang <wjc@cdjrlc.com>
Cc:     guillaume.tucker@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: mm: Prefer unsigned int to bare use of unsigned
Message-ID: <20210626092113.GZ22278@shell.armlinux.org.uk>
References: <20210626065833.6653-1-wjc@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626065833.6653-1-wjc@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 02:58:33PM +0800, Jinchao Wang wrote:
>   * By default, we write directly to secure registers.  Platforms must
>   * override this if they are running non-secure.
>   */
> -static void l2c_write_sec(unsigned long val, void __iomem *base, unsigned reg)
> +static void l2c_write_sec(unsigned long val, void __iomem *base, unsigned int reg)

... and then I'll get another patch because this now goes over 80
characters. No thanks.

There is nothing inherently wrong with "unsigned" - it's always been
legal C, and I'd prefer to keep the code as-is under arch/arm in
regard of this.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
