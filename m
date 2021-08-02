Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8643DCE43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 02:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhHBAQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 20:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhHBAQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 20:16:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350A4C0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 17:16:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o5so28033025ejy.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 17:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QgfmF/O4y4TDgdvbuE5rlFQmQjvGwXeEHXj3QAJZlao=;
        b=UEx+7MrYdZY/nTwdYYbmSF0UVARmJ5TubstgWxNYq1ZgwWD5WIeOt4rmcpyo7brdVk
         zLDe0WiBglVlFknD0R3Tk8ih2MbzLv4PctRbao0Dfltk46z0H2VSC8hueiCALDBfxz64
         ycaqaE1vx0Tn8khGFh9U8klBN0yS6o7odYb7cA1A3ApriKhxZt35FG56ODtzC2LtWpVZ
         HO5TCIuqZNM1Q4ws+ccbjXeq75u1SPSMu2q6QwQs3/430ezcCPofdgwz8VLnXB+QqMpV
         7mRjC+p6XzKiw7CcV+noRPHdM/ZSigG0i1ZtFYJn1PRpgBUCqC4NUyfYQuLEZUOJlJvb
         xPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QgfmF/O4y4TDgdvbuE5rlFQmQjvGwXeEHXj3QAJZlao=;
        b=XlWIVqtf77jqBn3IOsnNnecuLr+pF5QXJVjD+fQS0HSygoHWejTbVV8SUrL/bHBMRJ
         AcljF/vxUo+WTlnzAWA96YWkLkXnHQ0ApOLbCUXAJNbW7wwZLtPeGgIlAkhFlWEbGQR8
         GR0n8Bx3tqGEgAUDhMOn1GXkeoRRGE+0lI/OFvwOHUr2NSACnys0C2+SwGAcIA48Kgx1
         O7EMxoALk8g8sZVbQGShLZ4y981mB/PPBg5bqP2AINijEbxSl89vXpb5gcmpCf7Yov5L
         EY+yr4bNO0o9PlI7fWDgHu9YwL+jxxKuLPp66f6Vv0sBmz2utBi3wkVWnBaJ6oESvFND
         E13w==
X-Gm-Message-State: AOAM5318vCwlAKGsXjl/+0AZBpylqtqvxlnPWmk5mHVQwc/ju9JYSsdN
        qSy93l5mNU+PCEb6aChLt0JIcKuiVvtdrUO6tOCoRg==
X-Google-Smtp-Source: ABdhPJxFCfAsK6OeHM0o/Arn3r6OXz1iESjcrPoZuvXbibu/NUPHEIu8g17vbhtLGtoFgTAaDGpSlQgafE3vUTCK2oo=
X-Received: by 2002:a17:906:5e07:: with SMTP id n7mr13318802eju.552.1627863385573;
 Sun, 01 Aug 2021 17:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210731175341.3458608-1-lrizzo@google.com> <20210801123335.6a7f8e1ee1e52ea64db80323@linux-foundation.org>
In-Reply-To: <20210801123335.6a7f8e1ee1e52ea64db80323@linux-foundation.org>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Mon, 2 Aug 2021 02:16:14 +0200
Message-ID: <CAMOZA0+mAC-tHDehzqMVP4rd7wggY_DPofRdH=GMouZA9DRC1w@mail.gmail.com>
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(repost in plain text)

On Sun, Aug 1, 2021 at 9:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 31 Jul 2021 10:53:41 -0700 Luigi Rizzo <lrizzo@google.com> wrote:
>
> > find_vma() and variants need protection when used.
> > This patch adds mmap_assert_lock() calls in the functions.
> >
> > To make sure the invariant is satisfied, we also need to add a
> > mmap_read_loc() around the get_user_pages_remote() call in
> > get_arg_page(). The lock is not strictly necessary because the mm
> > has been newly created, but the extra cost is limited because
> > the same mutex was also acquired shortly before in __bprm_mm_init(),
> > so it is hot and uncontended.
> >
>
> Well, it isn't cost-free.  find_vma() is called a lot and a surprising
> number of systems apparently run with CONFIG_DEBUG_VM.  Why do you
> think this cost is justified?

I assume you are concerned with the cost of mmap_assert_locked() ?

I'd say the justification is the same as for all asserts:
at some point some code change may miss the required lock, and the
asserts are there to catch elusive race conditions,

There are in fact already instances of mmap_locked_assert()
right before find_vma() in walk_page_range(), and a couple before
calls to __get_user_pages().

As for the cost, I'd think that if CONFIG_DEBUG_VM is set,
one does it on purpose to catch errors and is prepared to pay
the cost (in this case the atomic_read(counter) in rwsem_is_locked(),
the counter should be hot).

FWIW I have instrumented find_vma() on a fast machine using kstats

   https://github.com/luigirizzo/lr-cstats

(load the module then enable the trace with
  echo "trace pcpu:find_vma bits 3" > /sys/kernel/debug/kstats/_control
and monitor the time with
  watch "grep CPUS /sys/kernel/debug/kstats/find_vma"

I didn't run anything especially intensive except some network
benchmarks, but I have collected ~2M samples with the following
distribution of find_vma() time in nanoseconds in 3 configs:

CONFIGURATION         p10   p50   p90   p95   p98

no-debug               89   109   214   332    605
debug                 331   369   603   862   1338
debug+this patch      337   369   603   863   1339

As you can see, just compiling a debug kernel, even without this patch,
makes the function 3x more expensive. The effect of this patch is
not measurable (the differences are below measurement error).

cheers
luigi
