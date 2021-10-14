Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B942D016
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhJNBxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhJNBxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28479611C1;
        Thu, 14 Oct 2021 01:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634176287;
        bh=1TCExL0NWW5Irta1dp80GReUysLQwrbjFu/tto0//0c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JVX+Dy0K30bTNzM3zPrMdHfud8XRGBxm3B6FapyecpqadyAktjCYzickvDGNqH3Lr
         tAYoCRdDtbIjkAljg21JHCr7kT1ejihI3ChyWFteaJIjOIFW8w5nUl83cWtaQdrjI2
         eZjUgK+Gx6MoGvvlwoxQLO2MkytTMVFqqGzL13VDGkGq73x1qChxru6bcPf3i0SKRo
         C85srdEXn72UIGq74RgfW7CO3dSyQa8VcUB2aSykmY/rTGESXN0iYhHuSAoKMChltX
         D80uqNKWo4TqxNALGbrLcZSSe/x/zRY4quvbDbSlGnpVB7Jwn19WH5LnH7KeHLgUCx
         C6HRikZDknhsg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5b8198f8.cc.17c7c0fc3e2.Coremail.zhanglyra@163.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com> <163416267274.936110.2784588823311275089@swboyd.mtv.corp.google.com> <5b8198f8.cc.17c7c0fc3e2.Coremail.zhanglyra@163.com>
Subject: Re:Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
To:     ChunyanZhang <zhanglyra@163.com>
Date:   Wed, 13 Oct 2021 18:51:25 -0700
Message-ID: <163417628586.936110.17321921086246870791@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting ChunyanZhang (2021-10-13 16:49:40)
> At 2021-10-14 06:04:32, "Stephen Boyd" <sboyd@kernel.org> wrote:
> >Quoting Chunyan Zhang (2021-09-22 23:41:35)
> >> diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.=
yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> >> +
> >> +examples:
> >> +  - |
> >> +    ap_apb_regs: syscon@71000000 {
> >> +      compatible =3D "sprd,ums512-glbregs", "syscon", "simple-mfd";
> >> +      reg =3D <0x71000000 0x3000>;
> >> +      #address-cells =3D <1>;
> >> +      #size-cells =3D <1>;
> >> +      ranges =3D <0 0x71000000 0x3000>;
> >> +
> >> +      clock-controller@0 {
> >> +        compatible =3D "sprd,ums512-apahb-gate";
> >
> >Why is this a subnode of a syscon and simple-mfd? Why not put the>clock-=
controller@71000000 directly onto the bus? Does making it a child
> >node help somehow?
>=20
> These clocks are at the same register range with global registers. I orig=
inally put them directly onto the bus indeed when submitting the patches fo=
r SC9863A clocks last year, and it had a private property named 'sprd,sysco=
n' which could provide regmap for these clocks.
>=20
> Rob suggested [1] us to make them a child of the syscon, and would not ne=
ed the private property 'sprd, syscon' then.

Why do you need to use a syscon? Are the registers shared with some
other driver?

2019 was two years ago...
