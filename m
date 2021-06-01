Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D414539730F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhFAMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:17:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12880 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhFAMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:17:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622549759; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=tprHWYokWxxPsEVWwyMkMhvSmSsooYLul99ouTewZiU=; b=qAJPN1L6k7biUaq0Jj+RszMnKGWAwbB/bIrNXy7uHuyru7mUMIg4HAw/qD3owPhTrJJNm3KW
 zGIieLfGCdNq+nftmf0Cpab2Fy+L8r6tgLxVWqA2LYcAm0HVZUoj6a1fQ1XGqnEMPbVLQaXV
 qdlUgBEBqSMyyUWupQWM3oY1LXU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60b624ea81efe91cda35ec73 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Jun 2021 12:15:38
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 89B02C43460; Tue,  1 Jun 2021 12:15:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.181.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAAD0C433D3;
        Tue,  1 Jun 2021 12:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAAD0C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v8] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <lkp@intel.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     kbuild-all@lists.01.org
References: <1622542057-14632-1-git-send-email-faiyazm@codeaurora.org>
 <202106011959.5wcQP2E6-lkp@intel.com>
 <96578f05-79a0-96eb-c015-02e8640e6016@suse.cz>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <3449cf29-3c21-69e2-d410-31a5730d4574@codeaurora.org>
Date:   Tue, 1 Jun 2021 17:45:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <96578f05-79a0-96eb-c015-02e8640e6016@suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/2021 5:44 PM, Vlastimil Babka wrote:
> On 6/1/21 1:08 PM, kernel test robot wrote:
>> Hi Faiyaz,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v5.13-rc4]
>> [cannot apply to hnaz-linux-mm/master next-20210601]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Faiyaz-Mohammed/mm-slub-move-sysfs-slab-alloc-free-interfaces-to-debugfs/20210601-180903
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c2131f7e73c9e9365613e323d65c7b9e5b910f56
>> config: i386-tinyconfig (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce (this is a W=1 build):
>>         # https://github.com/0day-ci/linux/commit/9540acc4691d680b7124d8daa1a2eb98a97ee19a
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Faiyaz-Mohammed/mm-slub-move-sysfs-slab-alloc-free-interfaces-to-debugfs/20210601-180903
>>         git checkout 9540acc4691d680b7124d8daa1a2eb98a97ee19a
>>         # save the attached .config to linux build tree
>>         make W=1 ARCH=i386 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    mm/slab_common.c: In function 'slab_caches_to_rcu_destroy_workfn':
>>>> mm/slab_common.c:452:3: error: implicit declaration of function 'debugfs_slab_release' [-Werror=implicit-function-declaration]
>>      452 |   debugfs_slab_release(s);
>>          |   ^~~~~~~~~~~~~~~~~~~~
>>    cc1: some warnings being treated as errors
> 
> Oh, right, CONFIG_SLOB.
> How about moving the ifdef-ed declaration from slub-def.h to mm/slab.h and
> discarding the slab-def.h empty one. That will take care of SLOB too.
> 

Yes, doing the same.
>> vim +/debugfs_slab_release +452 mm/slab_common.c
>>
>>    427	
>>    428	static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>>    429	{
>>    430		LIST_HEAD(to_destroy);
>>    431		struct kmem_cache *s, *s2;
>>    432	
>>    433		/*
>>    434		 * On destruction, SLAB_TYPESAFE_BY_RCU kmem_caches are put on the
>>    435		 * @slab_caches_to_rcu_destroy list.  The slab pages are freed
>>    436		 * through RCU and the associated kmem_cache are dereferenced
>>    437		 * while freeing the pages, so the kmem_caches should be freed only
>>    438		 * after the pending RCU operations are finished.  As rcu_barrier()
>>    439		 * is a pretty slow operation, we batch all pending destructions
>>    440		 * asynchronously.
>>    441		 */
>>    442		mutex_lock(&slab_mutex);
>>    443		list_splice_init(&slab_caches_to_rcu_destroy, &to_destroy);
>>    444		mutex_unlock(&slab_mutex);
>>    445	
>>    446		if (list_empty(&to_destroy))
>>    447			return;
>>    448	
>>    449		rcu_barrier();
>>    450	
>>    451		list_for_each_entry_safe(s, s2, &to_destroy, list) {
>>  > 452			debugfs_slab_release(s);
>>    453			kfence_shutdown_cache(s);
>>    454	#ifdef SLAB_SUPPORTS_SYSFS
>>    455			sysfs_slab_release(s);
>>    456	#else
>>    457			slab_kmem_cache_release(s);
>>    458	#endif
>>    459		}
>>    460	}
>>    461	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 
