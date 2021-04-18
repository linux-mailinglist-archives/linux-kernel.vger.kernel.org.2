Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DF03632F5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 03:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhDRBfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 21:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhDRBfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 21:35:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D268BC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 18:35:08 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d23so20673761qko.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 18:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yaFXTcx/Gh4E+HfFQ4jD16wC3q3f0eeM4Aa9EV+gi50=;
        b=RowUFWNA362OQaYBiWLizm0irFYonCk/6pUKjfE4bn/NdWaPPINpz52MK2ykN4oJKE
         gj04DOKeW8PgPCD1dtovSeSGReRb1MwLyPwnKjO3A6Qo95mSzJrmIPvH4UHMGNSnAikj
         KlmdqeiVtk+SdHj5wbk9BTKlCwGLMXO6FSeeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yaFXTcx/Gh4E+HfFQ4jD16wC3q3f0eeM4Aa9EV+gi50=;
        b=JOn8qLDLLF4Ygbxl3accOjH77Cfa5rEILaDTBAmkHJ2LsQI40GBJFBVBb1gy3yRjt8
         U7fd8iWmXjA0If2Om3Mlfk0oRbDQhrJSrIV6jriMlfpf3dR6GPgeCvJetcjVQJQc6GCu
         dAVpAUSGjrB6shnr6OhHFShLqwRRMH2kFU6gerOvFPwNBjzFhteplE1g3gRyOkg6JDfi
         y8z9H/waapfateRj0o9y3vQBKis7mnzkrG/nd7S1RBjnXzdzFJZ/1Qd1KK8pRsUbPsnc
         WbCBHmJdeOyJ46u8m62XiaDg1i7DSfGBOw4Rols2MelOQ+NpFzi7ZfRjUtIM0ivsEy/X
         ZzNg==
X-Gm-Message-State: AOAM531YaYi0sao02WjL9PgncesVd2kRV+dFPGX3MmtoBE2gPLx5K+0T
        /V/ejCN8WheMxBT69BUY0+30Zg==
X-Google-Smtp-Source: ABdhPJz6x8GhyaXzBUnWxAmHwQLbvoS/0jsJHyprKS8n9hEzDCHI+75lL0TNgaxxVIjGS78xKQZvlA==
X-Received: by 2002:ae9:d61c:: with SMTP id r28mr5880647qkk.462.1618709707966;
        Sat, 17 Apr 2021 18:35:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:5970:b016:6052:152])
        by smtp.gmail.com with ESMTPSA id i6sm7104899qkf.96.2021.04.17.18.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 18:35:07 -0700 (PDT)
Date:   Sat, 17 Apr 2021 21:35:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     Hao Luo <haoluo@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YHuMy0o7gRd+kIVN@google.com>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <CAEXW_YSS0ex8xK7t2R7c1jiE4eNbwxdwP2uyGPDK78YAaYQr5A@mail.gmail.com>
 <YGxtLOxCb4LO8kN0@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGxtLOxCb4LO8kN0@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:16:12AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Mon, Apr 05, 2021 at 02:46:09PM -0400, Joel Fernandes wrote:
> > Yeah, its at http://lore.kernel.org/r/20200822030155.GA414063@google.com
> > as mentioned above, let me know if you need any more details about
> > usecase.
> 
> Except for the unspecified reason in usecase 4, I don't see why cgroup is in
> the picture at all. This doesn't really have much to do with hierarchical
> resource distribution. Besides, yes, you can use cgroup for logical
> structuring and identificaiton purposes but in those cases the interactions
> and interface should be with the original subsystem while using cgroup IDs
> or paths as parameters - see tracing and bpf for examples.

Personally for ChromeOS, we need only the per-task interface. Considering
that the second argument of this prctl is a command, I don't see why we
cannot add a new command PR_SCHED_CORE_CGROUP_SHARE to do what Tejun is
saying (in the future).

In order to not block ChromeOS and other "per-task interface" usecases, I
suggest we keep the CGroup interface for a later time (whether that's
through prctl or the CGroups FS way which Tejun dislikes) and move forward
with per-task interface only initially.

Peter, any thoughts on this?

thanks,

- Joel
