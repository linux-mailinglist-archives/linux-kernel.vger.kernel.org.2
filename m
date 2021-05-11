Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A6C37AE25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhEKSNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhEKSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:13:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC0C061763
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:12:35 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z24so19082806ioj.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCQFRYKnpEWO7nMBCUi8YB2CYHmyNOt7CgGjrmkkW68=;
        b=jZDsQCz5XwmQC2L6QfYDJCIE6p1QmWi6VzUofsPkBsNYP+Rg+MZ6XYpnZIbsPPmdP6
         jMwheKL1jFTf7dNLBaQePPbqDXK/YTxGdsvSNtYqtw9xNxJjBVgoAXINz18T1ct2yw1j
         aL9a6USIRweParzL8U+hZU/kSf9zY+NWmealwJiLpoH4E3MGPdvvYixJV4p2X6EzcaQI
         sUvkCIuGq32HGGEKj73HmW6kkOrIDXgsggwPDuVzD6DzzZh2UGjmzlP+KgpeusaRbD/j
         mIBRQdJ8i9WJ94hy7u8LjLmEGoDvevqtN7bMsID8p82S2w32FcnGg7YzGQYMv9/7k8TA
         ZF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCQFRYKnpEWO7nMBCUi8YB2CYHmyNOt7CgGjrmkkW68=;
        b=P7Os7jwz9uW+CuqtVFHVMhirHXOwkg3SAq6MKoOPNgssqMmfyO5rFW2ZGjsEqH+FoH
         sSl9IC9+ndFDRFvH0GI/bD2YaQLqv65SbeVxdM9fR8/Yrnk3G3prMM2/eyKR98o+Y3XH
         Ncvol5J40D4u5CPN8xxjMwRlUsHqWU5bsDGnrQDCIGzNMAZnge4Y9ozVuwy0Ggh+DZ1T
         FwHoUBn9Lsnjz18BzG8oBswx3POWkvtYUyti8mbV0nqvUPX+cgYy/CY0BajVENb+ExIt
         64+yCEIRSTHk9Kbvr3epVi+mTaNi4O3IXtYjOq+l+dgSvrlgV8XQ1HopRkhSjEOJIsVm
         Ckjw==
X-Gm-Message-State: AOAM530XXusvCYSTMtF6QYozGdxOsrbnU9qS/MHVX7vRJHvvGLwsldWv
        UwgQ8M8ySB8fl1qG6u1o8DHUk1eGqG6KaLSr2z8rhg==
X-Google-Smtp-Source: ABdhPJzBFvo3VcEWCSO2q7hhXnROuFVAiGLe4L0aS0tsYpBErdoa3yP92qxbXyMkx746h31X4FPqm9yVtN74IW6oJiE=
X-Received: by 2002:a6b:cd08:: with SMTP id d8mr23698430iog.86.1620756755061;
 Tue, 11 May 2021 11:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLZ8GR8DKCZLQJKPS7oeP1CX4L3ijBFDBePGX4q6z-DQhg@mail.gmail.com>
In-Reply-To: <CAOp6jLZ8GR8DKCZLQJKPS7oeP1CX4L3ijBFDBePGX4q6z-DQhg@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 11 May 2021 11:11:58 -0700
Message-ID: <CAJHvVci_q5rxuo-N+EH_CNxX_M3oxWcLyitvbdySa_PMH3e_Dg@mail.gmail.com>
Subject: Re: Userspace notifications for observing userfaultfd faults
To:     "Robert O'Callahan" <roc@pernos.co>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Kyle Huey <khuey@pernos.co>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 5:38 PM Robert O'Callahan <roc@pernos.co> wrote:
>
> For rr (https://rr-project.org) to support recording and replaying
> applications that use userfaultfd, we need to observe that a task we
> are controlling has blocked on a userfault. Currently this is very
> difficult to do, especially if a task blocks on a userfault on a page
> where some other task has already triggered a userfault, so no new
> userfaultfd event is generated. We also need to observe which page has
> been faulted on so we can determine when the fault has been serviced
> and the task is ready to run again.
>
> I've tried to find workarounds with existing APIs and it doesn't seem
> tractable. See https://github.com/rr-debugger/rr/issues/2852#issuecomment-837514946
> for some thoughts about that.
>
> It seems to me that a sufficient API for us would be a new software
> perf event, e.g. PERF_COUNT_SW_USERFAULTS, with an associated
> PERF_SAMPLE_ADDR that would give us the address of the page. Does that
> sounds like a reasonable thing to add?

Is some combination of bpf and kprobes a possible solution? There are
some seemingly relevant examples here:
https://github.com/iovisor/bpftrace/blob/master/docs/tutorial_one_liners.md

I haven't tried it, but it seems like attaching to handle_userfault()
would give similar information to perf_count_sw_page_faults, but for
userfaults.

>
> Robert O'Callahan
