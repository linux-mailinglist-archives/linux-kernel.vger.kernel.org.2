Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B07A3D7CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhG0RyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhG0RyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:54:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D609860F4F;
        Tue, 27 Jul 2021 17:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408447;
        bh=l1K3ExWTjBH/JcKEEvkRPwTiN653mDX9zd4H/Pyf+es=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QfKB2KoHClq8tsBASVnA2L9bil+MLDevGv780bz9PwwwxGNikFJIaz9zDEiW1el+K
         lUSdKGz4b8WRowFI+UHB/n9cX4+klmMZWONFxsstUB3/Ln5Am1JfUmVhYHRqa+DrrK
         pL8FVQgKdeH6roeA4knginqp0xqZ9MmO3CrOyuPyz/TwJ2H68KBFmmOHIJTMqogVo+
         520R3e+Jw0YSHpmt0WO0UyVzJCNH95KEnXH2CBziVoQ1uNhegHZ99+ICefvKDQgTVw
         PH5CqTY2urk9V5yFe/ZRWNPrdA2IyNLsVPBHFgycbXDLFgZm3kB7Ftu1TzSlf53vYB
         zVYolPklxRTBA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-4-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-4-chun-jie.chen@mediatek.com>
Subject: Re: [v14 03/21] dt-bindings: ARM: Mediatek: Add audsys document binding for MT8192
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
Date:   Tue, 27 Jul 2021 10:54:04 -0700
Message-ID: <162740844465.2368309.1019968952456714373@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:01)
> This patch adds the audsys document binding for MT8192 SoC.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
