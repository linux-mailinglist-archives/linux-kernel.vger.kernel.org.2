Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C633CEDD0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbhGSTsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358890AbhGSTbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:31:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E00761164;
        Mon, 19 Jul 2021 20:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626725544;
        bh=JCj9N4s/hdtVIGnVeiVqSJIQIXC5g0PIHW7LS3LSnQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bYsT06FdvrtF6+L2WZ/G8akQFJ48X/JNEH3PoG/rEXDpPvNSVUsXMP9D7Qrx2iueP
         eJ0spKqMyZ4z9dGwva0crTrObiU031Qzwb59RtUqiUOP7NqiozRJ/VbjkZpha9gNpf
         IyV7IEItJ2HqJqDUzTFyXYzt4sogWEHdW5uUZ+8D/aJ2btnhwsg9SjoYoOZogL530d
         SWIsNOyX5TOfXIMwNcKQlgZkU5aSd3+F2ODF8Toas6H557Q9dzbtCfWTmJk3ji02v+
         ndYA2erHeBeXu8lTCUC/aecp/ED9YN7i3Csx6i9/5uo7q/bgA2dmsaCJQ+513XD9re
         /idw7mcXXM6KQ==
Received: by mail-ed1-f42.google.com with SMTP id w14so25629982edc.8;
        Mon, 19 Jul 2021 13:12:24 -0700 (PDT)
X-Gm-Message-State: AOAM530MFexKNspyxygcxZcgI7npKzqUDdJtJ0FNl8wLutdGxzc00yY6
        BdGfKORwqDfzdniIhTLkyYs3UUhv3cv6+aXJRg==
X-Google-Smtp-Source: ABdhPJwCxUJGpCNipUis1RgH8ABZHN7f3vU7SUFmhfDjndCv9fUJN8pvhKea2xsLX28gDThbSCs5vLmtxN/9QbIt8Lw=
X-Received: by 2002:aa7:c641:: with SMTP id z1mr27592530edr.289.1626725542940;
 Mon, 19 Jul 2021 13:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210610175613.167601-1-nfraprado@collabora.com>
 <20210624190041.GA1812802@robh.at.kernel.org> <20210719195115.cgh7fh54kwloo4o7@notapiano>
In-Reply-To: <20210719195115.cgh7fh54kwloo4o7@notapiano>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Jul 2021 14:12:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKoEwbfKz3s3OJJkk8izu2ak=dEhD2qjaw6Ad71Tb3_EA@mail.gmail.com>
Message-ID: <CAL_JsqKoEwbfKz3s3OJJkk8izu2ak=dEhD2qjaw6Ad71Tb3_EA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clk: Convert rockchip,rk3399-cru to DT schema
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Xing Zheng <zhengxing@rock-chips.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 1:51 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Thu, Jun 24, 2021 at 01:00:41PM -0600, Rob Herring wrote:
> > On Thu, 10 Jun 2021 14:56:13 -0300, N=C3=ADcolas F. R. A. Prado wrote:
> > > Convert the rockchip,rk3399-cru binding to DT schema format.
> > > Tested with
> > > ARCH=3Darm64 make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/de=
vicetree/bindings/clock/rockchip,rk3399-cru.yaml
> > > ARCH=3Darm64 make dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetr=
ee/bindings/clock/rockchip,rk3399-cru.yaml
> > >
> > > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > > ---
> > >
> > > One caveat is that this node expects certain external clocks, mainly =
'xin24m'.
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Thanks! Is this blocked on something else?

I'm expecting Stephen to pick this up.

Rob
