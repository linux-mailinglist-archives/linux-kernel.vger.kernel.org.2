Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E836A16D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 15:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhDXNwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhDXNwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 09:52:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D4CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 06:51:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 12so81330326lfq.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jCOp7RZ+iu6cfzLw/VonyR2hYz8LTHhRBEdxzPYuVcg=;
        b=XzK4dnfUjaa18YTv5ERftP59UulNix2QP1HZGGPY7zmpnt+C2OBLGwsn2qCXHIlt9h
         53Tz6YR+Cfb7/Oa4RnaMsiSFxCgFt7mGpRi59uxVfarHRhx54VJe9oQYscLkZvGm8XAd
         ZxLHtbZQkp92s+8Hz0bxzlDDyJbR1xITI4j2TphaCDiNo9Q424354c7k93C1enUBwAX3
         WVtNnI5Vpla+dLynsdWqW6uEOhJWjZSF5AItV9PZdnJR6iFjhq8M1qDEjkf74Ep77wfq
         5ONu4xgqi5fhP2tLH3fDqv0/JfdO1cNKH960kGxjjscKrbwDtyYf1Ztm+s8W/OgX6/yg
         LKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jCOp7RZ+iu6cfzLw/VonyR2hYz8LTHhRBEdxzPYuVcg=;
        b=CeQVs6sZGNMAy9w0RK1e6XEII8s//9/V+rQ8yrI8T99NVfSg9oCSvn9Ef2L+vQXmrp
         GrF3eLuLCg1OEi7QSBdNsFTlp1cSZqOM77zLZbFnMKeLnDhKoQloYrMUcAJQHr+XIXRN
         nsn+eYki/LImAWEMp9LFm42fLinQtbx2H944cpy41kgq6gVHnwIaBWfzfH8MJ0A5pjnI
         sqCoKMoRlWPb8x28r7nlrxyWVvJcPBL4v47+lsZRYwg/8duhoFSu1ngI7q/KbZhF8bud
         bnhb+F454M58U0lPMneIVBdxcTlXdVpr+tfDRcFOG6yvREuqXhCWhj4RmBVX3JGZ2vjr
         stZA==
X-Gm-Message-State: AOAM533RzR8Ql5+5q0zP6oTWMHGEbwjo9+nI1MM/xrprbISA2rDjCNoZ
        JtTUWTi0ub1EwZoSeqVXtBIubP8zFXAstGmb2+U=
X-Google-Smtp-Source: ABdhPJxNSl4Ds3+3NRYLP1M4XlNF4lsytCjH8ibqpqR58NCb8atatdL9iMeH3luV4c8AR4aW+fVwDYb2EZkHlWL8NFg=
X-Received: by 2002:ac2:5042:: with SMTP id a2mr6027441lfm.650.1619272314835;
 Sat, 24 Apr 2021 06:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210422151022.17868-1-sxwjean@me.com> <20210422151022.17868-2-sxwjean@me.com>
 <ac6cf0ae-7565-180e-03b2-5e72f89a823a@csgroup.eu>
In-Reply-To: <ac6cf0ae-7565-180e-03b2-5e72f89a823a@csgroup.eu>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Sat, 24 Apr 2021 21:51:28 +0800
Message-ID: <CAEVVKH-p4NqizZjC0DNEUgsw9eWurd1YWxW5QQwTxvUZHR5g4A@mail.gmail.com>
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

On Thu, Apr 22, 2021 at 11:29 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 22/04/2021 =C3=A0 17:10, Xiongwei Song a =C3=A9crit :
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > The esr register has the details of Program Interrupt on BookE/4xx cpus=
,
> > printing its value is helpful.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >   arch/powerpc/kernel/process.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proces=
s.c
> > index 5c3830837f3a..664aecf8ee2e 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1459,6 +1459,7 @@ static bool interrupt_detail_printable(int trap)
> >       case INTERRUPT_MACHINE_CHECK:
> >       case INTERRUPT_DATA_STORAGE:
> >       case INTERRUPT_ALIGNMENT:
> > +     case INTERRUPT_PROGRAM:
>
> With this, it will also print the DSISR on 8xx/6xx so it will print garba=
ge.
>
> 8xx/6xx provide the information in SRR1. If you want to proceed, you have=
 to do the same as in ISI:
> Copy the content of SRR1 into regs->dsisr in the assembly handler in head=
_book3s_32.S and in the
> instruction TLB error handler in head_8xx.S

Good point.
