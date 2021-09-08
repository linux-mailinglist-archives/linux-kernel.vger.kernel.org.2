Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C620C4040AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhIHVwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 17:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbhIHVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 17:52:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1E9C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 14:51:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g22so4850811edy.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 14:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lOg0eq9m0ngC6ZvpqCMi5DobNuxJwzYIoTh8hAOyJJI=;
        b=pI3iFRPRR7IxXKiMRd4Q/4yo970KKKt5QN52J3RSbLpeoc4SEplV7Oq7pFJ6vCpvjO
         cMr5iH2bpD2vbNIeGljQFxHmOMW+4e8cE3urS7pK5qd4Kkec7IQmr+jTBA7yO6QDutUK
         5gjAbe+j3Z8edT8HoLxAvF9N5rePZA22eGx049gNVP+zMT52lwvpKfCrQwly3OGNHVXv
         kfT2wnNsfmDkYo8uHp5ng4hy+92nVprEHEdRdKUw5ZnSN0d++/hs3EcQG2IpLOsLglrf
         kM3xKXDMx7fVUItcgmtdJjVHsZDAL4FC2+FpSyuG0/+CsQ89HUkzkkCpo/5sZyWpR8iO
         yD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lOg0eq9m0ngC6ZvpqCMi5DobNuxJwzYIoTh8hAOyJJI=;
        b=uH+uuu9pbKyEhul+e5mUWB62ggw/kw9NiuiD2MWBak02lq9E5a9u7QCV8rlRYE72To
         r/xefQjqIZ18n2PfoOBv5k6J8tXxLfwrbajh4w0xKGux4HIwVsx5IhWYwiKHNEzGthoP
         SW5LpNxRP9z+HcuPWFrb5zoxLUVV2xl7fBBufgC4TxzlLed5C7EXX7F3ETDTD7CZdnEP
         pFDL3HfI2LaQujNGUDPxyGi3PBjYNFalcuq7fv7EG1B0m9AB9uwWGV2cGnHA+VTU2xw0
         RNlcjqNJxIZnyb89kZkE4FlraEqEC8dltkIXY51P+qOcB+8vDuOzGSnU8qJAYkrsnAts
         Ft2Q==
X-Gm-Message-State: AOAM531kDZhN/YqLMhm/S0+e+tfU3R8DntNKHHITDd0Km2p1ij/HWufs
        XOhCFKIG9qzqTZfR1/T7sOc2gzg2rpoRmntAkRl+3pfc
X-Google-Smtp-Source: ABdhPJz/qmVMGpvj1S8/yftdjlo204SKB98R6t6+v10kcPKUJUGNAUxc2a5jYYiPoqbTE0MCREyklIjZPj4PxGjcYEk=
X-Received: by 2002:aa7:c882:: with SMTP id p2mr429479eds.46.1631137875036;
 Wed, 08 Sep 2021 14:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210906121200.57905-3-rongwei.wang@linux.alibaba.com> <CAHbLzkrrXyPojzF1sNXw=m3TZuYfybhz-Gy-SCtbovH+Oa4t+A@mail.gmail.com>
 <44BE85B4-692C-41E8-B5A0-C1E0B0272ACD@linux.alibaba.com>
In-Reply-To: <44BE85B4-692C-41E8-B5A0-C1E0B0272ACD@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 8 Sep 2021 14:51:02 -0700
Message-ID: <CAHbLzkrnEQkOsr=uUBx=aHP07pu5kMgFLvCpwNjgCunYJfo=Pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm, thp: bail out early in collapse_file for
 writeback page
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cfijalkovich@google.com, song@kernel.org,
        william.kucharski@oracle.com, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 7:16 PM Rongwei Wang
