Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A89C3457FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCWGug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhCWGuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:50:00 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1124C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:49:59 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso1740125otp.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZZJL9tMbCU4qyjcbaauUNvkSw0s/ZCjez5b1Gyz4S8=;
        b=oECYu6YlH6Xy3A+Q3DJws9QupqCPURtpETO8BHQJ73xnbY2Jw/t9myjwODxL5T3T0K
         BOSPs9kDXkeAJd6v5T+cbgc2vzFqQccYCF8uOL6uO6WdqLzdiq3SJzUJ+KmDrLSVO/fV
         Ico+21m0wwuoGcxTqVNJ3N8kR3cF/cYtjWHJHSWg/Zp9hP+5/bksxJQkrKjgUqIgJZq0
         N6T+VuWsl7QFwtOSAfTlPS/7WRFoNzvOp5/l+UUss659mLC1wmtlk6PxX+iCMSWJnCtv
         puum9NUw6Hp4qJxh8JYgyeGChieey6MfOAKJKlv25sUBFOdHdYhcCY5HxzfmL5LHcg7f
         XT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZZJL9tMbCU4qyjcbaauUNvkSw0s/ZCjez5b1Gyz4S8=;
        b=lfNQ17YvVjvPbAafulsjCrmBhPCYu2dhvl4Hiokytmk6+a4trKKDkqAZSZvxOpy6WX
         pzkQVU/Tomd3TnukFUbRWF2liUvBOyQYUQOivpqFmivxApz0NBCZLIHkGIc/erJtxXBr
         rCDmxK8LCc1j/oIKuS5KKdSnwjbiS1C81qD9COAGiKlzlC0oU21iewLsYb/VcSZ8ct0v
         XP+7FBhYkc+BvOOV8L+mwRt/h5g4YaIhjgtMe8G4EfAxCvnVmyNeKqw/EsIlEFeDCQEp
         oXrTGaF00rnEEUqGamdLqXFxdwysn+Y2PPURCS7GVxJMFjHxlZSBtQEMv6aUEKhTW8P1
         zRIw==
X-Gm-Message-State: AOAM533yfBfED+jZb2qf7b9CN+PKCt/peSwdBJtx7A1PDFzrLsL3cSPc
        UNxMqdHf9/BepPIXJU23oQKg9p7akxwyXJeGllyQ6Ietxa/oLsU7qFU=
X-Google-Smtp-Source: ABdhPJwXaegWtmXRx2z3HnIUdy2+xQ7NoaXw4TsiY606NDIxA7o1ioERcpkTu4NzhLvG6UeYSdXTzRZWpXiIAscT2+I=
X-Received: by 2002:a25:76c3:: with SMTP id r186mr3073528ybc.365.1616478516726;
 Mon, 22 Mar 2021 22:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210322114730.71103-1-yuchao0@huawei.com>
In-Reply-To: <20210322114730.71103-1-yuchao0@huawei.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 23 Mar 2021 13:48:26 +0800
Message-ID: <CAFcO6XMak8GSRqQbZ3nPdGvV_eM6DL0+P0z1X2y0G9hkrccaCg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix to avoid out-of-bounds memory access
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>, chao@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have tested the patch on 5.12.0-rc4+, it seems to fix the problem.

Regards,
 butt3rflyh4ck.


On Mon, Mar 22, 2021 at 7:47 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> butt3rflyh4ck <butterflyhuangxx@gmail.com> reported a bug found by
> syzkaller fuzzer with custom modifications in 5.12.0-rc3+ [1]:
>
>  dump_stack+0xfa/0x151 lib/dump_stack.c:120
>  print_address_description.constprop.0.cold+0x82/0x32c mm/kasan/report.c:232
>  __kasan_report mm/kasan/report.c:399 [inline]
>  kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
>  f2fs_test_bit fs/f2fs/f2fs.h:2572 [inline]
>  current_nat_addr fs/f2fs/node.h:213 [inline]
>  get_next_nat_page fs/f2fs/node.c:123 [inline]
>  __flush_nat_entry_set fs/f2fs/node.c:2888 [inline]
>  f2fs_flush_nat_entries+0x258e/0x2960 fs/f2fs/node.c:2991
>  f2fs_write_checkpoint+0x1372/0x6a70 fs/f2fs/checkpoint.c:1640
>  f2fs_issue_checkpoint+0x149/0x410 fs/f2fs/checkpoint.c:1807
>  f2fs_sync_fs+0x20f/0x420 fs/f2fs/super.c:1454
>  __sync_filesystem fs/sync.c:39 [inline]
>  sync_filesystem fs/sync.c:67 [inline]
>  sync_filesystem+0x1b5/0x260 fs/sync.c:48
>  generic_shutdown_super+0x70/0x370 fs/super.c:448
>  kill_block_super+0x97/0xf0 fs/super.c:1394
>
> The root cause is, if nat entry in checkpoint journal area is corrupted,
> e.g. nid of journalled nat entry exceeds max nid value, during checkpoint,
> once it tries to flush nat journal to NAT area, get_next_nat_page() may
> access out-of-bounds memory on nat_bitmap due to it uses wrong nid value
> as bitmap offset.
>
> [1] https://lore.kernel.org/lkml/CAFcO6XOMWdr8pObek6eN6-fs58KG9doRFadgJj-FnF-1x43s2g@mail.gmail.com/T/#u
>
> Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/node.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index caf43970510e..8311b2367c7c 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2790,6 +2790,9 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>                 struct f2fs_nat_entry raw_ne;
>                 nid_t nid = le32_to_cpu(nid_in_journal(journal, i));
>
> +               if (f2fs_check_nid_range(sbi, nid))
> +                       continue;
> +
>                 raw_ne = nat_in_journal(journal, i);
>
>                 ne = __lookup_nat_cache(nm_i, nid);
> --
> 2.29.2
>
