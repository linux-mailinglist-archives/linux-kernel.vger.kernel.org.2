Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCEE436C37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 22:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhJUUgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 16:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhJUUgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:36:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF50C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 13:33:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id g5so1252299plg.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pMLkf+/6o2RZX2xU0IzxmAZB7uZ5BczdFmEVP2ncEuI=;
        b=O+bc7OjF+a9de+Fmwriu2pbFTYm6Nd76WisEB6pxdtpMPCLsY2ID+U6EIkRIkgO5Xd
         B2KxuOz95ROxOopHz4Hd+wIjBfEeqcCSmaP6KcVQ5gIT9MurdTvKlwBQPOmwIvXlSHcc
         X5dV7XV+XlsD9lXye0yxmASvZlz4npVxd1CX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pMLkf+/6o2RZX2xU0IzxmAZB7uZ5BczdFmEVP2ncEuI=;
        b=JTp9HWcjR1ah2EcEkqC2QQ282+eDS1lfbMWqCgS7DvzMGa+Kfy1CUimH7olE2LHcVq
         cP6NFVIJl+eEczx3PwO7CTHlhpCsCywioZ99ngpU/A3EAODapbT92yqKfM0+XCCAufpi
         /xnSZlpZIM6Zy2ZFwgDG7shQKuqQDEPWMI/Wyebgx6bWH4TVOkZ3pVUkMzQA+6sOGX2D
         ANDgsK1mD9Qh/PbDzpmOzwwyxavGNLANxqjLep4htBubacqCGcfq6Wu1wUunZRlbI6oB
         IcnQLKBTPjdXXt1SMwSh+d8Vscy/YTjI2NCRYxRgBYkhsT5j5MTUozYXduPL9973o62R
         Alug==
X-Gm-Message-State: AOAM53026TcI7xEr9vP8w2uXCgzShetG2rzFyVbENH95foObUoQSb3/f
        iajrIQk8hH2keRGTxJmFq8LLPw==
X-Google-Smtp-Source: ABdhPJyjM5xwpcCQQ/v4wWtfPG0pXYOx25k0T2lL1xB4TvAQFm80Nj6V+yKGXizniv10MbKLyO1iUg==
X-Received: by 2002:a17:903:248f:b029:128:d5ea:18a7 with SMTP id p15-20020a170903248fb0290128d5ea18a7mr7246792plw.83.1634848428858;
        Thu, 21 Oct 2021 13:33:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b8sm7671106pfm.65.2021.10.21.13.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 13:33:48 -0700 (PDT)
Date:   Thu, 21 Oct 2021 13:33:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, H Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH 10/20] signal/vm86_32: Properly send SIGSEGV when the
 vm86 state cannot be saved.
Message-ID: <202110211327.F0D8DF3@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-10-ebiederm@xmission.com>
 <202110210915.BF17C14980@keescook>
 <87r1ce8g5i.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1ce8g5i.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 12:02:49PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Wed, Oct 20, 2021 at 12:43:56PM -0500, Eric W. Biederman wrote:
> >> Instead of pretending to send SIGSEGV by calling do_exit(SIGSEGV)
> >> call force_sigsegv(SIGSEGV) to force the process to take a SIGSEGV
> >> and terminate.
> >> 
> >> Update handle_signal to return immediately when save_v86_state fails
> >> and kills the process.  Returning immediately without doing anything
> >> except killing the process with SIGSEGV is also what signal_setup_done
> >> does when setup_rt_frame fails.  Plus it is always ok to return
> >> immediately without delivering a signal to a userspace handler when a
> >> fatal signal has killed the current process.
> >
> > Do the tools/testing/selftests/x86 tests all pass after these changes? I
> > know Andy has a bunch of weird corner cases in there.
> 
> That would require a 32bit userspace wouldn't it?
> 
> It is a good idea so I will see if I can dig such a box up, but I
> unfortunately don't have an up-to-date 32bit box handy, or even
> an up-to-date box with a 32bit userspace.
> 
> It has been about 20 years since I have done much with 32bit x86.

I've done recent ia32 testing just under qemu with a 32bit x86 image.
Since I've got this set up already, I'll give it a spin...

> How hard is it to run the tests under tools/testing/selftests/...
> Last time I tried it was a royal pain.  I am hoping it is better this
> round.

It _is_ a little weird. :P I do it like this, pulled from the larger docs[1]:

# Build host
$ make -C tools/testing/selftests gen_tar TARGETS="x86" FORMAT=.xz
$ scp $(find tools/testing/selftests -name kselftests.tar.xz) target:

# Target host
$ mkdir kselftests && cd kselftests
$ tar -xaf ../kselftests.tar.xz
$ ./run_kselftest.sh


[1] https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html

-- 
Kees Cook
