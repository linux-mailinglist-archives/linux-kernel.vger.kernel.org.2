Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642CF379C51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhEKB4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhEKB43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:56:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D97236147E;
        Tue, 11 May 2021 01:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620698124;
        bh=26hn+0kOgqaRBLID4DhwQ54tAZJRkx9R8d5RuUNnH28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xenllyu5mTFYA9dun8KMT8Jjq2SVYyfHS7Zk2R+sw937wxrA+WtFWCUecKyHOEwku
         JDAi7nxCm0kxKk8U9XEUp3GJkuHqJMB+zCVU2yRTM3vUDc43S5HJwjyi/lh9KufBBK
         MVg9BDEodJYf55PB1FrciMZesuvyiA9n9IBbTndgZJUw9/IiwkojqcV0JmnR43bZHZ
         dlWHId+ABSc2b4qwUrp7WRLw/oWbEGaA6KYY31j7y0x4O8eF3Fk+axLSmmpMXwLNZj
         wmY+CgB+QjhJ8SQBM6P65PM0weBZtT/+sgd2YBnrRggrLIXWYznL9sZ8XVAnQh14Qj
         u0AH6gaJBrNng==
Date:   Tue, 11 May 2021 09:55:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alice Guo <alice.guo@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Li Jun <jun.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Teresa Remmet <t.remmet@phytec.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mp: add flexspi node
Message-ID: <20210511015516.GA3425@dragon>
References: <20210309053116.1486347-1-hs@denx.de>
 <20210309053116.1486347-4-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309053116.1486347-4-hs@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:31:15AM +0100, Heiko Schocher wrote:
> add node for the flexspi modul on imx8mp.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>

Applied #3 and #4, thanks.
