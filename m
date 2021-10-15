Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CCD42F420
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbhJONsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240061AbhJONsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:48:18 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C54C061570;
        Fri, 15 Oct 2021 06:46:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id d131so22962428ybd.5;
        Fri, 15 Oct 2021 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UMmMwoh0d9xOMBuf6Cb27qJgX9NIbwQbOxUehDVoXW4=;
        b=mSDy6QRxK1GWCZFRze2z/WPjTfj8t295fUbQbf1kfgfC1DUUqn1r6OUB82lPqEziqO
         aPvbyCh7Fdmn7+U2T9aXBbvBtchCJWUvjWlTV+h4GFPiyaj9eOjPDeaevyfDx+XswY9O
         qlsP/N0k3ISA1BsIf11JnASBHQ+NVZOu6UIordsImPMmoVJ2eY/Mu64O44OsXQNgP3Uu
         GAwVOrPFCVDcaz9D9GLZ36hsUqoxlc4cNtH0hVd6r/OJGWnboEInE6zKcQGGMklOLgBs
         5qXHsjF3iMMJ/cwwo/tgbfTSCYNdGAYh4RpqZn+X97Ho5avE4EmgJ0pgCpZvhtcZcV2d
         nePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UMmMwoh0d9xOMBuf6Cb27qJgX9NIbwQbOxUehDVoXW4=;
        b=eBJPyCGVWkZGfifc5wHHIToj7DoSL/rL9ioa3cQhaMR4BAfgcwI7gdgDGjV/HIE3Av
         Q54F18oddvVi0Hvf7e4tyIx17cv8u6gzFwD8ZRqp9+jLTmN3s4/46omDGXDnpTuy3+8g
         SWi+5LKHRNoA/yvoBl8YWGlNpVRC5WBKsnsn3oJvVO72nEQ/DApqCgQD1SXonkeFWeVI
         uXx91/fdpdREhgnpxzhUCQc3qCTSSdfYrPIm5109N+0J1xXCKIRTyznb4D5wP1Q+3PBo
         DwGHF59woVZHfajBEX9TElJJpVrnArE6ay1B0qMJttJfMtAhvTiwGCtO2YE3rxNY1WBs
         8Y2w==
X-Gm-Message-State: AOAM531WF2WNJwUV0gNIu+66EiA8ZcRNamvLAyjyp/12nZZf+N00BZf/
        HJaOyN+nG91e50RCFBeHGzYN8viPIlPjISxkE7o=
X-Google-Smtp-Source: ABdhPJwfK40oo9nWMVG1fm09vk4sNWiVNDk0gjrfy78SzbWYqPeXgWz5q5WvAASkenwS0WeJTbIxH9crZgrqZMEVb7k=
X-Received: by 2002:a25:3843:: with SMTP id f64mr12590756yba.313.1634305571737;
 Fri, 15 Oct 2021 06:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211015100941.17621-1-heinrich.schuchardt@canonical.com>
 <CAEUhbmUSmi9mbiHpatBjGgRjrtyJPms9BRmyBPs5BWeVb7n1Nw@mail.gmail.com>
 <49af3dc8-0d1e-e82f-6df2-2bf8338acd3a@canonical.com> <D976B0F9-6AE4-4C04-8D52-75B24D6E4359@jrtc27.com>
In-Reply-To: <D976B0F9-6AE4-4C04-8D52-75B24D6E4359@jrtc27.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 15 Oct 2021 21:46:01 +0800
Message-ID: <CAEUhbmWFAJpVxproxX-iH3Tj7jHGqu_SwN6-tGuxqi7NXVhOhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: reg-io-width for SiFive CLINT
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 8:15 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 15 Oct 2021, at 12:54, Heinrich Schuchardt <heinrich.schuchardt@canoni=
cal.com> wrote:
> >
> > On 10/15/21 12:14, Bin Meng wrote:
> >> On Fri, Oct 15, 2021 at 6:09 PM Heinrich Schuchardt
> >> <heinrich.schuchardt@canonical.com> wrote:
> >>>
> >>> The CLINT in the T-HEAD 9xx processors do not support 64bit mmio acce=
ss to
> >>> the MTIMER device. The current schema does not allow to specify this.
> >>>
> >>> OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to indica=
te the
> >>> restriction. Samuael Holland suggested in
> >>> lib: utils/timer: Use standard property to specify 32-bit I/O
> >>> https://github.com/smaeul/opensbi/commit/b95e9cf7cf93b0af16fc89204378=
bc59ff30008e
> >>> to use "reg-io-width =3D <4>;" as the reg-io-width property is genera=
lly used
> >>> in the devicetree schema for such a condition.
> >>>
> >>> A release candidate of the ACLINT specification is available at
> >>> https://github.com/riscv/riscv-aclint/releases
> >>>
> >>> Add reg-io-width as optional property to the SiFive Core Local Interr=
uptor.
> >>>
> >>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com=
>
> >>> ---
> >>>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 7 ++++++=
+
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yam=
l b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >>> index a35952f48742..266012d887b5 100644
> >>> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >>> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >>> @@ -41,6 +41,13 @@ properties:
> >>>    reg:
> >>>      maxItems: 1
> >>>
> >>> +  reg-io-width:
> >>> +    description: |
> >>> +      Some CLINT implementations, e.g. on the T-HEAD 9xx, only suppo=
rt
> >>> +      32bit access for MTIMER.
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    const: 4
> >> But this is not a "sifive,clint" anyway. Should there be a new
> >> dt-bindings for T-Head clint variant?
> >
> > I assume by new dt-bindings variant you mean: Add a new compatible stri=
ng in Documentation/devicetree/bindings/timer/sifive,clint.yaml.
> >
> > The vendor Debian image uses:
> > compatible =3D "{allwinner,sun20i-d1-clint", "sifive,clint0=E2=80=9D};
>
> I assume Bin means to stop calling it a sifive,clint0 and instead have
> something like
>
>     "allwinner,sun20i-d1-clint", "thead,clint0"

Yep, that's what I wanted to see. Sorry for not being clear. The
T-Head CLINT is definitely not compatible with "sifive,clint0".

> as is being done for their non-conforming PLIC. It=E2=80=99s worth pointi=
ng out
> that the same is true here; the SiFive CLINT supports 64-bit accesses
> on RV64, so this is not compatible with a SiFive CLINT. Moreover, the
> RISC-V spec was clearly written in a way that intended 64-bit accesses
> to be supported for RV64, though was not completely explicit about
> that, which has now been resolved (see
> https://github.com/riscv/riscv-isa-manual/issues/639), so this CLINT
> violates the obvious intent of the pre-1.12 privileged specs (see
> Andrew=E2=80=99s message in the issue, which agrees with my reading).

Regards,
Bin
