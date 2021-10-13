Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF6442B6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 08:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhJMGU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 02:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhJMGUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:20:52 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949A0C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 23:18:49 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h10so1488397ilq.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2Vb9i/PJ7w2kwE75H5UZs8Spnuuytnn4odzwjotJmY=;
        b=HBrrRoV6b/HfdG2UOPggH8S8KCDaj1WWPMVafGBe/8Q59pxiC/Jj5XIOIS9sVm3C9c
         694X/sdc0Loy2JcTBl+qLxcH9elOpwIugBv7i6kVl89QyqOroaEZkD8TwPmdbpUWv6F1
         FxpSNRtABHzHKIdjKFJjo75h6/QFcQpHRQ//ICfURQVoYJ8HV/4WXIBo4Pw/fhVs1dwS
         AIT2THjJ5bN6Z8HcHvRNUJTvQrp8Ca9MQNunI7gkW+nl9Ad+EqluRQC60ShF4HiSXL0/
         zv0ABMvKJOs3LnQEev20N5v7X8yc7BWK84QJfgviuifqWDMlx9fmpCTchSCmztpzXcEt
         x48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2Vb9i/PJ7w2kwE75H5UZs8Spnuuytnn4odzwjotJmY=;
        b=NuipnGGbmssf0y8fue4BU6bpekfIAWNfXY3GRb2XT6AZsF+vXctIS0p6vGfjS3O3x4
         x51AJsvEUAC/o0zAHeLnznDB/4FdpbGBQb6Znj4pCwWNy73zPEd5wOpQ4Q2yqJ3JX0LX
         glN+Rf0DzGgTJQS62pZku1cheo6YmSG3MH3QsfI+GZ4JjG7n/qIxBeeC4ENnAof+NSWi
         qHricEK/SnRHV6YBJaboz0gKYqOCQU1O+Xv/X3IvTZGIRsKoWoHfzRm1IsFjIIHQgojt
         mGaN9PofstZQaRBPqkiY9K66nIaI3o2OGQRK9Ndax4HwY9YA9OB92fS+TiNWPQizxphD
         bjuA==
X-Gm-Message-State: AOAM530t4gUycmeEb2rRkGgHGqFxIcOC1ueB3CteaZAvf2mtqisX0s1N
        rHnHwMKQxLI4p2JvtjJWBN16JkSehXsLvrjAHR4=
X-Google-Smtp-Source: ABdhPJyPhvVd5LK+pODg3+wLQ9oQmq6s5LWY9R5KLOxEu65VNkSbHrHPMNrGt1xNtn2yHIC9Hzv5FHkXh6ekPPvHM4I=
X-Received: by 2002:a92:c009:: with SMTP id q9mr13987273ild.131.1634105928954;
 Tue, 12 Oct 2021 23:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <202110121132.N2z9JrD0-lkp@intel.com> <YWVw/oVd5ztGZDAK@hirez.programming.kicks-ass.net>
 <YWWPLnaZGybHsTkv@hirez.programming.kicks-ass.net>
In-Reply-To: <YWWPLnaZGybHsTkv@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 13 Oct 2021 14:18:13 +0800
Message-ID: <CALOAHbDkBn3LDsNvSXujMiQXrLHdRsfvJUqJv_eTh4s63osuTw@mail.gmail.com>
Subject: Re: [tip:sched/core 14/47] kernel/sched/fair.c:893:22: error:
 variable 'p' set but not used
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 9:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 12, 2021 at 01:26:54PM +0200, Peter Zijlstra wrote:
>
> > Again, I have absolutely no intention of fixing this. IMO this is the
> > compiler being a total pain in the arse.
> >
> > Please stop reporting this.
>
> How's this then?
>
> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> index 978fcfca5871..b0d9121c5dce 100644
> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -3,6 +3,10 @@ ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_clock.o = $(CC_FLAGS_FTRACE)
>  endif
>
> +# The compilers are complaining about unused variables inside an if(0) scope
> +# block. This is daft, shut them up.
> +ccflags-y += -Wno-unused-but-set-variable
> +
>  # These files are disabled because they produce non-interesting flaky coverage
>  # that is not a function of syscall inputs. E.g. involuntary context switches.
>  KCOV_INSTRUMENT := n

After this diff, the warnings disappear.

Tested-by: Yafang Shao <laoar.shao@gmail.com>

-- 
Thanks
Yafang