<rongwei.wang@linux.alibaba.com> wrote:
>
>
>
> On Sep 8, 2021, at 12:56 AM, Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, Sep 6, 2021 at 5:12 AM Rongwei Wang
> <rongwei.wang@linux.alibaba.com> wrote:
>
>
> Currently collapse_file does not explicitly check PG_writeback, instead,
> page_has_private and try_to_release_page are used to filter writeback
> pages. This does not work for xfs with blocksize equal to or larger
>
>
> I'm not quite sure if using try_to_release() to check the writeback
> flag is on purpose or not, but it should be better to check the flag
> more explicitly.
>
> Uh-huh. It is sure that try_to_release_page will check the writeback flag
> of page. But the place where check the writeback flag using:
>
> If (page_has_private(page) &&
> !try_to_release_page(page, GFP_KERNEL)) {
> ...
> }
>
> The original code will miss the page which in writeback status but has no=
 private data.
> The XFS case that above mentioned belongs to.
>
> Thanks!
>
>
> than pagesize, because in such case xfs has no page->private.
>
> This makes collapse_file bail out early for writeback page. Otherwise,
> xfs end_page_writeback will panic as follows.
>
> [ 6411.448211] page:fffffe00201bcc80 refcount:0 mapcount:0 mapping:ffff00=
03f88c86a8 index:0x0 pfn:0x84ef32
> [ 6411.448304] aops:xfs_address_space_operations [xfs] ino:30000b7 dentry=
 name:"libtest.so"
