Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407AE41A93B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbhI1HDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbhI1HDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:03:14 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E509C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:01:35 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id a9so12870807qvf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gKnIAqOx2fpSsjafReu8T2u4xETk4bKWTRz3yCNHzjI=;
        b=E07Nv6MOqKa+ILOhSg9aHDeaee684C+QGVF6V+5A/LJuZ+B/WigEII/4VQ3b8IUseA
         VAh2lFa6ABC6TrwArGEMXZ95rxiBq10EgdfK7HMZSXDBuaaXYxXP6LYfcsYEXBYBhDmd
         uHvxnwlSuRN/G+ZBnFeRD6pg4lz5L4XefYV0RMNEbLXTwl507zzlItF/MN+6Nr+t7ZHZ
         LH6hggV2uhQqhVH6pbHf7SoZuHjUASEwEbTSzkpoSx77Rc1ZvbjY4FliiqWA0wPpINZM
         FX9s6HmNIPKsGZYFoIblAPQpiAufS95bjSZvb7wJdV+ur0s24XXfeTWlDiFbI4pZ94Vt
         /QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gKnIAqOx2fpSsjafReu8T2u4xETk4bKWTRz3yCNHzjI=;
        b=AW9vNJhf2moltRisRIevqhMPZ+9ZFvtK4tDUkeAFUiIV4G7NHKgiEa2hgR5ff1sRSu
         kjaevlR/0rtUUWBVCRPnRwRwh+qGlVziq1aukORlvxVv3IUMXLCMPAbNlKJ92HSrWEuK
         4us9LoebmNjTcTAITDkX7VZ/uuTT9dMplwBauxBhoh4dtK0f6altgljgKkNK7JnnW+lN
         ZeGhs+E1T8g1ZyT2QlIUZPqsox2FI5h6ShBaMwn/AVBWdA+awZ8pSsoO37c+fjYPcDJH
         TkMoD5UOqrld3ey/26Kl3WIyIEca+nKtMO6LRXb3Xo0fyQOUhKFFGLgFT8HC8PBRIrc0
         SoVA==
X-Gm-Message-State: AOAM531/SwBOg5bwmG7BMF/8FSkiL2M86V48YJbCUk1IfSqb4waq/iVb
        +AKiqI+C7wNvM8Ef8Ar+UqIGohzMsgk3+QsBRAt+bA==
X-Google-Smtp-Source: ABdhPJy6qut5d4t8T2qj5WlvpYzsia5/XSW53qHwz/D3gNQY00xsOT1JNb8WeSaOdJVkToKtDUU79AitE1h8udMj8NU=
X-Received: by 2002:ad4:55af:: with SMTP id f15mr4054897qvx.32.1632812494336;
 Tue, 28 Sep 2021 00:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <33c485ee595aff1e19a0e43074da59779f58d105.1631121222.git.greentime.hu@sifive.com>
 <CAFiDJ59nbV_opZRxfsv2kj8ObSguT75GJUKhA6Zd3+BpQOynjw@mail.gmail.com>
In-Reply-To: <CAFiDJ59nbV_opZRxfsv2kj8ObSguT75GJUKhA6Zd3+BpQOynjw@mail.gmail.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 28 Sep 2021 15:01:22 +0800
Message-ID: <CAHCEeh+XDVEPjKhJ9OYv3xMGLRDnygA6CK_y8tDzr9RYFKC-Aw@mail.gmail.com>
Subject: Re: [RFC PATCH v8 15/21] riscv: Add vector extension XOR implementation
To:     Ley Foon Tan <lftan.linux@gmail.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ley Foon Tan <lftan.linux@gmail.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:30=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Sep 9, 2021 at 1:49 AM Greentime Hu <greentime.hu@sifive.com> wro=
te:
> >
> > This patch adds support for vector optimized XOR it is tested in spike =
and
> > qemu.
> >
> > Logs in spike:
> > [    0.008365] xor: measuring software checksum speed
> > [    0.048885]    8regs     :  1719.000 MB/sec
> > [    0.089080]    32regs    :  1717.000 MB/sec
> > [    0.129275]    rvv       :  7043.000 MB/sec
> > [    0.129525] xor: using function: rvv (7043.000 MB/sec)
> >
> > Logs in qemu:
> > [    0.098943] xor: measuring software checksum speed
> > [    0.139391]    8regs     :  2911.000 MB/sec
> > [    0.181079]    32regs    :  2813.000 MB/sec
> > [    0.224260]    rvv       :    45.000 MB/sec
> > [    0.225586] xor: using function: 8regs (2911.000 MB/sec)
> >
> > Co-developed-by: Han-Kuan Chen <hankuan.chen@sifive.com>
> > Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/include/asm/xor.h | 74 ++++++++++++++++++++++++++++++++
> >  arch/riscv/lib/Makefile      |  1 +
> >  arch/riscv/lib/xor.S         | 81 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 156 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/xor.h
> >  create mode 100644 arch/riscv/lib/xor.S
> >
> > diff --git a/arch/riscv/include/asm/xor.h b/arch/riscv/include/asm/xor.=
h
> > new file mode 100644
> > index 000000000000..60ee0224913d
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/xor.h
> > @@ -0,0 +1,74 @@
>
>
> [...]
>
> >
> > +extern bool has_vector;
> > +#undef XOR_TRY_TEMPLATES
> > +#define XOR_TRY_TEMPLATES           \
> > +       do {        \
> > +               xor_speed(&xor_block_8regs);    \
> > +               xor_speed(&xor_block_32regs);    \
> > +               if (has_vector) { \
> > +                       xor_speed(&xor_block_rvv);\
> > +               } \
> > +       } while (0)
> > +#endif
> >
> bool has_vector is changed to has_vector() function now, should this
> change as well?

That's right. Thank you, LeyFoon.
I'll merge the patch to fix the has_vector() issue in next version patchset=
.
