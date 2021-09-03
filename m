Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586053FF8A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 03:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbhICBWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 21:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhICBWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 21:22:21 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C11C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 18:21:22 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r4so7304958ybp.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbnWfjPWbMqaUy77C85OvsHvKmk1fJxMRcsrhSEyptw=;
        b=B/RiRqDWqn3gSMhdV8ILZNJvnvwgprEvlAiLRjyfK6EYIvNOdZANmN61654XhWynuh
         o4SyIXauNA1Ic5YOr8t4SjpT/3AqqtvL2ffCfcNyPE2WJWObnumdg+GPyjNebwubBV+7
         SOmzczK1xvtjcseWX+Ht2JhBygbwHotXVNC2jZICwZOBTQugQnTd7f7ThiTatxKmmIhk
         ANjxGf4xvWLeNQ/LVM29UkrLY64e9tgrAVsL+v8b9hXS3MC1eRH/uHo9Cm8JWYQK8+7/
         IaAyVbpCMlSBM8HUrC1vTClfdJ3OsK4E3gsFo2JP+gtDbX8ZWZg8w7nXrGhbtdfC6Pam
         EDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbnWfjPWbMqaUy77C85OvsHvKmk1fJxMRcsrhSEyptw=;
        b=UH3pyPvbeui1UEJDFDvt1vRmkUN8wt7VZfm+h3NeaZ42S9rwbS3K+s6yCLkMiLEhyH
         Bzi5cCiedLLPiBcCRRz5eZVmkIhS3L1q5jZLalQL405QIs+jlMTT0RZv36I+QkV6jwPG
         y46exB3N8uGUdXWaGMglSpwW9GVJlCyqBiTA3rGPiwdnNOmajX23msKUPdMbupK9p3+s
         0Rne0SLYPsRBgvoIzUsWBBiRKXb6Q1uIF+XsDpCWsvY1bD8szZC8u5CK1prjv8lA2Fj7
         m2GEGsDENC6T1iG+XkGFVjYdy8oANcYlb+R5t4pQk5+Gl6EZXFf6hQEdmslpc2M4KlPc
         kcLw==
X-Gm-Message-State: AOAM530MW/7Y7S1dKaaVcSrWOGlFLLGkWOHWvC6X0RuLaEznTfK9V/iU
        o56CSeZvEZv7iZ6YlAZGI/LjwMy85bPJialSHYw/6A==
X-Google-Smtp-Source: ABdhPJxoW+365yaXVacsVbgqdXRUGmiFd+AO+mo1bz+fKkwbsLg7I8giOS9V/G0liXBpEcPRio7MnYn9bce5+BqXZG8=
X-Received: by 2002:a25:4254:: with SMTP id p81mr1549551yba.442.1630632080846;
 Thu, 02 Sep 2021 18:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-2-joshdon@google.com>
 <20210902012206.cm6flytlp63c2h5v@oracle.com>
In-Reply-To: <20210902012206.cm6flytlp63c2h5v@oracle.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 2 Sep 2021 18:21:09 -0700
Message-ID: <CABk29NuoNRu0SnEEqC8zhJROndCSRhfsE2xkhO98WP_wTTDuCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] sched: cgroup SCHED_IDLE support
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 6:22 PM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> On Thu, Aug 19, 2021 at 06:04:00PM -0700, Josh Don wrote:
> > +static int se_is_idle(struct sched_entity *se)
> > +{
> > +     return 0;
> > +}
>
> I'm thinking !FAIR_GROUP_SCHED is a rare thing to behold?  So not a big
> deal, but I think this wants to be
>
>         return task_has_idle_policy(task_of(se));
>
> so buddies aren't set for SCHED_IDLE.

Good point. Peter has merged this one already, do you want to send a patch?
