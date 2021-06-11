Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441163A42B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhFKNLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:11:19 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:33583 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKNLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:11:18 -0400
Received: by mail-wm1-f52.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so6360387wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qpcVHfrrJXTIjek0yFmE1DcJmD0OGjQlIdx+1iBJ6ZE=;
        b=S/c9rk59JiJ4O1yjGr/ylxCD+C/UkgUiGLihgVnDLw0a/zdK7vyqNvnHhMZqibqtSb
         0BRx148RBeqCbmeIEdaeLMXqQV29R+BWWFeU2mGXQqjvMGUfUgTOm3GSncR7hbfKRvIP
         UUF3Pqn7sLKtU1HPn+E67cVeyWM6TsC+DcyKTi7/PxlnmuwNLdXRMgS0L6S/wneMFWqC
         GWHQJ3/f14sQ3NWp+g1PKjEZXQpYq3jqZHIVS2hWj7CR/m0t/GyAwxeIFb0nfCCqo7Tm
         hpapMqgoA50MH5VGSepZe9gFf04TXycW9Faqh0l5bFvHFh+oyG0YdOiSSNGmmD+bJMd7
         n5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qpcVHfrrJXTIjek0yFmE1DcJmD0OGjQlIdx+1iBJ6ZE=;
        b=RM7I8dBwAQzeyPqUXqFgThcyqoLQeVDrkpIdSju/OBer212smI36fQnB6JsJN57SB/
         d8WvN31V4n3z2EfbbXxeqzN0XvdLoA4OtgHK0PHTSKy05PwzDQZMqPBYbHI4aQNpXWTh
         vZZn11SS8k+Wwn6SWgMQeCHzk6nwHCzIejNiQU0/rdRO0HU8fOzAgucrvF29AG+EjJII
         Wmtwab4MXNDsKd4hp4vAEUQiNEsqclCtP5r+qRQPcENWufN57hxDtjJF/V17mLDwR3hV
         DvWo4fdnasJ3OxuCMo2kg8JVmANq4AXHe/zyamL1Yrw+u9Sb1sIPlvrGpYXwUJdlSIvd
         eCmw==
X-Gm-Message-State: AOAM533Zc3tNTvsdV3t2j1c6nTS8xJ7Fh5WW4hpiOShP1unQREuEL1Mo
        to2NEYQ6mo/xu100PKBfGsAZBQ==
X-Google-Smtp-Source: ABdhPJyCUKbcRGkXsDFvNTEuYN5ncuXTZaURb/3ITmjk1psqidwzACdxYViWyZfPbOt1itsNC/Xv9A==
X-Received: by 2002:a1c:6209:: with SMTP id w9mr3883976wmb.27.1623416899434;
        Fri, 11 Jun 2021 06:08:19 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id a10sm5241039wrr.48.2021.06.11.06.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 06:08:18 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:08:15 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 3/3] sched: Make uclamp changes depend on CAP_SYS_NICE
Message-ID: <YMNgPyfiIaIIsjqq@google.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-4-qperret@google.com>
 <20210611124820.ksydlg4ncw2xowd3@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611124820.ksydlg4ncw2xowd3@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Friday 11 Jun 2021 at 13:48:20 (+0100), Qais Yousef wrote:
> On 06/10/21 15:13, Quentin Perret wrote:
> > There is currently nothing preventing tasks from changing their per-task
> > clamp values in anyway that they like. The rationale is probably that
> > system administrators are still able to limit those clamps thanks to the
> > cgroup interface. However, this causes pain in a system where both
> > per-task and per-cgroup clamp values are expected to be under the
> > control of core system components (as is the case for Android).
> > 
> > To fix this, let's require CAP_SYS_NICE to increase per-task clamp
> > values. This allows unprivileged tasks to lower their requests, but not
> > increase them, which is consistent with the existing behaviour for nice
> > values.
> 
> Hmmm. I'm not in favour of this.
> 
> So uclamp is a performance and power management mechanism, it has no impact on
> fairness AFAICT, so it being a privileged operation doesn't make sense.
> 
> We had a thought about this in the past and we didn't think there's any harm if
> a task (app) wants to self manage. Yes a task could ask to run at max
> performance and waste power, but anyone can generate a busy loop and waste
> power too.
> 
> Now that doesn't mean your use case is not valid. I agree if there's a system
> wide framework that wants to explicitly manage performance and power of tasks
> via uclamp, then we can end up with 2 layers of controls overriding each
> others.

Right, that's the main issue. Also, the reality is that most of time the
'right' clamps are platform-dependent, so most userspace apps are simply
not equipped to decide what their own clamps should be.

> Would it make more sense to have a procfs/sysfs flag that is disabled by
> default that allows sys-admin to enforce a privileged uclamp access?
> 
> Something like
> 
> 	/proc/sys/kernel/sched_uclamp_privileged

Hmm, dunno, I'm not aware of anything else having a behaviour like that,
so that feels a bit odd.

> I think both usage scenarios are valid and giving sys-admins the power to
> enforce a behavior makes more sense for me.

Yes, I wouldn't mind something like that in general. I originally wanted
to suggest introducing a dedicated capability for uclamp, but that felt
a bit overkill. Now if others think this should be the way to go I'm
happy to go implement it.

Thanks,
Quentin
