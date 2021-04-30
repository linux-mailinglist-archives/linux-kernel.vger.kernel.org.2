Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC836FB4D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhD3NPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhD3NPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:15:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F74C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 06:14:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z6so9258194wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MPQPUN5VCn1ijxvAhjY2Rhy4FDLKQuGmZG+s6D8CjGk=;
        b=s+LK+3u2rwaMR0Hq51Bgtf8cGpb+ZSw5N68z8L+M07fjdgHyS/nCLLjVhnkkQo01d9
         XxkMXuPShO+2EABhOCOShlVK3i32UaQRZTGQkgZL6kwtuxuhAlRoXVeAU9kkr4WnksXY
         /Tx+xxQ3wIFoicgev/NBgykX675iLwqf86O0hz/RkeurIS0YdwJ55Ol0Uqrm/xAfKzKy
         4ExiTjnFS5AZTzdAYZo+v4fR1Tn9dwbmfcl+aq5QG5Iy6BhN82B9qEty6P+gAEBfqkeb
         t29Ho6iWN7HyaYDsnyFWIWpvy+Vnm7z7EkBxWW6ZChnaEe5BBdp7fqiGZ+hZXcfdTQXw
         Zu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MPQPUN5VCn1ijxvAhjY2Rhy4FDLKQuGmZG+s6D8CjGk=;
        b=Uaris+K8eKe3oJz9gh7p33UmUo2pdJz5f6n3WYb2zMm/gI6mKStAvSWA0JWEI3smKq
         5xPuRWsapTmQ268N1Rai3Ws0cgQBXQfSEwwSLqpN6YF5WZIviKE2Hr84L5Zqw/mI20K0
         ykXO+QpS0eWN5czobypxmPtZHArZLcst4HfbAJmVkfMsCKjakp3drrcSNGKzBXj4g7i6
         5ekhVe76U3tzWk9lhYBRdt55Ngd+RwA/uXGOX5OuS4+55hZJ2CnlBPqECt17psyDUlTL
         Vy1SxRUrMEPwqR2EZZVz3CIS8tCr45ZELyxAcD0yJ7c/RtH76BTj+IICr6EvrYqxkeD4
         yJag==
X-Gm-Message-State: AOAM530yimETdxD1mFJ8GxFGIjgXnsgIOl3CpYJDtHM7VMFrTNwTtPOj
        I2K7MMecCTRsQOpfpZBPIUANDg==
X-Google-Smtp-Source: ABdhPJx5Q4G+NYqCfZcTj6HWEs2avVL4eW9Zb3jJV57p49vuAHN92c+TOe4IWoDzb7XBL+YkQp7u9g==
X-Received: by 2002:a5d:54c9:: with SMTP id x9mr6694932wrv.91.1619788481511;
        Fri, 30 Apr 2021 06:14:41 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d6sm2220401wrr.77.2021.04.30.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 06:14:40 -0700 (PDT)
Date:   Fri, 30 Apr 2021 13:14:38 +0000
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH v2] sched: Fix out-of-bound access in uclamp
Message-ID: <YIwCvkfrPGkyk17d@google.com>
References: <20210429152656.4118460-1-qperret@google.com>
 <CAKfTPtAfgVnMYkY_M+SDmNQDb_EsxSctQw-fkt2WJhczZakOjQ@mail.gmail.com>
 <YIu/EjZ8QsEl9sum@google.com>
 <CAKfTPtDOuB0UzZM5OtNzCUABftz_A40Z4W1z9OAORzFitfPDEQ@mail.gmail.com>
 <YIvQoG52Vk96DJQ/@google.com>
 <CAKfTPtB-0N7ogk0snCgj78zDrXRWgFUL=G7MoRDn+Bg8Hnk-PQ@mail.gmail.com>
 <b6737247-ca02-e197-70c7-020952d95c1b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6737247-ca02-e197-70c7-020952d95c1b@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 Apr 2021 at 15:00:00 (+0200), Dietmar Eggemann wrote:
> On 30/04/2021 14:03, Vincent Guittot wrote:
> IMHO, this asks for
> 
> min_t(unsigned int, clamp_value/UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS-1);

Yep, that's what I have locally.

> >>  }
> >>
> >>  static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
> 
> Looks like this will fix a lot of possible configs:
> 
> nbr buckets 1-4, 7-8, 10-12, 14-17, *20*, 26, 29-32 ...
> 
> We would still introduce larger last buckets, right?

Indeed. The only better alternative I could see was to 'spread' the
error accross multiple buckets (e.g. make the last few buckets a bit
bigger instead of having all of it accumulated on the last one), but not
sure it is worth the overhead.

Suggestions are welcome though.

> Examples:
> 
> nbr_buckets 	delta	last bucket size
> 
> 20 		51	 +5 = 56
>
> 26		39	+10 = 49
> 
> 29		35	 +9 = 44

Yes the error can become worse in the relative sense with a large number
of buckets, but again the max is 20 so we should be fine?

Thanks,
Quentin
