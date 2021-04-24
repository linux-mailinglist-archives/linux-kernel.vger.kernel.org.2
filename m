Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E036A191
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 16:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhDXOWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 10:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhDXOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 10:22:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21986C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 07:21:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id l22so51452075ljc.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P531jV/gE1FZqL6RA2hoIiPZe+DPKeqrBTIMQshMdGo=;
        b=o1clgpPjpGEFw3+FHdVkmFJOv8/dKJlYdw2w7kl6XVx/GSsBL29iRck78tEqK7ObYF
         MbFaT+nPdKpMirkk+KDuJjJcsqB+FlZ1QKk9PXEkAxhKvaKa8p4OCNztMP+dWbX02ykS
         3nVlCuHpAACeGMCRSdJncL9oTU4XvfOQD6ovqWO4Xlksm6+W7TGwUPSpV0+YogaDt9Cs
         C5G8CBSqx4MMDNAHmk/5g+Y5pR58HapTLrB7QN3lU/KTKl4RQHgX+wQKqZ1p0UnuRTiA
         S49Q67T95z+/mqJMg1Nu6HV1LpJN43+/AS5SBdD5QuVyfH56iQgh9EQThR94wqDJ2lGg
         sjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P531jV/gE1FZqL6RA2hoIiPZe+DPKeqrBTIMQshMdGo=;
        b=uGJUN6sAmN+VZUiJapiw7n0VjJ7/w0DM0jQ4eoZzNbXpnZVptkDuXukZCp2tCdvWn3
         fA+DaiEyV03JoggV7pCs06gaaXhQQY3qjv3JtyFgTqr1iNlofDBGhkD8QKw4N9FrVNyI
         zAagNvhpA35I1fJ+ZGt8Oy740h8VFC5+eEZ4a7lXz6kTUdGdetJO5W2Xc2yNUf9+cGUC
         qP6U5Lplv1qU8bibEwcag2ZVD/SXMyOwAoN0KtQ8ij102478JT7W/5yksY95jtroCMpZ
         NXhRY2C4AJ3bKwT/N9GyMMvP7BaYDRiZcIRUe0m2rSD2I/CkPez7HMKAAUATvErbXXyM
         /SYg==
X-Gm-Message-State: AOAM532lhMqzgtA9nEEt4k+Az0USjy6XOM+97JNqB8uaCOvrUf9FRRm0
        qleqbW8lvNyqxSVu8rOmSSORzFNpbUac2JbTa1A=
X-Google-Smtp-Source: ABdhPJwjfSVVifAjHfydswQQAARoNfpuidd98YqrcBbE9hLP1VRL8N8S3uHAuepIxwUToZfhYrytyg4o+OqulWITkuA=
X-Received: by 2002:a2e:bb8f:: with SMTP id y15mr6174605lje.86.1619274115443;
 Sat, 24 Apr 2021 07:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210422151022.17868-1-sxwjean@me.com> <20210422151022.17868-2-sxwjean@me.com>
 <ac6cf0ae-7565-180e-03b2-5e72f89a823a@csgroup.eu> <7b3ad970-707d-ffcd-e4a3-0b6e622db403@csgroup.eu>
In-Reply-To: <7b3ad970-707d-ffcd-e4a3-0b6e622db403@csgroup.eu>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Sat, 24 Apr 2021 22:21:29 +0800
Message-ID: <CAEVVKH9xM7_u1xY9MswxT2ZH6XEDDxe2sW7f47ajw+x5J5vzgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc: Print esr register when hitting Program Interrupt
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Xiongwei Song <sxwjean@me.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        aneesh.kumar@linux.ibm.com, 0x7f454c46@gmail.com,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 12:50 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 22/04/2021 =C3=A0 17:29, Christophe Leroy a =C3=A9crit :
> >
> >
> > Le 22/04/2021 =C3=A0 17:10, Xiongwei Song a =C3=A9crit :
> >> From: Xiongwei Song <sxwjean@gmail.com>
> >>
> >> The esr register has the details of Program Interrupt on BookE/4xx cpu=
s,
> >> printing its value is helpful.
> >>
> >> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> >> ---
> >>   arch/powerpc/kernel/process.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proce=
ss.c
> >> index 5c3830837f3a..664aecf8ee2e 100644
> >> --- a/arch/powerpc/kernel/process.c
> >> +++ b/arch/powerpc/kernel/process.c
> >> @@ -1459,6 +1459,7 @@ static bool interrupt_detail_printable(int trap)
> >>       case INTERRUPT_MACHINE_CHECK:
> >>       case INTERRUPT_DATA_STORAGE:
> >>       case INTERRUPT_ALIGNMENT:
> >> +    case INTERRUPT_PROGRAM:
> >
> > With this, it will also print the DSISR on 8xx/6xx so it will print gar=
bage.
> >
> > 8xx/6xx provide the information in SRR1. If you want to proceed, you ha=
ve to do the same as in ISI:
> > Copy the content of SRR1 into regs->dsisr in the assembly handler in he=
ad_book3s_32.S and in the
> > instruction TLB error handler in head_8xx.S
>
> In fact, we already have get_reason() called by do_program_check() to ret=
rieve the reason of the
> program check exception. Maybe it could be used to print usefull informat=
ion instead of starting
> doing almost the same is another way.

Yes, there is the get_reason() function. But if the program interrupt
is triggered in kernel mode,
the reason can be lost , see the code below:

335 static bool exception_common(int signr, struct pt_regs *regs, int code,
 336                               unsigned long addr)
 337 {
 338         if (!user_mode(regs)) {
 339                 die("Exception in kernel mode", regs, signr);
 340                 return false;
 341         }

The third parameter(int code) of exception_common is to pass the
reason, when in kernel
mode, the "code" parameter is lost, hence I append INTERRUPT_PROGRAM here.

This is for __show_regs(), so just printing the content of the
register is fine I think.

>
> Or we do as I suggested above, and we remove that get_reason() stuff. But=
 get_reason() is also used
> by the alignment exception. So that doesn't look easy.
>
> I don't know what the best approach is.

Is it acceptable to print the interrupt reason before invoking die()
in exception_common()?

Regards,
Xiongwei
