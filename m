Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41516394682
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhE1ReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:34:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44424 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhE1ReQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:34:16 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lmgLf-0006NM-DL; Fri, 28 May 2021 19:32:39 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org, Alex Bee <knaerzche@gmail.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: rockchip: export ACLK_VCODEC for RK3036
Date:   Fri, 28 May 2021 19:32:37 +0200
Message-Id: <162222314613.2865009.9291015386212006336.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210528140736.79686-1-knaerzche@gmail.com>
References: <20210528140736.79686-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 16:07:36 +0200, Alex Bee wrote:
> It is required for the series at [1] to let hantro driver aquire the
> clock and set the rate for RK3036 correctly, but I didn't want to
> add a patch for yet another subsystem to this series.
> 
> [1] https://lore.kernel.org/linux-media/20210525152225.154302-1-knaerzche@gmail.com/

Applied, thanks!

[1/1] clk: rockchip: export ACLK_VCODEC for RK3036
      commit: 2adafc0512625bbd090dc37a353ddda15d525e9d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
