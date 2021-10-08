Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C284272CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 23:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbhJHVGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhJHVGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 17:06:07 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C4EC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 14:04:12 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g6so23838411ybb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJCyob/naNFIp66v1NuubO0ZrjxTyjmM346cE0DYb4k=;
        b=DMbN5ABQdgA8hTg3sZAeY9/flqtV6HZEXexCScbjhg6wkqZ8May85BF2yJvJ8eIpjt
         3mULY0ITrwjFZHUj+TsHbYbf/VTh8CI1xDP89VyHXlpT3AywQFdrPLbTPGVVrcM7Qtxp
         T3bfq52r7P6xYbzBNvNxE/zSyvz5NdG0VGgyfK23LtHNqUkm3cjW4aLjkrCG46H7X1C+
         qEczrGD+sgHmUty76/Pjy+ET0d32qyihe7QP4iH6WTnjK0+60TokmRANyMUCy+4U+LO1
         L1HuJ4Nj2LBDgtBWJoeWwybAFZYgjicxntniNcrSKLllMlJKZuGLWxtcm36TxvNjmjrh
         61lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJCyob/naNFIp66v1NuubO0ZrjxTyjmM346cE0DYb4k=;
        b=UoNdNpJqKoVSUFTFbidw7i+DMllrP9J6nWQicVJCHWBXQV9nNfezHpLYEwBu3L2FaO
         kXlQ+afMf4YEp9TJ2P4ZhiCf/MwCKLYwuxEH2p15GCTRRjG4WuONnjwlbzhS/+fi+JaB
         xGWv/qSf6gg5opbwjlbvY5nMHAdZYNb+QjGAU0PZD8IJMmz3zIUZNxf54uXhhbdlByYH
         Cof4ZgYeDEfwr68A8UzKuPiUj8De9oiz9kbLBK0o1r0rVuCWJ5MkKDkoMXSP2QuYTr0/
         MKdprNY5EBp8mDbsViW7E1naAWZJytK8w3y6XQiB6x4T3YrCbm89jfuXb7Rq5EJ1YLx5
         1smQ==
X-Gm-Message-State: AOAM532OVuMSLCAQcIZNIMimR/47uwDnYbe0WWLb4uciXI1YRzlDF07E
        9UbKYRg8CvzoUq7WLU5G/BGQRaFDcu5AKhepg32qcA==
X-Google-Smtp-Source: ABdhPJxDfHG8j7nwF/qYwAHp7NQBrrQBOdjhZbfslWjaK6O/vNQO/d27r3m53v8cGxtu6K3ThrD24gryx/Py0wbf+tE=
X-Received: by 2002:a25:b7d3:: with SMTP id u19mr5644868ybj.158.1633727051142;
 Fri, 08 Oct 2021 14:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000825.1364224-1-joshdon@google.com>
In-Reply-To: <20211008000825.1364224-1-joshdon@google.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 8 Oct 2021 14:04:00 -0700
Message-ID: <CABk29NvB5JCgYs+5uNVYyczCT05DPPTQtTc=dVyXRLDd9xqopg@mail.gmail.com>
Subject: Re: [PATCH] sched/core: forced idle accounting
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 5:08 PM Josh Don <joshdon@google.com> wrote:
>
> @@ -6051,6 +6071,13 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
>         core_rq->core_forceidle     = rq->core_forceidle;
>         core_rq->core_forceidle_seq = rq->core_forceidle_seq;
>
> +       /*
> +        * Accounting edge for forced idle is handled in pick_next_task().
> +        * Don't need another one here, since the hotplug thread shouldn't
> +        * have a cookie.
> +        */
> +       core_rq->core_forceidle_start = 0;
> +
>         /* install new leader */
>         for_each_cpu(t, smt_mask) {
>                 rq = cpu_rq(t);

Realized there needs to be a similar edge in sched_core_flip(). I'll
include that in a v2, after seeing if there are any other comments on
this patch.
