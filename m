Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F37323376
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhBWVuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:50:24 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33026 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231721AbhBWVuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:50:21 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lEfYm-0004jo-2o; Tue, 23 Feb 2021 22:49:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com, sam@ravnborg.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: kd35t133: allow using non-continuous dsi clock
Date:   Tue, 23 Feb 2021 22:49:32 +0100
Message-Id: <161411675671.3338515.6891041836727195011.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210206135020.1991820-1-heiko@sntech.de>
References: <20210206135020.1991820-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Feb 2021 14:50:20 +0100, Heiko Stuebner wrote:
> The panel is able to work when dsi clock is non-continuous, thus
> the system power consumption can be reduced using such feature.
> 
> Add MIPI_DSI_CLOCK_NON_CONTINUOUS to panel's mode_flags.
> 
> Also the flag actually becomes necessary after
> commit c6d94e37bdbb ("drm/bridge/synopsys: dsi: add support for non-continuous HS clock")
> and without it the panel only emits stripes instead of output.

Applied, thanks!

[1/1] drm/panel: kd35t133: allow using non-continuous dsi clock
      commit: 54dab3a718f7094532daf7d25cd14121a0e00e34

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
