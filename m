Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B315D3A44BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhFKPPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:15:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:63454 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhFKPPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:15:42 -0400
IronPort-SDR: wxehDXLccQrIX+4bClvdnGYcHENEIvWSNAVis7v4RFzj7owJOuZ5xcYxGNqLDnFbJqOF1/i+wu
 YU8cO8/WFMFA==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="291174246"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="xz'?scan'208";a="291174246"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 08:13:43 -0700
IronPort-SDR: RPpEVPmUiiV9/teUEXCHP3X6XBfMMRjBlDByNK8h1MpQsDM7Jz8FgEaPuR8K1RiGX5+zS4Eeo4
 33600QEq5xWQ==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="xz'?scan'208";a="483298795"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 08:13:39 -0700
Date:   Fri, 11 Jun 2021 23:29:59 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [init/initramfs.c] e7cb072eb9: invoked_oom-killer:gfp_mask=0x
Message-ID: <20210611152959.GA29971@xsang-OptiPlex-9020>
References: <20210607144419.GA23706@xsang-OptiPlex-9020>
 <d28354fd-0f72-559d-771f-fb2a80b51b05@rasmusvillemoes.dk>
 <20210611084817.GB26476@xsang-OptiPlex-9020>
 <db82c1c9-edfe-6ee2-c403-d6740e8c46c6@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <db82c1c9-edfe-6ee2-c403-d6740e8c46c6@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi Rasmus,

On Fri, Jun 11, 2021 at 11:20:18AM +0200, Rasmus Villemoes wrote:
> On 11/06/2021 10.48, Oliver Sang wrote:
> > hi Rasmus,
> > 
> > On Tue, Jun 08, 2021 at 09:42:58AM +0200, Rasmus Villemoes wrote:
> >> On 07/06/2021 16.44, kernel test robot wrote:
> >>>
> 
> 
> >> Also, I don't have 16G to give to a virtual machine. I tried running the
> >> bzImage with that modules.cgz under qemu with some naive parameters just
> >> to get some output [1], but other than failing because there's no rootfs
> >> to mount (as expected), I only managed to make it fail when providing
> >> too little memory (the .cgz is around 70M, decompressed about 200M -
> >> giving '-m 1G' to qemu works fine). You mention the vmalloc= argument,
> >> but I can't make the decompression fail when passing either vmalloc=128M
> >> or vmalloc=512M or no vmalloc= at all.
> > 
> > sorry about this. we also tried to follow exactly above steps to test on
> > some local machine (8G memory), but cannot reproduce. we are analyzing
> > what's the diference in our automaion run in test cluster, which reproduced
> > the issue consistently. will update you when we have findings.
> 
> OK. It's really odd that providing the VM with _more_ memory makes it
> fail (other then the obvious failure in the other direction when there's
> simply not enough memory for the unpacked initramfs itself). But
> unfortunately that also sounds like I won't be able to reproduce with
> the HW I have.
> 
> >> As an extra data point, what happens if you add initramfs_async=0 to the
> >> command line?
> > 
> > yes, we tested this before sending out the report. the issue gone
> > if initramfs_async=0 is added.
> 
> Hm. Sounds like some initcall after rootfs_initcall time must
> allocate/hog a lot of memory, perhaps with some heuristic depending on
> how much is available.
> 
> Can you try with initcall_debug=1? I think that should produce a lot of
> output, hopefully that would make it possible to see which initcalls
> have been done just prior to (or while) the initramfs unpacking hits ENOMEM.

thanks a lot for guidance!

by several jobs with initcall_debug=1, the oom happens consistently after
"calling  panel_init_module"

below is an example, and detail dmesg.xz attached:

