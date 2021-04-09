Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D24835942A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhDIEtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:49:43 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:32466 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhDIEtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:49:40 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 1394mm3t001055
        for <linux-kernel@vger.kernel.org>; Fri, 9 Apr 2021 13:48:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 1394mm3t001055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617943728;
        bh=KJyxpAMUu5os9o6Jt4uZ2kSpj4krFt8q/vhs9kRJbUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B5HfuGlcCnnqr3M3dEdH3OKYpLPdId31wCQ93fM6dindFrZl0V3g6xf5j9MXb8fB/
         FHol087Rod1FFYQ1WWqyhRCS5meG2npZ7b27jAZjiE1xvZXbKrbpc4jrCwZ0Ag09KI
         w1zpluv+W5bbYCb0tDhJLgsgv5IQOBw/ySXneV0vccaE9fz+gacWJT1SvEoKjJW3uE
         1GnvHd76c/yi4DHbZr2+k5psNC3LgGIztgpYMYM2I5eP5xkcLU1RnMtIrT1zqdUkDQ
         K0IRr9yKL+GZJFT4AfZbgrWikSZh7YatEs8FW8x74uiypTEvjiBmWFHTM+oZPO0CKI
         zcbFBVfcq8nMg==
X-Nifty-SrcIP: [209.85.215.176]
Received: by mail-pg1-f176.google.com with SMTP id d10so2957090pgf.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 21:48:48 -0700 (PDT)
X-Gm-Message-State: AOAM530tedb35zdTs/J7d3rMn51wYHUOSrY3fkhcR4WYP2kFZiby90Zt
        7zF83ywWrn/nxe2I3rZF1HZjClF7sKYlByocRqc=
X-Google-Smtp-Source: ABdhPJxKvV1u77zw96wY0kHvrzQ84+/YBZMHhC0qslIO9s0llO0dp227LFL8jhGkMdMHKKObckmNh3vvXOYCJWIz37M=
X-Received: by 2002:a65:45cf:: with SMTP id m15mr2503045pgr.7.1617943727671;
 Thu, 08 Apr 2021 21:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210301131533.64671-1-masahiroy@kernel.org> <20210301131533.64671-2-masahiroy@kernel.org>
 <a47312ad-8d62-b740-49cd-d1065bb76d76@digikod.net> <CAK7LNASQyyi0bOTLdmyhCwFg2PWPWq234ypVZnNkwLamoCAAmw@mail.gmail.com>
In-Reply-To: <CAK7LNASQyyi0bOTLdmyhCwFg2PWPWq234ypVZnNkwLamoCAAmw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Apr 2021 13:48:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzf+ZkyKX42=R1OaYobPdK-XBiQ8xxgXbY=THAw=78+w@mail.gmail.com>
Message-ID: <CAK7LNAQzf+ZkyKX42=R1OaYobPdK-XBiQ8xxgXbY=THAw=78+w@mail.gmail.com>
Subject: Re: [PATCH 1/7] x86/syscalls: fix -Wmissing-prototypes warnings from COND_SYSCALL()
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, x86 maintainers,


Thanks for picking up 1/7.

Could you check 2/7 - 7/7, please?


Thank you.


On Thu, Mar 25, 2021 at 11:31 PM Masahiro Yamada <masahiroy@kernel.org> wro=
te:
>
> On Thu, Mar 25, 2021 at 8:48 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net=
> wrote:
> >
> > Hi Masahiro,
> >
> > What is the status of this patch? Could you please push it to -next?
> > This would avoid emails from lkp:
> > https://lore.kernel.org/linux-security-module/202103191423.Jl0jVzfL-lkp=
@intel.com/
>
>
> Hmm, I also want to know the answer.
> This is the *third* time that I resent this patch
> to the x86 ML.
>
> This is a territory of the x86 subsystem
> because it is only touching
> arch/x86/include/asm/syscall_wrapper.h
> It is preferred to get this in via the x86 tree.
>
> x86 Maintainers,
> could you take a look please?
>
>
>


--=20
Best Regards
Masahiro Yamada
