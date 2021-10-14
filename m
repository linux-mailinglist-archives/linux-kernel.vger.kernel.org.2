Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1304F42D9E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhJNNOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJNNOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:14:15 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8237C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:12:10 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 188so3637070iou.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vm0uG47kjXZQUoBadNTCMv0FLQo5FyMI1RDxQQYcLzg=;
        b=icRf3w96WiNwX53QPS0x3z7UAj95POnNN9od9Zl8Ha6tpqr7KA5eHVUdoPT83RZbfA
         aDMF5AMGm6H695DWF7Lk20+tOtxSiq2cgEnpF04vFHsWJ95rNjxcRJgkloowOilnInqE
         2n4Ww9XD621f5cOYV/hrLSeTShdFub9KAMKcGnAYyAJQB0SZzWXjeSLpB/MYe3/wVeqr
         +FSeebhaZ2cbcPz4oiHCPZxVuk1mGvAJ5/1LCSUGIUsd3175HCx5/yTmlKf2EB3fswFc
         lJsB/cvn6N9vAYvZ6vaG3XXKjQaS2atUDRr5s0ZgObeSrQcNJLcdj8H9bJGzxsa8as6I
         p41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vm0uG47kjXZQUoBadNTCMv0FLQo5FyMI1RDxQQYcLzg=;
        b=cCJj9KYXGkvMU7KUXrPKw3Tcu6ifLtZ8uHpjNxV+/YbaLVjc6CIOZpi3wEsxwYApnd
         y8vmYKshss6BM0KPnLHstokZ/XGRwmmU0qR7fB7e74M6Derg+9+VMQwuLGrArc/x3dHz
         vFX1jlt7tOQyf5PikpjPPG1DUGCQPsd5dCQ2G6Dkbzi3kjwD2wERDQ95NFAZ61GmrJD0
         76mWnQPvlhBC2m/086UKQWK/78gknc01WrB6Z88MK3lDjyuCCAXBtDynm2UH3dPgJYTC
         N9EaOyWNtURLZCvu4Z6b49TOToCxzhdGw0+NUpnXXx09IAgkrVvzfElCPL4tmXQmmh0v
         fskQ==
X-Gm-Message-State: AOAM530mo0preHHIcvtTsl8q8lp8WrL5hQV6pFWBQrcnM3cfzANagLCh
        luga9yQLkQ5uymLZKUM1gYelU4/KQtD4lmHDC0k=
X-Google-Smtp-Source: ABdhPJw6Txd+UgF2zIWte9JLHc+cWuMJL5UBr7n88d6KgytvanShOCEdKLE/x/O/z0UgLXMvSGssSl/KhXmI5TK2yBg=
X-Received: by 2002:a02:2a48:: with SMTP id w69mr3998395jaw.23.1634217130388;
 Thu, 14 Oct 2021 06:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020>
 <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
 <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
 <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com> <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com>
In-Reply-To: <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Oct 2021 21:11:34 +0800
Message-ID: <CALOAHbBTxLvuiuT4tT2_7C+jaXBoh0uTjzLRm+njO4tKxCtPwg@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     acme <acme@kernel.org>, rostedt <rostedt@goodmis.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qiang Zhang <qiang.zhang@windriver.com>,
        robdclark <robdclark@chromium.org>,
        christian <christian@brauner.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        bristot <bristot@redhat.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 9:09 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Oct 14, 2021, at 9:05 AM, Yafang Shao laoar.shao@gmail.com wrote:
> [...]
> >> If it happens that this ABI break is noticed by more than an in-tree test
> >> program, then
> >> the kernel's ABI rules will require that this trace field size stays unchanged.
> >> This brings
> >> up once more the whole topic of "Tracepoints ABI" which has been discussed
> >> repeatedly in
> >> the past.
> >>
> >
> > I will check if any other in-tree tools depends on TASK_COMM_LEN.
>
> That's a start, but given this is a userspace ABI, out-of-tree userland
> tools which depend of this to be fixed-size are also relevant.
>

TASK_COMM_LEN isn't defined in include/uapi/ directory, so it seems
that it isn't the uerspace ABI?


-- 
Thanks
Yafang
