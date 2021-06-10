Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9846D3A27A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhFJJFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:05:03 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38636 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhFJJEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:04:53 -0400
Received: by mail-ot1-f49.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so13213889otk.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OrvGQveIDsGXb2Fmo6K6lcHqiuK7RhEdI4kF1LgsIA=;
        b=pvtJLauyJKFPxO+q8mK2qtn3JqB8gZmw5DuqaqwMquP8ATD5cS4N8fVPVRIM+CWFKK
         l2VyxisLie6n1Z0Mm0Z/ylt8qf3RBBbfeBJaEbYrhyI/9C4+syRD3d/uxnjvREmvmfaQ
         iMvtY2a7wTt/wE5NF7BRunETB/J8LJhq/NElG5ayfolyAi+FLasrE26kQHgACYI7xx9F
         OeNAXHeLsJ0HDrcd/4rvDh5my7KoVBLT4JrTShr0jc7iYxllgr6c6VjwxckBCrDr9eIQ
         zWZ0gGRTn6MLeIdrU2MYOnyzV4kw+ZTImVDAihSTSUsgn5NIjj0VzBJtJ8fHhQvfyXRt
         osmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OrvGQveIDsGXb2Fmo6K6lcHqiuK7RhEdI4kF1LgsIA=;
        b=PWmE/YmXQJG1yHlZCnm/EPIMoUu31drIguEmP9TBD9Ibhp5m1+IhxfQ/CEjIpf+BpM
         uliKSiink/lEfQZmnhToCAR9BDdgrGGKtBWqlgH8yhG9bO2bMEKRs9HjpfRxtXxpxs6k
         OEFULA7Xvph66J8f/bU8mxZc55W86ZqyQ8e6kBCuo0lon3Ui0to0Qi3twFpbHxB0z8Py
         1jxDlgEmO5YdcPSg1i1oZg+VXH+hN8HHBqEZOAr3lxPzNG4YNfUrrKVbbnTVd7Jc+wUz
         m5Mr0vK8ekG6GVQ8hvkTeAkdXteVmVhZp9HwEyT+VyqlVMnGGeyj/tdpmN8TigfP3BOS
         3Ilg==
X-Gm-Message-State: AOAM533lu71TMvuCDsL/UPDjnQTYvWtcxzadV3LShDW1Wdm9AHtAso9F
        2JEwNDbrZ54tQ/fmpsd4hAyztjfP9djCXDnx7uWvtw==
X-Google-Smtp-Source: ABdhPJxFA2MUlBWbD1pMojqtnp+EpAJV/P0y4Z/IgLSk29EqYhi1fMXSa4uzroZzBawq4nKgzapzf6W6Hau+1D/W/y0=
X-Received: by 2002:a05:6830:349b:: with SMTP id c27mr1601650otu.251.1623315705592;
 Thu, 10 Jun 2021 02:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210609122001.18277-1-mark.rutland@arm.com> <20210609122001.18277-2-mark.rutland@arm.com>
In-Reply-To: <20210609122001.18277-2-mark.rutland@arm.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 10 Jun 2021 11:01:34 +0200
Message-ID: <CANpmjNOvnqE29mMU++K0VMibF8xMixJXRDqbDKXjXuxobAfM1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] thread_info: add helpers to snapshot thread flags
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>, jonas@southpole.se,
        juri.lelli@redhat.com,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <rth@twiddle.net>, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi,
        Thomas Gleixner <tglx@linutronix.de>,
        vincent.guittot@linaro.org, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 at 14:20, Mark Rutland <mark.rutland@arm.com> wrote:
>
> We have common helpers to manipulate individual thread flags, but where
> code wants to check several flags at once, it must open code reading
> current_thread_info()->flags and operating on a snapshot.
>
> As some flags can be set remotely it's necessary to use READ_ONCE() to
> get a consistent snapshot even when IRQs are disabled, but some code
> forgets to do this. Generally this is unlike to cause a problem in
> practice, but it is somewhat unsound, and KCSAN will legitimately warn
> that there is a data race.
>
> To make it easier to do the right thing, and to highlight that
> concurrent modification is possible, let's add a new helpers to snapshot
> the flags, which should be used in preference to plain reads.
> Subsequent patches will move existing code to use the new helpers.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Marco Elver <elver@google.com>


> ---
>  include/linux/thread_info.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 157762db9d4b..f3769842046d 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -117,6 +117,11 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
>         return test_bit(flag, (unsigned long *)&ti->flags);
>  }
>
> +static inline unsigned long read_ti_thread_flags(struct thread_info *ti)
> +{
> +       return READ_ONCE(ti->flags);
> +}
> +

Are some of the callers 'noinstr'? I haven't seen it in this series
yet, but if yes, then not inlining (which some compilers may do with
heavier instrumentation) might cause issues and this could be
__always_inline.

Thanks,
-- Marco
