Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9460742FA9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbhJOR7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242413AbhJOR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:59:27 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B672DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:57:20 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v195so24756123ybb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97jlEBeOWc1FuL5gX+2pJvQdPP9/uMhHJPjVq16mCeQ=;
        b=MfHP24zhRLTuEfttABUfFJeWZfEBNb910OdOqWVEBQhhPVlUDYRrFuts+dEd5ygr9d
         MxSmcw/PmZqYmNGJ223VOCzpy1pc8AhlQ9XMqDhhsnwbXhbpj71lINakeQHVeeGGJJ0Y
         JqPV+Ttg6PqKTp6GxgQ/jei1ZawiFJm+uP41w+LrQHkdiGJ8hhIe2dVdA5CEvmmlRzU+
         SP9p0jo3mJYeuBRqmVdQ41/2usLdwF4gUqoynSdCYxny5oXVomjFZIsXITdSPh8IQhMm
         NyS9UfaJ0XaN+p25MeSmNsSxIyi3Er6YIopr+S/UmF0nDynQxXKWD3RUOAbBVDNzSo1g
         LHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97jlEBeOWc1FuL5gX+2pJvQdPP9/uMhHJPjVq16mCeQ=;
        b=43sTOKLIBcitC6n56KzZ5xWW2Yh+PYkGLqKWZsjOi9rgZbOSHTGTX3+ubC6QSdVU7m
         gkn5ijeCN2vTBNTGoqCDF0qCdVoMHvAlU36jJbNQ1O3ATZUStLRF7vqGRDXMq2+Id/BF
         wEHbP7EX8vD5m3YNH4MD2roOaLMsAJJIRUOO0xnjp69vPuxE6UXwM24mfVxnesSgPyFK
         ksyUHiD9yeVsajgLzeHyInYqL4+CpW05PvFN1ddSBapEwxGUQvxLehP7uZXTXVxmE9ug
         C8ZzZXVY3gMs6+vCrr9VJgu+eKlwoUYveXB4vQS7hF9ealcE9kq46psrMN3r699gW3c9
         9SmA==
X-Gm-Message-State: AOAM531v/0DCBnE7iZcX0Vd8M8JwKDOVmkVSodQrarKoTNk5hCElO7v7
        q7rQ2UD3FGzdLsN27hPREHAjiIxXOnK4xdFvujYUOQ==
X-Google-Smtp-Source: ABdhPJw/aouEmbvTZNiox/xkSdKoF5AmKM5SbeLN9/dPjuA7usq/b6BP8h1GSOVxAcl0lbxalan4yAsp0xJL3jcUMzs=
X-Received: by 2002:a25:2f8e:: with SMTP id v136mr13797663ybv.350.1634320639885;
 Fri, 15 Oct 2021 10:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211015124654.18093-1-vincent.guittot@linaro.org>
 <20211015124654.18093-5-vincent.guittot@linaro.org> <20211015174241.GJ174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211015174241.GJ174703@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Oct 2021 19:57:08 +0200
Message-ID: <CAKfTPtBoTnwuwekOSgZ3TTrcAb5UPzTMj+N3=1T8sAuUtsqZBA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] sched/fair: Remove sysctl_sched_migration_cost condition
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 at 19:42, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Oct 15, 2021 at 02:46:54PM +0200, Vincent Guittot wrote:
> > With a default value of 500us, sysctl_sched_migration_cost is
> > significanlty higher than the cost of load_balance. Remove the
> > condition and rely on the sd->max_newidle_lb_cost to abort
> > newidle_balance.
> >
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> This is separate and not folded in for ease of bisection?

yes ease bisect and ease revert if finally there is a regression
