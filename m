Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3584F331B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhCIACJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhCIABr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:01:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B7C16527E;
        Tue,  9 Mar 2021 00:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615248106;
        bh=xeqxDdYK18R1n0feuHusfVZYz5TdTUy3aLCw7hpI/SU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OijRaZoB4HY4hVZ5/77kt8rRf822M9ZQxDr4dVHscKtagt8fBfPrPFGGvXJQKZ+0A
         J3M+U5FlKM67MfX8dHKQ3bIbPM9wVPh5l0kikHcSDWEcyZhXH7Llh5B+vKurotCpHs
         2QCYD5Tdi8B8mg9CLbfYjbcbk0mJBaqxgF2UWaqnSmMojKtt6ZXrSiCGq0KBwi8tsh
         Xaie7EQcsCaQTvkfREgQD86GDQ0F3kjpYCuYVP0WHrv0HHJ0hv1pcMjYl2qnh3VNfp
         40TXVV1fZVpjOherMMf/CE6T3wn6yOY5qqsopJxuySACLukJPybQF0t2QA7k2yb29O
         no+jZBWRC8g2A==
Date:   Mon, 8 Mar 2021 16:01:45 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress: add compress_inode to
 cache compressed blockst
Message-ID: <YEa66ekikyuPWSyd@google.com>
References: <20210202080056.51658-1-yuchao0@huawei.com>
 <46e9924c-0086-cd2a-2e93-7149b92ba27e@huawei.com>
 <YDsleDjeIcpuBXKA@google.com>
 <YEFBAuP26t0RzVHZ@google.com>
 <01a0ff76-6fa7-3196-8760-e7f6f163ef64@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a0ff76-6fa7-3196-8760-e7f6f163ef64@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05, Chao Yu wrote:
> On 2021/3/5 4:20, Jaegeuk Kim wrote:
> > On 02/27, Jaegeuk Kim wrote:
> > > On 02/04, Chao Yu wrote:
> > > > Jaegeuk,
> > > > 
> > > > On 2021/2/2 16:00, Chao Yu wrote:
> > > > > -	for (i = 0; i < dic->nr_cpages; i++) {
> > > > > +	for (i = 0; i < cc->nr_cpages; i++) {
> > > > >    		struct page *page = dic->cpages[i];
> > > > 
> > > > por_fsstress still hang in this line?
> > > 
> > > I'm stuck on testing the patches, since the latest kernel is panicking somehow.
> > > Let me update later, once I can test a bit. :(
> > 
> > It seems this works without error.
> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=4e6e1364dccba80ed44925870b97fbcf989b96c9
> 
> Ah, good news.
> 
> Thanks for helping to test the patch. :)

Hmm, I hit this again. Let me check w/o compress_cache back. :(

[159210.201131] ------------[ cut here ]------------
[159210.204241] kernel BUG at fs/f2fs/compress.c:1082!
[159210.207321] invalid opcode: 0000 [#1] SMP PTI
[159210.209407] CPU: 4 PID: 2753477 Comm: kworker/u16:2 Tainted: G           OE     5.12.0-rc1-custom #1
[159210.212737] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[159210.224800] Workqueue: writeback wb_workfn (flush-252:16)
[159210.226851] RIP: 0010:prepare_compress_overwrite+0x4c0/0x760 [f2fs]
[159210.229506] Code: 8b bf 90 0a 00 00 be 40 0d 00 00 e8 4a 92 4f c4 49 89 44 24 18 48 85 c0 0f 84 85 02 00 00 41 8b 54 24 10 e9 c5 fb ff ff 0f 0b <0f> 0b 41 8b 44 24 20 85 c0 0f 84 2a ff ff ff 48 8
[159210.236311] RSP: 0018:ffff9fa782177858 EFLAGS: 00010246
[159210.238517] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[159210.240734] RDX: 000000000000001c RSI: 0000000000000000 RDI: 0000000000000000
[159210.242941] RBP: ffff9fa7821778f0 R08: ffff93b9c89cb232 R09: 0000000000000003
[159210.245107] R10: ffffffff86873420 R11: 0000000000000001 R12: ffff9fa782177900
[159210.247319] R13: ffff93b906dca578 R14: 000000000000031c R15: 0000000000000000
[159210.249492] FS:  0000000000000000(0000) GS:ffff93b9fbd00000(0000) knlGS:0000000000000000
[159210.254724] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[159210.258709] CR2: 00007f0367d33738 CR3: 000000012bc0c004 CR4: 0000000000370ee0
[159210.261608] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[159210.264614] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[159210.267476] Call Trace:
[159210.269075]  ? f2fs_compress_write_end+0xa2/0x100 [f2fs]
[159210.271165]  f2fs_prepare_compress_overwrite+0x5f/0x80 [f2fs]
[159210.273017]  f2fs_write_cache_pages+0x468/0x8a0 [f2fs]
[159210.274848]  f2fs_write_data_pages+0x2a4/0x2f0 [f2fs]
[159210.276612]  ? from_kgid+0x12/0x20
[159210.277994]  ? f2fs_update_inode+0x3cb/0x510 [f2fs]
[159210.279748]  do_writepages+0x38/0xc0
[159210.281183]  ? f2fs_write_inode+0x11c/0x300 [f2fs]
[159210.282877]  __writeback_single_inode+0x44/0x2a0
[159210.284526]  writeback_sb_inodes+0x223/0x4d0
[159210.286105]  __writeback_inodes_wb+0x56/0xf0
[159210.287740]  wb_writeback+0x1dd/0x290
[159210.289182]  wb_workfn+0x309/0x500
[159210.290553]  process_one_work+0x220/0x3c0
[159210.292048]  worker_thread+0x53/0x420
[159210.293403]  kthread+0x12f/0x150
[159210.294716]  ? process_one_work+0x3c0/0x3c0
[159210.296204]  ? __kthread_bind_mask+0x70/0x70
[159210.297702]  ret_from_fork+0x22/0x30


> 
> Thanks,
> 
> > 
> > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > >    		block_t blkaddr;
> > > > >    		struct bio_post_read_ctx *ctx;
> > > > > @@ -2201,6 +2207,14 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
> > > > >    		blkaddr = data_blkaddr(dn.inode, dn.node_page,
> > > > >    						dn.ofs_in_node + i + 1);
> > > > > +		f2fs_wait_on_block_writeback(inode, blkaddr);
> > > > > +
> > > > > +		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
> > > > > +			if (atomic_dec_and_test(&dic->remaining_pages))
> > > > > +				f2fs_decompress_cluster(dic);
> > > > > +			continue;
> > > > > +		}
> > > > > +
> > > 
> > > 
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> > 
