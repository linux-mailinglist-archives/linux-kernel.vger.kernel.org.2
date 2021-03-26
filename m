Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D5D34AD9A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZRdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCZRdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:33:05 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC60C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:33:05 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so5898535otn.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DM3M0JTgl270zpjMpK3QSJQtsz7+LSjPebarDvoiyI=;
        b=uqZMwM0KvkdJCK8D98xnjsxDeePbRyA8Rjr46wQXqOY+JwAmaN0dEncZm5IDoqNwDI
         O7st9MH2cSCcq0BkK7/vioz0uUgu88QnaemEvdm56xZuD8MlT39sESm6+y9tSJ7kfAVF
         eDNrtcCO5SOCpg0univ92ZvV6zuMhyZtHyBTd73jrqh886wcWwpUyQREeGxRRpmVps+S
         8WW5qB5Vm4D1z21GVhki0bnqSlTECaYnswexPiniO5bRgYUYYZPeUvlFqmBePvMImM8n
         Te9R5LWksAi1/sAZWcAl94xGKo3cg7T/6eZGwrJnS8QoDlnHtRByjnSUHu1VnW1KRL8X
         6zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9DM3M0JTgl270zpjMpK3QSJQtsz7+LSjPebarDvoiyI=;
        b=U8j8sOzuaFSTcpLffGwqko8w/SyYZYibAiCodcwpJ6nWi7HbckrjztA/yDkHrjAaI/
         dSQ6YWB+/la/tk0D9VQUxmbS1mWRNXT58q7s2WyTIYW5KUQV6i3zL4SmP8TwTeIYaJkP
         xKGGfrG77vL5EduOt/a4VFANXOOG2gJtNc13VTSWycgy/516zDCG3iS+vg1p9SZHZbBz
         sOpWPomyGFCFfVxt3SUg0ShIUNe2xR1tQH2pWGOTpWPgQ7A26nzqeDUsVb7I6O2uuJ5m
         P2oQfjWTHDPnNgc94ZKU55ZdwxtUxH74MEhYsRhn46wmksmHBCzepSi0Tyt1WTxXaUBO
         2G4Q==
X-Gm-Message-State: AOAM532fBaMfbi0O/EspOjimtZy1bv1mpgzPbdLyoN5EtzebnqhtAHrq
        m6wTqb83ngXreMl30j23D8bNReFHwcg0/wX7
X-Google-Smtp-Source: ABdhPJydsAzb4rEd+SuzOyJ8lwkzaS5v3OWez35mb92K1+a8lG6YUUjE0IIdXBbz4MKylQPwUEKL4A==
X-Received: by 2002:a05:6830:1404:: with SMTP id v4mr12226094otp.2.1616779984622;
        Fri, 26 Mar 2021 10:33:04 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id u194sm1860477oia.27.2021.03.26.10.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 10:33:04 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
Date:   Fri, 26 Mar 2021 13:32:59 -0400
Message-ID: <2126921.HKiPhdEZJ2@ubuntu-mate-laptop>
In-Reply-To: <CAMuHMdVaByX=ph82etGn5a0hV6+rGitD=gG8Y1zNkz7+UO+Uew@mail.gmail.com>
References: <20210320001518.93149-1-julianbraha@gmail.com> <2598523.FcGXNBlX6l@ubuntu-mate-laptop> <CAMuHMdVaByX=ph82etGn5a0hV6+rGitD=gG8Y1zNkz7+UO+Uew@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 25, 2021 3:20:59 AM EDT you wrote:
> Hi Julian,
> 
> On Thu, Mar 25, 2021 at 1:09 AM Julian Braha <julianbraha@gmail.com> wrote:
> > On Wednesday, March 24, 2021 4:12:34 AM EDT you wrote:
> 
> > > On Wed, Mar 24, 2021 at 7:48 AM Julian Braha <julianbraha@gmail.com> wrote:
> > > > On Monday, March 22, 2021 3:43:41 AM EDT you wrote:
> > > > > On Sun, Mar 21, 2021 at 11:40 PM Julian Braha <julianbraha@gmail.com> wrote:
> > > > > > On Sunday, March 21, 2021 2:28:43 PM EDT you wrote:
> > > > > > > On Sat, Mar 20, 2021 at 1:17 AM Julian Braha <julianbraha@gmail.com> wrote:
> > > > > > > > When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
> > > > > > > > is disabled, Kbuild gives the following warning:
> > > > > > > >
> > > > > > > > WARNING: unmet direct dependencies detected for FRAME_POINTER
> > > > > > > >   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
> > > > > > > >   Selected by [y]:
> > > > > > > >   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > > > > >
> > > > > > > > This is because LATENCYTOP selects FRAME_POINTER,
> > > > > > > > without selecting or depending on ARCH_WANT_FRAME_POINTERS,
> > > > > > > > despite FRAME_POINTER depending on ARCH_WANT_FRAME_POINTERS.
> > > > > > > >
> > > > > > > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > > > > > >
> > > > > > > Thanks for your patch!
> > > > > > >
> > > > > > > > --- a/lib/Kconfig.debug
> > > > > > > > +++ b/lib/Kconfig.debug
> > > > > > > > @@ -1675,6 +1675,7 @@ config LATENCYTOP
> > > > > > > >         depends on DEBUG_KERNEL
> > > > > > > >         depends on STACKTRACE_SUPPORT
> > > > > > > >         depends on PROC_FS
> > > > > > > > +       select ARCH_WANT_FRAME_POINTERS if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > > > >
> > > > > > > ARCH_WANT_FRAME_POINTERS is a symbol that is only to be selected by
> > > > > > > architecture-specific configuration, and must not be overridden:
> > > > > > >
> > > > > > >     # Select this config option from the architecture Kconfig, if it
> > > > > > >     # is preferred to always offer frame pointers as a config
> > > > > > >     # option on the architecture (regardless of KERNEL_DEBUG):
> > > > > > >
> > > > > > > Probably this should be turned into a depends instead?
> > > > > > >
> > > > > > > >         select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > > > > >         select KALLSYMS
> > > > > > > >         select KALLSYMS_ALL
> > > > >
> > > > > > Making this a 'depends' causes a recursive dependency error.
> > > > > > Any other ideas?
> > > > >
> > > > > What about
> > > > >
> > > > >     -select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE &&
> > > > > !ARM && !ARC && !X86
> > > > >     +depends on FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE
> > > > > && !ARM && !ARC && !X86
> > > > >
> > > > > ?
> > > >
> > > > Sadly, this won't work either. In Kconfig, 'depends' cannot have an 'if' after it (only 'select' can.)
> > > > Kbuild gives an error for this.
> > >
> > > Oops
> > >
> > >     select FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM
> > > || ARC || X86
> > >
> > > of course.
> 
> > I think it's a typo, but if you meant:
> > select FRAME_POINTER if MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
> > Then that works.
> 
> (Bummer, I shouldn't reply to emails before my morning coffee)
> Yes, it is a typo.  I meant:
> 
>     depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE ||
> ARM || ARC || X86
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 

Hi Geert,

I can relate on the coffee :)

Yes:
>     depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE ||
> ARM || ARC || X86
this is an acceptable solution. 

- Julian Braha





