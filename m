Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A93AA066
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhFPPwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:52:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10377 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234667AbhFPPwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:52:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623858635; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=y4PQBcJUYYfqwen29zXbaqkBU82Zn+Kqoo9Bv3Hnm70=; b=p2Bn7ZHj1V0DdibCBxiEINTNfXZvwsR2Ibiv8AJq+ekIuBo+VRTm3AXKnQ0tgkiUn5VoVADT
 kdRnya22IeNM+o4pvGUeFUv0TsWnzThF6DW7ylBCX0xxKe6CR0s/Ogftl+YkP5uF9m+0KfiT
 hfpcLavh7B2HSS1ztyyfPQfM1PE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60ca1dbded59bf69cc233bed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Jun 2021 15:50:21
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EA561C43144; Wed, 16 Jun 2021 15:50:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.100] (unknown [49.204.182.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02B87C433F1;
        Wed, 16 Jun 2021 15:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02B87C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v12] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Vlastimil Babka <vbabka@suse.cz>,
        Qian Cai <quic_qiancai@quicinc.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com,
        andy.shevchenko@gmail.com
Cc:     vinmenon@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>
References: <1623438200-19361-1-git-send-email-faiyazm@codeaurora.org>
 <8c821abf-8fa6-b78b-cea4-b7d3b3b74a69@quicinc.com>
 <ce1b3c14-ec88-c957-0694-834051d4d39e@suse.cz>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <25d59ad1-4d21-181c-afc2-8f396672bfd1@codeaurora.org>
Date:   Wed, 16 Jun 2021 21:20:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ce1b3c14-ec88-c957-0694-834051d4d39e@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2021 4:35 PM, Vlastimil Babka wrote:
> On 6/15/21 5:58 PM, Qian Cai wrote:
>>
>>
>> On 6/11/2021 3:03 PM, Faiyaz Mohammed wrote:
>>> alloc_calls and free_calls implementation in sysfs have two issues,
>>> one is PAGE_SIZE limitation of sysfs and other is it does not adhere
>>> to "one value per file" rule.
>>>
>>> To overcome this issues, move the alloc_calls and free_calls
>>> implementation to debugfs.
>>>
>>> Debugfs cache will be created if SLAB_STORE_USER flag is set.
>>>
>>> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
>>> to be inline with what it does.
>>>
>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>>
>> Reverting this commit on today's linux-next fixed all leaks (hundreds) reported by kmemleak like below,
>>
>> unreferenced object 0xffff00091ae1b540 (size 64):
>>   comm "lsbug", pid 1607, jiffies 4294958291 (age 1476.340s)
>>   hex dump (first 32 bytes):
>>     02 00 00 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
>>     6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>>   backtrace:
>>     [<ffff8000106b06b8>] slab_post_alloc_hook+0xa0/0x418
>>     [<ffff8000106b5c7c>] kmem_cache_alloc_trace+0x1e4/0x378
>>     [<ffff8000106b5e40>] slab_debugfs_start+0x30/0x50
>>     slab_debugfs_start at /usr/src/linux-next/mm/slub.c:5831
>>     [<ffff8000107b3dbc>] seq_read_iter+0x214/0xd50
>>     [<ffff8000107b4b84>] seq_read+0x28c/0x418
>>     [<ffff8000109560b4>] full_proxy_read+0xdc/0x148
>>     [<ffff800010738f24>] vfs_read+0x104/0x340
>>     [<ffff800010739ee0>] ksys_read+0xf8/0x1e0
>>     [<ffff80001073a03c>] __arm64_sys_read+0x74/0xa8
>>     [<ffff8000100358d4>] invoke_syscall.constprop.0+0xdc/0x1d8
>>     [<ffff800010035ab4>] do_el0_svc+0xe4/0x298
>>     [<ffff800011138528>] el0_svc+0x20/0x30
>>     [<ffff800011138b08>] el0t_64_sync_handler+0xb0/0xb8
>>     [<ffff80001001259c>] el0t_64_sync+0x178/0x17c
>>
> 
> I think the problem is here:
> 
>>> +static void slab_debugfs_stop(struct seq_file *seq, void *v)
>>> +{
>>> +	kfree(v);
>>> +}
>>> +
>>> +static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>>> +{
>>> +	loff_t *spos = v;
>>> +	struct loc_track *t = seq->private;
>>> +
>>> +	if (*ppos < t->count) {
>>> +		*ppos = ++*spos;
>>> +		return spos;
>>> +	}
>>> +	*ppos = ++*spos;
>>> +	return NULL;
>>> +}
> 
> If we return NULL, then NULL is passed to slab_debugfs_stop and thus we don't
> kfree ppos. kfree(NULL) is silently ignored.
> 
I think yes, if NULL passed to kfree, it simply do return.
> I think as we have private struct loc_track, we can add a pos field there and
> avoid the kmaloc/kfree altogether.
> 
Hmm, yes we can add pos field "or" we can use argument "v" mean we can
update v with pos in ->next() and use in ->show() to avoid the leak
(kmalloc/kfree).


Thanks and regards,
Mohammed Faiyaz
