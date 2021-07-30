Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C96B3DB5D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbhG3JWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhG3JW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627636944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hztfF3mk+w2hTp5cK9vPRcBqwpAjiT5aSw+6qCP4+BI=;
        b=cl1XIBjYiKTZ0JhyWAKUKgSUKWNENyWvr6DXUeB7zOKkX+5ewBnBiUdykCSZUSnMqQPQcs
        8xigh23+Uk7gRZo11GJOuv1ZmUeCaRlamxWsnII6ZQ/3UoI3dsQ22uynDC0sWj55qtvfDg
        /dQaBRPVM+d8FJ4P6acFZLQpjx6C5iU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-yvw0Kr7GNWi0W1lSyEZwXg-1; Fri, 30 Jul 2021 05:22:23 -0400
X-MC-Unique: yvw0Kr7GNWi0W1lSyEZwXg-1
Received: by mail-wr1-f72.google.com with SMTP id d14-20020adfe2ce0000b029013a357d7bdcso3028069wrj.18
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hztfF3mk+w2hTp5cK9vPRcBqwpAjiT5aSw+6qCP4+BI=;
        b=BA8JyCDiiVbFqfM9759yBJ4blB4tc7Hs7NeUlL3dJZJsk/ODsRO8e6/Vl0lTLDXpK6
         cfXDAdjXm9jEY/9bN3Ed8k7ScuMCy54VZ5ftsa3TM67tnBnUxdGMVrj6vmv3S6CeZ5k0
         CI3qxGabVBv6epAJujnoRiippVxaKOOQrHoFjQO9/BEQB872EYK644NNVUJZoeQiDk2G
         OGyhE4zz89a1fo/tNDFtjOWBFfNWbPxmAX3u+viZBq4f2swD7gSw6rwL9iShkhPxBZtA
         xY8jw0TN1GmugQkQnA51e1Ru4wogpfSCtizNbLUfiT38lHtcRvFtSzzatgzlbu5v3f7T
         f5Vg==
X-Gm-Message-State: AOAM531nt+OpFrRvY6bco50W6Bf+eynqUsg/w1PJ9ClRGCrL1iAamPpG
        /MfAqn7Y5z+X/+XukAluQbdKrxqa4b/uxoyIK5L/DOInQI1RusC5r0ANtgaVIo/5Ayg5p1prOdQ
        WAaUAZxP1eoMmlSroSRHMgeK/
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr1918316wmc.175.1627636941776;
        Fri, 30 Jul 2021 02:22:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbEAF/ThGMLMAsvCjLHbMjEFNweJvQ4f+e8wqit8PSMTV0Ug0oXt+ANrnNKwMhQMUcAKgjzA==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr1918301wmc.175.1627636941567;
        Fri, 30 Jul 2021 02:22:21 -0700 (PDT)
Received: from localhost.localdomain ([151.29.58.124])
        by smtp.gmail.com with ESMTPSA id p8sm1014945wrn.79.2021.07.30.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:22:20 -0700 (PDT)
Date:   Fri, 30 Jul 2021 11:22:18 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2] sched/deadline: Fix sched_getattr() for DL tasks
Message-ID: <YQPEygMj5ObRDLHG@localhost.localdomain>
References: <20210729175214.294142-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729175214.294142-1-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/07/21 18:52, Quentin Perret wrote:
> In its current state, sched_getattr() can report incorrect sched_flags
> if called on a deadline task.
> 
> Firstly, if the reset_on_fork flag is set on a deadline task using
> sched_setattr() with SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_KEEP_PARAMS,
> p->sched_reset_on_fork will be set but __setscheduler() will bail out
> early without updating the dl_se->flags. Consequently, if sched_getattr
> is then called on the same task, __getparam_dl() will override
> kattr.sched_flags with the now out-of-date copy in dl_se->flags and
> report a stale reset_on_fork value to userspace.
> 
> And secondly, sched_getattr() currently reports SCHED_FLAG_SUGOV as set
> if called on a schedutil worker, despite this flag being a kernel-only
> value that is not exposed in UAPI headers.
> 
> To fix both of these problems, make sure to only copy the flags that are
> relevant to sched_deadline to dl_se->flags, and filter them out when
> reporting them back to userspace.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>

Looks good to me.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri

