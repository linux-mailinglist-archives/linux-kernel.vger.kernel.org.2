Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2D40B484
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhINQYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhINQYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:24:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C84C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:23:35 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s11so13212757pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M1OLud5L7SR/XzmtK9MomZhlAfhb/UzSPLkSu/CN0Ls=;
        b=B8NXLPlEGILsGJ/1BwUEO69eIWz2uwusaVZqj+8n7lxKrMWY1UtJ/zDlMWoJWgJ/00
         qrIh2FpA72W3aJ6LOFl2Ehz5+ob/gv9jkQGgdZIWR2aSCP29UeIGtgMVP5jOVHvjUbkN
         aRkH2aGdxhZQvKGUL0H4gelX3vrBCk+gBm6HKCU8x5DDf+SSw6wIosj4Cu+VBh5mpRRr
         DvBlaX45P+OoBCtk2BUDQdhOsVdRswJ4SdgtcHH5gZ6WAoa7qusF5q2POcMBfZwNLXEd
         hQbPG62Uh7phRRhj767kXZz36U5jGisbeguNV0y2HL9ZYIF1JJpN49RYVC+pxrnRFkvv
         J3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=M1OLud5L7SR/XzmtK9MomZhlAfhb/UzSPLkSu/CN0Ls=;
        b=a41wtB8LltG+jyO+Vsa4kqD0AI2N0GCtr53ebPJeBzh0ZFuOXS4eLdwsPa/+kX2UBj
         uayhfs0CADYDcnQuztCL73rt7PlLBULMNri3TMXSdfhqnhgyZPnc8ka/jL7sOzpKIaao
         tLUKt9oPwErMtcPSqueHWy2yvDKPh+wHjANsq4Amw13LYH2XEpsyOPF71UgMbLwtV37/
         mJXuj3xDOYiduPywT8RCSc9iExvFxar5M4PJDTZljPxdQW1mbLHMtzZGETiqkt/YOkoV
         bCzqREDQvMmSVWJmIL2M9uY5DZucMuFaIUwMGpQncAIReQzJbYXpMtZyc/v/yNjgNHGB
         MKQg==
X-Gm-Message-State: AOAM5309PrG2Bgkcuj5SqfqWZWaazm3MKu0OrJ3q5T5rlUYVNkdMYmxC
        JSEMTLQhdEt3118vSJAiZ54=
X-Google-Smtp-Source: ABdhPJyR0pGdaF0XZzqirIt9uv2sXm7H8yc7mJ1F7Hy/d8nBrV9HEb9tCIOPXs06jYFigX2Fv+8YMg==
X-Received: by 2002:a05:6a00:8c2:b0:438:7f68:2438 with SMTP id s2-20020a056a0008c200b004387f682438mr5730980pfu.33.1631636614285;
        Tue, 14 Sep 2021 09:23:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e5sm2138355pjv.44.2021.09.14.09.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:23:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Sep 2021 06:23:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: [PATCH v2] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
Message-ID: <YUDMhMgM4ZECVBo8@slm.duckdns.org>
References: <20210911075054.6358-1-zhangqiao22@huawei.com>
 <YT+R3EnFgs78Vyvh@slm.duckdns.org>
 <b30205b0-bf54-7255-fc1c-9dfa5dbb4940@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30205b0-bf54-7255-fc1c-9dfa5dbb4940@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:20:02PM +0800, Zhang Qiao wrote:
> Perhaps we can fix this bug at sched_post_fork(), which is executed between cgroup_can_fork()
> and cgroup_post_fork(). Relocate the fectching of task_group and access it at sched_post_fork().

Can't we just add a can_fork callback in cpu_cgrp_subsys?

-- 
tejun
