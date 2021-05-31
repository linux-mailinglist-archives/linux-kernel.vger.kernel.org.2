Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA763955CD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhEaHNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:13:25 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28502 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaHNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:13:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622445104; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=er6iWpFOnYRYhyjNz1Ul7BlyTO2daX+WJ02mH9iGGYg=; b=GlbsDk8B70Xusf+lb3IBcRCxzj73p3LA87FEPpzKiL6JVlGWkbnyrmxGLNR8lXV6OOV3EYN6
 5f7BF25BIOkcuhxexm+y+pT9O4m47n5EJKpq/WhGIp4GLnGXkMEYyyZKMWWQVB2Ua/w8N5dY
 0dZYZkxPSWTBxMFQLQCnM+BeMVY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60b48c2f51f29e6baec9be3a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 May 2021 07:11:43
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E15B8C43143; Mon, 31 May 2021 07:11:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.182.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C81DAC433D3;
        Mon, 31 May 2021 07:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C81DAC433D3
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
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <be061209-7480-d1eb-4b70-883259aadffb@codeaurora.org>
Date:   Mon, 31 May 2021 12:41:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <0b0e5e43-2ccf-a8a4-1e3b-ab2326c55321@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2021 5:43 PM, Vlastimil Babka wrote:
> On 5/26/21 1:48 PM, Greg KH wrote:
>> On Wed, May 26, 2021 at 01:38:55PM +0200, Vlastimil Babka wrote:
>>>
>>> alias_list a single list and both slab_sysfs_init() and slab_debugfs_init()
>>> flush it. So only the init call that happens to be called first, does actually
>>> find an unflushed list. I think you
>>> need to use a separate list for debugfs (simpler) or a shared list with both
>>> sysfs and debugfs processing (probably more complicated).
>>>
>>> And finally a question, perhaps also for Greg. With sysfs, we hand out the
>>> lifecycle of struct kmem_cache to sysfs, to ensure we are not reading sysfs
>>> files of a cache that has been removed.
>>>
>>> But with debugfs, what are the guarantees that things won't blow up when a
>>> debugfs file is being read while somebody calls kmem_cache_destroy() on the cache?
>>
>> It's much harder, but usually the default debugfs_file_create() will
>> handle this for you.  See the debugfs_file_create_unsafe() for the
>> "other" variant where you know you can tear things down "safely".
> 
> Right, so IIUC debugfs will guarantee that while somebody reads the files, the
> debugfs cleanup will block, as debugfs_file_get() comment explains.
> 
> In that case I think we have the cleanup order wrong in this patch:
> 
> shutdown_cache() should first do debugfs_slab_release() (which would block) and
> only then proceed with slab_kmem_cache_release() which destroys the fundamental
> structures such as kmem_cache_node, which are also accessed by the debugfs file
> handlers.
>
If user is trying to read the data during shutdown_cache(), then I think
it's possible user will get empty data, to avoid that we can call
debugfs_slab_release() first and then do other stuff in shutdown_cache().

>> That being said, yes there are still issues in this area, be careful
>> about what tools you expect to be constantly hitting debugfs files.
> 
> FWIW, the files are accessible only to root.
> 
>> thanks,
>>
>> greg k-h
>>
> 
