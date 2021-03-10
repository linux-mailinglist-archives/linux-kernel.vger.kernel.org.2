Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC21336819
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 00:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhCJXu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 18:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhCJXuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 18:50:40 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D470C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:50:40 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id w34so11404998pga.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h9ZagqJLxk4OElhdkNGPVroIsWiFpbxbC5YZRvu24ZA=;
        b=gxKLX80uK2NO4R2AUw7XDraRQhplZ/rId2VFrO69upXzWsfYtCyiWN0ENOT0ZYEMB+
         MFvBKQGqalbJbZ4lzAoyecmPr6kgJXTaaptDA7rbElmrAMbx9ctSkQrhgKQGVejI3S5e
         nelCpfb4e8JCUEmHtg/RJtufArT/G7WQa7P9OyRfnh+dtAzWASSP+XSpqC7yTveT9xhK
         J15zO3fi1oYPEqSxSS0LctRiqB7OWTRjtPefpj2aYzQv7mGbiC7YuxdFgh1Sy5RVlwjU
         afr856u2vsDBd/06dgHiuPjpLJV+yZHjNtWcryO9ejf4m2AMtmB3QGcunyLeZZxueny6
         +ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h9ZagqJLxk4OElhdkNGPVroIsWiFpbxbC5YZRvu24ZA=;
        b=MxsZWakcNW5ouhdhwKwczqJfLA2pKgj5RvGA06ooHgRYLIVpKkpzgJE0ZkdJB686VQ
         5cPaRRGRoBXa9/GYd6iEe5NNNrLqgMp88JoHjd7AtgRPKtuCdk1WzHz05PImJuUNNvGu
         P1cfIzRO8Q1q3UaJrIGp0ePqhycS763DBQBMXuDU80gSyKEUAJ2WkH5qG6q5Uy8Bdw5m
         M53F9SMVJ9g89rUqiNCLwMcKV3GD/SPB0F6Wy9tPbcKc+lh9ii/KnaamvKjY6Vv2ABdD
         5Iuoq1UKoMZGg5FIEQdWRq80gPWseduYRTlLPp7fYO1xn0jthl/yttJ4iiE+rGInji59
         8Hpw==
X-Gm-Message-State: AOAM530r3V2A8P18dux9XKyLjjN3/Rx2pEqUgk5UA947toYUBkn2Ndfu
        zWqY1gGnHZflpw2S2oPwgXE=
X-Google-Smtp-Source: ABdhPJzd/+OScYpMEEtLglUJ+pg4TyfFxWjB1JBiNwsQ6WNyIWOFf6f6+UAyNBdKQTQD0O6U9XBsMw==
X-Received: by 2002:aa7:9aaa:0:b029:1f3:dd0e:282d with SMTP id x10-20020aa79aaa0000b02901f3dd0e282dmr5110398pfi.38.1615420239493;
        Wed, 10 Mar 2021 15:50:39 -0800 (PST)
Received: from f8ffc2228008.ant.amazon.com ([54.240.193.129])
        by smtp.gmail.com with ESMTPSA id z4sm527245pgv.73.2021.03.10.15.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 15:50:38 -0800 (PST)
Subject: Re: [PATCH v2 1/2] mm/memcg: rename mem_cgroup_split_huge_fixup to
 split_page_memcg
To:     Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-2-zhouguanghui1@huawei.com>
 <3ad50842-881f-eb88-a14d-0b6c70ce33d2@gmail.com>
 <YEcxqTUp88sl/cq3@dhcp22.suse.cz>
 <d20d5dbe-74cd-fe90-8e43-ebbc5a3b4403@gmail.com>
 <alpine.LSU.2.11.2103101353240.1783@eggly.anvils>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <f276a028-e2d2-f098-fdf9-6ee505f32e33@gmail.com>
Date:   Thu, 11 Mar 2021 10:50:31 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2103101353240.1783@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 9:00 am, Hugh Dickins wrote:
> On Thu, 11 Mar 2021, Singh, Balbir wrote:
>> On 9/3/21 7:28 pm, Michal Hocko wrote:
>>> On Tue 09-03-21 09:37:29, Balbir Singh wrote:
>>>> On 4/3/21 6:40 pm, Zhou Guanghui wrote:
>>> [...]
>>>>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>>  /*
>>>>> - * Because page_memcg(head) is not set on compound tails, set it now.
>>>>> + * Because page_memcg(head) is not set on tails, set it now.
>>>>>   */
>>>>> -void mem_cgroup_split_huge_fixup(struct page *head)
>>>>> +void split_page_memcg(struct page *head, unsigned int nr)
>>>>>  {
>>>>
>>>> Do we need input validation on nr? Can nr be aribtrary or can we enforce
>>>>
>>>> VM_BUG_ON(!is_power_of_2(nr));
>>>
>>> In practice this will be power of 2 but why should we bother to sanitze
>>> that? 
>>>
>>
>> Just when DEBUG_VM is enabled to ensure the contract is valid, given that
>> nr is now variable, we could end up with subtle bugs unless we can audit
>> all callers. Even the power of 2 check does not catch the fact that nr
>> is indeed what we expect, but it still checks a large range of invalid
>> inputs.
> 
> I think you imagine this is something it's not.
> 
> "all callers" are __split_huge_page() and split_page() (maybe Matthew
> will have a third caller, maybe not).  It is not something drivers will
> be calling directly themselves, and it won't ever get EXPORTed to them.
> 

Don't feel strongly about it if that is the case.

Thanks,
Balbir Singh

