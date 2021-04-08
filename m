Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8435899B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhDHQXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhDHQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:23:11 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE2C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:22:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 184so2979330ljf.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6G3+OZqQp9tJwJbpfeOs5bop8D+dStV4QMNjNUA2tCA=;
        b=TtHskSvLyj69vK1NCJTAi43mfhUPjOkxPD6JbyziSbl7SJzch4R+8xG013pZQnNkeo
         MCi+JyVnrfhl3zL7fyFATmJrEoh6L3MqxEHNYC3Ir+EOyZhzDUDXGuKQ5QhVSoNnyyH1
         PoXSkpV6XJTxGofaxbR4HFXQygQ82aFV+tUZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6G3+OZqQp9tJwJbpfeOs5bop8D+dStV4QMNjNUA2tCA=;
        b=R3ekr1ZwiPSMclLTqI1dEcxmkSJgKUbj5KI8HwtEfMqh2m5CePeCtqwIvYZBf2cwnN
         svdeq5Qf0Rz8vdHF3/XWW0xf1vk+p8C7Fi6SjVd9JV/BJiTBxKU1yrngzrD21jLBqtua
         6Ukat43mpz/mZQtM7ZciCC0SUjfFSjpihzh6nVSpJKl2aBi47ApKXFescb1P6WIvu2Aa
         OjgsF3H8OJCTK5WOnnVt1rlbxlSUxt+RbawgG9zJFLOwacuj/fqcXWbjMyk2toyABSHl
         A+dbTq8yZKySK42lzAAvulgctQlq9PhSNpDLulaxv7WGbUz9r2mJEAvNcfvqiV62ZL1y
         AHcA==
X-Gm-Message-State: AOAM532t2jLfEYPxhPbRCTTZsMs3wh+LyD81kxPqZawFeTJXQdG/q7py
        fyN7HfUd/HUPZn3p3YMmZy9e+IMXigU+Ew==
X-Google-Smtp-Source: ABdhPJwWjGDssyo17bFKAkrFPkQFep9oDFuASKyXjs8QfDVyCE9RyDRjKN5IUwyiODAo39eKC9nL/Q==
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr6402847ljj.116.1617898978046;
        Thu, 08 Apr 2021 09:22:58 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t193sm782911lff.2.2021.04.08.09.22.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 09:22:57 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s17so2986919ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:22:57 -0700 (PDT)
X-Received: by 2002:a2e:a306:: with SMTP id l6mr4543789lje.251.1617898977209;
 Thu, 08 Apr 2021 09:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <7abe5ab608c61fc2363ba458bea21cf9a4a64588.1617814298.git.gladkov.alexey@gmail.com>
 <20210408083026.GE1696@xsang-OptiPlex-9020>
In-Reply-To: <20210408083026.GE1696@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Apr 2021 09:22:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigPx+MMQMQ-7EA0pq5_5+kMCNV4qFsOss-WwdCSQmb-w@mail.gmail.com>
Message-ID: <CAHk-=wigPx+MMQMQ-7EA0pq5_5+kMCNV4qFsOss-WwdCSQmb-w@mail.gmail.com>
Subject: Re: 08ed4efad6: stress-ng.sigsegv.ops_per_sec -41.9% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 1:32 AM kernel test robot <oliver.sang@intel.com> wr=
ote:
>
> FYI, we noticed a -41.9% regression of stress-ng.sigsegv.ops_per_sec due =
to commit
> 08ed4efad684 ("[PATCH v10 6/9] Reimplement RLIMIT_SIGPENDING on top of uc=
ounts")

Ouch.

I *think* this test may be testing "send so many signals that it
triggers the signal queue overflow case".

And I *think* that the performance degradation may be due to lots of
unnecessary allocations, because ity looks like that commit changes
__sigqueue_alloc() to do

        struct sigqueue *q =3D kmem_cache_alloc(sigqueue_cachep, flags);

*before* checking the signal limit, and then if the signal limit was
exceeded, it will just be free'd instead.

The old code would check the signal count against RLIMIT_SIGPENDING
*first*, and if there were m ore pending signals then it wouldn't do
anything at all (including not incrementing that expensive atomic
count).

Also, the old code was very careful to only do the "get_user()" for
the *first* signal it added to the queue, and do the "put_user()" for
when removing the last signal. Exactly because those atomics are very
expensive.

The new code just does a lot of these atomics unconditionally.

I dunno. The profile data in there is a bit hard to read, but there's
a lot more cachee misses, and a *lot* of node crossers:

>    5961544          +190.4%   17314361        perf-stat.i.cache-misses
>   22107466          +119.2%   48457656        perf-stat.i.cache-reference=
s
>     163292 =C4=85  3%   +4582.0%    7645410        perf-stat.i.node-load-=
misses
>     227388 =C4=85  2%   +3708.8%    8660824        perf-stat.i.node-loads

and (probably as a result) average instruction costs have gone up enormousl=
y:

>       3.47           +66.8%       5.79        perf-stat.overall.cpi
>      22849           -65.6%       7866        perf-stat.overall.cycles-be=
tween-cache-misses

and it does seem to be at least partly about "put_ucounts()":

>       0.00            +4.5        4.46        perf-profile.calltrace.cycl=
es-pp.put_ucounts.__sigqueue_free.get_signal.arch_do_signal_or_restart.exit=
_to_user_mode_prepare

and a lot of "get_ucounts()".

But it may also be that the new "get sigpending" is just *so* much
more expensive than it used to be.

               Linus
