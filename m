Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958AE3D7CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhG0R4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhG0R4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:56:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FB6860F4F;
        Tue, 27 Jul 2021 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408592;
        bh=FHnAsqCd1mWH0cw4MowmdfppXrL9K/hZdfz1Y32vnOQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m0CW5jPU+meg+iTcDL8c1g0XpdyzLSap14SYriLlR3uuKiFlUnFjpXdv8n3rQD7nC
         tYSqEGTGM17vVpBp+oAtyD5vYuglSlSaJzGB56MzPD+dZeX6x2h9SGJBUkHd3HKq5K
         KT9FgK9UiVnjjQz3VHjMAqD+5EmH9/y30QKqjGoNnKHAj3b6TQQ+Iz6JYOFgHDn4fx
         4LKwr/6cxBEmb90gKrsNZwAebjFeD/AZtFKJE6HrmRyoIwLzntU+SDaEo0eI+3u75w
         mac8SJKfBfvGUE37XGgyGyL5iGyE77gdDtPsYtrJ5sdxtSN8hvw1oMqdi8/hZZsgP7
         LbHLtkHBFfLTA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-15-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-15-chun-jie.chen@mediatek.com>
Subject: Re: [v14 14/21] clk: mediatek: Add MT8192 ipesys clock support
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
Date:   Tue, 27 Jul 2021 10:56:29 -0700
Message-ID: <162740858987.2368309.16592701545993198310@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:12)
> Add MT8192 ipesys clock provider
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
