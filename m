Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E813F8DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbhHZSOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243304AbhHZSO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:14:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B525C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:13:41 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y18so4942261ioc.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W7xOOm2Ro906d9sGCBLmweLCblYJd7cBl1kLaJZIoGk=;
        b=RIVXgLY1Y+1EuOYpTWygSKEwamCnhnh6IFfwdpnYNcZqgOPsgVxEqmvm12kp74g0RD
         3frK7W63lxN+b3/0rtjbkf7C0KOtIP0vOPgWi4eMlc73IDIZQqldkdbIqp1CfSTOQv0U
         BBckPEJUHH0aV8ieUZeEWiLhS5gLvhT9fRqYlV9P3Y9CD7ul9NDhwhC5uEmB6ZBET6iX
         LIp77LBqyDjVZXqrZq1H1g5sDn+36vkR37Nn8m3G1LPK9AdLys2uwlZNxUhOwYnAczvb
         zfVkIP1yvecHp08d6r9V9ypz+FuxK0yRN0pMvqXm5ii7UeI3hMPky+CtloLRmZR8nRUY
         MFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W7xOOm2Ro906d9sGCBLmweLCblYJd7cBl1kLaJZIoGk=;
        b=tMUmNtrB6Sz+/XbyTT3ORXsv3C5Rqajfq4j2Pbwvs7cTTkz4Wp8FLv3jH3W174TTqz
         nCGTuo/mhMWCShyW7I/dnkiQvkdFE5aqRv7exFmbmPMbAJ940pAJApmL1816IpuSi7F7
         doRnSCDLXEyuxFN52jXVMvm8hMfUQ5lKrPO2vVc2rZg/GS5IzeZu133UeGH0k367Xjxe
         +BMTEamqFGUEljcEOtcOoV4ohx5/BEWPIyqNEK5JfSr7xvaXlmx2GZdCrggdOk/D0VM5
         kYOAjkYttm9OoSbHY7eNAxZEMMoIfJEO0n9RawnkinQ+y2LBvedvpwZIaVglDmYg+20V
         ahjw==
X-Gm-Message-State: AOAM532Lihqmpg/+scgukqoihreNZ5bQivmizLwS5DIjGqU//YYo9+zp
        /QDA/b4h+B/VXCC73Ib2bOH91A==
X-Google-Smtp-Source: ABdhPJwk1MPLi2Gc7nfL+qanSwYrPj9KSu2cdstNgoqeWLHK1eAD0E9Gj6UqTwargm5DZSMDh9n6WQ==
X-Received: by 2002:a05:6638:3898:: with SMTP id b24mr4640041jav.126.1630001620960;
        Thu, 26 Aug 2021 11:13:40 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k6sm2120724ilu.41.2021.08.26.11.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:13:40 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Bart Van Assche <bvanassche@acm.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
Date:   Thu, 26 Aug 2021 12:13:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 12:09 PM, Bart Van Assche wrote:
> On 8/26/21 7:40 AM, Zhen Lei wrote:
>> lock protection needs to be added only in dd_finish_request(), which
>> is unlikely to cause significant performance side effects.
> 
> Not sure the above is correct. Every new atomic instruction has a
> measurable performance overhead. But I guess in this case that
> overhead is smaller than the time needed to sum 128 per-CPU variables.

perpcu counters only really work, if the summing is not in a hot path,
or if the summing is just some "not zero" thing instead of a full sum.
They just don't scale at all for even moderately sized systems.

>> Tested on my 128-core board with two ssd disks.
>> fio bs=4k rw=read iodepth=128 cpus_allowed=0-95 <others>
>> Before:
>> [183K/0/0 iops]
>> [172K/0/0 iops]
>>
>> After:
>> [258K/0/0 iops]
>> [258K/0/0 iops]
> 
> Nice work!
> 
>> Fixes: fb926032b320 ("block/mq-deadline: Prioritize high-priority requests")
> 
> Shouldn't the Fixes: tag be used only for patches that modify
> functionality? I'm not sure it is appropriate to use this tag for
> performance improvements.

For a regression this big, I think it's the right thing. Anyone that may
backport the original commit definitely should also get the followup
fix. This isn't just a performance improvement, it's fixing a big
performance regression.

-- 
Jens Axboe

