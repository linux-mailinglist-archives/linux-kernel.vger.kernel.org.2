Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9443B42F052
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbhJOMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbhJOMRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:17:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86352C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:15:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e12so26182242wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zKcwx74z267YiFyp+7xDuwStWFpphD6WuubHKqDXSdQ=;
        b=kI8eiKsi6/LtLnq2lIvLR45KjHmFav19vk/2r4iqPwB8TI7rQHv44w2lXSUDspeawr
         vGMdfByLZ8FLMiv+gVpwglM73kuHMf4lsqq4TssgXcbL8EuCH3Eq0y97gL1bw4rl4uAs
         tafgFikBXmsV+kooDcifNvUCvqwElIoRbXTZ9m4quR0ovDcGaCL/59UdO14yojiaGuRd
         wvnVt0mE2190BtSOAY+VCucWgy0wIEfZzfuHEa7h7RKSOjnG+zULCnk+YaN4pc9ckshR
         IryiUYIanU2qHUuVuPWnm+z+p5T+kzgeDr3Ji7EJq8T4wx+zN8gcNykT9morM9fmpAw0
         Tkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zKcwx74z267YiFyp+7xDuwStWFpphD6WuubHKqDXSdQ=;
        b=LzZX7W5q0zEU+VTlB8huwOeBfXr0RD4xBoOa64xXhqtaAN45tLF7WEdNa6Gnnw4a7f
         aspgUd/ZXagff4R2BI/ZXAoh45UQTr6wZO0hF0D/euqB+j+3DH6J8wOvZw2gTtgLnGy8
         WIQLHix22B4tr21wEtsVIu8tgB7YKJGfsdQtI+r++jRgWDJC0S5foKc/XYpkI5dDZrii
         KoXz3o3uxAusFUO3JUWb6L7UxTxkGI2W6ylzCaPcpWtEMqafembPKOrragExaHJk1Spr
         FpWCIoA5xr1JZCzZCOXJ2XQ5BoYnVaXRzrb/s+d7bV2sM8GU5k5cdIASSFWgUkwEqBpc
         bmAw==
X-Gm-Message-State: AOAM530AKM3XkZYrpn9czgctuNGEs3kvR0cnQ8SrMDFvpXyj8kxj3Oa3
        92ToTbnsMyjzAnWPaOYnRXBbXA==
X-Google-Smtp-Source: ABdhPJwU1QWokaYMAqr3wNsIOAH38qWZ0WWT0A2QjEjHMg3zDHEJH6iyDA3nyB+cONMICiT7ppEalg==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr14310511wrr.74.1634300130142;
        Fri, 15 Oct 2021 05:15:30 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id l17sm4739706wrx.24.2021.10.15.05.15.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Oct 2021 05:15:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/1] dt-bindings: reg-io-width for SiFive CLINT
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <49af3dc8-0d1e-e82f-6df2-2bf8338acd3a@canonical.com>
Date:   Fri, 15 Oct 2021 13:15:28 +0100
Cc:     Bin Meng <bmeng.cn@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@linux.alibaba.com>, Xiang W <wxjstz@126.com>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        OpenSBI <opensbi@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D976B0F9-6AE4-4C04-8D52-75B24D6E4359@jrtc27.com>
References: <20211015100941.17621-1-heinrich.schuchardt@canonical.com>
 <CAEUhbmUSmi9mbiHpatBjGgRjrtyJPms9BRmyBPs5BWeVb7n1Nw@mail.gmail.com>
 <49af3dc8-0d1e-e82f-6df2-2bf8338acd3a@canonical.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Oct 2021, at 12:54, Heinrich Schuchardt =
<heinrich.schuchardt@canonical.com> wrote:
>=20
> On 10/15/21 12:14, Bin Meng wrote:
>> On Fri, Oct 15, 2021 at 6:09 PM Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>=20
>>> The CLINT in the T-HEAD 9xx processors do not support 64bit mmio =
access to
>>> the MTIMER device. The current schema does not allow to specify =
this.
>>>=20
>>> OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to =
indicate the
>>> restriction. Samuael Holland suggested in
>>> lib: utils/timer: Use standard property to specify 32-bit I/O
>>> =
https://github.com/smaeul/opensbi/commit/b95e9cf7cf93b0af16fc89204378bc59f=
f30008e
>>> to use "reg-io-width =3D <4>;" as the reg-io-width property is =
generally used
>>> in the devicetree schema for such a condition.
>>>=20
>>> A release candidate of the ACLINT specification is available at
>>> https://github.com/riscv/riscv-aclint/releases
>>>=20
>>> Add reg-io-width as optional property to the SiFive Core Local =
Interruptor.
>>>=20
>>> Signed-off-by: Heinrich Schuchardt =
<heinrich.schuchardt@canonical.com>
>>> ---
>>>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 7 =
+++++++
>>>  1 file changed, 7 insertions(+)
>>>=20
>>> diff --git =
a/Documentation/devicetree/bindings/timer/sifive,clint.yaml =
b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>>> index a35952f48742..266012d887b5 100644
>>> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>>> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>>> @@ -41,6 +41,13 @@ properties:
>>>    reg:
>>>      maxItems: 1
>>>=20
>>> +  reg-io-width:
>>> +    description: |
>>> +      Some CLINT implementations, e.g. on the T-HEAD 9xx, only =
support
>>> +      32bit access for MTIMER.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    const: 4
>> But this is not a "sifive,clint" anyway. Should there be a new
>> dt-bindings for T-Head clint variant?
>=20
> I assume by new dt-bindings variant you mean: Add a new compatible =
string in Documentation/devicetree/bindings/timer/sifive,clint.yaml.
>=20
> The vendor Debian image uses:
> compatible =3D "{allwinner,sun20i-d1-clint", "sifive,clint0=E2=80=9D};

I assume Bin means to stop calling it a sifive,clint0 and instead have
something like

    "allwinner,sun20i-d1-clint", "thead,clint0"

as is being done for their non-conforming PLIC. It=E2=80=99s worth =
pointing out
that the same is true here; the SiFive CLINT supports 64-bit accesses
on RV64, so this is not compatible with a SiFive CLINT. Moreover, the
RISC-V spec was clearly written in a way that intended 64-bit accesses
to be supported for RV64, though was not completely explicit about
that, which has now been resolved (see
https://github.com/riscv/riscv-isa-manual/issues/639), so this CLINT
violates the obvious intent of the pre-1.12 privileged specs (see
Andrew=E2=80=99s message in the issue, which agrees with my reading).

Jess

