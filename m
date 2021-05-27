Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9839305F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbhE0OEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:04:33 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:41805 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhE0OEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:04:30 -0400
Received: by mail-ed1-f52.google.com with SMTP id j10so970834edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vC1w+m2gFj0NBdSQr1ECSgW8iGeDGYvFDklf0Jp3cpo=;
        b=smPeXwPO4sOUrWcoW82WBai3BLIRnwH+9jKnNag6Pk1A5H3IasulcBN3oIvzvDT0ua
         Uv8gqDw8yR/hCacLP6HQfV0YWSdz+EPZIgkxFzETikv8kNJyzYhCbRn9qRFOkR6/yC/x
         4TS0ahmdB+zQxXeIffOgTNVC23lwsdAFyeCTUJ7YvPHXiSVYKq20x80enBrBZArHHRau
         o5QIqn+ht7LxdMRlLPrZNJjt5cVkDftUQikKM+VTbg83WWpvvc3412pelyCLO2HrEjIk
         912rOBB6EqnMPpudTYvuo0bQLuB20dE//GhB7eE+ICunFX4fygjfACZbn6FQ8eK7S5EO
         JmFQ==
X-Gm-Message-State: AOAM533eD7t5N1jZ/UOrj+0jUurmQlXmRNn4j73xS1mqyCn9ptlYJtrM
        BUSwBggGZf1SFOuMjGq69LphCHtXn/nmSQ75PGA=
X-Google-Smtp-Source: ABdhPJxaSg2r1G6SBxmNBwjUr/vPtdkb9HuBS3R9od2OxGRg4OXO23vVgivtPTB+Q9GFg1FQP3SMCHVvQimbIH8aWY8=
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr4374302edz.146.1622124175283;
 Thu, 27 May 2021 07:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-29-chang.seok.bae@intel.com> <1980c78b-d51b-c186-9179-f3c72692ad8a@kernel.org>
 <ff72d7cd-e36d-06d8-d741-645a0504bf65@intel.com> <CAJvTdKmQjTmOCwUBk+3dhYzOdsZBadqVdqFUPKRMkfcTccJHuA@mail.gmail.com>
 <bd5a5457-edd7-fc1c-2285-c8392a902298@intel.com> <CAJvTdKmOLb0pt2SDgAKfwjxtMzT=t=UoREoPRUmi=4MWzeJ+QA@mail.gmail.com>
 <YK+I8YEEnhWjuVAd@hirez.programming.kicks-ass.net>
In-Reply-To: <YK+I8YEEnhWjuVAd@hirez.programming.kicks-ass.net>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 27 May 2021 10:02:43 -0400
Message-ID: <CAJvTdK=YnC=B83WmRKLGX7qq+p1rKYTMa+u2wJF4VTEeCy2VAA@mail.gmail.com>
Subject: Re: [PATCH v5 28/28] x86/fpu/amx: Clear the AMX state when appropriate
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 7:56 AM Peter Zijlstra <peterz@infradead.org> wrote:

> Why can't this live in intel_idle.c ?

You are right, and that looks reasonable.

I was thinking we'd have to hack mwait_idle_with_hints() used by everybody,
but we could clone intel_idle() above and have a plug in a tweaked version
for AMX hardware.

Len Brown, Intel Open Source Technology Center
