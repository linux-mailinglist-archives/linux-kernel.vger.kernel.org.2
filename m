Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B270B3D7CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhG0R4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhG0R4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:56:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5731C6056B;
        Tue, 27 Jul 2021 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408579;
        bh=RLJ9B+ZMQPTAQawfisUEkdnjM42ljoeCVyMcRwPTXbI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jHwQX+EdhqRGjwvha+7pTWs8/ZA5ycszBcfVDtJ4m2KjnPZRWVNb9IvlgGoBKkEFv
         E4qxq0+Bm34U2E1ryvZwFVSGVm91nqdUTQoRyg3GiRPawdt30B0Dk7yZ5MhSCk3YAe
         58Gt9AFv7vpDfZuM6+pEVImlVjShMeM5ZVMGFRhHg4tZ6BB1Tbd40UdJ6AEqAVeiHE
         32QcA27F7O4oLBoi5pNjt0tagKa9Ju2bFHSpSqGbbhQ/DiESbLz8TSS+bXJcSvV9sK
         cpN1MsRh4+WCsDBy4p/8pQXyxUO3Vx2egTY6xgeKXY9pJS5wbF+Zq8tNTwCO8pK/Oh
         jO4cNblMWiYHg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-14-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-14-chun-jie.chen@mediatek.com>
Subject: Re: [v14 13/21] clk: mediatek: Add MT8192 imp i2c wrapper clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Jul 2021 10:56:17 -0700
Message-ID: <162740857718.2368309.6770707590477284935@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:11)
> Add MT8192 imp i2c wrapper clock provider
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
