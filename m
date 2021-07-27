Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43D3D7CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhG0Ryn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231426AbhG0Ry3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:54:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20DD260F91;
        Tue, 27 Jul 2021 17:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408469;
        bh=kDiVzdc+UAyPE1obrWI2EA3dFVaL4d8che9242Zhkys=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gjAqadbmhB9+AO6X0JU/qcLeg40yy93Xkh3kGJO4stxPHQtOZYBHJbUr4g5aCLnS2
         gucdesdfcDgRUixP+JCQJcWNUj3K0Cw97DKXQDiYKb6POs9b+gc7j3MlpIPI3oA+EE
         4KPPaUzcMu8Hz4Z3KuUS7o+3C5483ouVHPBVV4WP1c1ITYM/xrvnAtZFgBYlxwEFGy
         6KZDImArgbKTCxKpQO8H14R1FxGeiIxm5RGlvL0F7AAKzw4HIION2oHIMRpHUtzE28
         6MEHgmmHM9kEIQVwLF1zLPCJufGdiWgNW9gKRmlTWeMqcw4rqOCa5Jsd67hD+hw0vo
         hcL561s+4HYVA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-6-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-6-chun-jie.chen@mediatek.com>
Subject: Re: [v14 05/21] clk: mediatek: Get regmap without syscon compatible check
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
Date:   Tue, 27 Jul 2021 10:54:27 -0700
Message-ID: <162740846702.2368309.32443659644468726@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:03)
> Not all clock providers need to be marked compatible with "syscon"
> for system configuration usage, so use device_node_to_regmap() to
> skip "syscon" check.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
