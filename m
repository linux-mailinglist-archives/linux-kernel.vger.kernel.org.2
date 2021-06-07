Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1087139DE25
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFGN5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:57:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49641 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhFGN5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:57:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623074123; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Su/cq0k1ylesxhJXGbs0jmsD+IHmtamWDm3Jh1ynG/8=; b=MlFbveAA4nK1w2cZTqFODcMfYa9/nkOK54JjHhBw9XgpkxZkAdENVjWk0QEc0nk7mv5Oc9+Q
 Z3XGCE6NuHfOFHA/TgBp2lxjBWQcJN4jIyU+FeD8R4LCedlhW2Te9wyhV5NcHKVzAJJ480xH
 vASjKoXDHa3YSUh1gxb0HLulJbI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60be252a6ddc3305c4390d03 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Jun 2021 13:54:50
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 989C2C43148; Mon,  7 Jun 2021 13:54:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.121.187] (unknown [27.59.137.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FF56C433D3;
        Mon,  7 Jun 2021 13:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FF56C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v10] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org
References: <1622996045-25826-1-git-send-email-faiyazm@codeaurora.org>
 <CAHp75VdM0aziN4zHaf6=z6D0Nb=+GTbjV1pdTpRZ=yxGDZRkhw@mail.gmail.com>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <d5c16162-91af-40ba-66dc-02ac5a6a48ef@codeaurora.org>
Date:   Mon, 7 Jun 2021 19:24:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdM0aziN4zHaf6=z6D0Nb=+GTbjV1pdTpRZ=yxGDZRkhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/2021 2:01 AM, Andy Shevchenko wrote:
> On Sun, Jun 6, 2021 at 7:16 PM Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:
>>
>> alloc_calls and free_calls implementation in sysfs have two issues,
>> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> 
> limitation
> 
>> to "one value per file" rule.
>>
>> To overcome this issues, move the alloc_calls and free_calls implemeation
> 
> implementation
> 
>> to debugfs.
>>
>> Debugfs cache will be created if SLAB_STORE_USER flag is set.
>>
>> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
>> to be inline with what it does.
> 
> ...
> 
>> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
>> +void debugfs_slab_release(struct kmem_cache *);
>> +#else
> 
>> +static inline void debugfs_slab_release(struct kmem_cache *s)
>> +{
>> +}
> 
> It can be one line.
> 
>> +#endif
> 
> ...
> 
> 
>> +               if (l->sum_time != l->min_time) {
>> +                       seq_printf(seq, " age=%ld/%ld/%ld",
>> +                               l->min_time,
> 
>> +                               (long)div_u64(l->sum_time, l->count),
> 
> Hmm... Why is the cast needed here?
> 
>> +                               l->max_time);
>> +               } else
>> +                       seq_printf(seq, " age=%ld",
>> +                               l->min_time);
> 
> ...
> 
>> +               if (num_online_cpus() > 1 &&
>> +                               !cpumask_empty(to_cpumask(l->cpus)))
> 
> One line?
> 
I have split the line because it is crossing the 80 columns. In this
case it's okay to cross 80 columns?
> ...
> 
>> +static const struct seq_operations slab_debugfs_sops = {
>> +       .start  = slab_debugfs_start,
>> +       .next   = slab_debugfs_next,
>> +       .stop   = slab_debugfs_stop,
> 
>> +       .show   = slab_debugfs_show
> 
> Leave a comma here. It might not be the last one in the future.
> 
>> +};
> 
> + blank line?
> 
>> +static int slab_debug_trace_open(struct inode *inode, struct file *filep)
>> +{
> 
> ...
> 
>> +static const struct file_operations slab_debugfs_fops = {
>> +       .open    = slab_debug_trace_open,
>> +       .read    = seq_read,
>> +       .llseek  = seq_lseek,
>> +       .release = slab_debug_trace_release,
>> +};
>> +
>> +
> 
> One blank line is enough.
> 
> ...
> 
>> +       debugfs_remove_recursive(debugfs_lookup(s->name,
>> +                                       slab_debugfs_root));
> 
> One line?
> 
Same here!