[   15.120470] calling  img_ascii_lcd_driver_init+0x0/0x16 @ 1
[   15.122305] initcall img_ascii_lcd_driver_init+0x0/0x16 returned 0 after 128 usecs
[   15.124660] calling  panel_init_module+0x0/0x1f3 @ 1
[   19.941826] kworker/u4:0 invoked oom-killer: gfp_mask=0x40cd0(GFP_KERNEL|__GFP_COMP|__GFP_RECLAIMABLE), order=0, oom_score_adj=0
[   19.967679] CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 5.12.0-11533-ge7cb072eb988 #1
[   19.968362] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.968362] Workqueue: events_unbound async_run_entry_fn
[   19.968362] Call Trace:
[   19.968362]  dump_stack+0x69/0x85
[   19.968362]  dump_header+0x57/0x3ff
[   19.968362]  ? lock_release+0xa8/0x2b0
[   19.968362]  ? out_of_memory+0x310/0x4d0
[   19.968362]  out_of_memory.cold+0x2b/0x6f
[   19.968362]  __alloc_pages_slowpath+0xa3a/0xbb0
[   19.968362]  __alloc_pages+0x2a6/0x320
[   19.968362]  allocate_slab+0x242/0x300
[   19.968362]  ___slab_alloc+0x1e3/0x740
[   19.968362]  ? alloc_inode+0x77/0x80
[   19.968362]  ? lock_is_held_type+0x8a/0xf0
[   19.968362]  __slab_alloc+0x27/0x60
[   19.968362]  ? __slab_alloc+0x27/0x60
[   19.968362]  ? alloc_inode+0x77/0x80
[   19.968362]  kmem_cache_alloc+0x24d/0x290
[   19.968362]  ? alloc_inode+0x77/0x80
[   19.968362]  alloc_inode+0x77/0x80
[   19.968362]  new_inode_pseudo+0xf/0x50
[   19.968362]  new_inode+0x17/0x30
[   19.968362]  ramfs_get_inode+0x35/0x150
[   19.968362]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[   19.968362]  ? trace_hardirqs_on+0x48/0xf0
[   19.968362]  ? _raw_spin_unlock_irqrestore+0x38/0x60
[   19.968362]  ? lock_is_held_type+0x8a/0xf0
[   19.968362]  ramfs_mknod+0x36/0xa0
[   19.968362]  ? ramfs_mknod+0x36/0xa0
[   19.968362]  ? trace_preempt_on+0x36/0xd0
[   19.968362]  ? d_add+0xe4/0x1c0
[   19.968362]  ? ramfs_mkdir+0x50/0x50
[   19.968362]  ramfs_create+0x20/0x30
[   19.968362]  ? ramfs_create+0x20/0x30
[   19.968362]  path_openat+0x594/0xef0
[   19.968362]  do_filp_open+0x84/0xf0
[   19.968362]  ? lock_is_held_type+0x8a/0xf0
[   19.968362]  file_open_name+0xaf/0x1b0
[   19.968362]  filp_open+0x27/0x50
[   19.968362]  do_name+0xbc/0x27c
[   19.968362]  write_buffer+0x22/0x31
[   19.968362]  flush_buffer+0x26/0x74
[   19.968362]  __gunzip+0x204/0x28a
[   19.968362]  ? decompress_method+0x3b/0x3b
[   19.968362]  ? __gunzip+0x28a/0x28a
[   19.968362]  gunzip+0x16/0x18
[   19.968362]  ? write_buffer+0x31/0x31
[   19.968362]  ? initrd_load+0x23d/0x23d
[   19.968362]  unpack_to_rootfs+0x15d/0x273
[   19.968362]  ? write_buffer+0x31/0x31
[   19.968362]  ? initrd_load+0x23d/0x23d
[   19.968362]  do_populate_rootfs+0x5f/0x13f
[   19.968362]  async_run_entry_fn+0x24/0xb0
[   19.968362]  process_one_work+0x1ee/0x540
[   19.968362]  worker_thread+0x15e/0x3c0
[   19.968362]  kthread+0x109/0x140
[   19.968362]  ? process_one_work+0x540/0x540
[   19.968362]  ? kthread_insert_work_sanity_check+0x60/0x60
[   19.968362]  ret_from_fork+0x19/0x30
[   20.217543] Mem-Info:
[   20.218400] active_anon:0 inactive_anon:0 isolated_anon:0
[   20.218400]  active_file:0 inactive_file:0 isolated_file:0
[   20.218400]  unevictable:85038 dirty:0 writeback:0
[   20.218400]  slab_reclaimable:7910 slab_unreclaimable:1402
[   20.218400]  mapped:0 shmem:0 pagetables:4 bounce:0
[   20.218400]  free:3987860 free_pcp:117 free_cma:0
[   20.226846] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:340152kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:464kB pagetables:16kB all_unreclaimable? yes
[   20.233380] DMA free:572kB min:2296kB low:2356kB high:2416kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4664kB writepending:0kB present:15992kB managed:15916kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   20.240158] lowmem_reserve[]: 0 48 15946 15946
[   20.241518] Normal free:2816kB min:2816kB low:3008kB high:3200kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:10008kB writepending:0kB present:481272kB managed:49344kB mlocked:0kB bounce:0kB free_pcp:28kB local_pcp:16kB free_cma:0kB
[   20.248350] lowmem_reserve[]: 0 0 127183 127183
[   20.249784] HighMem free:15948052kB min:512kB low:64120kB high:127728kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:325496kB writepending:0kB present:16279432kB managed:16279432kB mlocked:0kB bounce:0kB free_pcp:440kB local_pcp:208kB free_cma:0kB
[   20.257038] lowmem_reserve[]: 0 0 0 0
[   20.258272] DMA: 0*4kB 0*8kB 1*16kB (E) 1*32kB (E) 0*64kB 0*128kB 0*256kB 1*512kB (E) 0*1024kB 0*2048kB 0*4096kB = 560kB
[   20.261437] Normal: 12*4kB (UME) 4*8kB (UM) 3*16kB (UM) 2*32kB (UE) 1*64kB (U) 2*128kB (UM) 1*256kB (M) 2*512kB (ME) 1*1024kB (U) 0*2048kB 0*4096kB = 2816kB
[   20.265294] HighMem: 1*4kB (U) 0*8kB 1*16kB (U) 0*32kB 0*64kB 2*128kB (UM) 2*256kB (UM) 1*512kB (M) 1*1024kB (M) 2*2048kB (M) 3892*4096kB (M) = 15948052kB
[   20.269081] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[   20.271583] 85050 total pagecache pages
[   20.272767] 4194174 pages RAM
[   20.273839] 4069858 pages HighMem/MovableOnly
[   20.275209] 108001 pages reserved
[   20.276264] Tasks state (memory values in pages):
[   20.277590] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[   20.280179] Out of memory and no killable processes...
[   20.281709] Kernel panic - not syncing: System is deadlocked on memory



> 
> Thanks,
> Rasmus

--Nq2Wo0NMKNjxTN9z
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
scRn+wIAAAAABFla

--Nq2Wo0NMKNjxTN9z--
