Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C664C3F685C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbhHXRrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhHXRra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:47:30 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD429C028BB1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:04:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id r4so42397653ybp.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIVpdBZk/HxPj/FHQOCKyznL6b/01iT5/ipB6uYEJGc=;
        b=mOPY+2sBRjXefurf+Hw43yE0d8uirfDlqwMWG+GvFkOb7Ypg9YWDI9abkmNS3rBngm
         +9S1c8DGHSQb+SpZcmcso67EWB38303y6w9r8oLTSdrBgKi7Nso+gsCElQvGTVhBBTCT
         6m5Gzk8c9FEdd4kkB/qHEA27D2gIORnCEPQgFMXRr8mxURgCIw0aQhKUm2Cl+lhLcEJg
         fcs91+BfmG1eA3C3HRId6HNr6SPOUxCTyuBi2BOfA+WkugYE9KNjDslmQcPwi8kxeXKf
         Me8uZ44zW0QSylMFglP7fIWyOokN7yUXk1eliYbeQ/YKSA1VT6j1q0f1XY3TR0RAfWgw
         ElmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIVpdBZk/HxPj/FHQOCKyznL6b/01iT5/ipB6uYEJGc=;
        b=oCeNJxgHd1ZP/xEjAB09qeTZZ9/Cxpt81mAdjQ3ICkQ21VLQZiQr+h8oHBz0I4YDTk
         K/YucKYXaZhRDQz3a0nddh+GFKLRg98gMfBC9fD4evHjS4rSysW4CrG+a8YaSSej0VLs
         +oNr7X/4bDdWl4Lt3wKQRFVZvlWctVb85uVdETPuUHbOsiyLY8JcngA/dYl1Dk4kC93b
         XZI5uILrJQz4dDZK+780xt/Gx8VEdvTF4NbTvoM+Krecl59G7Jtfz0k+JGyf1zCkTjPX
         eLLMhaELnOWtMt7i0cZDm6qoKs1OANyhIuMZsTW/Uc6QANSz8MVhke3IFsFQ3E8r+rni
         LJ3Q==
X-Gm-Message-State: AOAM530EC8WOhbakhgaKXMAFHejwaU3Iwd3lCuVFi1ZyJvIPGEB6RX46
        734wcZcHXoHire1GAvWt2QGDfh183+uGGrKXxSi6Gw==
X-Google-Smtp-Source: ABdhPJxXSm6jxoU38Pj8CVIgF+gP766L5/XiHXGCNGWV4gNmhEzvJVBO7oAsac8ffrqkISpMcPPb+FQClEU0xcKPbbM=
X-Received: by 2002:a5b:7c4:: with SMTP id t4mr49862379ybq.368.1629824680542;
 Tue, 24 Aug 2021 10:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-4-joshdon@google.com>
 <CAPJCdBm1vkbkK_0WqYTpw7dCWbW2dkE=ygTu5UxyHvwCRpUAJQ@mail.gmail.com>
In-Reply-To: <CAPJCdBm1vkbkK_0WqYTpw7dCWbW2dkE=ygTu5UxyHvwCRpUAJQ@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 24 Aug 2021 10:04:29 -0700
Message-ID: <CABk29NtVaUehs2gChfFPJmjxzbTn0eM49ivHr=a9F2+X20vAtg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] sched: reduce sched slice for SCHED_IDLE entities
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

Hi Jiang,

On Tue, Aug 24, 2021 at 3:25 AM Jiang Biao <benbjiang@gmail.com> wrote:
>
> Why not just ignore min granularity when normal entities compete with
> a SCHED_IDLE entity? something like this,
>
> @@ -697,8 +710,14 @@ static u64 sched_slice(struct cfs_rq *cfs_rq,
> struct sched_entity *se)
>                  slice = __calc_delta(slice, se->load.weight, load);
>          }
>
>  -       if (sched_feat(BASE_SLICE))
>  -               slice = max(slice, (u64)sysctl_sched_min_granularity);
>  +       if (sched_feat(BASE_SLICE)
>  +          && (!se_is_idle(init_se) || sched_idle_cfs_rq(cfs_rq)))
>  +               slice = max(slice, (u64)sysctl_sched_min_granularity);
>
>          return slice;
>   }
> If so, there seems no need to introduce sysctl_sched_idle_min_granularity? :)

Ignoring min_gran entirely could lead to some really tiny slices; see
discussion at https://lkml.org/lkml/2021/8/12/651.
