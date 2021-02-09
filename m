Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2F53145CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBIBub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhBIBuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:50:20 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD2C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:49:40 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q72so668337pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8sv6X8syVHw1MIFVnsFs4iqBtg0ahotEAO2Dby5NCpU=;
        b=iYuo4Ld9rJKpnWlst5Klip3cA0uIYA463UoQfUlm/ElZXIEuJ9xOYyWIQPmO05T52D
         lsdTx4V2qLKSR6bZWN1CqWototlMMdjJ7LRHfAg45/+FgGaCKErnR6JUzNOTe7K5GlY8
         oWCx4rAEEpbyUCqcc+dOclWiENK6Fjg4dxZ0rXZY9Tbipsy4umONf/gn0LSrRR3gSh2c
         8S1k1JrOc4bGdIhSFHduHa0rGtFeNA0LPy+Mmqu6DGzoCKrdGDmy7ZzIdhSr9VK4y9o7
         p1pbEp3aovV2Kq+OF58bEq1L5V/DeZPzQg06pGN5fcf3Rgspbow0oH6i3QfOp0AgRPwJ
         EXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8sv6X8syVHw1MIFVnsFs4iqBtg0ahotEAO2Dby5NCpU=;
        b=H4a3JRfsLx2I0GwE94yU/Shb2U8beEDA2Ec09HiBn7K+xylGSjlJCG2XtUmSYQkmKV
         7RNDmoz098rIVOQ/io/5auw/UtSE+bdYZFIOgDSaHVMVl7kS7MYwjbazlY1frv6ycOMh
         685r8bfuMk+QkdQDcU3hy9zg061v1oZTR5oxGXsOWmrNXFIGJnV5gy+R30jYcRbtHOYJ
         uAhft31b2Vn0dTn5RtYPMiVXyC6o4Fwir+MT4WWhyMm83ft9nV2GjsNx/NSs9wndpbVB
         JAyDWO50qY1P2M2SiUJe4qtxQGMSyGpSfLB1SyXbw5J5yBW3o8UH2oHzTcM/z2kiuIDy
         XeLw==
X-Gm-Message-State: AOAM530qki/3rBet90JcSJ37qvCF5LFjgRb4x554bwJ7t6NZiG92pURX
        gJVGkWzwywo9K16YZEKKGj8vGg==
X-Google-Smtp-Source: ABdhPJzZWidT5PIEFpUI7hEhLGLVBjo5gbdYu1UlNuQmIRIftrCd/yOqL2Ex2XHz8iGxZg85N4LdFQ==
X-Received: by 2002:a17:90a:c789:: with SMTP id gn9mr1662640pjb.101.1612835380312;
        Mon, 08 Feb 2021 17:49:40 -0800 (PST)
Received: from [10.255.96.22] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id y2sm488470pjw.36.2021.02.08.17.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 17:49:39 -0800 (PST)
Subject: Re: [External] Re: [PATCH] psi: Add PSI_CPU_FULL state
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
References: <20210207072402.67532-1-zhouchengming@bytedance.com>
 <YCGAYEiyTKCO71E3@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <2cb984f3-fb8b-df26-31a2-8a091213d87e@bytedance.com>
Date:   Tue, 9 Feb 2021 09:49:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCGAYEiyTKCO71E3@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/2/9 上午2:18, Johannes Weiner 写道:

> On Sun, Feb 07, 2021 at 03:24:02PM +0800, Chengming Zhou wrote:
>> The FULL state doesn't exist for the CPU resource at the system level,
>> but exist at the cgroup level, means all non-idle tasks in a cgroup are
>> delayed on the CPU resource which used by others outside of the cgroup.
>>
>> Co-developed-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> That metric's come up in our production environment recently as well,
> it makes a lot of sense.
>
> In addition to outside competition, this also applies to downtimes
> enforced by cpu.max - another cgroup usecase that is worth mentioning
> in the changelog & code comment.

Thank you, I will add this and send patch-v2.

> Thanks
