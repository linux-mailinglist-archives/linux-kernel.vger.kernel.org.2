Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3F93E8CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhHKI4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:56:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35156 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbhHKI4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:56:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 082E71FEAF;
        Wed, 11 Aug 2021 08:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628672136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKE2B1opnvB/hJAxsbfc2CiKooYcumMdQd+fJCEjFtM=;
        b=UFqYaCyRuF0TqfywsPvOhlsX3rY1kmgjbSVYphwOTqY6JZhaXyc867yHS8pnLhehv5jCBN
        h9FDJCilYiAEveqKuyK6mbBsocXGFMBP5FONJGRnjDjQ7FqkR4i414KIEVpRhHqLlNxHUp
        6+l02soRYgG+JBmV7uFGhX5OUEQv8QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628672136;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKE2B1opnvB/hJAxsbfc2CiKooYcumMdQd+fJCEjFtM=;
        b=cDO8H1F/zq0znC2swz+XLJovpND8ceWcW50OpyeVXwha4eC0c5WdBWkH/MbfwF18cb/ue/
        71N1SMVMMMLB0RDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C224C131F5;
        Wed, 11 Aug 2021 08:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id wc/HJYeQE2GudwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 08:55:35 +0000
Subject: Re: [PATCH v4 29/35] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-30-vbabka@suse.cz>
 <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
 <50fe26ba-450b-af57-506d-438f67cfbce3@suse.cz>
Message-ID: <60e50d8c-ccfa-1036-5a03-2b1a9d25f958@suse.cz>
Date:   Wed, 11 Aug 2021 10:55:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <50fe26ba-450b-af57-506d-438f67cfbce3@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 4:33 PM, Vlastimil Babka wrote:
> On 8/9/21 3:41 PM, Qian Cai wrote:
> 
>>>  static void flush_all(struct kmem_cache *s)
>>>  {
>>> -	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
>>> +	struct slub_flush_work *sfw;
>>> +	unsigned int cpu;
>>> +
>>> +	mutex_lock(&flush_lock);
>> 
>> Vlastimil, taking the lock here could trigger a warning during memory offline/online due to the locking order:
>> 
>> slab_mutex -> flush_lock
> 
> Here's the full fixup, also incorporating Mike's fix. Thanks.
> 

One more fixup, sorry for the churn.
----8<----
From 7cfe3fb1bcd6e589199b10bef480ed097ba9de14 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 11 Aug 2021 10:51:14 +0200
Subject: [PATCH] mm, slub: fix memory and cpu hotplug related lock ordering
 issues - fix

Make __kmem_cache_do_shrink static to silence "no previous prototype" warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 152487f84025..c9531e03addd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4393,7 +4393,7 @@ EXPORT_SYMBOL(kfree);
  * being allocated from last increasing the chance that the last objects
  * are freed in them.
  */
-int __kmem_cache_do_shrink(struct kmem_cache *s)
+static int __kmem_cache_do_shrink(struct kmem_cache *s)
 {
 	int node;
 	int i;
-- 
2.32.0

