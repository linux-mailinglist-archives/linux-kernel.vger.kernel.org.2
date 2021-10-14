Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7207142E496
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhJNXLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 19:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233935AbhJNXLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 19:11:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B8F360F11;
        Thu, 14 Oct 2021 23:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634252953;
        bh=EZ/WB5HXZm7aAvIuXY679+z1Z+5GCBnK9dsEdZuxJr0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KEBp5D2AOpfE2zOoulrtgt9fECZ6NdWxFDL0s3VpbCLqiPigEFBMhOyFEGe3Lsy88
         Gtv76yeq3aksqCBBxIB7Hk+HNzzDFV21w1dMCB4OVrO28VYK6z1nUOM3Qb6lqNboyd
         709Z+IRdx4Mp/yMjvOAQlieOm42oE8/IxcHNsLz5Y9iGIg3fOzZYJvzSEYCX+zLLqA
         nGE6qqblmTni/uWWYwgvNLcWG4Syyi1TxLGUdriVzG+TrHPkm6f+4eVtJNbR/pFo3A
         5VOS9lkHHdCMCMciKMjCXAQKzsEt3EDw0l7cHW2zZ3VxgXiFe9k834QmKxYX/apLV1
         BCH/hdAo+4ipw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <71369ca3.307a.17c7de16354.Coremail.zhanglyra@163.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com> <163416267274.936110.2784588823311275089@swboyd.mtv.corp.google.com> <5b8198f8.cc.17c7c0fc3e2.Coremail.zhanglyra@163.com> <163417628586.936110.17321921086246870791@swboyd.mtv.corp.google.com> <4e2e8b98.cc9.17c7c899967.Coremail.zhanglyra@163.com> <163419352215.936110.17102590465311356046@swboyd.mtv.corp.google.com> <71369ca3.307a.17c7de16354.Coremail.zhanglyra@163.com>
Subject: Re:Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
To:     ChunyanZhang <zhanglyra@163.com>
Date:   Thu, 14 Oct 2021 16:09:12 -0700
Message-ID: <163425295208.1688384.11023187625793114662@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting ChunyanZhang (2021-10-14 01:18:15)
>=20
> Resend this since I forgot to switch to plain text mode :(
>=20
> At 2021-10-14 14:38:42, "Stephen Boyd" <sboyd@kernel.org> wrote:
> >Quoting ChunyanZhang (2021-10-13 19:02:44)
> >> At 2021-10-14 09:51:25, "Stephen Boyd" <sboyd@kernel.org> wrote:
> >> >Quoting ChunyanZhang (2021-10-13 16:49:40)
> >> >> At 2021-10-14 06:04:32, "Stephen Boyd" <sboyd@kernel.org> wrote:
> >> >> >Quoting Chunyan Zhang (2021-09-22 23:41:35)
> >> >> >> diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-g=
lbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> >> >> >> +
> >> >> >> +examples:
> >> >> >> +  - |
> >> >> >> +    ap_apb_regs: syscon@71000000 {
> >> >> >> +      compatible =3D "sprd,ums512-glbregs", "syscon", "simple-m=
fd";
> >> >> >> +      reg =3D <0x71000000 0x3000>;
> >> >> >> +      #address-cells =3D <1>;
> >> >> >> +      #size-cells =3D <1>;
> >> >> >> +      ranges =3D <0 0x71000000 0x3000>;
> >> >> >> +
> >> >> >> +      clock-controller@0 {
> >> >> >> +        compatible =3D "sprd,ums512-apahb-gate";
> >> >> >
> >> >> >Why is this a subnode of a syscon and simple-mfd? Why not put the>=
clock-controller@71000000 directly onto the bus? Does making it a child
> >> >> >node help somehow?
> >> >>=20
> >> >> These clocks are at the same register range with global registers. =
I originally put them directly onto the bus indeed when submitting the patc=
hes for SC9863A clocks last year, and it had a private property named 'sprd=
,syscon' which could provide regmap for these clocks.
> >> >>=20
> >> >> Rob suggested [1] us to make them a child of the syscon, and would =
not need the private property 'sprd, syscon' then.
> >> >
> >> >Why do you need to use a syscon? Are the registers shared with some
> >> >other driver?
> >>=20
> >> Yes, shared with more than one devices which basically are multimedia =
devices. You may noticed that these are all gate clocks which are in the gl=
obal registers ranges and are used to controll the enable status of some de=
vices or some part of devices.
> >>=20
> >
>=20
> >Where does the multimedia device address space start? I see 0x71000000
>=20
> It doesn't mean that multimedia device address is in this space, multided=
ia devices have their own address space actually.

Ok got it.

> All the registers in this space (started from 0x71000000) are more like c=
ontroll registers for device power, and they were designed as "global regis=
ters".
> Some gate clocks are also in global register space, so we make this kind =
of clocks a subnode of syscon, and clock driver can use regmap which mapped=
 by syscon to avoid remapping the same address space to more than one virtu=
al addresses.

So it looks like we're making the "power controller" device into a
syscon and then adding nodes in DT to describe the various pieces that
some registers inside that correspond to, like clks, power domains, etc.
I wonder why the ap_apb_regs device can't be a single node covering the
entire register space and then use the auxiliary bus in the kernel to
carve that device up into various kernel subsytems so that the
appropriate maintainers can review it.

>=20
> Hope I've made that clear, I'd like to give you an example, but I'm on a =
long leave and cannot look up the specification right now :(
> This is not a new issue, we discussed this when the first time I submitte=
d the patches for sprd clocks IIRC.

Yes, I know it's not a new issue. Take care! We can pick this discussion
back up when you get back from leave.
