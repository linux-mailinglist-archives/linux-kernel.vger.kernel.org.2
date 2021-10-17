Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A80430C71
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 23:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbhJQVyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 17:54:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54278 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235265AbhJQVyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 17:54:51 -0400
Received: from p508fd4f7.dip0.t-ipconnect.de ([80.143.212.247] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mcE56-0004w2-3u; Sun, 17 Oct 2021 23:52:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: vop: Add timeout for DSP hold
Date:   Sun, 17 Oct 2021 23:52:33 +0200
Message-Id: <163450753814.562592.2607935368161273314.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008153102.1.I2a5dbaaada35023a9703a8db7af501528fbb6e31@changeid>
References: <20211008153102.1.I2a5dbaaada35023a9703a8db7af501528fbb6e31@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 15:31:04 -0700, Brian Norris wrote:
> If hardware is malfunctioning (e.g., misconfigured clocks?), we can get
> stuck here forever, holding various DRM locks and eventually locking up
> the entire system. It's better to complain loudly and move on, than to
> lock up the system.
> 
> In local tests, this operation takes less than 20ms.

Applied, thanks!

[1/1] drm/rockchip: vop: Add timeout for DSP hold
      commit: 085af7d28897deb08a4f64a29e55525f963cc041

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
