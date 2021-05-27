Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53E83930A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhE0OVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbhE0OU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:20:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78050C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:19:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i9so287064lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LatqtaP/aGx6woxQl/xZuLro5ci8AMLtHb6rQktXh24=;
        b=M7YJUkv0b9ZqkYCDwgcBFIcG5MN4CKndmPnWQdY2RJQHhZFVfdRUJHVRnhKAumFP7L
         xB0gbKrxCsAVajM8z2yvoA1bc7kvVBybZX48Htc446q/1kNtqtm5hoaVse9MYQh660Wv
         E56HXbe9YBGsOWvDV03VnedvUY8Mat1bdqAGkqtC0LuSynuSgH8hjijzLj+Xy6bhjsK/
         5u/9h3epeiMaAH7QNiIm4MIhBuom/9p5Fw+VhVhcAg3mg0GxMNmAPhNCio3HOiAC+6U5
         oM94F79Pvp3i6mfXvE8WGMbW0XSv7cApEYZHQ4BeedsDydhMkYNurUGs9FfJ6NnDhxvv
         QHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LatqtaP/aGx6woxQl/xZuLro5ci8AMLtHb6rQktXh24=;
        b=X2yXOswTcYPIvBhXJNCycPDCLrptx7AMDZSsLjmm3qVwgns7clQpZg8CK1jWUDiy4c
         CWjaRz01Wn2cgChWkyQaeAeZz3rOF3VKmR7RYMOcWpoyxntOTNXhuuHIPU/eJ2JrToWS
         gLr+FXOdd7h2RIGdgrBku7DNB6HF/+qbU3DWWVWSIpTuwlUBMgyVRTiU0Dkzgi1dYrol
         83AYrtpyAg6SqiqBM50n78QeikUQ+hZsF7teSnMItzsaCsInm06EBHXhCu2BL6CGinl3
         tm37sNMdg2JfyNepnU9RX0KQzP1kuRiEvOCF5QZftjIQF+XQzDXrD87tgjvpy9TtBHf2
         vKSw==
X-Gm-Message-State: AOAM5306UeQbM980IcszOmcyDTVEc2WTdGiPb0pvkHTuxCoSP0oRfiFs
        Ft+F80lWRZSujHcCL4GCQ3XZTo2p7t6prYQaFcXkoQ==
X-Google-Smtp-Source: ABdhPJwsOlsV0ZytuPo8dcabW8+vOtf/l++7R/XvOwxqJ9HGcHO+jMzLXJOXXcOg7S38dSjqEO5I6lMj20DMgZ1RfXc=
X-Received: by 2002:a19:e017:: with SMTP id x23mr2549190lfg.254.1622125159781;
 Thu, 27 May 2021 07:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210527122916.27683-1-vincent.guittot@linaro.org>
In-Reply-To: <20210527122916.27683-1-vincent.guittot@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 May 2021 16:19:08 +0200
Message-ID: <CAKfTPtAK2fkzhzKA8iFT8cEcCG6Q=8WfLskPYADvTrQ=nF7kDA@mail.gmail.com>
Subject: Re: [PATCH 0/2] schd/fair: fix stalled cfs_rq->tg_load_avg_contrib
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Odin Ugedal <odin@uged.al>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Odin,

On Thu, 27 May 2021 at 14:29, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Odin reported some fairness problem between cgroup because of stalled
> value in cfs_rq->tg_load_avg_contrib:
>
> https://lkml.org/lkml/2021/5/18/566
>
>
> 2 problems generated this situation:
> -1st: After propagating load in the hierarchy, load_sum can be null
>  whereas load_avg isn't so the cfs_rq is removed whereas it still
>  contribute to th tg's load
> -2nd: cfs_rq->tg_load_avg_contrib was not always updated after
>  significant changes like becoming null because cfs_rq had already
>  been updated when propagating a child load.
>

This series fixes the problem triggered by your 1st script on my test
machine. But could you confirm that this patchset also fixes the
problem on yours

Regards,
Vincent

>
> Vincent Guittot (2):
>   sched/fair: keep load_avg and load_sum synced
>   sched/fair: make sure to update tg contrib for blocked load
>
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> --
> 2.17.1
>
