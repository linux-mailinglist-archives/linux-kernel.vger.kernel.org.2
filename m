Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C566740BB39
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhINWUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235721AbhINWUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:20:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F6706115B;
        Tue, 14 Sep 2021 22:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657957;
        bh=yjIs0g9MLXapVPiuBtQEanyGP3q9sN9rXhDmCOR3AxU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=t14Fdj8ft601W5nKoiyo+UsKLvyznGqM7oiNgsvkKZMMAbC8x9V4PfD6Aqj7ZnEBD
         gMwkWiwUNsofKw/+NhmboI5+DKuA+zB42/gt2TvVj75InDj2wkQYmB/bviW210Kmx9
         9oxpS33uFGJhz4kLIUEKy4Jg803+V/ZNVPAidZ4EbwVBsdaaZiihj9kgOKoF6NWZdM
         MSQF+D6T4jgPWqlsL6YwQr0hqeuuCaoF2riXKJgKJbHuPrS2AwU1CrzwOg0RXgxvAA
         C37Ke5UG4/5xh05vBX3U/DwJXJHrPwR1f/IxxYRKjh3bIYIYdGt4Q9jDXVk8br2YOO
         WtsHWZ22EcSQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-15-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-15-chun-jie.chen@mediatek.com>
Subject: Re: [v3 14/24] clk: mediatek: Add MT8195 mfgcfg clock support
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
Date:   Tue, 14 Sep 2021 15:19:14 -0700
Message-ID: <163165795490.763609.14036221868373779992@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:23)
> Add MT8195 mfg clock controller which provides clock gate
> control for GPU.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
