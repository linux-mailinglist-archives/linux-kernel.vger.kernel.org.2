Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878FF42539E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbhJGNE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbhJGNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:04:58 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE647C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 06:03:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e144so6679177iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8hdHnLG0fAkLfzjNI0GPM/IGHQ+RmHhMYMNwSn35q0=;
        b=H8ihl1RcNbPk8FLx0u5kWgmP6E31ThIv8id3dOV0vBokt6OgCu91dTsA/vdPJt89NM
         nzITFOxGKIT87/RtJzCcDOVLF4SCZSW/SLQkvPj7XUtNhI5tJxbbDV9Fei0Tn3xGZ766
         yMZ+QOss8D4xSzmliAr/+O7ubSwtm1Gf9VzqcFpgLYorY+LJi2gf/edwtGnA0lNdAT52
         imk4PFCBQh7t6e8ptonO2ScZo1g/epR9hC8Qgeo9lPTPu/yyNiO32XRrD/CUfKhBsH4c
         SvsRXLO/VHjf3jWLXufTFfRmRjjwtUQQ//t4H/mCbUN5rsj/4vVwmD/oXx+K+WsGVoaK
         DnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8hdHnLG0fAkLfzjNI0GPM/IGHQ+RmHhMYMNwSn35q0=;
        b=tRJz/byR2ic2RgxbRitv9J8e5lb+hsAknOOdKyGV2xL0W05JUW8cUCa21yyHq5miZb
         tz9RUrGhdr8O5oUQSi3kib6QNAf0irI6z3OEjDX+pCt8qMr46ZYYW2ZUDJBIOfXRy06u
         cgYmpjMs42GKUg2gDjgU8GVo7TJC5Ib2tzEzzOrfPKkxJlRobTl8gUe/dh/Bkpd49am8
         ZBQ+PEpmWDo+K8ZDAHxslnLl7c8aRXf7ZBCgAaoVEpJlTv90IydcWD3a+YjjYQCYhhG8
         45HyKfeK6AENkpwJxMRq8G7/Wk8iMX/UafUUZEz+/C3mi7aGuosaGF/qMGjCJi6hCEYx
         XEqA==
X-Gm-Message-State: AOAM530sEqPkPVGMz/e6rE0+SGNbrX1T3sJSGloGmq6ybBRL40DxrMMz
        ynLyw1rGRQJeOOFUC4Cf0I1nsRaVlGjyveeAaw4PtGmOtVkMvw==
X-Google-Smtp-Source: ABdhPJzp+IaADdIOdk/+xCsAfZqZQTVXoKtNV2rhdoG0b/Wzv128mXKVXfuMB5yfaPkR6+cvzD9w24S4RVZK+MjoBtM=
X-Received: by 2002:a05:6638:35a0:: with SMTP id v32mr2789681jal.128.1633611784169;
 Thu, 07 Oct 2021 06:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211007120752.5195-1-laoar.shao@gmail.com> <20211007120752.5195-4-laoar.shao@gmail.com>
 <YV7t748s8vJQS9Bi@hirez.programming.kicks-ass.net>
In-Reply-To: <YV7t748s8vJQS9Bi@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Oct 2021 21:02:27 +0800
Message-ID: <CALOAHbDXHd8QW0-k8F1U59=Zp_vfRVFQOTW3PLkTrbOZ+=sBoQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sched.h: extend task comm from 16 to 24 for CONFIG_BASE_FULL
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>, Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 8:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 07, 2021 at 12:07:51PM +0000, Yafang Shao wrote:
> > Besides the in-tree kthreads listed above, the out-of-tree kthreads may
> > also be truncated:
> >
> >     rtase_work_queu
> >     nvidia-modeset/
> >     UVM global queu
> >     UVM deferred re
> >     ...
> >
>
> Fundamentally we don't give a crap about out of tree stuff. And their
> behaviour or not should be of absolutely no concern what so ever for any
> patch ever.

Thanks for the explanation, I will update the commit log.

-- 
Thanks
Yafang
