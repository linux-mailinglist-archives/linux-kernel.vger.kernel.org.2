Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30803F870F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbhHZMPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhHZMPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:15:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2195BC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TRtL4257U7HQ9HSWhs33zhviZUifqBtCKs/0jahRZT4=; b=R6rbC20zVAKo6S7NFA+v+Itej
        uq6GQvVFmRkDKERnaO2juLauqL29bxaIVuHQmWkY09CEdNIw7jTghF1hJkES5ID7cal4+VjrYgwBb
        l565CvpUOlOgliXUqSYMyjlS6RvSiPyudsWRmrLdB+OrPxbJwDwn0EvKV8EpGlx37wGLv4LNLZ6g0
        3ugDKSQnne6BdP53UyN9G1bxPtnECzGFjoShV9mJrEy/FiAPCbjS0D0+pa4GI2lEFld2xqAYcZhLu
        R0vGStupwg1DBpQJv7Fv8RcEFOYnGBaINDlV+4gZwGhiesj+GMOij7j55XhHqChiGds66EFQuLLKi
        rOHlU/dhw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47710)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mJEH6-0007s6-TK; Thu, 26 Aug 2021 13:14:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mJEH4-0000o5-Lj; Thu, 26 Aug 2021 13:14:26 +0100
Date:   Thu, 26 Aug 2021 13:14:26 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Michael Walle <michael@walle.cc>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Lukas F . Hartmann" <lukas@mntre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/3] drm/etnaviv: fix dma configuration of the virtual
 device
Message-ID: <20210826121426.GR22278@shell.armlinux.org.uk>
References: <20210826121006.685257-1-michael@walle.cc>
 <20210826121006.685257-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826121006.685257-3-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 02:10:05PM +0200, Michael Walle wrote:
> +	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(40);
> +	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;

Please use dma_coerce_mask_and_coherent() here instead.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
