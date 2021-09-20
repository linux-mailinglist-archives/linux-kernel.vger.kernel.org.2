Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2D44116F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbhITOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:30:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55144 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237796AbhITOaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:30:22 -0400
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSKHq-0005O5-1O; Mon, 20 Sep 2021 16:28:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] clk: rockchip: rk3399: make CPU clocks critical
Date:   Mon, 20 Sep 2021 16:28:38 +0200
Message-Id: <163214478703.1547258.2785345284675906680.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
References: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021 11:13:38 -0700, Brian Norris wrote:
> The CPU clocks don't currently have any owner (e.g., cpufreq-dt doesn't
> enable() them -- and even if it did, it's not early enough compared to
> other consumers -- nor does arch/arm64/kernel/smp.c), and instead are
> simply assumed to be "on" all the time.
> 
> They are also parents of a few other clocks which haven't been
> previously exposed for other devices to consume. If we want to expose
> those clocks, then the common clock framework may eventually choose to
> disable their parents (including the CPU PLLs) -- which is no fun for
> anyone.
> 
> [...]

Applied, thanks!

[1/3] clk: rockchip: rk3399: make CPU clocks critical
      commit: ef087b7ecf8aaeb08a17ae825f10cd94e116616e
[2/3] clk: rockchip: rk3399: expose PCLK_COREDBG_{B,L}
      commit: bd2c1f664ea647d8f66fbe083f9256511d4f2b9a
[3/3] arm64: dts: rockchip: add Coresight debug range for RK3399
      commit: 75dccea503b8e176ad044175e891d7bb291b6ba0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
