Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F102E406D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhIJNvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233245AbhIJNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631281786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZ7wX9gnYVZ+IUhQNGX1+3fKK1+B4n+d3hgqCAR8Nrk=;
        b=KJILneJ1Deep3lpEP/v8RXsdwPYvtMklQV/jmcBi67kZMqwI2JqdOwQ67ucHbocj9UpIIl
        Bb5kNOiduhVxmNOkK/I0V5WbYcKav6biUa6WFeefT13o4q45uj7xZ8zWEjxuWqTh/XYsYT
        z8eU5rrOSHZFudSKjePDe6Sdatr0vxM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-Zua19QLbOI-HTgXAwuD2fg-1; Fri, 10 Sep 2021 09:49:44 -0400
X-MC-Unique: Zua19QLbOI-HTgXAwuD2fg-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so853409wmj.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rZ7wX9gnYVZ+IUhQNGX1+3fKK1+B4n+d3hgqCAR8Nrk=;
        b=BYzarJncZFzkC4c7K03cEqQZrTeAaVTxkr7iCgCeyYp9LA90fpyUPmRpKFQ8PSvXE3
         41tzAr07qU824ERGW28KwP7iEBxXh1YoV8vx2tRJm+0QB0znmd472nvKPjmDo2h01hn1
         GA4wbpjXrCp+6V16Dp3goEhjMrSCyWdZnvC8AM1Nrcj2yz27eaQagzRBJ4/I6mKByPmI
         UkIWhld/l6iIiDKTR/ZjcZQ62F0ZVnhN00VI+hQ6uTlUBw6LDLL1sIC/aic/oKv04i1O
         CCcbh7gtddrB55INs87DOazLKG28Myr3+QH1GeeInF729vVdFjxL4buveD9XapknAjOA
         rMSw==
X-Gm-Message-State: AOAM533RAOAn0tJLGHzRy7SO7hay/2hwAq1uyR4FNsefi4+o+pSb7Dzd
        4PyOnWbe8iwMgBL95kQp6FpzqbGJGvPQbq3Yi+G9jBpxf9vAQV0vBpfCu3VmRlI6vuyQZKHUspP
        rmK9s7mix3he48M1vGyatSiUA
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr8479932wmf.154.1631281783618;
        Fri, 10 Sep 2021 06:49:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxj439zu/cF9HzSP55q1SE17gudtQBOZR+HM2vG8huz4WiHkVKR1XGSKbP+aChI2HuTMkewg==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr8479917wmf.154.1631281783450;
        Fri, 10 Sep 2021 06:49:43 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1f0d:6700:7eb9:ffb3:3868:81d7? ([2a0c:5a80:1f0d:6700:7eb9:ffb3:3868:81d7])
        by smtp.gmail.com with ESMTPSA id q128sm5180452wma.27.2021.09.10.06.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 06:49:43 -0700 (PDT)
Message-ID: <92252a92c5fe45b3ef6d2627975d917e0e522e8f.camel@redhat.com>
Subject: Re: [patch V3 3/8] task isolation: sync vmstats on return to
 userspace
From:   nsaenzju@redhat.com
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Date:   Fri, 10 Sep 2021 15:49:42 +0200
In-Reply-To: <20210824152646.743604666@fuller.cnet>
References: <20210824152423.300346181@fuller.cnet>
         <20210824152646.743604666@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Tue, 2021-08-24 at 12:24 -0300, Marcelo Tosatti wrote:
> The logic to disable vmstat worker thread, when entering
> nohz full, does not cover all scenarios. For example, it is possible
> for the following to happen:
> 
> 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> 2) app runs mlock, which increases counters for mlock'ed pages.
> 3) start -RT loop
> 
> Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> the mlock, vmstat shepherd can restart vmstat worker thread on
> the CPU in question.
> 
> To fix this, use the task isolation prctl interface to quiesce 
> deferred actions when returning to userspace.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---

[...]

> Index: linux-2.6/kernel/entry/common.c
> ===================================================================
> --- linux-2.6.orig/kernel/entry/common.c
> +++ linux-2.6/kernel/entry/common.c
> @@ -6,6 +6,7 @@
>  #include <linux/livepatch.h>
>  #include <linux/audit.h>
>  #include <linux/tick.h>
> +#include <linux/task_isolation.h>
>  
>  #include "common.h"
>  
> @@ -287,6 +288,7 @@ static void syscall_exit_to_user_mode_pr
>  static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
>  {
>  	syscall_exit_to_user_mode_prepare(regs);
> +	isolation_exit_to_user_mode_prepare();

Are safe from migration at this stage?

-- 
Nicolás Sáenz

