Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4132030EE0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhBDIJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhBDII4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:08:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E88C64E31;
        Thu,  4 Feb 2021 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612426096;
        bh=DSGc+cN3pkKMpvffVQy2duWfgDyA4dJ72Yyh5aV+ZmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iA3HRQpiZlRZI3UoewYuBcvSKIXBbIkc2GCrtw5KQ6or7oxrpPAuCyX3rrhWCghZx
         7swPR9FPU+zM2FTTnTTqK41pPCLqeMooWDq7C20XVEEzw4wVF2LxIHqwfvAum0Yfll
         Ou+xYWTlNVdF0+c11GIgcvWDknzkEuqYoUsyI9HjYTsTbMiAFQOvyOYVx/dZ0Un2DE
         cEMBYCKLJLDl4+DXb3wfChvi7TW7WWbk3rqs1/0SelDVh4f0J1XxZZh5g47u8Iaop+
         yvj0999T2+Ye5SNa+HZIaz5uENYt//0mL76rn00tLHajTYW4z8sMYzrrJYyT3Zhtzr
         iW5mRrVC3pi/w==
Date:   Thu, 4 Feb 2021 13:38:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] phy: mediatek: Add missing MODULE_DEVICE_TABLE()
Message-ID: <20210204080812.GO3079@vkoul-mobl.Dlink>
References: <20210203110631.686003-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203110631.686003-1-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-02-21, 12:06, Enric Balletbo i Serra wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> This patch adds the missing MODULE_DEVICE_TABLE definitions on different
> Mediatek phy drivers which generates correct modalias for automatic loading
> when these drivers are compiled as an external module.

Applied, thanks

-- 
~Vinod
