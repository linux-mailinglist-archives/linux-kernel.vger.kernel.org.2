Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA940AB15
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhINJqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhINJqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:46:49 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C43C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:45:31 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id s16so26952442ybe.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6OJphO0e7rLBRBbSAlg3q6/R5zqNUP3oaJTDFY8VD3I=;
        b=TkO9nV1hDvJp8P33x5ZB/0xrRLFYaRevCj1mdGZMDpScuL1eG8jx/9yweoJFH1zvyQ
         Jl9JwWGlbuY3mTQmzFQ9/t0mfhOFtZLA+q6kOZWxTdLMUoxEgOQQiFSZscM7g2DJ/1xE
         s8o1g5RHIGBzvBfhPa9EdqVK1oRgeBByZxmeGF8Cr+tia6LyWnI5a5qScQgntExLimTq
         bXgUJFZu73lpz9IbFYQxWXVq09/lQBfkZTwPEyiDpiCGpLcmOKBFg5lxuFequVeaRLUF
         esR7QPpAnKIXO8VoKwzEiTTEN5528a6QJ6+RbYH4T58c4PzPMHD5UQWWYFgsDcugDuj/
         ibMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6OJphO0e7rLBRBbSAlg3q6/R5zqNUP3oaJTDFY8VD3I=;
        b=i7ODhFr/hMguAjIprulJICvWPhCvN7NDxAxXkuJ1GJXKrU3TTWwiwXaMcEqRhYQWlq
         8JELgAO+ATg2q7SncMVtdyJbQGeHE5BgRoyaAFBGHkjr1LS12uFllXM0kWVxSTA9dtUS
         BQMqSb/OoQWmnQ8S6Bhuz9Qa+/JzXOdfYAtgbuU0ShIKvsCkmYzVjxg5QriBBWr7jjVj
         h4c5E+zhIvM6SG1X3VtxZBKU/2hDV8rNPe8r7a+4XW8GFyc0jG2s8PB/KjpQgj6SI6BH
         1tiDDg+LaF/egRxdoMXFoj/82cAhaTqGd3C3JwiqfHpTlbdJBCE+5+6cE3UrSFi50z5f
         zwyw==
X-Gm-Message-State: AOAM530hVKGwx+6hxbT8sZGyQNJRP6+LPpETjTOjjjgOTMNI/qs0BnGN
        f8QBYMY23gj9KkM9sL+fFzFVZ53W7GWJ+W1/lHjlfQ==
X-Google-Smtp-Source: ABdhPJybgwF7eQVAOzPZ8prlqcmbMuyk8npM8/LpbQc5+nLyExHtvnMi1adumdMzq7GNItknPQ2rIdJ59CcTBlsESw8=
X-Received: by 2002:a25:2d4c:: with SMTP id s12mr21464868ybe.350.1631612730785;
 Tue, 14 Sep 2021 02:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210819175034.4577-1-mkoutny@suse.com> <20210819175034.4577-5-mkoutny@suse.com>
 <CAKfTPtCAxksmsR6DJuAoSZ7XTon+gesyic36EHL-nQk0LiHWQg@mail.gmail.com> <20210914092207.GA23743@blackbody.suse.cz>
In-Reply-To: <20210914092207.GA23743@blackbody.suse.cz>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Sep 2021 11:45:19 +0200
Message-ID: <CAKfTPtDw6_iMxGyCK8vrwgV-zMyHtNKBksxs3OpbpK=houzp2g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] sched/fair: Simplify load_cfs_rq_list maintenance
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sept 2021 at 11:22, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Fri, Sep 10, 2021 at 04:19:27PM +0200, Vincent Guittot <vincent.guitto=
t@linaro.org> wrote:
> > Your proposal looks interesting but I need more time to make sure that
> > all cases are covered. We have faced several odd corner cases and
> > sequences in the past that I need time to check that you don't put
> > some back
>
> Do you have any pointers to the cases that come to your mind? I wonder
> if those could be reproduced with a simple setup.

I don't have a strict list but several warnings for leaf_list have
been already reported on lkml in the past and the use cases were quite
complicated and I want to go through them to make sure they are still
covered.

Vincent

> (FTR, I used the LTP test (at b673f49ae) cfs_bandwidth01 to check this ch=
ange.)
>
> Thanks,
> Michal
