Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611AB3C1ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 23:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhGHVPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 17:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhGHVPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 17:15:18 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1098BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 14:12:36 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id g25so4433989vss.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1NHfW9F+V78jjSXkJMUixUMtEy56ReUIzgPfUrq2/k=;
        b=kX91r1j3b1eond5H8vs2cxeIPsnS3WnX4y41EibTl/bRNtJ+cvF05DPNYodSGN7rVl
         a4wPQTrKiR0MODFixrsSBlfMIf9MmbyDgxPUkorZQBy5HR3F3b2E7XOSoSym+94bTRjk
         sp+86F24xZ60jEwDZ/CaNsVK6Ns53eFJ3w8GLuwCUYQkI0RVU2aCtR/wmIgfnpqFuedD
         iw9HyEyxAS086IPLo39bzeS5KBMHgyHlFRTEX1GbVXHR4A9ivJRrh0RqyuP+4UaEq4sg
         /KQM1RWfaf1/ba2uau1H0GTT0lKQgSrVrFOAmBV+GQ1vMRLuX5tfgSxX+hZMobqlmPWF
         SArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1NHfW9F+V78jjSXkJMUixUMtEy56ReUIzgPfUrq2/k=;
        b=TE2GphYu3EwmEK4YBOJkE8ovkiGTRSkKmMO2CeaJmsAOyvV52xFLmgBORzs+H50SA3
         eypuJCL9ua6Mh1WT4Zq21F3td/YFReXRdEr570z7HrlzNg6gugpoIaq8SNMMJJc/6Anu
         SPbVcNZghYELVbthv3gKbpiGZbealK/DvOoGt4CqPtiHOI23oVkc4/YM5e4xFZ+W1kAr
         9iXrlemR3XGh9AmHwS0ANSnAr3HQbyhwxOQ+7cn/r8ASSFktQgLylZus0NI0eDHftAC+
         TUmW5BGk+UyeybIWCTMjzMC6DN5/1C1o0nRLlHvqk6yzaj5qhEapoZSwtd1Qs3Pzm/2E
         U+7g==
X-Gm-Message-State: AOAM533LUQvHUNtYKxv+aRY+XYrnALYwGsqXqd4tNFZIb3kS+xzh9PH5
        BdtZW641w4xHiDT8ESgB4aDfSdONLJ9QBfndeQS14Q==
X-Google-Smtp-Source: ABdhPJzjcQRpPyO+uiq9mWg8ubZa2vCyJpTZozBlll1pHMwAWuxcR59BDzuLnrWh4uOPYGHV+z02Je619Y5mcf82ISM=
X-Received: by 2002:a67:d998:: with SMTP id u24mr30784838vsj.16.1625778754878;
 Thu, 08 Jul 2021 14:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210708194638.128950-1-posk@google.com> <20210708194638.128950-3-posk@google.com>
In-Reply-To: <20210708194638.128950-3-posk@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 8 Jul 2021 23:12:08 +0200
Message-ID: <CAG48ez3LxrPva9Kxtn1DVhJWxhn3hvJ5oeDwXcrEeK_UvGh0UA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3 v0.2] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 8, 2021 at 9:46 PM Peter Oskolkov <posk@posk.io> wrote:
> Add helper functions to work atomically with userspace 32/64 bit values -
> there are some .*futex.* named helpers, but they are not exactly
> what is needed for UMCG; I haven't found what else I could use, so I
> rolled these.
>
> At the moment only X86_64 is supported.
>
> Note: the helpers should probably go into arch/ somewhere; I have
> them in kernel/sched/umcg.h temporarily for convenience. Please
> let me know where I should put them and how to name them.

Instead of open-coding spinlocks in userspace memory like this (which
some of the reviewers will probably dislike because it will have
issues around priority inversion and such), I wonder whether you could
use an actual futex as your underlying locking primitive?

The most straightforward way to do that would probably be to make the
head structure in userspace look roughly like this?

struct umcg_head {
  u64 head_ptr;
  u32 lock;
};

and then from kernel code, you could build a fastpath that directly
calls cmpxchg_futex_value_locked() and build a fallback based on
do_futex(), or something like that.

There is precedent for using futex from inside the kernel to
communicate with userspace: See mm_release(), which calls do_futex()
with FUTEX_WAKE for the clear_child_tid feature.
