Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042243946CA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhE1SL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:11:29 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44690 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhE1SL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:11:28 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lmgve-0006Ve-Pv; Fri, 28 May 2021 20:09:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Thomas Hebb <tommyhebb@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] drm/rockchip: dsi: move all lane config except LCDC mux to bind()
Date:   Fri, 28 May 2021 20:09:44 +0200
Message-Id: <162222530163.2887132.15086890641493370565.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <55fe7f3454d8c91dc3837ba5aa741d4a0e67378f.1618797813.git.tommyhebb@gmail.com>
References: <55fe7f3454d8c91dc3837ba5aa741d4a0e67378f.1618797813.git.tommyhebb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Apr 2021 19:04:10 -0700, Thomas Hebb wrote:
> When we first enable the DSI encoder, we currently program some per-chip
> configuration that we look up in rk3399_chip_data based on the device
> tree compatible we match. This data configures various parameters of the
> MIPI lanes, including on RK3399 whether DSI1 is slaved to DSI0 in a
> dual-mode configuration. It also selects which LCDC (i.e. VOP) to scan
> out from.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: dsi: move all lane config except LCDC mux to bind()
      commit: 43c2de1002d2b70fb5941fa14e97a34e3dc214d4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
