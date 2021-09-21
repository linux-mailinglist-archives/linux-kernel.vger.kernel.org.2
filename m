Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA00413132
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhIUKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:06:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38244 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231635AbhIUKFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:05:41 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mScdE-0001rd-Hx; Tue, 21 Sep 2021 12:04:08 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andy.yan@rock-chips.com>, Alex Bee <knaerzche@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Daniel Vetter <daniel@ffwll.ch>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan McDowell <noodles@earth.li>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] drm/rockchip: handle non-platform devices in rockchip_drm_endpoint_is_subdriver
Date:   Tue, 21 Sep 2021 12:03:38 +0200
Message-Id: <163221857584.2031971.6026620150373954389.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210914150756.85190-1-knaerzche@gmail.com>
References: <20210914150756.85190-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 17:07:56 +0200, Alex Bee wrote:
> As discussed at [1] rockchip_drm_endpoint_is_subdriver will currently always
> return -ENODEV for non-platform-devices (e.g. external i2c bridges), what
> makes them never being considered in rockchip_rgb_init.
> 
> As suggested at [1] this additionally adds a of_device_is_available for
> the node found, which will work for both platform and non-platform devices.
> Also we can return early for non-platform-devices if they are enabled,
> as rockchip_sub_drivers contains exclusively platform-devices.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: handle non-platform devices in rockchip_drm_endpoint_is_subdriver
      commit: 37825e07ab413187e1ea078bc33dcdb835008be2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