> [ 6411.448312] flags: 0x57fffe0000008027(locked|referenced|uptodate|activ=
e|writeback)
> [ 6411.448317] raw: 57fffe0000008027 ffff80001b48bc28 ffff80001b48bc28 ff=
ff0003f88c86a8
> [ 6411.448321] raw: 0000000000000000 0000000000000000 00000000ffffffff ff=
ff0000c3e9a000
> [ 6411.448324] page dumped because: VM_BUG_ON_PAGE(((unsigned int) page_r=
ef_count(page) + 127u <=3D 127u))
> [ 6411.448327] page->mem_cgroup:ffff0000c3e9a000
> [ 6411.448340] ------------[ cut here ]------------
> [ 6411.448343] kernel BUG at include/linux/mm.h:1212!
> [ 6411.449288] Internal error: Oops - BUG: 0 [#1] SMP
> [ 6411.449786] Modules linked in:
> [ 6411.449790] BUG: Bad page state in process khugepaged  pfn:84ef32
> [ 6411.450143]  xfs(E)
> [ 6411.450459] page:fffffe00201bcc80 refcount:0 mapcount:0 mapping:0 inde=
x:0x0 pfn:0x84ef32
> [ 6411.451361]  libcrc32c(E) rfkill(E) aes_ce_blk(E) crypto_simd(E) crypt=
d(E) aes_ce_cipher(E) crct10dif_ce(E) ghash_ce(E) sha1_ce(E) uio_pdrv_genir=
q(E) uio(E) vfat(E) nfsd(E) fat(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace=
(E) sunrpc(E) sch_fq_codel(E) ip_tables(E) ext4(E) mbcache(E) jbd2(E) virti=
o_net(E) net_failover(E) virtio_blk(E) failover(E) sha2_ce(E) sha256_arm64(=
E) virtio_mmio(E) virtio_pci(E) virtio_ring(E) virtio(E)
> [ 6411.451387] CPU: 25 PID: 0 Comm: swapper/25 Kdump: loaded Tainted: G  =
      W   E
> [ 6411.451389] pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=3D--)
> [ 6411.451393] pc : end_page_writeback+0x1c0/0x214
> [ 6411.451394] lr : end_page_writeback+0x1c0/0x214
> [ 6411.451395] sp : ffff800011ce3cc0
> [ 6411.451396] x29: ffff800011ce3cc0 x28: 0000000000000000
> [ 6411.451398] x27: ffff000c04608040 x26: 0000000000000000
> [ 6411.451399] x25: ffff000c04608040 x24: 0000000000001000
> [ 6411.451401] x23: ffff0003f88c8530 x22: 0000000000001000
> [ 6411.451403] x21: ffff0003f88c8530 x20: 0000000000000000
> [ 6411.451404] x19: fffffe00201bcc80 x18: 0000000000000030
> [ 6411.451406] x17: 0000000000000000 x16: 0000000000000000
> [ 6411.451407] x15: ffff000c018f9760 x14: ffffffffffffffff
> [ 6411.451409] x13: ffff8000119d72b0 x12: ffff8000119d6ee3
> [ 6411.451410] x11: ffff8000117b69b8 x10: 00000000ffff8000
> [ 6411.451412] x9 : ffff800010617534 x8 : 0000000000000000
> [ 6411.451413] x7 : ffff8000114f69b8 x6 : 000000000000000f
> [ 6411.451415] x5 : 0000000000000000 x4 : 0000000000000000
> [ 6411.451416] x3 : 0000000000000400 x2 : 0000000000000000
> [ 6411.451418] x1 : 0000000000000000 x0 : 0000000000000000
> [ 6411.451420] Call trace:
> [ 6411.451421]  end_page_writeback+0x1c0/0x214
> [ 6411.451424]  iomap_finish_page_writeback+0x13c/0x204
> [ 6411.451425]  iomap_finish_ioend+0xe8/0x19c
> [ 6411.451426]  iomap_writepage_end_bio+0x38/0x50
> [ 6411.451427]  bio_endio+0x168/0x1ec
> [ 6411.451430]  blk_update_request+0x278/0x3f0
> [ 6411.451432]  blk_mq_end_request+0x34/0x15c
> [ 6411.451435]  virtblk_request_done+0x38/0x74 [virtio_blk]
> [ 6411.451437]  blk_done_softirq+0xc4/0x110
> [ 6411.451439]  __do_softirq+0x128/0x38c
> [ 6411.451441]  __irq_exit_rcu+0x118/0x150
> [ 6411.451442]  irq_exit+0x1c/0x30
> [ 6411.451445]  __handle_domain_irq+0x8c/0xf0
> [ 6411.451446]  gic_handle_irq+0x84/0x108
> [ 6411.451447]  el1_irq+0xcc/0x180
> [ 6411.451448]  arch_cpu_idle+0x18/0x40
> [ 6411.451450]  default_idle_call+0x4c/0x1a0
> [ 6411.451453]  cpuidle_idle_call+0x168/0x1e0
> [ 6411.451454]  do_idle+0xb4/0x104
> [ 6411.451455]  cpu_startup_entry+0x30/0x9c
> [ 6411.451458]  secondary_start_kernel+0x104/0x180
> [ 6411.451460] Code: d4210000 b0006161 910c8021 94013f4d (d4210000)
> [ 6411.451462] ---[ end trace 4a88c6a074082f8c ]---
> [ 6411.451464] Kernel panic - not syncing: Oops - BUG: Fatal exception in=
 interrupt
>
> Fixes: eb6ecbed0aa2 ("mm, thp: relax the VM_DENYWRITE constraint on file-=
backed THPs")
> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> ---
> mm/khugepaged.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 045cc57..529b117 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1798,7 +1798,8 @@ static void collapse_file(struct mm_struct *mm,
>                        goto out_unlock;
>                }
>
> -               if (!is_shmem && PageDirty(page)) {
> +               if (!is_shmem && (PageDirty(page) ||
> +                                 PageWriteback(page))) {
>
>
> Why not check the writeback flag in the place before taking page lock too=
?
>
> Thanks! Your words remind me. I will double check the writeback flag befo=
re
> and after taking page lock. Likes:
>
> +                       } else if (PageWriteback(page)) {
> +                               xas_unlock_irq(&xas);
> +                               result =3D SCAN_FAIL;
> +                               goto xa_unlocked;
>                         } else if (trylock_page(page)) {
>                                 get_page(page);
>                                 xas_unlock_irq(&xas);
> @@ -1798,7 +1802,8 @@ static void collapse_file(struct mm_struct *mm,
>                         goto out_unlock;
>                 }
>
> -               if (!is_shmem && PageDirty(page)) {
> +               if (!is_shmem && (PageDirty(page) ||
> +                                 PageWriteback(page))) {

Yeah, this is what I meant. Thanks.

>
> Thanks!
>
>
>                        /*
>                         * khugepaged only works on read-only fd, so this
>                         * page is dirty because it hasn't been flushed
> --
> 1.8.3.1
>
>
