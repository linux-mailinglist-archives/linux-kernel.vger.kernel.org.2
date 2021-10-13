Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BC742B10C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJMAnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhJMAnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:43:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE1A961039
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634085676;
        bh=GH3igafYeytaTpk7zJsmr6w3R02FY4WrWs5BsNlaxL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DJddNpRTq6rX0axpfO3wXrIFaGPJAYDjvw1SzFbXzZnlzsteFD8MKDZr6T52lzGRi
         9iz308qT2ug/X1K1WECUIMYuZ2bP+Ag4vJNKzWrh7VQcISb+ffZi6hXoZNhJmHJmue
         o4oP+iIPia7NC01wYayfb8NjWcMDSG892tG1sWCpsCbiOirj8dFkfChAMueW141Odc
         TMDj69XJ4UG/dzsWqW/VCYNW/G6DAiibHqQdSg4Nn5nKn82KSkLOkmlzsjtxVfXezw
         FM16VQrqlsTS9z8l5O5NVpxEav+Ypt7LtIFgO2Irs9IEKhx2bc33p2R/TMuGs/2k6a
         xRcgslQzwICLg==
Received: by mail-vk1-f172.google.com with SMTP id j38so769419vkd.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:41:16 -0700 (PDT)
X-Gm-Message-State: AOAM533aBmXaOk5JEtcp//ABO0ZnLfkWYO8nqAaLN0GmPmm+FJh7hxZH
        BbtIoo3SwJjDwu87DMXrLcL9JerfzYO2qkc2gO0=
X-Google-Smtp-Source: ABdhPJzXK69p14VG2+bbGVOT4RRVuxqtUe6l0McroQAIodF6h+L0cP/wsTVSk6Fc6K8MDZdPRNuoAfEZF/aSPd6k1Rg=
X-Received: by 2002:a05:6102:32cd:: with SMTP id o13mr30558491vss.50.1634085675849;
 Tue, 12 Oct 2021 17:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211012153432.2817285-1-guoren@kernel.org> <3384738.8kAFQ6LgSR@diego>
In-Reply-To: <3384738.8kAFQ6LgSR@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Oct 2021 08:41:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSpVfgOQVjsZ37ZknmU-Kmht5JXc8D3-Oif2i-RWzfFCQ@mail.gmail.com>
Message-ID: <CAJF2gTSpVfgOQVjsZ37ZknmU-Kmht5JXc8D3-Oif2i-RWzfFCQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: update riscv plic compatible string
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 11:41 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
>
> Hi,
>
> Am Dienstag, 12. Oktober 2021, 17:34:31 CEST schrieb guoren@kernel.org:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add the compatible string "thead,c9xx-plic" to the riscv plic
> > bindings to support SOCs with thead,c9xx processor cores.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > ---
> >  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sif=
ive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controlle=
r/sifive,plic-1.0.0.yaml
> > index 08d5a57ce00f..202eb7666f9b 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,pli=
c-1.0.0.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,pli=
c-1.0.0.yaml
> > @@ -46,6 +46,7 @@ properties:
> >        - enum:
> >            - sifive,fu540-c000-plic
> >            - canaan,k210-plic
> > +          - thead,c9xx-plic
>
> Devicetree bindings shouldn't use asterisks (the xx-part).
> Instead you want (probably)
>
> +          - thead,c906-plic
> +          - thead,c910-plic
Okay, remove xx-part. But I will use thread,c900-plic for all of them.

>
> to name the specific SoCs that plic is used on
>
>
> Heiko
>
> >        - const: sifive,plic-1.0.0
> >
> >    reg:
> >
>
>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
