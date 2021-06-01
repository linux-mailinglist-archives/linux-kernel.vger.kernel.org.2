Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C3D39730A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhFAMPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:15:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36674 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhFAMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:15:54 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB8B421926;
        Tue,  1 Jun 2021 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622549651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3QbPuZmzCj3kt2UlzpOt7teYl+odFUhgka2ffSCpYI=;
        b=S6dumE+J60zZwDBW4Ad0Lv9NafScli1fm0JN0BVOgTA8TJmEryZJ89QbvXyc3ZXn/eimey
        C1xObOcj3HYV/hYlUXLG2Bs2lVdqsI2j0VfucXq/j88Sr5SRRedH7dS0/tYQ6ufBrdjFZF
        Xz67B92YGjWj+z/YlIq10SsoPOreMYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622549651;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3QbPuZmzCj3kt2UlzpOt7teYl+odFUhgka2ffSCpYI=;
        b=2t2UodyrGEHy6KxId5+Bt5Jnhh3lgyVEWx5Ke/5MSY/XoYo6Aq47G84RKedu7MKK73hL8W
        rPEdVaRyv0GGC5Bg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A8E74118DD;
        Tue,  1 Jun 2021 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622549651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3QbPuZmzCj3kt2UlzpOt7teYl+odFUhgka2ffSCpYI=;
        b=S6dumE+J60zZwDBW4Ad0Lv9NafScli1fm0JN0BVOgTA8TJmEryZJ89QbvXyc3ZXn/eimey
        C1xObOcj3HYV/hYlUXLG2Bs2lVdqsI2j0VfucXq/j88Sr5SRRedH7dS0/tYQ6ufBrdjFZF
        Xz67B92YGjWj+z/YlIq10SsoPOreMYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622549651;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3QbPuZmzCj3kt2UlzpOt7teYl+odFUhgka2ffSCpYI=;
        b=2t2UodyrGEHy6KxId5+Bt5Jnhh3lgyVEWx5Ke/5MSY/XoYo6Aq47G84RKedu7MKK73hL8W
        rPEdVaRyv0GGC5Bg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id SqDAKJMktmCqUAAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Tue, 01 Jun 2021 12:14:11 +0000
Subject: Re: [PATCH v8] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     kernel test robot <lkp@intel.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     kbuild-all@lists.01.org
References: <1622542057-14632-1-git-send-email-faiyazm@codeaurora.org>
 <202106011959.5wcQP2E6-lkp@intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <96578f05-79a0-96eb-c015-02e8640e6016@suse.cz>
Date:   Tue, 1 Jun 2021 14:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <202106011959.5wcQP2E6-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 1:08 PM, kernel test robot wrote:
> Hi Faiyaz,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.13-rc4]
> [cannot apply to hnaz-linux-mm/master next-20210601]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Faiyaz-Mohammed/mm-slub-move-sysfs-slab-alloc-free-interfaces-to-debugfs/20210601-180903
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c2131f7e73c9e9365613e323d65c7b9e5b910f56
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/9540acc4691d680b7124d8daa1a2eb98a97ee19a
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Faiyaz-Mohammed/mm-slub-move-sysfs-slab-alloc-free-interfaces-to-debugfs/20210601-180903
>         git checkout 9540acc4691d680b7124d8daa1a2eb98a97ee19a
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    mm/slab_common.c: In function 'slab_caches_to_rcu_destroy_workfn':
>>> mm/slab_common.c:452:3: error: implicit declaration of function 'debugfs_slab_release' [-Werror=implicit-function-declaration]
>      452 |   debugfs_slab_release(s);
>          |   ^~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Oh, right, CONFIG_SLOB.
How about moving the ifdef-ed declaration from slub-def.h to mm/slab.h and
discarding the slab-def.h empty one. That will take care of SLOB too.

> vim +/debugfs_slab_release +452 mm/slab_common.c
> 
>    427	
>    428	static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>    429	{
>    430		LIST_HEAD(to_destroy);
>    431		struct kmem_cache *s, *s2;
>    432	
>    433		/*
>    434		 * On destruction, SLAB_TYPESAFE_BY_RCU kmem_caches are put on the
>    435		 * @slab_caches_to_rcu_destroy list.  The slab pages are freed
>    436		 * through RCU and the associated kmem_cache are dereferenced
>    437		 * while freeing the pages, so the kmem_caches should be freed only
>    438		 * after the pending RCU operations are finished.  As rcu_barrier()
>    439		 * is a pretty slow operation, we batch all pending destructions
>    440		 * asynchronously.
>    441		 */
>    442		mutex_lock(&slab_mutex);
>    443		list_splice_init(&slab_caches_to_rcu_destroy, &to_destroy);
>    444		mutex_unlock(&slab_mutex);
>    445	
>    446		if (list_empty(&to_destroy))
>    447			return;
>    448	
>    449		rcu_barrier();
>    450	
>    451		list_for_each_entry_safe(s, s2, &to_destroy, list) {
>  > 452			debugfs_slab_release(s);
>    453			kfence_shutdown_cache(s);
>    454	#ifdef SLAB_SUPPORTS_SYSFS
>    455			sysfs_slab_release(s);
>    456	#else
>    457			slab_kmem_cache_release(s);
>    458	#endif
>    459		}
>    460	}
>    461	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

