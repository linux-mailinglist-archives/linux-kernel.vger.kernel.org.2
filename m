Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518D740BB11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhINWTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234017AbhINWTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:19:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72F8861164;
        Tue, 14 Sep 2021 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657870;
        bh=H3LVFe3o74JDFJmwzbvvC8Hema3SZT1AXDwvppvUE5M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eJpdHrDbnx+3vrF8pnM6ntrAkPZb4titKQ40xqM1cji/VUseuBpY6tGyfgqIBf9U/
         9KNAy7z/fuPS8hTly36jaW593KK31wnHezJmIX5Ynz8mhxabYUO4gi1qu0GEgigLwo
         Jv7VZgRIc4SpN++K8SdJdCx+w8/nDM7SFGDLB7qwuN10Naig7QdcnqDnIN1mhExSP0
         AVwwsaCSUHWUC12gusEKs3vG1Zo1NihduV2EtFsaQLhESKpryQ9uc5Qp8UULHDyie3
         x3qghHo7aiI2fOxs4FKCsHLkYYXe7q0VcQPWxWOeRO5e1caGwAORHiC9LMaqwP0Chg
         Cf+sEk1WED8AA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-2-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-2-chun-jie.chen@mediatek.com>
Subject: Re: [v3 01/24] dt-bindings: ARM: Mediatek: Add new document bindings of MT8195 clock
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
Date:   Tue, 14 Sep 2021 15:17:49 -0700
Message-ID: <163165786922.763609.13079852242605675480@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:10)
> This patch adds the new binding documentation for system clock
> and functional clock on Mediatek MT8195.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
