Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1A45E01C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhKYSCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355670AbhKYSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:00:41 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F1EC061761
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:48:38 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y12so28554948eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piPPx0C5vR0aiOCRe+WHG1sdLCIsOqxRqziOLbvFXn8=;
        b=L4RBmR6qR+oJhI3E/rhbr+4UmpRXX0zRiYWuTKGVompvPpWqed5Ereh42iX3HLGsYa
         ypcQ7FroJdTZJTwY4Df+bC/52pFoN17ZbCcbLOLhGs5pIpDomXOCl2HpVwI3vwZ0hXpC
         cCyJv22wGDDfW439TmsaSiTychc+FMVtNMIyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piPPx0C5vR0aiOCRe+WHG1sdLCIsOqxRqziOLbvFXn8=;
        b=5J9r881G2vn4JEF+yg/GBiaQ86mAK2Jlbf2sYp1cGiWZk0vblJSSwtYtMSRq3V+4oe
         sRpMbLD3zg9ki32qQu8soxTXCPVmeWrUSwc6kU4L+r5+YwQAwOk688SqCPjIKBlGVaHn
         9l6tIR51j3wECQ3gZxxAx/S+tn0dTjQdLz/sCoGmdFlqvL7Fh6jGxFEx9W5E6IVibWT0
         AljlJl2+OqKuHdRr5z0h5aafPo/bEkUT93CsV8uR69gXmT38Zf4WXx4bprCdljo4wsqt
         HpEmLDlGXByd5fKfaYm/8VB5Pm3lH9MjChCAZ+FIOI800X1uCotGU5Ou0kkYG8LyNK4R
         EIww==
X-Gm-Message-State: AOAM532gaOgOeHFxnuOZvXrjwB+OAJTK8QkehmJmoIPbl14TCR4zwe+Y
        /Q7ing/F5Az5WfCxk32iHvxw9p4wMv0k4F+1
X-Google-Smtp-Source: ABdhPJzpEp3dCLF3NXAv892MKdP4MrQCUJadGdi2hbimVk+aimFXico5wb+c4rSip3fhJXL2FQE9PA==
X-Received: by 2002:aa7:df9a:: with SMTP id b26mr41174685edy.107.1637862516400;
        Thu, 25 Nov 2021 09:48:36 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id hv13sm2031080ejc.75.2021.11.25.09.48.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 09:48:34 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 133so6263774wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:48:33 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr9787858wmq.8.1637862513491;
 Thu, 25 Nov 2021 09:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20211125142622.GD3109@xsang-OptiPlex-9020> <a5274ba1922d5eaf9568886191e0a05bdfc55506.camel@sipsolutions.net>
In-Reply-To: <a5274ba1922d5eaf9568886191e0a05bdfc55506.camel@sipsolutions.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Nov 2021 09:48:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj7OZQcHPdcTz1cAXN1fdRJ4kqqeQHqOTP8CChHHS=bjQ@mail.gmail.com>
Message-ID: <CAHk-=wj7OZQcHPdcTz1cAXN1fdRJ4kqqeQHqOTP8CChHHS=bjQ@mail.gmail.com>
Subject: Re: [gcov] 1391efa952: BUG:KASAN:slab-out-of-bounds_in_gcov_info_add
To:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Hackmann <ghackmann@android.com>,
        Tri Vo <trong@android.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     "Sang, Oliver" <oliver.sang@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 7:45 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> In any case, reviewing my commit again I see nothing wrong there, and I
> don't understand the code/clang well enough to see what might be the
> issue.

Yeah, looks like the kvmalloc() conversion simply tightened the
checking boundaries, now that it might be using kmalloc() instead of
full pages.

The report isn't wonderful (the KASAN report is garbled, and the "code
disassembly" is not from the actual KASAN report, it's from the return
to user space code), but it blames a 8-byte read at

    gcov_info_add (kernel/gcov/clang.c:328)

which in that kernel version (1391efa952e8) is that

        for (i = 0; i < sfn_ptr->num_counters; i++)
->              dfn_ptr->counters[i] += sfn_ptr->counters[i];

and so it looks like that 'sfn_ptr->counters[i]' access is the problem case.

The allocation was

    gcov_info_dup (include/linux/mm.h:804 kernel/gcov/clang.c:371
kernel/gcov/clang.c:404)

and in particular, it's the inlined gcov_fn_info_dup() at line 371:

        cv_size = fn->num_counters * sizeof(fn->counters[0]);
        fn_dup->counters = kvmalloc(cv_size, GFP_KERNEL);

but I'm not seeing how that could fail.

Sure, that code doesn't explicitly ever set "fn_dup->num_counters",
but it should get set thanks to the

        fn_dup = kmemdup(fn, sizeof(*fn), GFP_KERNEL);

so I don't see anything wrong there, but I'm adding some of the
involved people to the participants in case they see what's going on..

                  Linus
