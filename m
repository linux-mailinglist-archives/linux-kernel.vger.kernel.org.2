Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB9452C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 08:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhKPHvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 02:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhKPHvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:51:10 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F8C061764
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 23:48:13 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id k22so24715486iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 23:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNMO16ys3SRg3qubZRbpEBsLE4XxyPjpPKgU0sFNabA=;
        b=MqjpB+4wPdOWfk2Bo4O/NQ4PTb3NOwItTsesWBCqXvU6vjfxV5XTK2ajOvc/S0sJDb
         66NqfYzIBE2E6pvT8ncZDGIzjYMR5xcF73d6s57iu+lOBZUj15IWAkqYRr5c6phdlRsi
         yYaE6Pn3k1/t0sHkxnFE1Sjak06f8AceK4aDDOAPPDYyUaccTfaorssj0IVL2M92nt1x
         B2VO82w384ogSnmQzGzFn3H/UqlxoZnyiCapU52PGjbR2n/xoQ5NnXaddOLlhUS1KfxS
         woK650GuT5tVr8HEVT4/4wvVCHU7tJnrrIkNt36jaGY8onAqjBOl5Dm5AYwoNYusghN+
         EDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNMO16ys3SRg3qubZRbpEBsLE4XxyPjpPKgU0sFNabA=;
        b=pcmdflNzBQuEUlyVbflkR0pqzutFIs2com45CJPGJmEWtlHjZhwllBYACWLH/rQPNP
         QvtnPhOphRL5zGw6jgytWlrvQA47PwTxrFT92Ybj32L4zG8WJl5aCrfoFWqBPuBixT+2
         NEBu2vhzDjYK3wvwg7AxWuvICYtpg59dpiZ7A21kw4n9RGPFTu+anjSk2rEmSG4Sc8Dp
         WsDljeL6Mt4/0OQeISfQxWkksEQ/ggFvsuvd2Cyd2lsA7XMh14+qzUmBSh7cw+MIvEmj
         9pIFalV/mBMaay0qcR5F1Rgy95fsvTpwdaZNCkS7uz32D0hVKDquUPgb5pyQPIcOpNDZ
         0yJA==
X-Gm-Message-State: AOAM531uf98lYcI3ZIHikwdML3gqch6Xdtb0OFF4sa1TTTncZJzI6Bz5
        HDxP27uOK1xuKF4kWKbbJIfjfBg4sLuuJaIP4T0iUg==
X-Google-Smtp-Source: ABdhPJx3Yc5uyNCfwqgrsz/VfGuZYV0WKpdGsHKujPAou5HLdXYFyndjQdxl+ztnJsUAxUmxUPOLu9bsXIrrenpByEg=
X-Received: by 2002:a5d:9492:: with SMTP id v18mr3459492ioj.158.1637048893052;
 Mon, 15 Nov 2021 23:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com> <20211111084415.663951-4-eranian@google.com>
 <YY6QBXs0sM16DdbV@hirez.programming.kicks-ass.net>
In-Reply-To: <YY6QBXs0sM16DdbV@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 15 Nov 2021 23:48:01 -0800
Message-ID: <CABPqkBShSBaJH+PR6rMkRRzjZAKN5zPhcdnLWx=4a-yQWxcA2A@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 8:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 11, 2021 at 12:44:05AM -0800, Stephane Eranian wrote:
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 38b2c779146f..28559557f966 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -683,11 +683,16 @@ void x86_pmu_disable_all(void)
> >
> >               if (!test_bit(idx, cpuc->active_mask))
> >                       continue;
> > +
> > +             if (is_amd_brs(hwc))
> > +                     amd_brs_disable();
> > +
> >               rdmsrl(x86_pmu_config_addr(idx), val);
> >               if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
> >                       continue;
> >               val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
> >               wrmsrl(x86_pmu_config_addr(idx), val);
> > +
> >               if (is_counter_pair(hwc))
> >                       wrmsrl(x86_pmu_config_addr(idx + 1), 0);
> >       }
>
> Please, stick that in amd_pmu_disable_all().


If I do that, I need to add a for_each_counter() loop to
amd_pmu_disable_all() but it does not have one call systematically.
If you are okay with it, then I am fine as well.
