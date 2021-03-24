Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7379347022
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhCXDag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:30:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38235 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235045AbhCXDaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:30:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616556595; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=00TqvYCNeciOSY+tXTmof3mxA8FUNJGcjvkmvoy4PAM=; b=kTRu5E5/jgD43+p5HRdfZTpVyi4sN5QF8e2heWvXmfyCwhO+Ys7CatavgSw3YvWo4Z52e5Xb
 sYILcvo42iWeIUGRs3VOMPs3xfSMGjlFzi5h2OdMJtKL2oLs3D1VCZiTqkSp8FjZ8PSpel7K
 HWlNmHuF9hi8YmGnKMvhfdASxuw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 605ab22be3fca7d0a6fc9f8e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Mar 2021 03:29:47
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EEBFEC43461; Wed, 24 Mar 2021 03:29:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.109] (unknown [103.110.147.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DE6EC433CA;
        Wed, 24 Mar 2021 03:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DE6EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH] mm: vmalloc: Prevent use after free in _vm_unmap_aliases
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1616062105-23263-1-git-send-email-vjitta@codeaurora.org>
 <20210318165907.GA10448@pc638.lan>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <803dc8ec-d1a2-ed26-ddab-a5258e60d318@codeaurora.org>
Date:   Wed, 24 Mar 2021 08:59:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318165907.GA10448@pc638.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2021 10:29 PM, Uladzislau Rezki wrote:
> On Thu, Mar 18, 2021 at 03:38:25PM +0530, vjitta@codeaurora.org wrote:
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> A potential use after free can occur in _vm_unmap_aliases
>> where an already freed vmap_area could be accessed, Consider
>> the following scenario:
>>
>> Process 1						Process 2
>>
>> __vm_unmap_aliases					__vm_unmap_aliases
>> 	purge_fragmented_blocks_allcpus				rcu_read_lock()
>> 		rcu_read_lock()
>> 			list_del_rcu(&vb->free_list)
>> 									list_for_each_entry_rcu(vb .. )
>> 	__purge_vmap_area_lazy
>> 		kmem_cache_free(va)
>> 										va_start = vb->va->va_start
> Or maybe we should switch to kfree_rcu() instead of kmem_cache_free()?
> 
> --
> Vlad Rezki
> 

Thanks for suggestion.

I see free_vmap_area_lock (spinlock) is taken in __purge_vmap_area_lazy
while it loops through list and calls kmem_cache_free on va's. So, looks
like we can't replace it with kfree_rcu as it might cause scheduling
within atomic context.

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
