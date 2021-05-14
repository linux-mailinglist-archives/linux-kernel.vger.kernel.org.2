Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09911380923
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhENMHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:07:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43890 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231394AbhENMHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:07:16 -0400
Received: from p5b127fa9.dip0.t-ipconnect.de ([91.18.127.169] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lhWZq-0002WL-OD; Fri, 14 May 2021 14:05:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     mturquette@baylibre.com,
        "Elaine@vger.kernel.org" <Elaine@vger.kernel.org>, sboyd@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-clk@vger.kernel.org, kever.yang@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        linux-kernel@vger.kernel.org, finley.xiao@rock-chips.com,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1] clk: rockchip: Optimize PLL table memory usage
Date:   Fri, 14 May 2021 14:05:56 +0200
Message-Id: <162099394917.1964929.5627318553471535848.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210511090726.15146-1-zhangqing@rock-chips.com>
References: <20210511090726.15146-1-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 17:07:26 +0800, Elaine@vger.kernel.org wrote:
> Before the change: The sizeof rk3568_pll_rates = 2544
> Use union: The sizeof rk3568_pll_rates = 1696
> 
> In future Soc, more PLL types will be added, and the
> rockchip_pll_rate_table will add more members,
> and the space savings will be even more pronounced
> by using union.

Applied, thanks!

[1/1] clk: rockchip: Optimize PLL table memory usage
      commit: 23029150a05b59ebacca6dd76f6c14dc67a95877

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
