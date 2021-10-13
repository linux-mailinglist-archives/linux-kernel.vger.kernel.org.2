Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F1542BB34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbhJMJNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbhJMJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:13:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54577C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:11:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t2so5919074wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PV4TDA9Wg4a3/4+lvLr8uQ2IGR+/8BcN/iS1LNsPzfE=;
        b=4cWkdw4CWnHs6G7XTSrFY0htwwCVCl8pqcD74gAXvrbpdAaxoIEYgALY2LK9WjZzJH
         V+0gi186XUglWAfVoTSWZVZlGQiBhOJDJmvuKd/vl2gyWCMY7Mede+Nt0p1IG5ND9j2y
         MA+rynIjYs1BP+4dsgA7GNVmvifaiB3O+6IFGdYV523C1GewdGkP1z0CrmjMuiJKv3uk
         TPJMtDnORLiWkJb/wGgv9FB1n/13IYx3t7Q9V+XaMFIniQkYEKNf4tcKWoNKpZa+0+QC
         Y+/eKYV5A/5T/Ye3+X3sWp5yVRxkR7G8dXtAi9fkxxZUY17hpwCZPPeLnF08baaJ0zeU
         GTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PV4TDA9Wg4a3/4+lvLr8uQ2IGR+/8BcN/iS1LNsPzfE=;
        b=nkkpumfwDa5MGXaISTb/bJDMZuPVoL7R0mGn+WGCq5cu+izmsBGqPQT6CdoZjZcHJk
         ZMzXKbHx79C0K64Y8uCwq5Qfg2Tr57JhMRsn+bjW3NydDJfYIt2+rW04c5pV3iSobdsk
         qkenTSgAvowPNNX5wi0PpzzSA7j98IwfwBS113sJyIFXoXb14j3dgy9QUuKwaSI7YHAI
         9PmlZPxQB4KT5cpeuF1cIdzewUHKd+eWLxwI8xHnhqUDVXQkp2gaVE3W04cVDKwNGdSK
         oDDmTDSUpRDaZOg1Ch23OifoTsM7GRab5logcnuDOFlKm6xLsTVVfFyK+oVT0uINkz/Q
         t/Gg==
X-Gm-Message-State: AOAM5300m1F6FY9UOxDzYioBiaXmFOVkBIB/jMdFzFZzY1mlriO6Ed85
        SccUAseq0303fAPOurl0XhdobodCYjd8I0Zd8yPN6w==
X-Google-Smtp-Source: ABdhPJyCqFgQZJ7BVVPy5O3gqM1t6WzuFwPHsuGG7tJ+0UNwo2/ilMMITf9N/zNU2s2XOzmiaJxHmD8PludN+2F64gc=
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr11281690wmh.137.1634116297799;
 Wed, 13 Oct 2021 02:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org> <CAAhSdy042JY_Vm2j_d5t4jweS3gf51h30j1O9LXDnE6KkB8AEg@mail.gmail.com>
 <4039032.XOxOlHldtI@diego>
In-Reply-To: <4039032.XOxOlHldtI@diego>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 13 Oct 2021 14:41:26 +0530
Message-ID: <CAAhSdy3j2Co2ckxn4vDtOxL=Ym3hgb66vkmnTbUjec+x7bRRDA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Guo Ren <guoren@kernel.org>, Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 2:27 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Anup,
>
> Am Mittwoch, 13. Oktober 2021, 07:11:46 CEST schrieb Anup Patel:
> > On Wed, Oct 13, 2021 at 6:52 AM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Add the compatible string "thead,c900-plic" to the riscv plic
> > > bindings to support SOCs with thead,c9xx processor cores.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > Cc: Anup Patel <anup@brainfault.org>
> > > Cc: Atish Patra <atish.patra@wdc.com>
> > >
> > > ---
> > >
> > > Changes since V3:
> > >  - Rename "c9xx" to "c900"
> > >  - Add thead,c900-plic in the description section
> > > ---
> > >  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml    | 6 ++++=
++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/s=
ifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-control=
ler/sifive,plic-1.0.0.yaml
> > > index 08d5a57ce00f..82629832e5a5 100644
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,p=
lic-1.0.0.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,p=
lic-1.0.0.yaml
> > > @@ -35,6 +35,11 @@ description:
> > >    contains a specific memory layout, which is documented in chapter =
8 of the
> > >    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U5=
4-MC-RVCoreIP.pdf>.
> > >
> > > +  While the "thead,c900-plic" would mask IRQ with readl(claim), so i=
t needn't
> > > +  mask/unmask which needed in RISC-V PLIC. When in IRQS_ONESHOT & IR=
QCHIP_EOI_THREADED
> > > +  path, unnecessary mask operation would cause a blocking irq bug in=
 thead,c900-plic.
> > > +  Because when IRQ is disabled in c900, writel(hwirq, claim) would b=
e invalid.
> >
> > This is a totally incorrect description of the errata required for C9xx=
 PLIC.
> >
> > Please don't project non-compliance as a feature of C9xx PLIC.
> >
> > > +
> > >  maintainers:
> > >    - Sagar Kadam <sagar.kadam@sifive.com>
> > >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > > @@ -46,6 +51,7 @@ properties:
> > >        - enum:
> > >            - sifive,fu540-c000-plic
> > >            - canaan,k210-plic
> > > +          - thead,c900-plic
>
> we still want specific SoC names in the compatible, the "c900"
> is still a sort-of placeholder.

Yes, we need "c900" compatible string as well. The "c9xx"
compatible string is for the custom PLIC spec followed by T-HEAD.

>
>
> > >        - const: sifive,plic-1.0.0
> >
> > The PLIC DT node requires two compatible string:
> > <implementation_compat>, <spec_compat>
> >
> > The C9xx PLIC is not RISC-V PLIC so, the DT node should
> > be: "thead,c900-plic", "thead,c9xx-plic"
> >
> > You need to change "- const: sifive,plic-1.0.0" to
> > - enum:
> >     - sifive,plic-1.0.0
> >     - thead,c9xx-plic
>
>

Regards,
Anup
