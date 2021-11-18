Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6704455170
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbhKRAIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbhKRAIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:08:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7350BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:05:05 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y7so3697031plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChZgIpzUfYvijuqUqtVoWtSMGD31N+GQgxAh+7fMbp8=;
        b=Di7J6TOX33+B9dU/u9WC+7YP4svglgu9OaaCXscWh0VBycwGYItmVIlA8AmTeuV18o
         Ql+ctrzRstL3Ps98BFm9H5xAWIlVjEP2ZcF50hSpogiz1bbsJthGKWpsdpG7mxr8AQ2N
         TltTSDGJ0iypzFDJFD+OmPYrGHr3DocGqc9rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChZgIpzUfYvijuqUqtVoWtSMGD31N+GQgxAh+7fMbp8=;
        b=K6e/utGfTEUXMGec+KucFTi1b8Ap+E0T+icpLdrHADwZ0rjzKO6ljARIrCaT5xhq5G
         GZNHS3vdsHsfo0KqvMLoP+egvT5zD4yd00cwe6YLcyThpLN+zki88WwHXL+ivNPW/4Qq
         N7O/IjLzF5bMIIh988ACy+izK5hsPq/O/61FdLpqQjaUvTla7tTFO8IiGGxuGWV0wSYs
         aKcvSRa6ununpKdfJrOL6C4jH4fohrWp5wA7WyzsQD7Ur8jJS8+bR1m+Gt70xId1kDmh
         VHxZEChClkiapQDWI6f0asw2qTXOOn2JDbFDnn6os43QtgVlidbLYsa7njcnQiSR/cUE
         AGQQ==
X-Gm-Message-State: AOAM531Ba55JHR+gr7G9QU9sKF3aZLCMUuUkFkT3i0q420Y6e+sMefQa
        WQ8WWErDEYRwB7n3XwcvkVic6A==
X-Google-Smtp-Source: ABdhPJz5YJBDbTERTvTg1d9Or3fJnBADZp93ACWVfY67SpTH3thC82aRTj9OrDJXtWSOM4jCjovwkA==
X-Received: by 2002:a17:90b:3508:: with SMTP id ls8mr4819396pjb.51.1637193904941;
        Wed, 17 Nov 2021 16:05:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q89sm699960pjk.50.2021.11.17.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 16:05:04 -0800 (PST)
Date:   Wed, 17 Nov 2021 16:05:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kyle Huey <me@kylehuey.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
Message-ID: <202111171603.34F36D0E01@keescook>
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook>
 <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org>
 <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 03:24:24PM -0800, Linus Torvalds wrote:
> On Wed, Nov 17, 2021 at 1:54 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The SA_IMMUTABLE change was to deal with failures seen in the seccomp
> > test suite after the recent fatal signal refactoring. Mainly that a
> > process that should have effectively performed do_exit() was suddenly
> > visible to the tracer.
> 
> I think this basically shows that the conversion from do_exit() to
> fatal_signal() was just wrong. The "do_exit()" wasn't really a signal,
> and can't be treated as such.
> 
> That said, instead of reverting, maybe we can just mark the cases
> where it really is about sending a synchronous signal, vs sending an
> explicitly fatal signal.
> 
> It's basically the "true" condition to force_sig_info_to_task(), so
> the fix might be just
> 
>   @@ -1323,7 +1323,8 @@ force_sig_info_to_task(struct kernel_siginfo
> *info, struct task_struct *t, bool
>         blocked = sigismember(&t->blocked, sig);
>         if (blocked || ignored || sigdfl) {
>                 action->sa.sa_handler = SIG_DFL;
>   -             action->sa.sa_flags |= SA_IMMUTABLE;
>   +             if (sigdfl)
>   +                     action->sa.sa_flags |= SA_IMMUTABLE;
>                 if (blocked) {
>                         sigdelset(&t->blocked, sig);
>                         recalc_sigpending_and_wake(t);
> 
> Kyle, does that fix your test-case? And Kees - yours?

Yup, the correct behavior is retained for me with this change.

(nit: should the "sigdfl" argument be renamed "immutable" for clarity
in this function?)

-- 
Kees Cook
