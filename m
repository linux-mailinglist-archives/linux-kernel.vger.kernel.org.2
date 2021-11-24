Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7A45B11B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 02:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhKXBYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 20:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKXBYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 20:24:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01187C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 17:21:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so3614567pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 17:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=YWhfXghFABBf6LlzYG/IR3Fhic7MRtqIGQdOLTKrXVE=;
        b=iPL6f1ta8Zk4Rgns3gYDGX2HCPBucC+HsKJ9sBfiB6xRYXuBeNg7O17b0abuLiQ3K/
         By8hpZZIBi20BIf2uHf50yii/tgdmeoJQLVydkJH9igBZ5UAT3dbXb83WwuVMwddK0VU
         M+yAvp8SWVHyVseHHU6rL9nFuGL9qa/iecpI5sJCA3kVz8cebhmkyCmvAHsvij98D642
         H4Isl3WAxl4GEZamLp55c4EhpwK7WM3HwSvSy7XTKF6kdT8xAYyKmvoNtSiMbIp0gg8/
         EpIbxekSGivUdkBLuAkVLn8lWAdfz6nibrTfRcZC8tx2uutjd9eQDHS8zhndI/OV1z3A
         8+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=YWhfXghFABBf6LlzYG/IR3Fhic7MRtqIGQdOLTKrXVE=;
        b=ZG8rMnkPSMWBkKIyQ6ouNKUACt8Lid8iJYeY1Vf6V3Grj52U2o0eznn5ZE0XKOSa2K
         6al1glmpS7OAZ/MfZ//y36reVDwcZ1x52wlLezhI3rpZv9sZ4l/AS5iCRPgXkuvR0E2L
         mZr7gO08fNg5iREeu7J8R+wcuTRPhRT/xEmYlmlhl0OLkYvRszl2nDdVjb4EiYHr+u1f
         u470crPtGFoQ/4DgS4Zxl21jgwBm8ZLtSp9ckdcY0xH4ERW3pNalE+kpre2mEnFVcKGE
         UobIXYuDnd+0FREJSoAkkQtfKIcdFlkrEpaX+dt21q69oMS0IR4xRcwy4WtheVXa4/P6
         x4RA==
X-Gm-Message-State: AOAM533e4Mx3Q5e/9uEQQSlJ4FQxV9+8ekaFsexN8h+xh+UsZVDeWf1A
        O0F08XkBwaxvquH1e2FX8GE=
X-Google-Smtp-Source: ABdhPJy/J/RK9A40Yb7QBrfJ9alSUNT/XI6lqXUx5Jkgigh4rEfY2mk36NRctgnOp08zkW1MXKt3IA==
X-Received: by 2002:a17:90b:388f:: with SMTP id mu15mr9487208pjb.30.1637716870561;
        Tue, 23 Nov 2021 17:21:10 -0800 (PST)
Received: from localhost.localdomain ([43.128.78.144])
        by smtp.gmail.com with ESMTPSA id oj11sm2596074pjb.46.2021.11.23.17.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 17:21:10 -0800 (PST)
Date:   Wed, 24 Nov 2021 09:21:03 +0800
From:   Aili Yao <yaoaili126@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        yaoaili@kingsoft.com
Subject: Re: [PATCH] sched/isolation: delete redundant
 housekeeping_overridden check
Message-ID: <20211124092103.64e93376@gmail.com>
In-Reply-To: <20211123123852.11a84a9e@gandalf.local.home>
References: <20211123154535.48be4399@gmail.com>
        <20211123123852.11a84a9e@gandalf.local.home>
Organization: ksyun
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 12:38:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 23 Nov 2021 15:45:35 +0800
> Aili Yao <yaoaili126@gmail.com> wrote:
> 
> > From: Aili Yao <yaoaili@kingsoft.com>
> > 
> > housekeeping_test_cpu is only called by housekeeping_cpu(),
> > and in housekeeping_cpu(), there is already one same check;
> > 
> > So delete the redundant check.
> > 
> > Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> > ---
> >  kernel/sched/isolation.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 7f06eaf..5c4d533 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -56,9 +56,8 @@ void housekeeping_affine(struct task_struct *t, enum
> > hk_flags flags) 
> >  bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
> >  {
> > -	if (static_branch_unlikely(&housekeeping_overridden))
> > -		if (housekeeping_flags & flags)
> > -			return cpumask_test_cpu(cpu,
> > housekeeping_mask);  
> 
> Not only is your email client broken, you don't seem to understand what
> static_branch_unlikely() is.

Yes, My mail client is not properly configured, sorry for that, I will make it work.

And Yes again, I have limited knowledge about static key, But still don't understand why we
need two same check(jump or nop instruction?) here, could you be kindly to explain this?

A lot Thanks!
Aili Yao
