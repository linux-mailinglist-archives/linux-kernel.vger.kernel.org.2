Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60C432BA9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358069AbhCCLiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343781AbhCCDlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:41:21 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C2DC061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 19:40:32 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id a23so5514807pga.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 19:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fXj7pUv1rSHNrbWS16GZpW+aOhtxYAFrXaUPJx5/v/k=;
        b=swkOa5Vzo7h//FHwE8PxXseo33f8A7LeYCNlcJ20nSTXecWZCez8dmEYpd7QHVYmQP
         abe8SGSzV1cGENuWBYUcJmq+2fbDgK4WjY81AnMAzSEUZmj6vNiFgyuJzlVRNUPDBr3m
         q9Wkwha3h3tqg+kKcDMStDweoKVY/6eQs6cwtHRC5kuPbHq3WX/1Pl/uDWAOujNtyscK
         CrCSGMETWSJDWId3xGSp6znFZ+c/6kDKXnwc2tcGgbV+3USHUWxNqUEk8yfSvwL91naJ
         JlZdWA2+jeFZed0Vg3WHqkoUTyU5axZOfS2ZtQIxdBe3176EEZzCh05iWIRAI5QbJRXM
         bW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fXj7pUv1rSHNrbWS16GZpW+aOhtxYAFrXaUPJx5/v/k=;
        b=LrQW7DWq+rN6mdKPEPGIHx0yAcf1A2Ydn0UBkzxnvJSqf3ZnSUiF/9pPHAefSZkwt3
         UFb7eAqz2ES+PkimO2h4EAyZOHjXb9u6Z4uYDdPcEQx/QONNSScqMhwdED6tiiySERzS
         2ZFyf7jyMQBZOcD3iOB2cswjBYpoW24eVlOWyEBeqQCrbFFRZpjNPrDqyX0HcLFloXh0
         q1vtogYM0o3OK+hwLMu6g6T42bvk5Als1jYmdx/kRfxbxM+HySsGCKCHzNtpMpD3Y9uQ
         4YxftrKn/SrbxTXSpayAW8+lLiJIYRXm38xy+/w9vR80bEbAPaZgGdgTPWynA9dLSeAh
         /rmQ==
X-Gm-Message-State: AOAM530KoIqVM8yzavM7SLZYtZKn3j8XpUUdDEiSY/JIy0c/0L6HnFx9
        gF4Uza4T1MFDWSvFG7vFNfV+hHFhVzZZQS2UaiMTAxbSRp3Nz4rA
X-Google-Smtp-Source: ABdhPJxAjhVWhTHFfT/cCI2iypfwj6MoWYBzVnuwqdBw1mQ1KX+WMxHyZMYMwQwhlIfIpqNGw0CE0gH2TeJXg7HgZwM=
X-Received: by 2002:a63:141e:: with SMTP id u30mr21344365pgl.31.1614742832061;
 Tue, 02 Mar 2021 19:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20200420070453.76815-1-songmuchun@bytedance.com> <YD55OxQrJ54PWgs+@blackbook>
In-Reply-To: <YD55OxQrJ54PWgs+@blackbook>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 3 Mar 2021 11:39:56 +0800
Message-ID: <CAMZfGtVn7c2bQ+zttUs2k33he=z_Mm895yH7c0ghzwt+jRaySg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] sched/cpuacct: Fix charge
 cpuacct.usage_sys incorrently.
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 1:43 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> (Sorry for necroposting, found this upstream reference only now.)
>
> On Mon, Apr 20, 2020 at 03:04:53PM +0800, Muchun Song <songmuchun@bytedan=
ce.com> wrote:
> >  /* Time spent by the tasks of the CPU accounting group executing in ..=
. */
> > @@ -339,7 +340,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cp=
utime)
> >  {
> >       struct cpuacct *ca;
> >       int index =3D CPUACCT_STAT_SYSTEM;
> > -     struct pt_regs *regs =3D task_pt_regs(tsk);
> > +     struct pt_regs *regs =3D get_irq_regs() ? : task_pt_regs(tsk);
> I've read the discussion in [1] but I don't think this approach is
> correct either (and I don't know what is better :-/).

Yes. It didn't solve the problem completely. I am trying to
count the sys time as much as possible, but the sys time here
still can be lower than the real situation. I didn't think of a better
solution.

>
> I only have a qualitative proof:
>
> host:~ # uname -r
> 5.10.16-1-default
>
> host:~ # systemd-run -p CPUAccounting=3Dyes sh -c 'time sh -c "i=3D0 ; wh=
ile [ \"\$i\" -lt 10000 ] ; do i=3D\$((\$i+1)) ; cat /proc/slabinfo >/dev/n=
ull ; done" ; sleep inf'
> Running as unit: run-r101b9f53efcb4d2a9bfb65feb6f120ca.service
>
> host:~ # cat /sys/fs/cgroup/cpuacct/system.slice/run-r101b9f53efcb4d2a9bf=
b65feb6f120ca.service/cpuacct.usage{,_user,_sys}
> 16138535165
> 14332580468
> 1805954697
>
> (See that sys/user ~ 0.1)
>
> host:~ # journalctl -u run-r101b9f53efcb4d2a9bfb65feb6f120ca.service
> -- Logs begin at Tue 2021-03-02 18:06:41 CET, end at Tue 2021-03-02 18:27=
:45 CET. --
> Mar 02 18:27:29 host systemd[1]: Started /usr/bin/sh -c time sh -c "i=3D0=
 ; while [ \"\$i\" -lt 10000 ] ; do i=3D\$((\$i+1)) ; cat /proc/slabinfo >/=
dev/null ; done" ; sleep inf.
> Mar 02 18:27:45 host sh[19117]: real        0m15.543s
> Mar 02 18:27:45 host sh[19117]: user        0m10.752s
> Mar 02 18:27:45 host sh[19117]: sys        0m5.379s
>
> (See that sys/user ~ 0.5)
>
> host:~ # cat /sys/fs/cgroup/cpuacct/system.slice/run-r101b9f53efcb4d2a9bf=
b65feb6f120ca.service/cpuacct.stat
> user 415
> system 1209
>
> (See that sys/user ~ 3.0 :-o)
>
> The expectation is that significant amount of the loop is spent in
> kernel (dumping slabinfo). I can't tell which of the ratios fits the
> reality best but the cpuacct.usage_sys still seems too low.
>
>
> Michal
>
> [1] https://lore.kernel.org/lkml/20200416141833.50663-1-songmuchun@byteda=
nce.com/
