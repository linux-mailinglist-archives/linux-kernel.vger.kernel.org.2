Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47582413133
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhIUKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:06:22 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38256 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231593AbhIUKFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:05:43 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mScdD-0001rd-SG; Tue, 21 Sep 2021 12:04:07 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, daniel@ffwll.ch,
        Souptick Joarder <jrdr.linux@gmail.com>, airlied@linux.ie
Cc:     Heiko Stuebner <heiko@sntech.de>,
        kernel test robot <lkp@intel.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] drm/rockchip: remove of_match_ptr()
Date:   Tue, 21 Sep 2021 12:03:36 +0200
Message-Id: <163221857585.2031971.13481757624811469468.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210607184836.3502-1-jrdr.linux@gmail.com>
References: <20210607184836.3502-1-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 00:18:36 +0530, Souptick Joarder wrote:
> Kernel test robot throws below warning when CONFIG_OF
> is not set.
> 
> >> drivers/gpu/drm/rockchip/analogix_dp-rockchip.c:457:34:
> warning: unused variable 'rockchip_dp_dt_ids' [-Wunused-const-variable]
>    static const struct of_device_id rockchip_dp_dt_ids[] = {
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: remove of_match_ptr()
      commit: f7fc7a79bdbf20f2edef69dc62666a4f0cdac0e3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
