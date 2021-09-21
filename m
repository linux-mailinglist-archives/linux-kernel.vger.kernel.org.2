Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99641413134
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhIUKG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:06:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38254 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231566AbhIUKFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:05:43 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mScdD-0001rd-Gy; Tue, 21 Sep 2021 12:04:07 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, daniel@ffwll.ch,
        Souptick Joarder <jrdr.linux@gmail.com>, airlied@linux.ie
Cc:     Heiko Stuebner <heiko@sntech.de>,
        kernel test robot <lkp@intel.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] drm/rockchip: remove of_match_ptr() from vop_driver_dt_match
Date:   Tue, 21 Sep 2021 12:03:35 +0200
Message-Id: <163221857585.2031971.3046018534177866323.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210607190800.3992-1-jrdr.linux@gmail.com>
References: <20210607190800.3992-1-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 00:38:00 +0530, Souptick Joarder wrote:
> kernel test robot throws warning when CONFIG_OF not set.
> 
> >> drivers/gpu/drm/rockchip/rockchip_vop_reg.c:1038:34:
> warning: unused variable 'vop_driver_dt_match' [-Wunused-const-variable]
>    static const struct of_device_id vop_driver_dt_match[] = {
> 
> Fixed it by removing of_match_ptr().

Applied, thanks!

[1/1] drm/rockchip: remove of_match_ptr() from vop_driver_dt_match
      commit: 87185cc823693933308bd33a190032e9c262c75f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
