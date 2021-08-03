Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362193DF64A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbhHCURm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239434AbhHCURl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:17:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F417260F45;
        Tue,  3 Aug 2021 20:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628021850;
        bh=XTY6UB22so0/DVKfLu1mpMtUhtLH6Sk2bDv9rtYPFuw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kDV+fafGWRc9HRtQpMMuNBgfkqjwbrUW/9dncn55koAK1K0WYo5IWAt9pR6towgvE
         PJ1rLKzhic0uMhonErS/TS3FdmVoPZL+dVVjTf9cHaH9yBbAW0OnTWNEj4zgPTAxnz
         3+G5t6DBI23y5tWwLTHV66pcxlTy6LYpXoOCw9zSo9SeJBriL2IOlpNKLMLh5WO3FY
         1lil1PAXOXuGzxJft2AAWT3khWgvGi2er17ts4WMQSMkYZVQEJpLul47jPQQ/eP2Ww
         4i7aNseAlg3F5mViKZcE0xnMLKX/aOVAvckFxEGaHYQrYkpfBn8gU7MHkc0YAcggEp
         l0wRNOPlWoEnQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFqH_51D0A_Oht785cxvWjuNFYgLL25-qX1QEpLhWBARtTgVMA@mail.gmail.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-3-chun-jie.chen@mediatek.com> <162740843452.2368309.13157283201271440368@swboyd.mtv.corp.google.com> <CAFqH_51D0A_Oht785cxvWjuNFYgLL25-qX1QEpLhWBARtTgVMA@mail.gmail.com>
Subject: Re: [v14 02/21] dt-bindings: ARM: Mediatek: Add mmsys document binding for MT8192
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, moderated list:
        ARM/Mediatek SoC support <linux-mediatek@lists.infradead.org>,
        linux-clk@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 03 Aug 2021 13:17:28 -0700
Message-ID: <162802184879.3896750.16823365734333299735@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Enric Balletbo Serra (2021-07-28 01:47:21)
> Hi Chun-Jie and Stephen,
>=20
> Missatge de Stephen Boyd <sboyd@kernel.org> del dia dt., 27 de jul.
> 2021 a les 19:54:
> >
> > Quoting Chun-Jie Chen (2021-07-26 03:57:00)
> > > This patch adds the mmsys document binding for MT8192 SoC.
> > >
> > > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> >
> > Applied to clk-next
> >
>=20
> This will conflict in linux-next as the binding was already converted
> to yaml. See
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml?id=3D6=
3e1125e6bb8eae3cd20292f6a10ee421dd574ae
>=20

Looks like it has been resolved in linux-next. Is there anything to do?
