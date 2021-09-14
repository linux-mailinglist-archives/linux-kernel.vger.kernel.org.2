Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1117A40B541
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhINQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhINQu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:50:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5095C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:49:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so2673757wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8cZjnBfKQ98RvNo+t8dXEqCfexHSNrNgQFLczr/dzUw=;
        b=ZIQJC39PqdNfy6y886PfF/Xyv2QsZ3DqnoJ0S5ozQT5AMmPORdXwJF0cgGxR1S51r3
         gipsEbV0W+CTKwig18Aid5zMp4RYSRvdqQYmr6PPuQTB/g14jrFlsq00X+H7aoLp4CvG
         NSESuAgGbCn+bU1oZspQ0hEyU8eCwIaHXmNCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8cZjnBfKQ98RvNo+t8dXEqCfexHSNrNgQFLczr/dzUw=;
        b=e3qk5dtGkzqmX8CzkcFFIPm/q/XXW/ILkFn7Qy+FCDFzakMy3JJ0s8IcKj0zYA6m60
         HT1ikNj7JCDsWzm54Pzs/KJxSy34EfJJ/FsjONE5PJ0qNpwbPHLsj6lX0sDjJR6q91jC
         lRd6iaITq6n7GNeqOzm/1KCMt+Y/BUP26DVL1QZ1C+/3Jx38M6Q/FtGkasmCsTkqeAdI
         NOzLUBE7a/4dK4Bu3CyngUa5YxcLIaayANcLwkAa00tb5vOdJBmDX8ueNH7H6Y/VirJx
         nvK235mLPPgFuL72CkSCX8WzlndSf6UOBn2xCqBTWxOIkAE0t1L/EWEP/2WxXWpeycV7
         gNlA==
X-Gm-Message-State: AOAM533YFUVCEhmfvWt9i+27/vvkjKnImeO7qlORf1c3d80up7WUTPis
        pBuoE8cdX1pVzl7wIvzWwPBTgQ==
X-Google-Smtp-Source: ABdhPJzqeHEMXP/9pTdykDN6ru9xN7OB6P1teNNIhylfS1EyHKmQABixQp5Mj6EOHF/9gkP8sXVegg==
X-Received: by 2002:a05:600c:2193:: with SMTP id e19mr54963wme.38.1631638148124;
        Tue, 14 Sep 2021 09:49:08 -0700 (PDT)
Received: from localhost ([194.207.141.245])
        by smtp.gmail.com with ESMTPSA id z79sm310798wmc.17.2021.09.14.09.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:49:07 -0700 (PDT)
Date:   Tue, 14 Sep 2021 17:49:06 +0100
From:   Chris Down <chris@chrisdown.name>
To:     yongw.pur@gmail.com
Cc:     tj@kernel.org, mhocko@suse.com, peterz@infradead.org,
        wang.yong12@zte.com.cn, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn
Subject: Re: [PATCH v2] vmpressure: wake up work only when there is
 registration event
Message-ID: <YUDSgr+iwVz7iFBN@chrisdown.name>
References: <1631635551-8583-1-git-send-email-wang.yong12@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1631635551-8583-1-git-send-email-wang.yong12@zte.com.cn>
User-Agent: Mutt/2.1.2 (9a92dba0) (2021-08-24)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yongw.pur@gmail.com writes:
>From: wangyong <wang.yong12@zte.com.cn>
>
>Use the global variable num_events to record the number of vmpressure
>events registered by the system, and wake up work only when there is
>registration event.
>Usually, the vmpressure event is not registered in the system, this patch
>can avoid waking up work and doing nothing.
>
>Test with 5.14.0-rc5-next-20210813 on x86_64 4G ram.
>Consume cgroup memory until it is about to be reclaimed, then execute
>"perf stat -I 2000 malloc.out" command to trigger memory reclamation
>and get performance results.
>The context-switches is reduced by about 20 times.
>
>unpatched:
>Average of 10 test results
>582.4674048	task-clock(msec)
>19910.8		context-switches
>0		cpu-migrations
>1292.9		page-faults
>414784733.1	cycles
><not supported>	stalled-cycles-frontend
><not supported>	stalled-cycles-backend
>580070698.4	instructions
>125572244.7	branches
>2073541.2	branch-misses
>
>patched
>Average of 10 test results
>973.6174796	task-clock(msec)
>988.6		context-switches
>0		cpu-migrations
>1785.2		page-faults
>772883602.4	cycles
><not supported>	stalled-cycles-frontend
><not supported>	stalled-cycles-backend
>1360280911	instructions
>290519434.9	branches
>3378378.2	branch-misses
>
>Tested-by: Zeal Robot <zealci@zte.com.cn>

That's not how Tested-by works. Tested-by is for human testers who have 
actively understand and have validated the effects of the code, not CI: please 
remove the tag.

>Signed-off-by: wangyong <wang.yong12@zte.com.cn>
>---
>
>Changes since v1:
>-Use static_key type data as global variable
>-Make event registration judgment earlier
>
> mm/vmpressure.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/mm/vmpressure.c b/mm/vmpressure.c
>index 76518e4..6f4e984 100644
>--- a/mm/vmpressure.c
>+++ b/mm/vmpressure.c
>@@ -67,6 +67,11 @@ static const unsigned int vmpressure_level_critical = 95;
>  */
> static const unsigned int vmpressure_level_critical_prio = ilog2(100 / 10);
>
>+/*
>+ * Count the number of vmpressure events registered in the system.
>+ */
>+DEFINE_STATIC_KEY_FALSE(num_events);
>+
> static struct vmpressure *work_to_vmpressure(struct work_struct *work)
> {
> 	return container_of(work, struct vmpressure, work);
>@@ -272,6 +277,9 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
> 		return;
>
> 	if (tree) {
>+		if (!static_branch_unlikely(&num_events))
>+			return;
>+
> 		spin_lock(&vmpr->sr_lock);
> 		scanned = vmpr->tree_scanned += scanned;
> 		vmpr->tree_reclaimed += reclaimed;
>@@ -407,6 +415,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
> 	mutex_lock(&vmpr->events_lock);
> 	list_add(&ev->node, &vmpr->events);
> 	mutex_unlock(&vmpr->events_lock);
>+	static_branch_inc(&num_events);
> 	ret = 0;
> out:
> 	kfree(spec_orig);
>@@ -435,6 +444,7 @@ void vmpressure_unregister_event(struct mem_cgroup *memcg,
> 		if (ev->efd != eventfd)
> 			continue;
> 		list_del(&ev->node);
>+		static_branch_dec(&num_events);
> 		kfree(ev);
> 		break;
> 	}
>-- 
>2.7.4
>
>
