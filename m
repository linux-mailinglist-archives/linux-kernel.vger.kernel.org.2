Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B8841312B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhIUKFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:05:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38234 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231587AbhIUKFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:05:40 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mScdC-0001rd-RH; Tue, 21 Sep 2021 12:04:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, daniel@ffwll.ch,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie
Subject: Re: [PATCH] drm/rockchip: dsi: Fix duplicate included linux/phy/phy.h
Date:   Tue, 21 Sep 2021 12:03:33 +0200
Message-Id: <163221857584.2031971.9461320682192946569.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1629454729-108701-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1629454729-108701-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 18:18:49 +0800, Jiapeng Chong wrote:
> Clean up the following includecheck warning:
> 
> ./drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c: linux/phy/phy.h is
> included more than once.

Applied, thanks!

[1/1] drm/rockchip: dsi: Fix duplicate included linux/phy/phy.h
      commit: d90def98f90fb166191f19b41620e1a54b6dac75

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
