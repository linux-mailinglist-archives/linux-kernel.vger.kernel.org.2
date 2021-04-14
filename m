Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB5535FD84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhDNWBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 18:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDNWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 18:01:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 15:01:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r12so33729631ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=UH9r0bLwqpvfnNk2Tt3rk+LCXIhN1P9yRfnJnHjQ3r0=;
        b=cg12crFQou1yuZGklg3lvMl/mxvNSOoWRHuZwMSshge9hHeV1OLwzSrHN51bDEc6JZ
         k/iB0Y11pHw9ykAzvJNMw2ZkAgCXMxaEPE/03Z8r3M90okfBUCq+Trp6OOHocfMQ5DF9
         +L1gQYqaaJNKLSb45ahZgtnf2ryriGm+KP91CMPoXQ3kkd2jWrvDyc44fatGb/B4bE6F
         fZrFEF3Qaj9LjKLH72J8C9pukSvhyq2YBlV4WXTbrm+KNXuEY6oh2hOm4UAIUFNorzQU
         fcxxW/ddKBev3nlRXzp156Wd8lGoZWAamKo3ZP2a3tdsI7BdXbwdUuqokrqxNcm/j4me
         Ibgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=UH9r0bLwqpvfnNk2Tt3rk+LCXIhN1P9yRfnJnHjQ3r0=;
        b=bRD1wMLPftu8y4KvGYtUuiXr8NGz21i67XlV2PuHl5GVm8SSV4tRxrF3e9vVOZNKuH
         wqM/EJuUh63Rvpk0/qRXJx+rYBb0hr1vwZU3twd8aWuFzerktVZqXfgPOgK2SnGOXzvD
         UtW7xO30xpkWJSrcCN7UlqeDHff2Wx7EbPf7r2L8bWeuMijwXV6pPwnk3s9c6R2sjvXe
         ucnF/6Rd3MN6UPw6RtPoduklqyYZdnqCBD57NqBKCSF2+W7d5bKN15gErNbQwsSnXzXp
         D5OD9fxBxKftf3GMaxd0pdPTnS+b3+FQoU4fknuoZ5aN15E6rROzAiyCmCCAFWuKfmBX
         qLjQ==
X-Gm-Message-State: AOAM532dpGktBlFSKxR6QZ9SNx/irgQsnTCW402nUcwpqzMaM1LMgcpk
        SiyKrNVRYuOB6VPtM4qE8Smp5SnfNfwhxg50/L8Z7n8tLFbXkeo7
X-Received: by 2002:a17:906:7c52:: with SMTP id g18mt175850ejp.362.1618437666524;
 Wed, 14 Apr 2021 15:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <1617714261-18111-1-git-send-email-pkondeti@codeaurora.org>
 <YGxjwKbec68sCcqo@slm.duckdns.org> <20210406152715.GB21941@codeaurora.org>
 <YGyJHAlLKqng2WeS@slm.duckdns.org> <20210407013856.GC21941@codeaurora.org>
In-Reply-To: <20210407013856.GC21941@codeaurora.org>
From:   Wei Wang <wvw@google.com>
Date:   Wed, 14 Apr 2021 15:00:55 -0700
Message-ID: <CAGXk5yp5sETNM=b4vw8xiCF=YYRhAqSpzHe-0W2Zm-VMnZsnTw@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Relax restrictions on kernel threads moving out
 of root cpu cgroup
Cc:     LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 6:39 PM Pavan Kondeti <pkondeti@codeaurora.org> wrote:
>
> On Tue, Apr 06, 2021 at 12:15:24PM -0400, Tejun Heo wrote:
> > Hello,
> >
> > On Tue, Apr 06, 2021 at 08:57:15PM +0530, Pavan Kondeti wrote:
> > > Yeah. The workqueue attrs comes in handy to reduce the nice/prio of a
> > > background workqueue if we identify that it is cpu intensive. However, this
> > > needs case by case analysis, tweaking etc. If there is no other alternative,
> > > we might end up chasing the background workers and reduce their nice value.
> >
> > There shouldn't be that many workqueues that consume a lot of cpu cycles.
> > The usual culprit is kswapd, IO related stuff (writeback, encryption), so it
> > shouldn't be a long list and we want them identified anyway.
> >
> Sure. I have not done a complete study on which workers in our system can
> compete with important tasks in other cgroups. We will have to do that to
> adjust the workqueue priority so that the impact can be minimized.
>

kswapd0 is actually migratable to subgroup.

But echo what Pavan said, the real world is not ideal and the
problematice drivers are inactive when the use case is not activated
in Android, e.g. connectivity, camera, etc. It is tricky sometimes to
track all of those.

> > > The problem at our hand (which you might be knowing already) is that, lets say
> > > we have 2 cgroups in our setup and we want to prioritize UX over background.
> > > IOW, reduce the cpu.shares of background cgroup. This helps in prioritizing
> > > Task-A and Task-B over Task-X and Task-Y. However, each individual kworker
> > > can potentially have CPU share equal to the entire UX cgroup.
> > >
> > > -kworker/0:0
> > > -kworker/1:0
> > > - UX
> > > ----Task-A
> > > ----Task-B
> > > - background
> > > ----Task-X
> > > ----Task-Y
> > > Hence we want to move all kernel threads to another cgroup so that this cgroup
> > > will have CPU share equal to UX.
> > >
> > > The patch presented here allows us to create the above setup. Any other
> > > alternative approaches to achieve the same without impacting any future
> > > designs/requirements?
> >
> > Not quite the same but we already have
> > /sys/devices/virtual/workqueue/cpumask which affects all unbound workqueues,
> > so maybe a global default priority knob would help here?
> >
>
> yeah, not exactly what we are looking for. It gives us the abiility to restrict
> the priority of all unbound workqueues at the expense of not being able to
> prioritize one workqueue over another workqueue.
>

Same here, Android used to have its cgroup setup like this, where the
BG group can be starved too long potentially (and sometimes PI is not
inevitable of course,  that's the reason why I removed BG cgroup in
Android (https://android-review.googlesource.com/q/topic:remove_bg_cgroup)).

-Task-A
-Task-B
-kworker/0:0
- background
----Task-X
----Task-Y

So having things left in root will post the same risk,

> Thanks,
> Pavan
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>
