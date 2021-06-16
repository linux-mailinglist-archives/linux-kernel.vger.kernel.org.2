Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38003A98C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFPLHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:07:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41080 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhFPLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:07:52 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93E20219D6;
        Wed, 16 Jun 2021 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcnqgYV1OHaJr0sq4rpPF6e//e/o64rPvF0s7j9YdWo=;
        b=lHUFofQkBTtr5npeN6gBLNXp4eETFhqp4qQHwOICibnfQTXZH6php5fyMCiYGgIQieQXFX
        EpwGmSEmbym19oxSrxL0LgUR+0c7dqOMss1oQozuCDivp2GDzN1u2iRJNYncxwSDHH6/j4
        5dbCDJgs7WirXvLfeOQDhmxPq7J+Oag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcnqgYV1OHaJr0sq4rpPF6e//e/o64rPvF0s7j9YdWo=;
        b=OPJCzz5nh9hmVzow8cUb64+csDdolPJFKZYD24Z8N/xvAkA8HEvSonlpWmcUOYggqUVed1
        d07OTbm8iBqpfbBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 68ADB118DD;
        Wed, 16 Jun 2021 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcnqgYV1OHaJr0sq4rpPF6e//e/o64rPvF0s7j9YdWo=;
        b=lHUFofQkBTtr5npeN6gBLNXp4eETFhqp4qQHwOICibnfQTXZH6php5fyMCiYGgIQieQXFX
        EpwGmSEmbym19oxSrxL0LgUR+0c7dqOMss1oQozuCDivp2GDzN1u2iRJNYncxwSDHH6/j4
        5dbCDJgs7WirXvLfeOQDhmxPq7J+Oag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcnqgYV1OHaJr0sq4rpPF6e//e/o64rPvF0s7j9YdWo=;
        b=OPJCzz5nh9hmVzow8cUb64+csDdolPJFKZYD24Z8N/xvAkA8HEvSonlpWmcUOYggqUVed1
        d07OTbm8iBqpfbBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id QtwCGQnbyWDBYgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 16 Jun 2021 11:05:45 +0000
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com,
        andy.shevchenko@gmail.com
Cc:     vinmenon@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>
References: <1623438200-19361-1-git-send-email-faiyazm@codeaurora.org>
 <8c821abf-8fa6-b78b-cea4-b7d3b3b74a69@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v12] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <ce1b3c14-ec88-c957-0694-834051d4d39e@suse.cz>
Date:   Wed, 16 Jun 2021 13:05:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8c821abf-8fa6-b78b-cea4-b7d3b3b74a69@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 5:58 PM, Qian Cai wrote:
> 
> 
> On 6/11/2021 3:03 PM, Faiyaz Mohammed wrote:
>> alloc_calls and free_calls implementation in sysfs have two issues,
>> one is PAGE_SIZE limitation of sysfs and other is it does not adhere
>> to "one value per file" rule.
>> 
>> To overcome this issues, move the alloc_calls and free_calls
>> implementation to debugfs.
>> 
>> Debugfs cache will be created if SLAB_STORE_USER flag is set.
>> 
>> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
>> to be inline with what it does.
>> 
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> 
> Reverting this commit on today's linux-next fixed all leaks (hundreds) reported by kmemleak like below,
> 
> unreferenced object 0xffff00091ae1b540 (size 64):
>   comm "lsbug", pid 1607, jiffies 4294958291 (age 1476.340s)
>   hex dump (first 32 bytes):
>     02 00 00 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
>     6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>   backtrace:
>     [<ffff8000106b06b8>] slab_post_alloc_hook+0xa0/0x418
>     [<ffff8000106b5c7c>] kmem_cache_alloc_trace+0x1e4/0x378
>     [<ffff8000106b5e40>] slab_debugfs_start+0x30/0x50
>     slab_debugfs_start at /usr/src/linux-next/mm/slub.c:5831
>     [<ffff8000107b3dbc>] seq_read_iter+0x214/0xd50
>     [<ffff8000107b4b84>] seq_read+0x28c/0x418
>     [<ffff8000109560b4>] full_proxy_read+0xdc/0x148
>     [<ffff800010738f24>] vfs_read+0x104/0x340
>     [<ffff800010739ee0>] ksys_read+0xf8/0x1e0
>     [<ffff80001073a03c>] __arm64_sys_read+0x74/0xa8
>     [<ffff8000100358d4>] invoke_syscall.constprop.0+0xdc/0x1d8
>     [<ffff800010035ab4>] do_el0_svc+0xe4/0x298
>     [<ffff800011138528>] el0_svc+0x20/0x30
>     [<ffff800011138b08>] el0t_64_sync_handler+0xb0/0xb8
>     [<ffff80001001259c>] el0t_64_sync+0x178/0x17c
> 

I think the problem is here:

>> +static void slab_debugfs_stop(struct seq_file *seq, void *v)
>> +{
>> +	kfree(v);
>> +}
>> +
>> +static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>> +{
>> +	loff_t *spos = v;
>> +	struct loc_track *t = seq->private;
>> +
>> +	if (*ppos < t->count) {
>> +		*ppos = ++*spos;
>> +		return spos;
>> +	}
>> +	*ppos = ++*spos;
>> +	return NULL;
>> +}

If we return NULL, then NULL is passed to slab_debugfs_stop and thus we don't
kfree ppos. kfree(NULL) is silently ignored.

I think as we have private struct loc_track, we can add a pos field there and
avoid the kmaloc/kfree altogether.
