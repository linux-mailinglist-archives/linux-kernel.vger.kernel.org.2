Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A683DA78B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbhG2P0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:26:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46148 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbhG2PYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:24:30 -0400
Date:   Thu, 29 Jul 2021 17:24:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627572242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uwv2h2GSM4shfGQAgPrAhSb9T6CgEPT3X+fH1BOdcKE=;
        b=iIure9/ogHNXLyPV3HtV/R2xk1yb4v28ngBBdA5+z1LE3qD7ZMmcjkEovxqo6Zv7Bk4qPC
        IrZQ684FFN8oKy8Be5gl+32xHyFXpnHt8GDJJOdr8gDCOGCUGKdUI9lOm/Ux4fZbDBIe3Q
        MaHT/tRibo+wiG325QTDL1mSctRTEQ+IAq+9oMIg+yk9XkOu9k9wVxkZdJhNOfHurAW7xh
        FIN5rJbFY8yucJjGJnYfqwWgMu8TfnCLcKbMjD19/C62lk5d1QuQmU9xrwQQxIvNJwt2wA
        gamM8wtl6cXvQ/iw+BPhBfaPE3Ol7Q9lAaaOF10HNLYzoI4lMT1eQbQQKaSbmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627572242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uwv2h2GSM4shfGQAgPrAhSb9T6CgEPT3X+fH1BOdcKE=;
        b=YO3GxbyN7hHbdRhhRL9ZkKWMyKrz6cnK8G3eLj7VWCR2yfJ1seJx/z/s3mPriOufdGfZ3t
        tzbuY1vXVGZJ06Aw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
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
Subject: Re: [PATCH v3 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210729152400.ed35ocv5jtpf3ns5@linutronix.de>
References: <20210729132132.19691-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-29 15:20:57 [+0200], Vlastimil Babka wrote:
> Changes since v2 [5]:

With PARTIAL enabled on top of -rc3:

| root@debpg:~# grep ^kmalloc-512 /proc/slabinfo
| kmalloc-512         3552   3552    512   32    4 : tunables    0    0    =
0 : slabdata    111    111      0
| root@debpg:~# hackbench -g80
| Running in process mode with 80 groups using 40 file descriptors each (=
=3D=3D 3200 tasks)
| Each sender will pass 100 messages of 100 bytes
| Time: 0.643
| root@debpg:~# grep ^kmalloc-512 /proc/slabinfo
| kmalloc-512       954080 954080    512   32    4 : tunables    0    0    =
0 : slabdata  29815  29815      0
| root@debpg:~# hackbench -g80
| Running in process mode with 80 groups using 40 file descriptors each (=
=3D=3D 3200 tasks)
| Each sender will pass 100 messages of 100 bytes
| Time: 0.604
| root@debpg:~# grep ^kmalloc-512 /proc/slabinfo
| kmalloc-512       1647904 1647904    512   32    4 : tunables    0    0  =
  0 : slabdata  51497  51497      0
| root@debpg:~# echo 1 > /sys/kernel/slab/kmalloc-512/shrink=20
| root@debpg:~# grep ^kmalloc-512 /proc/slabinfo
| kmalloc-512          640   1120    512   32    4 : tunables    0    0    =
0 : slabdata     35     35      0

otherwise a few more hackbench invocations without manual shirnk lead to
OOM-killer:
| oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),cpuset=3D/,mems_a=
llowed=3D0,task=3Dsystemd-logind,pid=3D1713,uid=3D0
| Out of memory: Killed process 1713 (systemd-logind) total-vm:15720kB, ano=
n-rss:956kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:72kB oom_score_adj=
:0
| Mem-Info:
| active_anon:56 inactive_anon:24782 isolated_anon:0
|  active_file:13 inactive_file:45 isolated_file:0
|  unevictable:0 dirty:0 writeback:0
|  slab_reclaimable:8749 slab_unreclaimable:894017
|  mapped:68 shmem:118 pagetables:28612 bounce:0
|  free:8407 free_pcp:36 free_cma:0
| Node 0 active_anon:224kB inactive_anon:99128kB active_file:260kB inactive=
_file:712kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:76=
4kB dirty:0kB writebaco
| Node 0 DMA free:15360kB min:28kB low:40kB high:52kB reserved_highatomic:0=
KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unev=
ictable:0kB writependiB
| lowmem_reserve[]: 0 1939 3915 3915
| Node 0 DMA32 free:11696kB min:3960kB low:5944kB high:7928kB reserved_high=
atomic:0KB active_anon:0kB inactive_anon:40740kB active_file:0kB inactive_f=
ile:4kB unevictable:0kB
| lowmem_reserve[]: 0 0 1975 1975
| Node 0 Normal free:5692kB min:4032kB low:6052kB high:8072kB reserved_high=
atomic:0KB active_anon:224kB inactive_anon:58440kB active_file:440kB inacti=
ve_file:100kB unevictaB
| lowmem_reserve[]: 0 0 0 0
| Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*10=
24kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
| Node 0 DMA32: 11*4kB (UM) 15*8kB (M) 20*16kB (UME) 12*32kB (UME) 7*64kB (=
ME) 5*128kB (UME) 4*256kB (UM) 6*512kB (ME) 4*1024kB (M) 1*2048kB (M) 0*409=
6kB =3D 12196kB
| Node 0 Normal: 324*4kB (UME) 221*8kB (UME) 60*16kB (UM) 24*32kB (UME) 5*6=
4kB (UM) 2*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 5368kB
| Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepage=
s_size=3D2048kB
| 189 total pagecache pages
| 0 pages in swap cache
| Swap cache stats: add 0, delete 0, find 0/0
| Free swap  =3D 0kB
| Total swap =3D 0kB
| 1048432 pages RAM
| 0 pages HighMem/MovableOnly
| 41108 pages reserved
| Unreclaimable slab info:
=E2=80=A6
| kmalloc-512          2144352KB    2144352KB

This does not happen if I disable SLUB_CPU_PARTIAL.

Sebastian
