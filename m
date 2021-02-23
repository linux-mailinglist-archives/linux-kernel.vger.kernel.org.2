Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71F13224E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 05:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhBWEXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 23:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhBWEXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 23:23:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83262C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 20:22:24 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p21so9152586lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 20:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyJORd7FWEZsXSaJofrLR3ruQAyi/9i2o1KfD9q8gl4=;
        b=udwJ/mPHPi6kGHPc4qGwVsZe+0iq6dfraQjjZ1IeOVNbsgZ3Q7jzZq7VxPA1cjlrfo
         WrmCEkFMHiUl8Mb2v/hzLdsPKOpL3aSHA29CTSo1n6s9xjFCvfvzIVZNlYveNBEIqGul
         slceZzVzPGAfvOnvZrnSBrllQvbgwaOdS1AEYEkIC1X4HiGiQOpTESMUvqUx77GHl5IG
         /URO2gpIraDRfU2rc3sJGttZYGpDywPZDbYaamGRhezsHeyn+CM1/ahdjvlaOfSJYjtZ
         85rz7B0FdL+rpTuG/s1mUBSoDu9+9kARPESxrxzNH0JnO820Ru0vPVr1mhuKItn5Dk0K
         5riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyJORd7FWEZsXSaJofrLR3ruQAyi/9i2o1KfD9q8gl4=;
        b=se13H4yYnR3PaIRX2fJuE0KHKCvefmJK3z+uKoEMo1CX1Kb/O/CGl2bsta0qbPi8gY
         mc8c8ayzo5CPFhk9QAWagWWhi7c/94slYMwQ9lGRwN7hmhbLE0F46YC5XK3Z5fzCiEIv
         4flwaEiVd9EKteFcC2M2+T1gZQZ6kzOVIxVG2oqX185he7IKUBIb1NxQgX5FdYH7snUu
         qCxtP7sin4Wjq2EsFRAW4hxRz8LJEXeZHzL1Iu3d43xKv2GodS9eU9B/EN8Lut6pQGv8
         O+d31E3xvXMnD1vY1TlYg7nZ0xfhc+8d+PZRjw/dS00dRTLptulIIJpQpWDVTCdfBGBa
         4twg==
X-Gm-Message-State: AOAM533KEgvQO16cbtfMLedIswmCYhG7JBTERRVEmhWW9KeSajq5xCxO
        UU5mk2tGJcgqaqe4ni/jtx4HIJjXRq+5kiPpFpuGFA==
X-Google-Smtp-Source: ABdhPJwnzf3xZkTdEPBen4/E5Ue1mtnRgpwCAFV1b9sdyr74SzSdawA1ZvflTvKLG75jVzNrX3gU0B04fFSoJ9MtkYk=
X-Received: by 2002:a05:6512:33b8:: with SMTP id i24mr15205981lfg.7.1614054142873;
 Mon, 22 Feb 2021 20:22:22 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
 <BYAPR04MB496566A72BC5641BAC7D279F86809@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB496566A72BC5641BAC7D279F86809@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Feb 2021 20:22:09 -0800
Message-ID: <CALAqxLXWs0GUZv=zWFK8hvnnkEgfMXvr_tZPyPaPBra=k9yf-A@mail.gmail.com>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     David Anderson <dvander@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 7:39 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 2/22/21 19:07, John Stultz wrote:
> > [   34.784901] ueventd: LoadWithAliases was unable to load platform:regulatory
> > [   34.785313]  bio_alloc_bioset+0x14/0x230
> > [   34.796189]  bio_clone_fast+0x28/0x80
> > [   34.799848]  bio_split+0x50/0xd0
> > [   34.803072]  blk_crypto_fallback_encrypt_bio+0x2ec/0x5e8
> > [   34.808384]  blk_crypto_fallback_bio_prep+0xfc/0x140
> > [   34.813345]  __blk_crypto_bio_prep+0x13c/0x150
> > [   34.817784]  submit_bio_noacct+0x3c0/0x548
> > [   34.821880]  submit_bio+0x48/0x200
> > [   34.825278]  ext4_io_submit+0x50/0x68
> > [   34.828939]  ext4_writepages+0x558/0xca8
> > [   34.832860]  do_writepages+0x58/0x108
> > [   34.836522]  __writeback_single_inode+0x44/0x510
> > [   34.841137]  writeback_sb_inodes+0x1e0/0x4a8
> > [   34.845404]  __writeback_inodes_wb+0x78/0xe8
> > [   34.849670]  wb_writeback+0x274/0x3e8
> > [   34.853328]  wb_workfn+0x308/0x5f0
> > [   34.856726]  process_one_work+0x1ec/0x4d0
> > [   34.860734]  worker_thread+0x44/0x478
> > [   34.864392]  kthread+0x140/0x150
> > [   34.867618]  ret_from_fork+0x10/0x30
> > [   34.871197] Code: a9ba7bfd 910003fd f9000bf3 7900bfa1 (f9403441)
> > [   34.877289] ---[ end trace e6c2a3ab108278f0 ]---
> > [   34.893636] Kernel panic - not syncing: Oops: Fatal exception
> >
>
> If you have time then until you get the reply from others, can you try
> following patch ?
>
> diff --git a/block/bio.c b/block/bio.c
> index a1c4d2900c7a..9976400ec66a 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -663,7 +663,10 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t
> gfp_mask, struct bio_set *bs)
>  {
>         struct bio *b;
>
> -       b = bio_alloc_bioset(gfp_mask, 0, bs);
> +       if (bs)
> +               b = bio_alloc_bioset(gfp_mask, 0, bs);
> +       else
> +               b = bio_kmalloc(gfp_mask, 0);
>         if (!b)
>                 return NULL;
>
> P.S.This is purely based on the code inspection and it may not solve your
> issue. Proceed with the caution as it may *break* your system.

So with an initial quick test, this patch (along with the follow-on
one you sent) seems to avoid the issue.

I'm wondering if given there are multiple call sites, that in
bio_alloc_bioset() would something like the following make more sense?
(apologies, copy pasted so this is whitespace corrupted)
thanks
-john

diff --git a/block/bio.c b/block/bio.c
index a1c4d2900c7a..391d5cde79fc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -402,6 +402,9 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask,
unsigned short nr_iovecs,
        struct bio *bio;
        void *p;

+       if(!bs)
+               return bio_kmalloc(gfp_mask, 0);
+
        /* should not use nobvec bioset for nr_iovecs > 0 */
        if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_iovecs > 0))
                return NULL;
