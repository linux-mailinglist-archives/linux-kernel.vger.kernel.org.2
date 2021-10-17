Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0207F430C73
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 23:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbhJQVyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 17:54:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54282 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235265AbhJQVyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 17:54:53 -0400
Received: from p508fd4f7.dip0.t-ipconnect.de ([80.143.212.247] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mcE56-0004w2-Eg; Sun, 17 Oct 2021 23:52:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Thomas Hebb <tommyhebb@gmail.com>,
        aleksandr.o.makarov@gmail.com, linux-rockchip@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Fix Rockchip MIPI DSI display init timeouts
Date:   Sun, 17 Oct 2021 23:52:34 +0200
Message-Id: <163450753815.562592.9456022037085526003.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928213552.1001939-1-briannorris@chromium.org>
References: <20210928213552.1001939-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 14:35:48 -0700, Brian Norris wrote:
> The Rockchip DSI driver has had a number of bugs over time and has
> usually only worked by chance. A number of users have noticed that
> things regressed with commit 43c2de1002d2 ("drm/rockchip: dsi: move all
> lane config except LCDC mux to bind()"), although it was fixing several
> real issues of its own that had been present forever in the upstream
> driver (but notably, not in the downstream/BSP driver).
> 
> [...]

Applied, thanks!

[1/4] drm/rockchip: dsi: Hold pm-runtime across bind/unbind
      commit: 514db871922f103886ad4d221cf406b4fcc5e74a
[2/4] drm/rockchip: dsi: Reconfigure hardware on resume()
      commit: e584cdc1549932f87a2707b56bc588cfac5d89e0
[3/4] drm/rockchip: dsi: Fix unbalanced clock on probe error
      commit: 251888398753924059f3bb247a44153a2853137f
[4/4] drm/rockchip: dsi: Disable PLL clock on bind error
      commit: 5a614570172e1c9f59035d259dd735acd4f1c01b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
