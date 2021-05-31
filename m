Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329A4395875
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhEaJwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:52:51 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52658 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhEaJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:52:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622454667; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=q7Wz7E8q1Z+/6dUG1hU3N6iWpBVBOzCSwDl6PQVYNuY=; b=ixRkyP3OaAPFFZFjH1ZgfkFPzK5YMgb+cAEiYZx/Hl6LVLMDgFoDiL9iE+5x1asoDJRhaHkA
 Jb0/LXlCfJismts7WrIFEeFkEVMU2j9OBfYR8+BdcdxDZkGuXVXs1j27sK/ROlKOVxate5l4
 31igUWLZBh9RtHd03IOv9hr609A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60b4b177ea2aacd729c13f1b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 May 2021 09:50:47
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7F38C433F1; Mon, 31 May 2021 09:50:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.182.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82705C433F1;
        Mon, 31 May 2021 09:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82705C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Vlastimil Babka <vbabka@suse.cz>, Greg KH <greg@kroah.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <86d843f0-bbef-7c3b-6b6a-5d6b32434bee@suse.cz> <YK41eFeL5j4qqSnV@kroah.com>
 <0b0e5e43-2ccf-a8a4-1e3b-ab2326c55321@suse.cz>
 <be061209-7480-d1eb-4b70-883259aadffb@codeaurora.org>
 <043cfec6-7881-46e8-ec9c-3b4d6611ac2c@suse.cz>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <2fc580b5-13a5-1a54-fe0b-9843ec685e64@codeaurora.org>
Date:   Mon, 31 May 2021 15:20:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <043cfec6-7881-46e8-ec9c-3b4d6611ac2c@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2021 1:49 PM, Vlastimil Babka wrote:
> On 5/31/21 9:11 AM, Faiyaz Mohammed wrote:
>>
>>
>> On 5/26/2021 5:43 PM, Vlastimil Babka wrote:
>>> On 5/26/21 1:48 PM, Greg KH wrote:
>>>> On Wed, May 26, 2021 at 01:38:55PM +0200, Vlastimil Babka wrote:
>>>>>
>>>>> alias_list a single list and both slab_sysfs_init() and slab_debugfs_init()
>>>>> flush it. So only the init call that happens to be called first, does actually
>>>>> find an unflushed list. I think you
>>>>> need to use a separate list for debugfs (simpler) or a shared list with both
>>>>> sysfs and debugfs processing (probably more complicated).
>>>>>
>>>>> And finally a question, perhaps also for Greg. With sysfs, we hand out the
>>>>> lifecycle of struct kmem_cache to sysfs, to ensure we are not reading sysfs
>>>>> files of a cache that has been removed.
>>>>>
>>>>> But with debugfs, what are the guarantees that things won't blow up when a
>>>>> debugfs file is being read while somebody calls kmem_cache_destroy() on the cache?
>>>>
>>>> It's much harder, but usually the default debugfs_file_create() will
>>>> handle this for you.  See the debugfs_file_create_unsafe() for the
>>>> "other" variant where you know you can tear things down "safely".
>>>
>>> Right, so IIUC debugfs will guarantee that while somebody reads the files, the
>>> debugfs cleanup will block, as debugfs_file_get() comment explains.
>>>
>>> In that case I think we have the cleanup order wrong in this patch:
>>>
>>> shutdown_cache() should first do debugfs_slab_release() (which would block) and
>>> only then proceed with slab_kmem_cache_release() which destroys the fundamental
>>> structures such as kmem_cache_node, which are also accessed by the debugfs file
>>> handlers.
>>>
>> If user is trying to read the data during shutdown_cache(), then I think
>> it's possible user will get empty data, to avoid that we can call
> 
> Empty data is fine, when the cache is going away anyway.
> 
>> debugfs_slab_release() first and then do other stuff in shutdown_cache().
> 
> Everything above list_del(&s->list) should be OK, it's equivalent to normal
> cache operations which the debugfs files must cope with anyway.
> list_del(&s->list) is OK as the debugfs handlers don't go through the list. It's
> slab_kmem_cache_release() that matters.
> 
okay, I will move debugfs_slab_release() before the
slab_kmem_cache_release() in next patch version.
>>>> That being said, yes there are still issues in this area, be careful
>>>> about what tools you expect to be constantly hitting debugfs files.
>>>
>>> FWIW, the files are accessible only to root.
>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>>
>>>
>>
> 
