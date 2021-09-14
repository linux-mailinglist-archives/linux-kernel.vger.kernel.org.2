Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4D540BB23
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhINWTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235546AbhINWTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:19:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47A7C61166;
        Tue, 14 Sep 2021 22:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657911;
        bh=SXy0ezH2GYZgyIlW+eAYQ7JeS5J8qw+HhFson7cURyw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QSHn/+0WnQkhF78liCpPlaWkrIUksDFaIoq5T83yqmQour1tys42jquXs7TSZx3br
         AW7rcamkyShjf6h28ETeBxvh9sAHZfT8OoizGZ5somvp3Bq/0hL/1sZInIvdJY7bbU
         2zpwsOzdrqYXO5vQy5DUN21lFKIAEfKf4T3y0YWJCqfJXqN6Yp9fXSU+xLV3eQKiFu
         pxMuGswF2i/Wk7zCIucnGD+mrGcCCH5EkVG0nICzJz45w5K3JVVjNEPgFIL+ORWEH0
         FI7nfrYypM8uLAayEjIlRpnC3styQ8yABtn+21McHFxGMBngtm+GBeFBAG9Sp5q8mn
         JJu9DVbKUGsVg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-8-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-8-chun-jie.chen@mediatek.com>
Subject: Re: [v3 07/24] clk: mediatek: Add MT8195 topckgen clock support
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
Date:   Tue, 14 Sep 2021 15:18:29 -0700
Message-ID: <163165790962.763609.6256601941616166474@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:16)
> Add MT8195 topckgen clock controller which provides muxes, dividers
> to handle variety clock selection in other IP blocks.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
