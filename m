Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88D842D2CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhJNGku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhJNGkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:40:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7168561029;
        Thu, 14 Oct 2021 06:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634193523;
        bh=G10VS/6BBtrqv0MgD6Bl95nuURYHl2bUPHYWpk2iiaU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GXOl8jwtUUrxofhl0847Wcnp5i6+5J3OwDO0LcMGR7y9Vxvxryt4etEdDPkC3zTz3
         UR8qiDsFkY33+1IQo60QktQ5PdFqwX6yAOpg3yA3ahZLVlVNSV3cerWYQRCyssxwM9
         b2tHdt7BPYNe/oIyDw2//Gierx4309Z0VK9SRmT2DTOfn8X3Pve3JGGbaK8ujO9H8U
         6hloPK4lrhzzJrC91P5ZdIlcC3KoB8DVaZtAB8msDbKwqoPrOtWaxglJQWhO7cS48U
         HNlBa5ByB1Io5T2V6fKIlCZ6p1D7AgSYQ0Mo229/tbnj/hAKqiK4LWPlKbWKEt85UT
         XdQKdbxS4lBog==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4e2e8b98.cc9.17c7c899967.Coremail.zhanglyra@163.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com> <163416267274.936110.2784588823311275089@swboyd.mtv.corp.google.com> <5b8198f8.cc.17c7c0fc3e2.Coremail.zhanglyra@163.com> <163417628586.936110.17321921086246870791@swboyd.mtv.corp.google.com> <4e2e8b98.cc9.17c7c899967.Coremail.zhanglyra@163.com>
Subject: Re:Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
To:     ChunyanZhang <zhanglyra@163.com>
Date:   Wed, 13 Oct 2021 23:38:42 -0700
Message-ID: <163419352215.936110.17102590465311356046@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting ChunyanZhang (2021-10-13 19:02:44)
> At 2021-10-14 09:51:25, "Stephen Boyd" <sboyd@kernel.org> wrote:
> >Quoting ChunyanZhang (2021-10-13 16:49:40)
> >> At 2021-10-14 06:04:32, "Stephen Boyd" <sboyd@kernel.org> wrote:
> >> >Quoting Chunyan Zhang (2021-09-22 23:41:35)
> >> >> diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbr=
eg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> >> >> +
> >> >> +examples:
> >> >> +  - |
> >> >> +    ap_apb_regs: syscon@71000000 {
> >> >> +      compatible =3D "sprd,ums512-glbregs", "syscon", "simple-mfd";
> >> >> +      reg =3D <0x71000000 0x3000>;
> >> >> +      #address-cells =3D <1>;
> >> >> +      #size-cells =3D <1>;
> >> >> +      ranges =3D <0 0x71000000 0x3000>;
> >> >> +
> >> >> +      clock-controller@0 {
> >> >> +        compatible =3D "sprd,ums512-apahb-gate";
> >> >
> >> >Why is this a subnode of a syscon and simple-mfd? Why not put the>clo=
ck-controller@71000000 directly onto the bus? Does making it a child
> >> >node help somehow?
> >>=20
> >> These clocks are at the same register range with global registers. I o=
riginally put them directly onto the bus indeed when submitting the patches=
 for SC9863A clocks last year, and it had a private property named 'sprd,sy=
scon' which could provide regmap for these clocks.
> >>=20
> >> Rob suggested [1] us to make them a child of the syscon, and would not=
 need the private property 'sprd, syscon' then.
> >
> >Why do you need to use a syscon? Are the registers shared with some
> >other driver?
>=20
> Yes, shared with more than one devices which basically are multimedia dev=
ices. You may noticed that these are all gate clocks which are in the globa=
l registers ranges and are used to controll the enable status of some devic=
es or some part of devices.
>=20

Where does the multimedia device address space start? I see 0x71000000
to 0x71002000 is for the clock-controller. Is the multimedia device at
0x71002000 to 0x71003000? If so they're next to each other but not
sharing the same register space. Is ap_apb_regs more like a soft macro
that combines a few clks with some multimedia device?
