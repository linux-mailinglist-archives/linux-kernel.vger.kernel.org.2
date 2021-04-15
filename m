Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1425360DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhDOPEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:04:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43410 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233968AbhDOO4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:56:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618498560; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=FFS6EKj/DWquOwjPpszmYv2XYXjqrSmpSWLrx/ZGvbE=; b=Sga/2GUowc3M+Ek/yy/k/FARd34ODjhnFJd15OUUbU0CDGWXSMqZldlL8AQuyzFcJsX3Nkof
 XD4x6N22enj9wejn5zAFD+gExcqd8A6n7QKcc5iZw0euvTBEHV1bRjpQ7dH5jZpbSUqukVLG
 9NHGsHl0z/hKYuOCBtihtNCpOA8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 607853ed8166b7eff7484a62 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Apr 2021 14:55:41
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C022C43468; Thu, 15 Apr 2021 14:55:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.156.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D93F2C43464;
        Thu, 15 Apr 2021 14:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D93F2C43464
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] sched,psi: fix the 'int' underflow for psi
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
References: <1618496981-6148-1-git-send-email-charante@codeaurora.org>
 <YHhQ7tDZWF6tHXSQ@cmpxchg.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <b0a0b8f5-a5bc-4807-f55b-288db57c74e2@codeaurora.org>
Date:   Thu, 15 Apr 2021 20:25:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHhQ7tDZWF6tHXSQ@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Johannes!!

On 4/15/2021 8:12 PM, Johannes Weiner wrote:
> Makes sense, it's more graceful in the event of a bug.
> 
> But what motivates this change? Is it something you hit recently with
> an upstream kernel and we should investigate?

We specifically didn't hit the issue around this change. Identified this
while doing code walk through.

> 
> There is already a branch on the tasks to signal the bug. How about:
> 
> 		if (groupc->tasksk[t]) {
> 			groupc->tasks[t]--;
> 		} else if (!psi_bug) {
> 			printk_deferred(...
> 			psi_bug = 1;
> 		}

Looks cleaner. Will raise V2 with this.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
