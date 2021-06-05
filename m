Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC139C4FD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhFECRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFECRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:17:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39389C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 19:15:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id v22so15479357lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 19:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EI6m4DFQAlCt7nir2Xp+wCzvHYT20bXHAsNalWojQQ=;
        b=QWsgQnfVWlVwkO8wXtuVA8D26uH86+8XkaNXxmUgybfCss6KHbg3Jsf+csekF8M3P4
         4X7yp6jRsNc+4pZoBLlFXSO0tqAGUteW2rtN6a39ZKvgPNJiID9zi9nBx1nvf3S5grZO
         m3BynhIye9NJ8Fq0G3QZTOrg4BASGwDZoS3x7auJN2JmKe0kkQftCz4W2fAKfxfSYtDm
         XQrugGXaJNXA1wnKnifbj4Z/shK20QV/KoN4o2w8hhOzPgI4/R5BM7IPu86OcAzJJRge
         qLYAZIMjTWZVdY22qWH9vVYn1PrUhuHPqaUkm/YitHosAQe05IlKyPWL5RnpjhCLEYXS
         mF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EI6m4DFQAlCt7nir2Xp+wCzvHYT20bXHAsNalWojQQ=;
        b=rUA1mG9LynoOULldm7tlg2GDkQdAtZAQ4tKGf9TGb1ve4xHai7FYCBJPNJ4N1/rw5F
         U66wfzGECdfFVgS3Pz8l9uWubUPD+fDqgY+LFBmHNNQX0WrTk+bkNy3iUkwQfYR/8/mD
         47lztiOnKjWsXYUel16EWoZLbxDTuTAY61vETXjxWQLoBhJJYKTcx3tAPuPI8nXkCyIl
         XX0DFAnANSRMrA2jEYnX/hW6a0RFTHepm+Pi6WaCNNtAZwhJgb7UGCwT7X7cRuF+nxM9
         QG80x/iVSCzQikcnm7HBBD40N8hqKOZeVsg/9BTjjVokrH19Ttk3TItH9gbPK4r9HIM9
         osNw==
X-Gm-Message-State: AOAM530DW+ic9yMjbDC/zHS4RZS7OajXcrRQRU5anCD+C5DxcCi4jR1E
        b+84308GzVk3MEP2lqkjO/mOqTN9VzLwpViRoBA=
X-Google-Smtp-Source: ABdhPJwnVHtwJzEup1p+5GKbnv4WHi4QY45TAGmHdjIZTyAf+gX52IUPSmhq6zMLWCrTBkquqcu7tYZ77fVeqJpbkQg=
X-Received: by 2002:a05:6512:3749:: with SMTP id a9mr4737337lfs.110.1622859305584;
 Fri, 04 Jun 2021 19:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210602123803.15738-1-xuewen.yan94@gmail.com>
 <YLeF/556Wbvx1Ssc@google.com> <CAB8ipk9BqzEQ4Ta5s+vJeep=v1pmaXS-WsF2tq0u9G8Q2PGmsA@mail.gmail.com>
 <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com> <d57e4a37-3e17-3f30-d055-729ece19f555@arm.com>
In-Reply-To: <d57e4a37-3e17-3f30-d055-729ece19f555@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Sat, 5 Jun 2021 10:14:04 +0800
Message-ID: <CAB8ipk_7_ta3Wtfn4=g=08u7nXoR403y0AKQZUR3i=j=yeUeng@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Avoid setting cpu.uclamp.min bigger than cpu.uclamp.max
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 12:22 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 04/06/2021 18:08, Qais Yousef wrote:
> > On 06/03/21 10:24, Xuewen Yan wrote:
> >> +CC Qais
> >
> > Thanks for the CC :)
> >
> >>
> >>
> >> Hi Quentin
> >>
> >> On Wed, Jun 2, 2021 at 9:22 PM Quentin Perret <qperret@google.com> wrote:
> >>>
> >>> +CC Patrick and Tejun
> >>>
> >>> On Wednesday 02 Jun 2021 at 20:38:03 (+0800), Xuewen Yan wrote:
> >>>> From: Xuewen Yan <xuewen.yan@unisoc.com>
> >>>>
> >>>> When setting cpu.uclamp.min/max in cgroup, there is no validating
> >>>> like uclamp_validate() in __sched_setscheduler(). It may cause the
> >>>> cpu.uclamp.min is bigger than cpu.uclamp.max.
> >>>
> >>> ISTR this was intentional. We also allow child groups to ask for
> >>> whatever clamps they want, but that is always limited by the parent, and
> >>> reflected in the 'effective' values, as per the cgroup delegation model.
> >
> > As Quentin said. This intentional to comply with cgroup model.
> >
> > See Limits and Protections sections in Documentation/admin-guide/cgroup-v2.rst
> >
> > Specifically
> >
> >       "all configuration combinations are valid"
> >
> > So user can set cpu.uclamp.min higher than cpu.uclamp.max. But when we apply
> > the setting, cpu.uclamp.min will be capped by cpu.uclamp.max. I can see you
> > found the cpu_util_update_eff() logic.
>
> To support this:
>
> Patrick had appropriate checks in his `[PATCH v10 12/16] sched/core:
> uclamp: Extend CPU's cgroup controller`.
>
> https://lkml.kernel.org/r/20190621084217.8167-13-patrick.bellasi@arm.com
>
> But is was discussed that cgroup v2 `resource distribution model`
> configurations (here protection/limit: uclamp_min/uclamp_max) should not
> be restricted.
>
> Further down in this thread:
>
> "... Limits always trump protection in effect of course but please don't
> limit what can be configured..."

Okay, I have got it. Thanks a lot!

BR
xuewen.yan
