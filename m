Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E4337348A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 07:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhEEFHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 01:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhEEFHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 01:07:11 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341A5C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 22:06:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m124so941440pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7gpK7P2CpPVVCbVLUyVVTrI01QfMpCG4qxYH2m0q/WY=;
        b=hRMfiR1c8aF8nkaibSuLvPsQ8VyCx/qSncGkzxu18vorhQYjFwpROhAEbXYMCNfquk
         R79aCKblQiB16JvI81QOiFG7hoE+vwWFzuhbV1jcmU/QB6LmQwc8IoHRHHgrHKr1AooE
         osQlLpZYwvRJRTQEWQKzZE0vUJAkPSCwibEEASukSg4xW9ERGzKZ40/yoQH+95owSb6v
         iLEPDrI5blgVJviaQyBNxrHi4u/g5MffBYnIDhQOKoi0ygD8CMEeF9UCIMm87nzMRxHJ
         P8UUlfcrr05jevKCiccoYy4X4FyQ6RYZzLzqVTr8I8qEmKxi4cqZReJU1TEVcBJWusH4
         /VZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7gpK7P2CpPVVCbVLUyVVTrI01QfMpCG4qxYH2m0q/WY=;
        b=StrDnEl/vBZXXXrn1Qi1paUnJ24FeV5vABsj58yZIg5g55R//bIuEL66/ZxxdsALSQ
         zTHFLRfEBSZe6ylCUzipg7i+t0QVtypjuebq5dVOIAKJS3azMSHdG8SPOeM2KcCi0fKO
         wqvfCprWUQBJfcVT+Leswxvg9k6KV3rWO+v3uCvAlFSNJbzMUOFAsD0WMrBX1F1HUaRe
         XCEqnS3IWdQ3gWIrvcCNLwsWbNZeJiClLGCKlNYrKlHc61pjD25hP4r7l1vwA358TOCB
         FH8atbqDDOObKNmiNxTY97cKeLell1AXEDFAbRn7Lkizgj5d3r4gPluH00cpUdxkvoLA
         UypA==
X-Gm-Message-State: AOAM530B/thbHLoycgmW+kSE58Kc1+4nRLP2HdDLFMVxBrClcJWm19Vb
        7A4D3zXZNBK6dDOwG8ulfU3sCV4IkauVJw==
X-Google-Smtp-Source: ABdhPJz9VCC3PefBm33FrYikAk5yJSpijtIJiHa1jMrpQcN0eALeOoj+FqzHKiLwil2NOY6iXfaG3A==
X-Received: by 2002:a62:ed0b:0:b029:25c:9ea2:abea with SMTP id u11-20020a62ed0b0000b029025c9ea2abeamr27332089pfh.46.1620191174556;
        Tue, 04 May 2021 22:06:14 -0700 (PDT)
Received: from [10.254.93.79] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id k10sm13420308pff.140.2021.05.04.22.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 22:06:14 -0700 (PDT)
Subject: Re: [Phishing Risk] [External] Re: [PATCH 2/3] cgroup/cpuset:
 introduce cpuset.mems.migration
To:     Tejun Heo <tj@kernel.org>, hannes@cmpxchg.org
Cc:     akpm@linux-foundation.org, lizefan.x@bytedance.com, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210426065946.40491-1-wuyun.abel@bytedance.com>
 <20210426065946.40491-3-wuyun.abel@bytedance.com>
 <YIgjE6CgU4nDsJiR@slm.duckdns.org>
From:   Abel Wu <wuyun.abel@bytedance.com>
Message-ID: <55582805-5103-96c0-d8e8-e6d0b01beff3@bytedance.com>
Date:   Wed, 5 May 2021 13:06:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIgjE6CgU4nDsJiR@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping :)

On 4/27/21 10:43 PM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Apr 26, 2021 at 02:59:45PM +0800, Abel Wu wrote:
>> When a NUMA node is assigned to numa-service, the workload
>> on that node needs to be moved away fast and complete. The
>> main aspects we cared about on the eviction are as follows:
>>
>> a) it should complete soon enough so that numa-services
>>     won’t wait too long to hurt user experience
>> b) the workloads to be evicted could have massive usage on
>>     memory, and migrating such amount of memory may lead to
>>     a sudden severe performance drop lasting tens of seconds
>>     that some certain workloads may not afford
>> c) the impact of the eviction should be limited within the
>>     source and destination nodes
>> d) cgroup interface is preferred
>>
>> So we come to a thought that:
>>
>> 1) fire up numa-services without waiting for memory migration
>> 2) memory migration can be done asynchronously by using spare
>>     memory bandwidth
>>
>> AutoNUMA seems to be a solution, but its scope is global which
>> violates c&d. And cpuset.memory_migrate performs in a synchronous
> 
> I don't think d) in itself is a valid requirement. How does it violate c)?
> 
>> fashion which breaks a&b. So a mixture of them, the new cgroup2
>> interface cpuset.mems.migration, is introduced.
>>
>> The new cpuset.mems.migration supports three modes:
>>
>>   - "none" mode, meaning migration disabled
>>   - "sync" mode, which is exactly the same as the cgroup v1
>>     interface cpuset.memory_migrate
>>   - "lazy" mode, when walking through all the pages, unlike
>>     cpuset.memory_migrate, it only sets pages to protnone,
>>     and numa faults triggered by later touch will handle the
>>     movement.
> 
> cpuset is already involved in NUMA allocation but it always felt like
> something bolted on - it's weird to have cpu to NUMA node settings at global
> level and then to have possibly conflicting direct NUMA configuration via
> cpuset. My preference would be putting as much configuration as possible on
> the mm / autonuma side and let cpuset's node confinements further restrict
> their operations rather than cpuset having its own set of policy
> configurations.
> 
> Johannes, what are your thoughts?
> 
> Thanks.
> 
