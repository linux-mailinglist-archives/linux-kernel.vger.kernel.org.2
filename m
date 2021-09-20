Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121974116FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbhITOaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:30:35 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55170 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240391AbhITOaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:30:25 -0400
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSKHs-0005O5-GY; Mon, 20 Sep 2021 16:28:52 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: rockchip: use module_platform_driver_probe
Date:   Mon, 20 Sep 2021 16:28:47 +0200
Message-Id: <163214478703.1547258.17263307131653841411.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210904152856.31946-1-miles.chen@mediatek.com>
References: <20210904152856.31946-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sep 2021 23:28:56 +0800, Miles Chen wrote:
> Replace builtin_platform_driver_probe with module_platform_driver_probe
> because that rk3399 and rk3568 can be built as kernel modules.

Applied, thanks!

[1/1] clk: rockchip: use module_platform_driver_probe
      commit: bb232c4c2a4bcab2ceff494a6d3b0869601f06d1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
