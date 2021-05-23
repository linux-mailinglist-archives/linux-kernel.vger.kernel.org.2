Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BB338DE31
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 01:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhEWXwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 19:52:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36960 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231982AbhEWXwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 19:52:50 -0400
Received: from p5b127ecf.dip0.t-ipconnect.de ([91.18.126.207] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lkxsF-0003D5-NC; Mon, 24 May 2021 01:51:11 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: fix rk3568 cpll clk gate bits
Date:   Mon, 24 May 2021 01:51:10 +0200
Message-Id: <162181382840.2545380.4133939469375306641.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210519174149.3691335-1-pgwipeout@gmail.com>
References: <20210519174149.3691335-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 13:41:49 -0400, Peter Geis wrote:
> The cpll clk gate bits had an ordering issue. This led to the loss of
> the boot sdmmc controller when the gmac was shut down with:
> `ip link set eth0 down`
> as the cpll_100m was shut off instead of the cpll_62p5.
> cpll_62p5, cpll_50m, cpll_25m were all off by one with cpll_100m
> misplaced.
> 
> [...]

Applied, thanks!

[1/1] clk: rockchip: fix rk3568 cpll clk gate bits
      commit: 2f3877d609e7951ef96d24979eb9d163f1f004f8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
