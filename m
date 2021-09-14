Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE140BB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhINWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235579AbhINWVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:21:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37B7E6115B;
        Tue, 14 Sep 2021 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657994;
        bh=hpJblHQsrimkq/c68ID4x9JPNBho0SJE+Frt4QttDBQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hZnJaepBxrp2EoSlw9XB3CnAJyNV0oQajJSkcOXRGudZmkE1sdphhSa0KzRl4CdXX
         bvJOXU9HQgJwpFNb1UZzwIX4jUw02Lmzn2D1H6RpdYn69IWlYeZRsKdNfJXxEz8hzI
         TSjzXbbcN4m8OCFw/5h77fkqg/vEtMxTQ3OCNrlgrJolkyINcnVEhMsvdxrqI9KS6s
         XyyXzV62c9Z3cB0JRlS0qmksU5ta4GtR0ziWKI2PLtS9itGeJCWZKEqzvBftGSX3Md
         TOxRA0xGooWI0H1H7juAeiFGfhWjbb6gvp9mWsNfMtLdQdRTukrKoZQDacrhP6nlBj
         Dve62aSwiUqaQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-21-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-21-chun-jie.chen@mediatek.com>
Subject: Re: [v3 20/24] clk: mediatek: Add MT8195 vppsys0 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Sep 2021 15:19:53 -0700
Message-ID: <163165799301.763609.10553027877067193825@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:29)
> Add MT8195 vppsys0 clock controller which provides clock gate
> controller for Video Processor Pipe.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
