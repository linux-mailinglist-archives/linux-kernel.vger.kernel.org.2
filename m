Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED1409BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346106AbhIMSCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345955AbhIMSCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:02:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0004BC061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:01:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f21so4130325plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rQ0g6XucybidUQ32/zOjQbHjv/JiyzGbAkIREo++RIA=;
        b=kRhVWV7Y8vznKIlC6QEoW/HdLY+lVkKAFP4div/K+WTBqlIl5xjTyYfDQVGL7F7VKv
         9eWpX8e8rel3vBVCADsnzHsqlDfqICyvzm/OxhIERfxo9vCgKjbq5h72SFdhOTL2k8BS
         nNTJjDjEXE7hlWI3JcpKW5WjTNwcMCjr8i9uPQBq5Bs2qZsGT8ZWu+dYne/Uzdwqmb5N
         HWGxr3LMifEKPQX/KZiXGK1reU9t1twBld2Z9qUfaLBDRHjKErbjy30f7OV83kH80dfA
         2Otmw8uX0ug3WIGbU/oKo8cxQDAsGlbRPBIN1mV3kJzMlRajUY06Ms9LE1BQSB6Slu1m
         qeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rQ0g6XucybidUQ32/zOjQbHjv/JiyzGbAkIREo++RIA=;
        b=1vFQvr6vU7hPnK4plTLGD4ZGSeGJsl3dHwfvLCxNz03YZSIvp5ysUKa5l9rQT7/Te0
         j/P23Qoa6hW/1zCyBVu3nWnl6J5HGFl4U2gyDN3Y9llKZahzMalZWL7nTXHCyonmPCNy
         KALk2G5g857eh/Ncb9cHOmWFztN10FuVxVBiVr0CSBY1crwjI5Zbql2FhdNwvhEc757g
         BLQXGdprMQPc8eocbpg9Eu7ziotXQqDXWNr4HniAz/arBMiAQoZ7Zomn0P4VkIzPEzf5
         +ARstHXmVD97OIhl8Nm6xgG6CUN9vvXg2XaO+5k5k43UpKa4dwueoFAUNNzWm2PAXd43
         iKmw==
X-Gm-Message-State: AOAM532+xdds5LMl3Gu5iTHKf9ulPj4rlqaDEi+Q9JBIpJKRDzdvc0AI
        Ge4WowGpuleTrV6IK4Rhg5I=
X-Google-Smtp-Source: ABdhPJxYakF3Jd+j4zlidTOHP1ciG7+3ECSNFP7wQqgCNVqX1VgE5/0582YlrCbMUlhKxB0Xzb8dsw==
X-Received: by 2002:a17:90a:2e82:: with SMTP id r2mr748614pjd.151.1631556062441;
        Mon, 13 Sep 2021 11:01:02 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ch19sm7816708pjb.33.2021.09.13.11.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:01:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 08:01:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: [PATCH v2] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
Message-ID: <YT+R3EnFgs78Vyvh@slm.duckdns.org>
References: <20210911075054.6358-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911075054.6358-1-zhangqiao22@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Sep 11, 2021 at 03:50:54PM +0800, Zhang Qiao wrote:
> Between cgroup_can_fork() and cgroup_post_fork(), the cgroup
> membership is fixed and thus sched_task_group can't change. So
> call sched_fork() after cgroup_can_fork() and update the child's
> sched_task_group before it is used.

The part being fixed looks correct to me but it's difficult to for me to
assess whether the whole relocation of the sched_fork() hook doesn't change
anything else. Besides, even if we decide to relocate the sched_fork hook, I
think it'd be better to separate the two changes - one is a relatively safe
bug fix, the other is a code reorganization with possibly subtle side
effects. So, I think it'd be better to produce a patch which just fixes the
bug even if that ends up introducing another function in the flow.

Thanks.

-- 
tejun
