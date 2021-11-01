Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30580441A97
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhKALVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:21:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42594 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKALVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:21:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 23FF11FD6F;
        Mon,  1 Nov 2021 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635765524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dm5Oe23ThzgNkO1zplniJYhEpCsmQbBHu8pHbwLx7r0=;
        b=wRCFCO0ESWvL26fIKwv0yTTob6KsxYryw12Ikk1rDDpbwjHw9vhp0yE9mxkSlcrrn4l5hu
        3+kOva4y++u9PcJQolFBHkWfR2q6m0QcWpi9nvX8dCAjrB0tYLdLj0tC9Srwh18sUTD7+U
        j1axe0gZ1pXw/J7SlL+ADIwrfEOGfa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635765524;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dm5Oe23ThzgNkO1zplniJYhEpCsmQbBHu8pHbwLx7r0=;
        b=YBvsOH45hHybu2kPEKcMlp5GoZ5JfK+CLxUfbl/IvZVZmeHjQSl1+XiNl0JIr0WDFts1Oe
        miKLa539XzVdazDw==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8BA87A3B83;
        Mon,  1 Nov 2021 11:18:42 +0000 (UTC)
Date:   Mon, 1 Nov 2021 11:18:40 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Simplify task_numa_find_cpu()
Message-ID: <20211101111840.GT3891@suse.de>
References: <1635578759-32343-1-git-send-email-yuanzhaoxiong@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1635578759-32343-1-git-send-email-yuanzhaoxiong@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 03:25:59PM +0800, Yuan ZhaoXiong wrote:
> Combine the 'cpumask_of_node()' with 'env->p->cpus_ptr' and drop the
> cpumask_test_cpu().
> 
> Signed-off-by: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>

This potentially creates of a temporary cpumask variable as noted in the
comment for for_each_cpu_and.

 * This saves a temporary CPU mask in many places.  It is equivalent to:
 *      struct cpumask tmp;
 *      cpumask_and(&tmp, &mask1, &mask2);
 *      for_each_cpu(cpu, &tmp)
 *              ...

task_numa_find_cpu() is a relatively deep function. Did you check
the stack usage to make sure it's not pushing too close to the stack
boundary? While there are other users of for_each_cpu_and, they are mostly
shallow although find_energy_efficient_cpu() is a bit questionable and
probably should have used select_idle_mask.

Does the patch have a noticable performance impact? 

-- 
Mel Gorman
SUSE Labs
