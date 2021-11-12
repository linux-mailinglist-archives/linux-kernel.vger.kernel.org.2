Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A0844E29F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 08:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhKLHxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 02:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhKLHxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 02:53:49 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EECC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 23:50:59 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e136so21568495ybc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 23:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hsJfBjpLQBnNYoC8zh5y1uUfpVlm2S4eitLUmrS0SI=;
        b=JBV6L1OHMnp6AQ9vM+jo8Lrg6xtxiG3nXWTz5o5RSYI39xgwe0ng8XHLP+9bwUfd/o
         hLaQgG26lHY6x1a83Ds1FJTIr5fS/v/wX3KIBeoHC1nprvQVCHfzIE+4aCnJeLuyehSH
         2ihTrpFqGF2kb8SwhGO6OW+FSEbQjeuKjzY1+UfqqOXAbJihZjyMqZe2EH/Rxf+EAgS8
         0QbRoGuuGB7teAMvE3SCmg8nvr7PHDXsd7df5FoOjjfmgCXvzWDRGt5tG/3pum5zp4WI
         y7ZVZjpA6HR0bWMug27ecBkz14v4Tk7SdQTOqRatzShMMu8ZQwXakG74WjW7H5JOHl4H
         q4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hsJfBjpLQBnNYoC8zh5y1uUfpVlm2S4eitLUmrS0SI=;
        b=yL00qa/lc8ngX8w23i99cSaJhuzw0rq7DtZ8zwmZQRlR/fb4T9lEwcGWTABqG+8nRm
         VQQqDFO7h+vNp2ptXjf65Cq3hJPXLKH+ozZzJ44JZmyFrw7JJ6+OHeKVq/quRHAj6swm
         mLlFOPRTEtsyZdv2vRei6jUIpdYLovi4lCI/VjyrfTOXOkgyp/7E1xXVqx03K+FAdgEP
         IN/x1DfuOOa/kQxQSTE3jUEKL0wAsk+4ZZbXEzBur7uddJ02sBxcvDDxOxZlpPkkfyVo
         b7RNizPJ2gFeFPP6C3yQ5jCc7Mcwf44hrXl1G5B8RgYrwYx9hsiCYNQ053z8bbhKr5t3
         b6Ig==
X-Gm-Message-State: AOAM531lds88vhR+9NHdc1Yj2qbHBFhTAKh5W/dsl1B494/pWBq6O1rA
        0C5R/DcZq5dl7c649E75/zMl6WZY+oRnxLWJ/IxK6w==
X-Google-Smtp-Source: ABdhPJxYnWdOcV5iPRaYM7MejstD+Cx3j6SwdJdRMaK1kX1sZPdfnECqq3bvWSXTyWwZRDugM5kEUr51wLDc3Vui35E=
X-Received: by 2002:a25:a427:: with SMTP id f36mr14333170ybi.245.1636703458115;
 Thu, 11 Nov 2021 23:50:58 -0800 (PST)
MIME-Version: 1.0
References: <YYrU2PdmdNkulWSM@sultan-box.localdomain> <20211109213847.GY174703@worktop.programming.kicks-ass.net>
 <CAKfTPtC_A-_sfQ+rm440oHwd2gUZ222FMwsi-JTkyLPc-x0qrw@mail.gmail.com> <YYwihj21abVmf9Ag@sultan-box.localdomain>
In-Reply-To: <YYwihj21abVmf9Ag@sultan-box.localdomain>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 12 Nov 2021 08:50:46 +0100
Message-ID: <CAKfTPtDaO9KGhWGYnr6CNRy=h1UuVXTJEqcVFz3dzvi=xqMv4A@mail.gmail.com>
Subject: Re: printk deadlock due to double lock attempt on current CPU's runqueue
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 at 20:50, Sultan Alsawaf <sultan@kerneltoast.com> wrote:
>
> On Wed, Nov 10, 2021 at 10:00:35AM +0100, Vincent Guittot wrote:
> > Is it the same SCHED_WARN_ON(rq->tmp_alone_branch !=
> > &rq->leaf_cfs_rq_list); that generates the deadlock on v5.15 too ?
> >
> > one remaining tmp_alone_branch warning has been fixed in v5.15 with
> > 2630cde26711 ("sched/fair: Add ancestors of unthrottled undecayed cfs_rq")
>
> I should clarify that I didn't actually reproduce the issue on v5.15; I just saw
> that the call chain leading to the deadlock still existed in v5.15 after looking
> through the code.

Thanks for the clarification

>
> Failing the SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list); assert
> is extremely rare in my experience, and I don't have a reproducer. It has only
> happened once after months of heavy usage (with lots of reboots too, so not with
> crazy high uptime).
>
> Sultan
