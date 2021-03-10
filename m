Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291DB334A02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhCJVo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhCJVob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:44:31 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFB1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:44:31 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t37so1478660pga.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F1rP/HK0MUpthdudkFLSzT5JtnfPSdIqufAWiqCyWfE=;
        b=WX3V1AKQraPws2f/CLbZSrzfKO5shyl+APrsP1fTvCPUV8TNkxbdFcWlcAXvozZLXd
         kifrWLi/f8JJdtI0PL736rcBkXvmm/jZFTlNH0MSk9iLJJctqmFyrpZyTY1od6ejsP8+
         4NIRB5hL3/0+8sjcNd9CFCZxm8V27X9MNja1bxX4w3I1Ksg+rQyNJ4pHHlcDhezxYAAA
         tv/WRm1pKgKAUPMd7ejAS2p1IwZYAuq+xW8mlQNpCDbeCSDLkGlO0Ik1NsWecDZTHeTL
         QLqSm+ZhNHi4cgc+rsAI+3aVXSClw6g1/mumkg10Ago+jQISGbxzKc1ba8nHk6Juoivh
         m4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F1rP/HK0MUpthdudkFLSzT5JtnfPSdIqufAWiqCyWfE=;
        b=SrwEvCfizRNaCismVPlf8EtDx62wBnxLBLkonV4+p+qylCBhpS8b8JJhMvZlF2vFm1
         BmZKGrQCUe+5fzZS0HIBY/40k4yHZIgU+e0FIf4Kh/m1YqbVpAReQaDzutqRc8hlb0h4
         XyiWQReZXfplPl3e1JcGwqpbvV/EMG+nb2CIlB5/g/VEO8AESGsk+6pAXWCo7KXPe1tl
         SBO0EQB6HjeE5yZIoqo129ATTXgr5monwoogQV5E7+Czl8XwU2Orv1yNdc4NwnzZXEpG
         E+zXrP7nhR7Xs9UO2PoNv125Qad5lRrZngr8uaxkHpXu4OgG1kVgN5SHh4cUujJ/FR9K
         Jj/Q==
X-Gm-Message-State: AOAM532gSDsTg3KjmvMvZi4JvIMEVCOIowFtNZhFHGYND410lI55ABMT
        owvE6PWGfwYQz0NqcPUvxck=
X-Google-Smtp-Source: ABdhPJypsSKXx5n5ORV+uEvNyrGd64CkLtPHIiDVVoGJhkcs5JqN2IsQm46LGimngeRfP8puqcbJcA==
X-Received: by 2002:a65:6a48:: with SMTP id o8mr4411929pgu.424.1615412670705;
        Wed, 10 Mar 2021 13:44:30 -0800 (PST)
Received: from f8ffc2228008.ant.amazon.com ([54.240.193.1])
        by smtp.gmail.com with ESMTPSA id a7sm407994pfo.105.2021.03.10.13.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 13:44:29 -0800 (PST)
Subject: Re: [PATCH v2 1/2] mm/memcg: rename mem_cgroup_split_huge_fixup to
 split_page_memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-2-zhouguanghui1@huawei.com>
 <3ad50842-881f-eb88-a14d-0b6c70ce33d2@gmail.com>
 <YEcxqTUp88sl/cq3@dhcp22.suse.cz>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <d20d5dbe-74cd-fe90-8e43-ebbc5a3b4403@gmail.com>
Date:   Thu, 11 Mar 2021 08:44:22 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEcxqTUp88sl/cq3@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 7:28 pm, Michal Hocko wrote:
> On Tue 09-03-21 09:37:29, Balbir Singh wrote:
>> On 4/3/21 6:40 pm, Zhou Guanghui wrote:
> [...]
>>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>  /*
>>> - * Because page_memcg(head) is not set on compound tails, set it now.
>>> + * Because page_memcg(head) is not set on tails, set it now.
>>>   */
>>> -void mem_cgroup_split_huge_fixup(struct page *head)
>>> +void split_page_memcg(struct page *head, unsigned int nr)
>>>  {
>>
>> Do we need input validation on nr? Can nr be aribtrary or can we enforce
>>
>> VM_BUG_ON(!is_power_of_2(nr));
> 
> In practice this will be power of 2 but why should we bother to sanitze
> that? 
> 

Just when DEBUG_VM is enabled to ensure the contract is valid, given that
nr is now variable, we could end up with subtle bugs unless we can audit
all callers. Even the power of 2 check does not catch the fact that nr
is indeed what we expect, but it still checks a large range of invalid
inputs.

Balbir Singh.
