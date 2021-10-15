Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C1F42E675
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhJOCXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhJOCXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:23:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE19C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 19:21:32 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 188so6057987iou.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 19:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+0FJAOBVbzmlxq86UJy2VhVjXmI/y5S7VtIfFQ8H/Q=;
        b=F8Oe+jdxcrtcyMpFIqmvIFJkeU1U30c+0Tr6nBEkXS9X6APUldT6H491EbG9e91FOo
         TdET+iGUeDfLDnh/h+9wSO33DeaDtqmLtU9gd0Pq9nh8ub7CmAgu8LP3uS0xzObeEGLy
         fGjJzYTmx0tvuLtjz+L6WFk8iLwju0zI66A7C4WJzKMsqeRn4IxzQE4BKCaqNIbfl/8m
         towkD7TEVvBww/O3C4gZA+W7/DBo7NXnr5fIrzK6L5oZnFrxGfZbCOszDWou8SxP4qoW
         CK0Tt5z67thWxUftabnT6/8OqbqsYrprT78lMbQwJX+XWpQf77cjKc2hgdE3NDW3OMWV
         PcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+0FJAOBVbzmlxq86UJy2VhVjXmI/y5S7VtIfFQ8H/Q=;
        b=8PSVIhipbIEBHCeSJeHz+odvWTnf5pQfaJbrBV7pgVajbqBlGCc5tX/ItvEYrjLtFP
         w0GNeSjjgN6zvSC3gzYtz5FNLBcK5qaJgIpM/tPl8niSbNSnYn+xfCncFClFIH/p7aqE
         QN/s2vwXw4Yow8IpQihOiDiQIJWsfsNuB4p/wN5pDPkOUYzLEOMx1qbSdPgs/6T1DQn1
         or3G55MWEtIsgiZnDQyjxa+neT5QnwOV0U1RR3AdkEfDMpFpN0HJDiG17ecgGds8VBRD
         EX3dpSd2DfBaxGNs7ZjOkwk7bXIsltvYqfo4rcF4tewGAnYzuKiFHU4kPRQ5rbNogMfO
         Mh/Q==
X-Gm-Message-State: AOAM5321ASfGzEpRTa4q2WtWYityh8FFBvZqNPpTgmEEkrVolMyK2BHp
        +qJN6BfodWHtFrnZfQkre+A3zgCsWWqoDWMzXzk=
X-Google-Smtp-Source: ABdhPJyCerH1ljCjkuEQgpL5KNsfPgFAlAjEzkcV6GmJofjdLDvWBUQ/LpHKjelSk8SuV4oAHQPv0a06AvoLtm3UmHs=
X-Received: by 2002:a5e:9b18:: with SMTP id j24mr1968027iok.202.1634264492138;
 Thu, 14 Oct 2021 19:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020>
 <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
 <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
 <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com>
 <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com>
 <CALOAHbBTxLvuiuT4tT2_7C+jaXBoh0uTjzLRm+njO4tKxCtPwg@mail.gmail.com>
 <1171592945.14099.1634219447199.JavaMail.zimbra@efficios.com>
 <CALOAHbAhT1bTAThrmA1zYE5q8shR4dxZf5fqcq_9wVrV+XwVEQ@mail.gmail.com>
 <202110140910.295E856@keescook> <CALOAHbAQ06+G776+7WqWBag+Q1gO5M+Qg3axYd4=Tpbzx1i=tg@mail.gmail.com>
 <20211014221409.5da58a42@oasis.local.home>
In-Reply-To: <20211014221409.5da58a42@oasis.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 15 Oct 2021 10:20:56 +0800
Message-ID: <CALOAHbAyLQ-NkeyERjs=PbaRAC7Qf=BO4KeDWfMxcB2QCTOcRQ@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        acme <acme@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
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

On Fri, Oct 15, 2021 at 10:14 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 15 Oct 2021 10:05:56 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > > I'd say we need a TASK_COMM_LEN_V1 to use in all the old hard-coded
> > > places.
> > >
> >
> > Sure, it will be easy to grep then.
>
> Just because I'm picky about my bikeshed colors...
>
>
> Perhaps have it called TASK_COMM_LEN_16 ?
>
> The reason being, I have no idea what "V1" is. Version 1? What's that
> mean? And now TASK_COMM_LEN can be either 16 or 24. Perhaps we can have
> it be:
>
> #define TASK_COMM_LEN_16        16
> #define TASK_COMM_LEN_24        24
>
> if CONFIG_BASE_SMALL
> #define TASK_COMM_LEN                   TASK_COMM_LEN_16
> #else
> #define TASK_COMM_LEN                   TASK_COMM_LEN_24
> #endif
>
> or call it TASK_COMM_LEN_SMALL and TASK_COMM_LEN_LARGE
>
> ??
>
> It's still "grepable"
>

Good idea.

It seems TASK_COMM_LEN_16  and TASK_COMM_LEN_24 are more clear.
I will do it as you suggested.

-- 
Thanks
Yafang
