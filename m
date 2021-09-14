Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1840BB51
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhINWVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235693AbhINWVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:21:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C6226115B;
        Tue, 14 Sep 2021 22:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631658007;
        bh=W1pICJlRvSW1ssmFRiGoKgBpCPqmo3zRGu6NGVebegw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iT/sbQMhhcXy0LkiRmzPGy03xQNLwXKS4E4jFnfjI6mnbfXkn89NI+rcYNdXYjsbx
         5RXsU/twsLIVKRLLogXPhxTUAWl9CPFNqYCrvLKSp6Jy+dhvgxxDdKuAKf93si18oQ
         5lQakE7pb6Ms71Upkwy3RGxsPc8LOt4w1XyQR18K9UlzEEviczIm/Tja+fEVU8Booo
         0qO7abqIukgx9tIfL0LHUYvxhCDDgpg+ZE/nqakm2QtejGu+FkIZN3Vaman4vCmSCj
         YjgxnCPLOqosbGozjG+LD7YJ3IpWxUHWlZ0VqX/CbWhXmB4urXSQq7CnoUeQ5zwu4y
         SQhc5j6nbSdpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-23-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-23-chun-jie.chen@mediatek.com>
Subject: Re: [v3 22/24] clk: mediatek: Add MT8195 wpesys clock support
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
Date:   Tue, 14 Sep 2021 15:20:05 -0700
Message-ID: <163165800550.763609.17699241098825295982@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:31)
> Add MT8195 wpesys clock controllers which provide clock gate
> control in Wrapping Engine.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
