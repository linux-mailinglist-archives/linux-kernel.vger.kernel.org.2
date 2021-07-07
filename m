Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9463BECF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 19:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGGRUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 13:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhGGRUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:20:46 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC084C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 10:18:05 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so4231419oiv.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zlDFOGjXouTQIFi23PupdbcwNOzhZtlzVmn1XuDDG0=;
        b=KFMEQm7oSGE9cUX1bSsKrSdUQjpO8T0fqel95+e8ch2aPHqeA2NDtztXqpJxWJHl7P
         AipuvkgagJDT8Tvsb4DEi6oznXKwOIPyw5kq9Ds6oJde6rNnY4aFliHzbJQwpIAHjm4x
         s5QdpalknK7w+dHh9eooWixJRjsfu52gcqn+JiwQV0gJ6cM8qyvCQBmUmXbZnhNjLvNe
         i1hYnteonDAXK9gpW0JS+RrggleUMLieo1lHLRANKUd/FKZHcoOVpJFgQlduDJ6jmk2f
         r9P0E7yKFQU5Mtp3zvsPJ0UAG5pkBHotRmhT5kqQbM9hVUsrnAB5dH61KJVjnIxMIrZ8
         V2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zlDFOGjXouTQIFi23PupdbcwNOzhZtlzVmn1XuDDG0=;
        b=FrKRp12PA8wShzLxrI0LgpMxYxRBJDFxqir/mYwtb5o3jXJFhSdioyJscmBV+g5yPE
         r7UJJP6p9zVeCzzwfl1tcxFjO7dNBqkhvDNONC3x9/lCb3l89I5KKP9QI4XHumBX2cV8
         fqlAs93wdKSRYlEMdQwKNRfU6r9D/IneDL6aX8JYTSF2wdcmfH2/pSh2WsPq2Gqw63Ai
         KTd/aYmTy5ixcO2KtArBcTy1p3NVBRGdf3qi5rr8GN9L6x1P284TuNVJmHouT2TBqb2d
         S/GnX5zE/qEfTooMy5SK2uQ0WNfdio+d+UJZiKfkFLDyNdDM+u8GLpCD1bLtWLUkoXzD
         f35Q==
X-Gm-Message-State: AOAM532ttw/vWUsAASzF2M4Wi6ogkUUcbMgvNca50lqk8AlVoWPRvW0D
        DBFiNv3mmS1FB1cztyASqtkyuPHTFNf3f4wBFvT44w==
X-Google-Smtp-Source: ABdhPJzkwIV2dAw6OuD+6NjV5UuwBbAnbwKElq0XwqOdq7Eh1qd+Ppn7pXFjfDc4uEzf0QLJR61ZUBmRS9h5pnNULJc=
X-Received: by 2002:aca:1e07:: with SMTP id m7mr18873358oic.28.1625678285069;
 Wed, 07 Jul 2021 10:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <de6b97a567e273adff1f5268998692bad548aa10.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <20210706195233.h6w4cm73oktfqpgz@habkost.net> <4cc2c5fe-2153-05c5-dedd-8cb650753740@redhat.com>
 <CAOpTY_qdbbnauTkbjkz+cZmo8=Hz6qqLNY6i6uamqhcty=Q1sw@mail.gmail.com>
 <671be35f-220a-f583-aa31-3a2da7dae93a@redhat.com> <CAOpTY_paTO=xqfGXPCC2Paty5ptJ6Dqpo4Tzb4C2hrO_t=vS8w@mail.gmail.com>
 <CALMp9eSJyvU1=FndZyR+hZMtKPWwgibKisBqp0Xcx4jxjrWn2w@mail.gmail.com> <CAOpTY_pefOmJ0zJjUzitgTGxqgX6XxwTP0fMKoiyuBCHrh+AWg@mail.gmail.com>
In-Reply-To: <CAOpTY_pefOmJ0zJjUzitgTGxqgX6XxwTP0fMKoiyuBCHrh+AWg@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 7 Jul 2021 10:15:09 -0700
Message-ID: <CALMp9eSNS+yKsDgS3TXH6bSf4eUM2sJaRrLxZa+Y8e0FqVhRJA@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/tsx: Add cmdline tsx=fake to not clear CPUID bits
 RTM and HLE
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Victor Ding <victording@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Anand K Mistry <amistry@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org, Jiri Denemark <jdenemar@redhat.com>,
        "libvir-list@redhat.com" <libvir-list@redhat.com>,
        Michal Privoznik <mprivozn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 10:08 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Wed, Jul 7, 2021 at 12:42 PM Jim Mattson <jmattson@google.com> wrote:
> >
> > On Wed, Jul 7, 2021 at 8:09 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >
> > > CCing libvir-list, Jiri Denemark, Michal Privoznik, so they are aware
> > > that the definition of "supported CPU features" will probably become a
> > > bit more complex in the future.
> >
> > Has there ever been a clear definition? Family, model, and stepping,
> > for instance: are these the only values supported? That would make
> > cross-platform migration impossible. What about the vendor string? Is
> > that the only value supported? That would make cross-vendor migration
> > impossible. For the maximum input value for basic CPUID information
> > (CPUID.0H:EAX), is that the only value supported, or is it the maximum
> > value supported? On the various individual feature bits, does a '1'
> > imply that '0' is also supported, or is '1' the only value supported?
> > What about the feature bits with reversed polarity (e.g.
> > CPUID.(EAX=07H,ECX=0):EBX.FDP_EXCPTN_ONLY[bit 6])?
> >
> > This API has never made sense to me. I have no idea how to interpret
> > what it is telling me.
>
> Is this about GET_SUPPORTED_CPUID, QEMU's query-cpu-model-expansion &
> related commands, or the libvirt CPU APIs?

This is my ongoing rant about KVM_GET_SUPPORTED_CPUID.
