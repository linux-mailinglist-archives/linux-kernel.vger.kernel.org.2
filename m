Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A430040A274
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhINB0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhINB0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:26:21 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05912C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:25:05 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r21so9907942qtw.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8zeFrHijeuDDSgea2thpakNO3UstBjJsYAAwyq56two=;
        b=YIQHhW+ZnjrjtKrGd8pHMXPiZJ50qUQ0iOC/25IJGJEZpaYUSt4QPmzq0av6x1Euvo
         1WYSm0VMnNc2MnQAE8LN2Nng1BcKKn02FNVLI6wsTu4s+2/VKsrvHizh/SVpDlZUDkVe
         QeawM4MI2DK7zN2IM++TJXzkjRqvG080nqfMgMBuB2V5HA4WWu5c3wr+gR0tECy4ikNX
         bEBBhPAeDBP7A2gJSm4awv0B70PpXL2T3aUXeLNicEoirvh9F668oL+Xt+iDBIpNsjh0
         z3wxVaTpSe4CRXuaBnrffFMNHRLBLL1Q+b5n8LXKsDB+9dBgSVleSXRQYopJTAo1UAGx
         QWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zeFrHijeuDDSgea2thpakNO3UstBjJsYAAwyq56two=;
        b=ZSTVNKXOo9MKcU6NaBQi7dXQCAVgJwEdUhxTnxUOA37ToAm+qCa8qFPD0iV4Rb3Gcu
         E4w/4XWWCb3Z0V2uAQBWvhoO9Pu2HAbPpEsyU1r2SJ+mihG+on4yxCw4nY0CAHbQWWMf
         d1ihR0PT2Qr7NhMtof41onOJ97DYBg8FTKpwhz0QyOyNN1va5sqPXORlm+XAZexBILRs
         VMuw48DfxIXM2BEpUSf5khhSh52AY3gHVbKsoKYsapllOgWD47+MMsK2/bpH7MGnuKTG
         UOFyyCZ+YiuGF22c6+TrW25zD8VnSd74goPa05PPnBtQmxeNR3CQbZWjkuqYY0qQivM0
         LdIw==
X-Gm-Message-State: AOAM532XWhr6d1Cqjb0ijJTy3Dm7o4XWgdIAaGK9vjxWWA7r13w+dVZA
        POFuzpYd0GrLTwgt6O+4q/3G87yyT3K4hz7XKwp7J9E9MOk=
X-Google-Smtp-Source: ABdhPJxcUN1eEILXXliVbFFENNwZ7+EUy+yzCOajOV+k2dgoAWPGn91ps4ir835E6uG3JF9r4xYjPqtMqclVvv+fZl4=
X-Received: by 2002:ac8:410f:: with SMTP id q15mr2260768qtl.299.1631582704131;
 Mon, 13 Sep 2021 18:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <1631188824-25623-1-git-send-email-huangzhaoyang@gmail.com> <YTouqsXeAGV6c5oV@cmpxchg.org>
In-Reply-To: <YTouqsXeAGV6c5oV@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 14 Sep 2021 09:24:43 +0800
Message-ID: <CAGWkznGFWE3A=QRvQQ89JhX9AG2DsH=vR58-UwZpYA1wbW74gQ@mail.gmail.com>
Subject: Re: [RFC PATCH] psi : calc psi memstall time more precisely
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, xuewen.yan@unisoc.com,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 11:54 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Sep 09, 2021 at 08:00:24PM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > psi's memstall time is counted as simple as exit - entry so far, which ignore
> > the task's off cpu time. Fix it by calc the percentage of off time via task and
> > rq's util and runq load.
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Can you please explain what practical problem you are trying to solve?
>
> If a reclaimer gets preempted and has to wait for CPU, should that
> stall be attributed to a lack of memory? Some of it should, since page
> reclaim consumed CPU budget that would've otherwise been available for
> doing real work. The application of course may still have experienced
> a CPU wait outside of reclaim, but potentially a shorter one. Memory
> pressure can definitely increase CPU pressure (as it can IO pressure).
The preempted time which is mentioned here can be separated into 2
categories. First one is cfs task preempted because running out of the
share of schedule_lantency. The second one is preempted by RT,DL and
IRQs. IMO, the previous is reasonable to be counted in stall time,
while the second one NOT.
>
> Proportional and transitive accounting - how much of total CPU load is
> page reclaim, and thus how much of each runq wait is due to memory
> pressure - would give more precise answers. But generally discounting
> off-CPU time in a stall is not any more correct than including it all.
>
> This is doable, but I think there needs to be better justification for
> providing this level of precision, since it comes with code complexity
> that has performance and maintenance overhead.
The rq's utilization of load tracking provides an easy way to compute
such proportion. A new commit has been given out which mainly deals
with the 2nd scenario described above. The statistics of the precision
are provided together.
