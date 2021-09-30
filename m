Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F3E41D219
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 06:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhI3EKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 00:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhI3EKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 00:10:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5FAC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:08:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z24so19524052lfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t3FALQ9F/29nwpH8yMUnQ6iSaUPA8tnjZM1xJdoGkuk=;
        b=gK60KkPoCIhYjuIuwMim1u3NwuU9HylcGXNclr7e0uqmbx+CoAzIWT0pe1fLPVl0L3
         w5u9kwiH+H0vxWtAD+y15k4oAAWs1MrP04iGYomqEUqp6veYnSMmKS28XG4FGb7Dma+Y
         66q/zAAp90Erg5XJHSwCUOOCnywwpudyr4S5bSoxF+msczjUqEZMuFE7fjiq/HVqvTYR
         9eE/gC5d3bQedL9VhZYb7hmsDTOxfi1cAygzz9bOJm0VmqS6vJ9mUkO2npkLdDloFTO2
         589WHGrGqJg7Vxr96r3XdjQKYkS1ABMxBEdKh7C8C+nhzNVnR4aO11DpWf3uD4lbKo/x
         OYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3FALQ9F/29nwpH8yMUnQ6iSaUPA8tnjZM1xJdoGkuk=;
        b=ANqwqUp75DrBhanAkbbehxjDGQ7Y5irFq4iv2iFHx7wkGKSgWOJOGWl2c5SI8e6jO4
         bfv+Q6M6Bhgf1G1pxeGrNr6xG5jCJudKx+MivPuiUhpmXA9Nvjl7rE9pA4CLz2gvz5xi
         mmmRmS2yKriOyI8pFvyMSX2FmnKAXD9qRCPipuUwnYUpDEG1JCEuoR+E6p2DHGi9VTP7
         OdFwYBrKpf7z78pvM05tALDWDjNc6nDHtAh4uJb6wo8nsaL/QKcuBnVoAGkPr6K8EmqV
         MdE/fq/fwLTPZwxFKop/MXHEfOmtCfDgsB3ynS6QA7Y7zjpsz0yRA2guqX3Q0uAph5gL
         IjyA==
X-Gm-Message-State: AOAM531y/YFgeMgBQOWPMiBCaRFcdFpUYOWKUwU8fnXzyszEWUevlANN
        CVsJTk8JjlFr8kPG+LL8aN8NDGGwRHIKN3liOS22ow==
X-Google-Smtp-Source: ABdhPJyav0ctqOfrQN5qVG918Z+tPvChnwnLpYKr3rd9LFJlbCyzYrotLyv/ym5LkvisvocbMG+fF0MLyYyJoozE6zQ=
X-Received: by 2002:a2e:7504:: with SMTP id q4mr3777457ljc.422.1632974934566;
 Wed, 29 Sep 2021 21:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-11-pasha.tatashin@soleen.com> <20210929124513.GD21631@willie-the-truck>
In-Reply-To: <20210929124513.GD21631@willie-the-truck>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 30 Sep 2021 00:08:17 -0400
Message-ID: <CA+CK2bDBr_upP87hg-8EiUz3ucZ93tAaYaZrfN3JhqszF=PvvQ@mail.gmail.com>
Subject: Re: [PATCH v17 10/15] arm64: kexec: use ld script for relocation function
To:     Will Deacon <will@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, missed two comments:

> >       /* Flush the reloc_code in preparation for its execution. */
> >       dcache_clean_inval_poc((unsigned long)reloc_code,
> > -                            (unsigned long)reloc_code +
> > -                            arm64_relocate_new_kernel_size);
> > +                            (unsigned long)reloc_code +  reloc_size);
>
> Extra whitespace.

Yeap, extra whitespace after '+', will fix it :)

>
> >       icache_inval_pou((uintptr_t)reloc_code,
> > -                      (uintptr_t)reloc_code +
> > -                      arm64_relocate_new_kernel_size);
> > +                      (uintptr_t)reloc_code + reloc_size);
> >       kexec_list_flush(kimage);
> >       kexec_image_info(kimage);
> >
> > diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> > index b4fb97312a80..9d2400855ee4 100644
> > --- a/arch/arm64/kernel/relocate_kernel.S
> > +++ b/arch/arm64/kernel/relocate_kernel.S
> > @@ -15,6 +15,7 @@
> >  #include <asm/sysreg.h>
> >  #include <asm/virt.h>
> >
> > +.pushsection    ".kexec_relocate.text", "ax"
>
> Just use .section if you're putting the entire file in there?

Good point, I will change it to .section.
