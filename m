Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0DB3F6866
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbhHXRuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbhHXRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:50:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9B9C04C39E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:12:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z128so42392307ybc.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PfOHx/yYiVRDFcplLpIShH9j4DkSNtuEs48LotWh3gY=;
        b=qR+Cx3gYe5B4T+OEfcLxI2qUcoOx0R40mL2hb9r9JU0eHhjgV+aNoNXfTcvpE2giLM
         iGr+K/xv5QqnR+ic+DUGfM8sHlAoDHqadQRe4mMN/wC7kZrUMXlmhEbGH34Zp17S+PYG
         3VEcoSOi63Gzpt3oTOweFtp305sKD6TVxWOA/OrKHJmVG6fD7z3M6Xg7Nzb0HPnV6BUv
         kUm5JlzJWiShB8eGgwKGOtwS7S7VF9iqX5f3BmJbqxpkB/RG8nYX7/qxgitiE+83fLEZ
         IyUbiKL/wcu/IJP9D5CDwyz4cw2K0FExma1kGsLuZd+R5KL+Lu2Kfo33qKOVvthRhUK8
         u+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfOHx/yYiVRDFcplLpIShH9j4DkSNtuEs48LotWh3gY=;
        b=fL4mL2E1dvPSGA2KTOvJk+RqtCZNryRMl5rr1C4UKUfwjQJBKQsYovYcyqp/cWXbsj
         v7yYiGROAfDUa0hgH13G77oMqkZcYdZgIgTy9+ooYNeYpgvoSpRL4Nm5dslcKuGpfnc7
         8+ElUCEpmZWoDyJyN9rsiqdlswKhi/seT9vTxLGH3yI5OgKt3hxsJV2M0ETGwgOzncDh
         0zuWvlwzks+g9UAi097qiqhPetPfd76POIpWarvoAYf88CkUDEJdvKPzoCcZwoL2n7jg
         M4WnW2kOClUtJpHKSzSwwIOkvddYBRwUYoTul2iewhAJ/yYghyQP7Tp4cEvs5Q3wuJA4
         F05Q==
X-Gm-Message-State: AOAM5321kCbhRnotrXSccTO4FbnXnNbf7oXNeGgksES4loiy4Ox0bQ5e
        eYSxA+WzgBI7xVAkyaRo6kaKnapRq5bzRUa8IjD7eQ==
X-Google-Smtp-Source: ABdhPJze8Zpd/C2n67fCbfSLN0JpwAjoDpi8a4tVfAxoo8Pwq6gpSAaeHibU58oD+VRCCg75MngUFaV9H29jO2wzmoY=
X-Received: by 2002:a25:c095:: with SMTP id c143mr11675278ybf.179.1629825145263;
 Tue, 24 Aug 2021 10:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-5-joshdon@google.com>
 <CAPJCdBnz7AzAWyD5Sqc4TLy3By1k4PAex8kpaWrcJb=YPwVC8w@mail.gmail.com>
In-Reply-To: <CAPJCdBnz7AzAWyD5Sqc4TLy3By1k4PAex8kpaWrcJb=YPwVC8w@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 24 Aug 2021 10:12:14 -0700
Message-ID: <CABk29NtWw53a8CWz4gDc1d57BwNyN1=uiGnSKbdxkGijs__1tg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] sched: adjust sleeper credit for SCHED_IDLE entities
To:     Jiang Biao <benbjiang@gmail.com>
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

On Tue, Aug 24, 2021 at 1:16 AM Jiang Biao <benbjiang@gmail.com> wrote:
>
> Hi,
>
> On Fri, 20 Aug 2021 at 09:06, Josh Don <joshdon@google.com> wrote:
> >
> > Give reduced sleeper credit to SCHED_IDLE entities. As a result, woken
> > SCHED_IDLE entities will take longer to preempt normal entities.
> >
> > The benefit of this change is to make it less likely that a newly woken
> > SCHED_IDLE entity will preempt a short-running normal entity before it
> > blocks.
> >
> > We still give a small sleeper credit to SCHED_IDLE entities, so that
> > idle<->idle competition retains some fairness.
> >
> > Example: With HZ=1000, spawned four threads affined to one cpu, one of
> > which was set to SCHED_IDLE. Without this patch, wakeup latency for the
> > SCHED_IDLE thread was ~1-2ms, with the patch the wakeup latency was
> > ~5ms.
> >
> > Signed-off-by: Josh Don <joshdon@google.com>
> Tried to push a similar patch before, but failed. :)
> https://lkml.org/lkml/2020/8/20/1773
> Please pick my Reviewed-by if you don't mind,
> Reviewed-by: Jiang Biao <benbjiang@tencent.com>

Done, thanks :)
