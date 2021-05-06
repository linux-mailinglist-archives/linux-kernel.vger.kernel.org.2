Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A357D37506D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhEFH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233573AbhEFH4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:56:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECED8613B4
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 07:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620287741;
        bh=3sDJ888SLNUCur4aTOF3IQGTGqEco0o9IiPFtnwq1ak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LxmTrYLOuxcFX2as0QL71dYUZB8kFHI4Juagg1my2bfZAoWg1MF7AWcEb73aANSxX
         v1gq5CsaNrDqSoaM5Bbxxx1yqbkg1F9yTay/Lu80qTcMIDwkbvBA86KipZF/Mo/QlH
         zliZzHTjI1b7Mojs+djFXxf8pr4uLgfNUcjnJLBRv1eKA4JBsDunqKComHu7QvP2r5
         TQXjJLgsfes2TjS9ezlrMC+qi+RWjIB7dzku8ZpfDhNoQp2Oc4Cl+5fjQeMyLpWIQB
         mhxZr08hrH2zQHjPvePKudCyIhhcnnju0oOMbZhTGhe5PiVv2AwsQWPIf4Mj1REv2f
         ypXczrAAvjQiQ==
Received: by mail-wm1-f43.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so2506654wmn.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 00:55:40 -0700 (PDT)
X-Gm-Message-State: AOAM532URN0v9rvEaNgUzo+ToSCtLTJslFgOC1YT3mMG2l56cp+HwomT
        eweXkX8h+Xh8f3haCn4Z9oW8uSo+eZCKpnJqQb0=
X-Google-Smtp-Source: ABdhPJx4y/7+JlKJQ8TmRJLV+zNWF0jFZmWktfd+JBz3Hg3FbLOH9uaKOlx0fO0WW+D8xAV82cbDaWRjw5UcgpOuY3Y=
X-Received: by 2002:a7b:c344:: with SMTP id l4mr13612962wmj.120.1620287739444;
 Thu, 06 May 2021 00:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210505211300.3174456-1-arnd@kernel.org> <87czu4slom.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87czu4slom.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 6 May 2021 09:54:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1SBDXqHE5FgG_WfzrcbeT6V6kg5T+xTGU8Cp_vLLdMqA@mail.gmail.com>
Message-ID: <CAK8P3a1SBDXqHE5FgG_WfzrcbeT6V6kg5T+xTGU8Cp_vLLdMqA@mail.gmail.com>
Subject: Re: [PATCH] [v2] smp: fix smp_call_function_single_async prototype
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        He Ying <heying24@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 3:20 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Arnd Bergmann <arnd@kernel.org> writes:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > As of commit 966a967116e6 ("smp: Avoid using two cache lines for struct
> > call_single_data"), the smp code prefers 32-byte aligned call_single_data
> > objects for performance reasons, but the block layer includes an instance
> > of this structure in the main 'struct request' that is more senstive
> > to size than to performance here, see 4ccafe032005 ("block: unalign
> > call_single_data in struct request").
> >
> > The result is a violation of the calling conventions that clang correctly
> > points out:
> >
> > block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to 32-byte aligned parameter 2 of 'smp_call_function_single_async' may result in an unaligned pointer access [-Walign-mismatch]
> >                 smp_call_function_single_async(cpu, &rq->csd);
>
> Can this be silenced by
>
>                 smp_call_function_single_async(cpu, (call_single_data_t *)&rq->csd);

Probably, but casting from smaller alignment to larger alignment is undefined
behavior and I'd rather not go there in case this triggers some runtime
misbehavior or ubsan check in the future. Making the function accept a
pointer with the smaller alignment avoids getting into undefined behavior
and doesn't require a cast.

       Arnd
