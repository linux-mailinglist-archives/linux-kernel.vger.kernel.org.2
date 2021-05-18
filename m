Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5104387928
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349125AbhERMvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:51:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20277 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243188AbhERMvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:51:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621342177; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=vgRBEr4vJNOC4MDE9iyMZ01ZKrU4nugXaWK/OTMBl9g=; b=ZPx8x/Kvza35o7LAnxJCEtQHs6v6GwYilkxos0qHobVJw7s43eoBXwogdUVVK3oU9C/jVns2
 9sEpm5zjpqqu1rbObNV8FSrItddoKo/A54f69cqO9wrymcuPmKUCk/n17yv2+5Z0LoLP1Ltb
 jlzXSbHLTxMvbxjZVFKwuEg/Cd0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60a3b7e0b15734c8f93e43a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 May 2021 12:49:36
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2D43C43146; Tue, 18 May 2021 12:49:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.182.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6941AC433D3;
        Tue, 18 May 2021 12:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6941AC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v5] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, glittao@gmail.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org, vinmenon@codeaurora.org
References: <202105070253.GuJL1RPR-lkp@intel.com>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <b42b02d6-08f4-01b1-6ab3-72237ef58034@codeaurora.org>
Date:   Tue, 18 May 2021 18:19:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <202105070253.GuJL1RPR-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Updated in the patch,
https://lore.kernel.org/linux-mm/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/T/#u

Thanks and regards,
Mohammed Faiyaz

On 5/7/2021 10:51 AM, Dan Carpenter wrote:
> Hi Faiyaz,
> 
> url:    https://github.com/0day-ci/linux/commits/Faiyaz-Mohammed/mm-slub-move-sysfs-slab-alloc-free-interfaces-to-debugfs/20210506-182420
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 8404c9fbc84b741f66cff7d4934a25dd2c344452
> config: i386-randconfig-m021-20210506 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> mm/slub.c:5891 slab_debugfs_start() warn: possible memory leak of 'spos'
> 
> vim +/spos +5891 mm/slub.c
> 
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5877  static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5878  {
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5879  	struct kmem_cache_node *n;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5880  	struct kmem_cache *s;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5881  	enum track_item alloc;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5882  	int node;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5883  	loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
>                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Generally avoid putting functions which can fail in the declaration
> block.  Allocations inside the declaration block are a tiny percent of
> declarations over all but they are an outsize source of static checker
> bugs.
> 
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5884  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5885  	s = seq->file->f_inode->i_private;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5886  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5887  	if (!spos)
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5888  		return NULL;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5889  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5890  	if (!(s->flags & SLAB_STORE_USER))
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06 @5891  		return ERR_PTR(-EOPNOTSUPP);
> 
> "spos" is leaked.
> 
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5892  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5893  	if (*ppos == 0) {
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5894  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5895  		t.count = 0;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5896  		t.max = 0;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5897  		t.loc = NULL;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5898  		if (strcmp(seq->file->f_path.dentry->d_name.name, "alloc_traces") == 0)
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5899  			alloc =  TRACK_ALLOC;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5900  		else
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5901  			alloc =  TRACK_FREE;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5902  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5903  		if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5904  			     GFP_KERNEL)) {
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5905  			seq_puts(seq, "Out of memory\n");
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5906  			return ERR_PTR(-ENOMEM);
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5907  		}
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5908  		/* Push back cpu slabs */
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5909  		flush_all(s);
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5910  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5911  		for_each_kmem_cache_node(s, node, n) {
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5912  			unsigned long flags;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5913  			struct page *page;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5914  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5915  			if (!atomic_long_read(&n->nr_slabs))
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5916  				continue;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5917  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5918  			spin_lock_irqsave(&n->list_lock, flags);
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5919  			list_for_each_entry(page, &n->partial, slab_list)
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5920  				process_slab(&t, s, page, alloc);
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5921  			list_for_each_entry(page, &n->full, slab_list)
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5922  				process_slab(&t, s, page, alloc);
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5923  			spin_unlock_irqrestore(&n->list_lock, flags);
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5924  		}
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5925  	}
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5926  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5927  	if (*ppos < t.count) {
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5928  		*spos = *ppos;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5929  		return spos;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5930  	}
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5931  
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5932  	kfree(spos);
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5933  	return NULL;
> 88e180b99466c1 Faiyaz Mohammed 2021-05-06  5934  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
