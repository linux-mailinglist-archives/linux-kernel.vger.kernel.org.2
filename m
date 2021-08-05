Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC863E1F88
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbhHEXuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240913AbhHEXuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:50:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82566610FF;
        Thu,  5 Aug 2021 23:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628207393;
        bh=V2m0cMUtBRpLdmQUhz7CRPUwiosgV5Nj4ymrvGsBhTE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jHXxfBk9h03LTPzOt+gDHoTsNWmvz1aBsb0LedGizcWznENUUMWuONDNpkXGEGHib
         VgJ2UK4XOSWOOmw50st5WaXvzsy4p28oDR77VYegqv9/p5eS9d5771sE57LLA30Q8r
         tu8M1XK5wxNiiBWOI53PViPccgqlCTqRBz8ISdl+kEWqqeDcMAEZBesEQS3EWS5Epp
         wewFc5IMoup6Na6qPEp5EZlVdO/li7/FWQmvKuoTTCgJhdsRA83HHatgXniSQHKKSr
         vbNnIR9sCpU1ZmNU/fsCKPaxlsBfVyiCASrGzd/6/ChfgrVNj6IyQsO/XTlKoANyCc
         KJk1poxYwvXhQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b98aeeee-c544-3025-cc06-ec04be7ab638@gmail.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-3-chun-jie.chen@mediatek.com> <162740843452.2368309.13157283201271440368@swboyd.mtv.corp.google.com> <b98aeeee-c544-3025-cc06-ec04be7ab638@gmail.com>
Subject: Re: [v14 02/21] dt-bindings: ARM: Mediatek: Add mmsys document binding for MT8192
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 05 Aug 2021 16:49:52 -0700
Message-ID: <162820739221.19113.17602385426851379006@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Brugger (2021-08-05 08:35:09)
>=20
>=20
> On 27/07/2021 19:53, Stephen Boyd wrote:
> > Quoting Chun-Jie Chen (2021-07-26 03:57:00)
> >> This patch adds the mmsys document binding for MT8192 SoC.
> >>
> >> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> >> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> >> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> ---
> >=20
> > Applied to clk-next
> >=20
>=20
> Please drop this patch. The mmsys binding will change to yaml in this mer=
ge
> window and this will create a merge conflict.
>=20

It is particularly difficult to resolve? linux-next maintainers seem to
have resolved it so I'm not very concerned.

https://lore.kernel.org/r/20210728124304.1199-1-broonie@kernel.org
