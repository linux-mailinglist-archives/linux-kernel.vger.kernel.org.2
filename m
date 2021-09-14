Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8A40BB29
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhINWUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235546AbhINWUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 543BA6115B;
        Tue, 14 Sep 2021 22:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657924;
        bh=01uS6VKFvnOijqMcf9pn5juu60oS1v80Mb/+F+Yu0cY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=M1D7z/GiyWf7pviaz/6UmuBgvaZUSnzu+Dq9epmIBdKfvpMTVqEFngkgldvRs3JhG
         W2oj4LTs7LbAL3jDO23Jys3CyBHyPbf72bhE0pxih3aEj6ppS4YlFbi3vXN7N4ZrIq
         HisLaYA6LhEZ1jnY6nmcQROEDWAJ4HF8jip7GRbLNzujfesaP/d4Dw7OVLJqtE0r0m
         lJ28k0eMZJStScjAe8+m+JCdk2qAyiIuiSnCeh/n75BKMJMkLQKlQIRUCacrIWHuCJ
         ytF+G1kqCBPW9Dr/tznibcDm7iuUIKmB623s3N3BrRtFazv+yiMcKPlOqAb42DZ9yi
         LmA8qEBNs1CSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-10-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-10-chun-jie.chen@mediatek.com>
Subject: Re: [v3 09/24] clk: mediatek: Add MT8195 infrastructure clock support
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
Date:   Tue, 14 Sep 2021 15:18:43 -0700
Message-ID: <163165792313.763609.7788460119459873369@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:18)
> Add MT8195 infrastructure clock controller which provides
> clock gate control for basic IP like pwm, uart, spi and so on.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
