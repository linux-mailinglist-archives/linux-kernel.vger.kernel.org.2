Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50C23DA790
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbhG2P1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:27:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41700 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhG2P1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:27:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4475B223F2;
        Thu, 29 Jul 2021 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627572439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Su0HafVKInKv9fAX9yenEdE8BQ0rZJiMRpS8/sYSBpM=;
        b=2m4o1jAutkkxbCchsC0/ltO7ri+MQNeN+iSk68eVk2gzxMCZsIv7wvePctYX9JCJXWTI0+
        mK5wbsntXlQoBxe14uUivf/4DxfHb72y0yenrHybVkmlZUrZzxwAJeyCG1UVicUHOGTXDw
        oCtcZDRfVEh30WKY9+d3xzQy5qCceRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627572439;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Su0HafVKInKv9fAX9yenEdE8BQ0rZJiMRpS8/sYSBpM=;
        b=e4hdKnOoWeLEXkI5lFQ17CM/YDwiDSd4BXl+XgROO0ln/RybY94SV7GFqjg6L3/Z6fYcMY
        I1MNYr2IqhrwIsBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1CAB313738;
        Thu, 29 Jul 2021 15:27:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UUxiBtfIAmE5LgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 15:27:19 +0000
Subject: Re: [PATCH v3 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210729132132.19691-1-vbabka@suse.cz>
 <20210729152400.ed35ocv5jtpf3ns5@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <803269ba-d4f4-6016-067f-8f9e02b3c794@suse.cz>
Date:   Thu, 29 Jul 2021 17:27:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729152400.ed35ocv5jtpf3ns5@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 5:24 PM, Sebastian Andrzej Siewior wrote:
> On 2021-07-29 15:20:57 [+0200], Vlastimil Babka wrote:
>> Changes since v2 [5]:
> 
> With PARTIAL enabled on top of -rc3:

Is that also PREEMPT_RT? Interesting...

> | root@debpg:~# grep ^kmalloc-512 /proc/slabinfo
> | kmalloc-512         3552   3552    512   32    4 : tunables    0    0    0 : slabdata    111    111      0
> | root@debpg:~# hackbench -g80
> | Running in process mode with 80 groups using 40 file descriptors each (== 3200 tasks)
> | Each sender will pass 100 messages of 100 bytes
> | Time: 0.643
> | root@debpg:~# grep ^kmalloc-512 /proc/slabinfo
> | kmalloc-512       954080 954080    512   32    4 : tunables    0    0    0 : slabdata  29815  29815      0
> | root@debpg:~# hackbench -g80
> | Running in process mode with 80 groups using 40 file descriptors each (== 3200 tasks)
> | Each sender will pass 100 messages of 100 bytes
> | Time: 0.604
> | root@debpg:~# grep ^kmalloc-512 /proc/slabinfo
> | kmalloc-512       1647904 1647904    512   32    4 : tunables    0    0    0 : slabdata  51497  51497      0
> | root@debpg:~# echo 1 > /sys/kernel/slab/kmalloc-512/shrink 
> | root@debpg:~# grep ^kmalloc-512 /proc/slabinfo
> | kmalloc-512          640   1120    512   32    4 : tunables    0    0    0 : slabdata     35     35      0
> 
> otherwise a few more hackbench invocations without manual shirnk lead to
> OOM-killer:
> | oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,task=systemd-logind,pid=1713,uid=0
> | Out of memory: Killed process 1713 (systemd-logind) total-vm:15720kB, anon-rss:956kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:72kB oom_score_adj:0
> | Mem-Info:
> | active_anon:56 inactive_anon:24782 isolated_anon:0
> |  active_file:13 inactive_file:45 isolated_file:0
> |  unevictable:0 dirty:0 writeback:0
> |  slab_reclaimable:8749 slab_unreclaimable:894017
> |  mapped:68 shmem:118 pagetables:28612 bounce:0
> |  free:8407 free_pcp:36 free_cma:0
> | Node 0 active_anon:224kB inactive_anon:99128kB active_file:260kB inactive_file:712kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:764kB dirty:0kB writebaco
> | Node 0 DMA free:15360kB min:28kB low:40kB high:52kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writependiB
> | lowmem_reserve[]: 0 1939 3915 3915
> | Node 0 DMA32 free:11696kB min:3960kB low:5944kB high:7928kB reserved_highatomic:0KB active_anon:0kB inactive_anon:40740kB active_file:0kB inactive_file:4kB unevictable:0kB
> | lowmem_reserve[]: 0 0 1975 1975
> | Node 0 Normal free:5692kB min:4032kB low:6052kB high:8072kB reserved_highatomic:0KB active_anon:224kB inactive_anon:58440kB active_file:440kB inactive_file:100kB unevictaB
> | lowmem_reserve[]: 0 0 0 0
> | Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
> | Node 0 DMA32: 11*4kB (UM) 15*8kB (M) 20*16kB (UME) 12*32kB (UME) 7*64kB (ME) 5*128kB (UME) 4*256kB (UM) 6*512kB (ME) 4*1024kB (M) 1*2048kB (M) 0*4096kB = 12196kB
> | Node 0 Normal: 324*4kB (UME) 221*8kB (UME) 60*16kB (UM) 24*32kB (UME) 5*64kB (UM) 2*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 5368kB
> | Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
> | 189 total pagecache pages
> | 0 pages in swap cache
> | Swap cache stats: add 0, delete 0, find 0/0
> | Free swap  = 0kB
> | Total swap = 0kB
> | 1048432 pages RAM
> | 0 pages HighMem/MovableOnly
> | 41108 pages reserved
> | Unreclaimable slab info:
> …
> | kmalloc-512          2144352KB    2144352KB
> 
> This does not happen if I disable SLUB_CPU_PARTIAL.
> 
> Sebastian
> 

