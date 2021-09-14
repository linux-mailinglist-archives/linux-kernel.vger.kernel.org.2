Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1462540BB54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhINWVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235786AbhINWVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:21:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A2DB6115B;
        Tue, 14 Sep 2021 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631658014;
        bh=jvI12QmPpCnTZnWtnOHFRAXmDQ1Q9jJWv5MmuR9s6xA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YPiP+CmmWIY/o1SC9RXyQws8EPOPFD4OGHj1ZdWlnVpBykQ2cpfjoQdRPQYQVnCLL
         IWxSwF6lt3gOXyAP+KdLTF7F1IoGhTDe2M97AzVSly9tdr2ie4R0y6CdyamZkB1rbV
         jDAj6sq99Jk9QBwDPqfKjM9hFuPMKm7cy9dypCpL2oKlpnLSirL/TlvwIPbv03LzxW
         ViFAYDbnSARuIizeHPRIRaWFYBbg/9qH+zPwcdgzwrey4RbUIO8KZ/FbWN9nv0lTHi
         PqqXeg48MtOxNUxua+jFcPWS2V0IVCJWi22NOpHaORG57QPm1tNTtaMscy3bAFRgom
         rpZK3hkQJ4LuQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-24-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-24-chun-jie.chen@mediatek.com>
Subject: Re: [v3 23/24] clk: mediatek: Add MT8195 imp i2c wrapper clock support
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
Date:   Tue, 14 Sep 2021 15:20:13 -0700
Message-ID: <163165801346.763609.12185791472817481426@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:32)
> Add MT8195 imp i2c wrapper clock controllers which provide clock gate
> control in I2C IP blocks.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
