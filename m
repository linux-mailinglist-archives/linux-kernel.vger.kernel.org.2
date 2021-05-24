Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC1538F2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhEXS0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:26:36 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:46895 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhEXS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:26:34 -0400
Received: by mail-ed1-f54.google.com with SMTP id r11so33015427edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QojKTRkPlVVMjB+1f05/ajNnuj9bmWOO2et8XaYKM5g=;
        b=NbbeIPNZ1RYCYQ/vK3/NhUfZCPwAbUAdAFoFFWWJO2ATkPV/bmO7rhSh+nEwP+Ns6p
         M694qqX89UugFHtzacbDKpWi9ayeChXVReZqWL/VhWZ0BafeYjHzzmPXGvz7/cgBoFSx
         kwhcQxPopLU16eeG04RlxSBZ9k4JRw6nY5bblYIo6eooxxkjxAvse5p2ldv+hxl7O547
         XSdMCCDUFZxynoWcPW01aEE5CJn9LIRd2oT6DJCx8NgGX9B63j/gzQiJTNyEbs8Tow35
         6LM708LmZLbiZPSOf04ALdfDc56UNABFipyyb8nX2yO+iA8IMu1EztGPcXYFbNmsJygS
         XStA==
X-Gm-Message-State: AOAM530eblreyINhZ1KRmFvqY/kKDjngqvlmLnX3ySU7Sv6Tn76az9Mf
        +vbt23T/avHbxFXMIO2GXrW7LHwUjLCMAbizal0=
X-Google-Smtp-Source: ABdhPJxfj7BEopPTpi/6NFpSGwSX4JPtG7UGwJig/maIqtxWIKVpDUD/aYrO49NQCQmKO306EvPRqo2mua9xx5JMmaM=
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr27261490ede.122.1621880705184;
 Mon, 24 May 2021 11:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-29-chang.seok.bae@intel.com> <1980c78b-d51b-c186-9179-f3c72692ad8a@kernel.org>
 <ff72d7cd-e36d-06d8-d741-645a0504bf65@intel.com> <CAJvTdKmQjTmOCwUBk+3dhYzOdsZBadqVdqFUPKRMkfcTccJHuA@mail.gmail.com>
 <bd5a5457-edd7-fc1c-2285-c8392a902298@intel.com>
In-Reply-To: <bd5a5457-edd7-fc1c-2285-c8392a902298@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 24 May 2021 14:24:54 -0400
Message-ID: <CAJvTdKmOLb0pt2SDgAKfwjxtMzT=t=UoREoPRUmi=4MWzeJ+QA@mail.gmail.com>
Subject: Re: [PATCH v5 28/28] x86/fpu/amx: Clear the AMX state when appropriate
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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

On Mon, May 24, 2021 at 1:39 PM Dave Hansen <dave.hansen@intel.com> wrote:

> >> might be considered nasty.

> > I'm not excited about burdening the generic idle path with a CPU
> > feature specific check that would need to be checked on every idle
> > entry.
>
> Me neither.
>
> But, the check itself should be cheap.  A cpu_feature_enabled(AMX) check
> will eliminate even the cost of a branch on systems without AMX.  You
> could probably even get fancy and also use a static branch that doesn't
> get enabled until the first AMX user shows up.

It isn't just the hardware run-time cost.
It is the source code complexity.
That code is 100% generic.

Len Brown, Intel Open Source Technology Center
