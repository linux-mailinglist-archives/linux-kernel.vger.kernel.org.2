Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB04A36B200
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhDZK6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233006AbhDZK6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619434670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mJlHYYmSrGQFfVIc4gOH0IGpUPzxG6UA9y4Zdncqjjo=;
        b=BVO04rTwA/hLzuLUDI7lPeU6mJa/+xGjHDBiul/eU1Q4p18P1e1NaNVUFGpfX2Qa6mc+vW
        yhopbYSIfgfiHs7bTQFxdrE4rL5Y19Rv3cCe3exAKRZ/xvIYIUFQ7uzYxI/gZ305UWpXVu
        /yE9fO/zNydesCWx6B29/hZJGovyuzY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-e5vte85bND-jSWaLPw2XCA-1; Mon, 26 Apr 2021 06:57:49 -0400
X-MC-Unique: e5vte85bND-jSWaLPw2XCA-1
Received: by mail-pg1-f200.google.com with SMTP id b2-20020a6567c20000b02901fda3676f83so17664794pgs.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 03:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mJlHYYmSrGQFfVIc4gOH0IGpUPzxG6UA9y4Zdncqjjo=;
        b=DCIUfq8x1D3QjudwvkGFNlrpcj3MkGHoGrnyVnF3uImqYhHhUqtoqeBvkqaJvmVVhH
         7X1CaiJTLmzCXJEQlcLX6O7FPVbU9FM0jO3c6kFYwwLCvw1gV/XJGxy8T6vvqQ0vzhFe
         OTWBVvTPCId8+Vu4crEg1UJZsoUXhDdzq6pcmruGw1F+0NmCoo5aDKPwlz8gNDiyq1Cl
         ranSRlNkgwuLR2uxBQ6ycZ2P5Yrx1WFT9V7auwSpHF2RiLYKz0ufeqw7qxp75t+eGgc1
         WXXdjK8XxrSkLosvUYqQfXhQXOxvLypxBW+pQf0ej+8IakmamaGllHw1qOoesy9f2nsh
         LTfA==
X-Gm-Message-State: AOAM53091/C/PH2hrR/V98GhQcbuDQ4A1zCTyBeQHOHgT8KvmLFaskJH
        vDavVr1T2HUmPItoD1Ps7WijOV1jsws81OB15pidw/nIErJatI54ldLQOSH8KWp7+4WNr3hHw+j
        AzHu7l62GDgVO7Bid3SRoOeGB
X-Received: by 2002:a17:902:da8a:b029:ec:9032:35f6 with SMTP id j10-20020a170902da8ab02900ec903235f6mr18171661plx.37.1619434666846;
        Mon, 26 Apr 2021 03:57:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzws+NTNxvAiKn8sdeeDOlVVt+HnIfLvysb7fZgGBcohzobMhMyiwKcCUrswKtVyICDJGQLgQ==
X-Received: by 2002:a17:902:da8a:b029:ec:9032:35f6 with SMTP id j10-20020a170902da8ab02900ec903235f6mr18171643plx.37.1619434666593;
        Mon, 26 Apr 2021 03:57:46 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ch14sm2651837pjb.55.2021.04.26.03.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 03:57:46 -0700 (PDT)
Date:   Mon, 26 Apr 2021 18:57:34 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Guo Weichao <guoweichao@oppo.com>, Yue Hu <huyue2@yulong.com>,
        Ruiqi Gong <gongruiqi1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [GIT PULL] erofs updates for 5.13-rc1
Message-ID: <20210426105733.GA4060072@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.13-rc1?

In this cycle, we would like to introduce a new feature called big
pcluster so EROFS can compress file data into more than 1 fs block
and different pcluster size can be selected for each (sub-)files by
design. The current EROFS test results on my laptop are [1]:

Testscript: erofs-openbenchmark
Testdata: enwik9 (1000000000 bytes)
 ________________________________________________________________
|  file system  |   size    | seq read | rand read | rand9m read |
|_______________|___________|_ MiB/s __|__ MiB/s __|___ MiB/s ___|
|___erofs_4k____|_556879872_|_ 781.4 __|__ 55.3 ___|___ 25.3  ___|
|___erofs_16k___|_452509696_|_ 864.8 __|_ 123.2 ___|___ 20.8  ___|
|___erofs_32k___|_415223808_|_ 899.8 __|_ 105.8 _*_|___ 16.8 ____|
|___erofs_64k___|_393814016_|_ 906.6 __|__ 66.6 _*_|___ 11.8 ____|
|__squashfs_8k__|_556191744_|_  64.9 __|__ 19.3 ___|____ 9.1 ____|
|__squashfs_16k_|_502661120_|_  98.9 __|__ 38.0 ___|____ 9.8 ____|
|__squashfs_32k_|_458784768_|_ 115.4 __|__ 71.6 _*_|___ 10.0 ____|
|_squashfs_128k_|_398204928_|_ 257.2 __|_ 253.8 _*_|___ 10.9 ____|
|____ext4_4k____|____()_____|_ 786.6 __|__ 28.6 ___|___ 27.8 ____|

, which has been verified but I'd like warn it as experimental for
a while. This matchs erofs-utils dev branch and I'll also release
a new userspace version for this later.

Apart from that, several improvements are also included: e.g. complete
a missing case for inplace I/O, optimize endio decompression logic for
non-atomic contexts and support adjustable sliding window size, ...
In addition to those, there are some cleanups as always.

All commits have been tested and have been in linux-next for about 2
weeks and I've just confirmed with 5.12 release. This merges cleanly
with master.

[1] https://lore.kernel.org/r/20210329053654.GA3281654@xiangao.remote.csb

Thanks,
Gao Xiang

The following changes since commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3:

  Linux 5.12-rc5 (2021-03-28 15:48:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.13-rc1

for you to fetch changes up to 8e6c8fa9f2e95c88a642521a5da19a8e31748846:

  erofs: enable big pcluster feature (2021-04-10 03:20:19 +0800)

----------------------------------------------------------------
Changes since last update:

 - avoid memory failure when applying rolling decompression;

 - optimize endio decompression logic for non-atomic contexts;

 - complete a missing case which can be safely selected for inplace
   I/O and thus decreasing more memory footprint;

 - check unsupported on-disk inode i_format strictly;

 - support adjustable lz4 sliding window size to decrease runtime
   memory footprint;

 - support on-disk compression configurations;

 - support big pcluster decompression;

 - several code cleanups / spelling correction.

----------------------------------------------------------------
Gao Xiang (15):
      erofs: complete a missing case for inplace I/O
      erofs: add unsupported inode i_format check
      erofs: introduce erofs_sb_has_xxx() helpers
      erofs: introduce on-disk lz4 fs configurations
      erofs: add on-disk compression configurations
      erofs: reserve physical_clusterbits[]
      erofs: introduce multipage per-CPU buffers
      erofs: introduce physical cluster slab pools
      erofs: fix up inplace I/O pointer for big pcluster
      erofs: add big physical cluster definition
      erofs: adjust per-CPU buffers according to max_pclusterblks
      erofs: support parsing big pcluster compress indexes
      erofs: support parsing big pcluster compact indexes
      erofs: support decompress big pcluster for lz4 backend
      erofs: enable big pcluster feature

Huang Jianan (4):
      erofs: avoid memory allocation failure during rolling decompression
      erofs: use workqueue decompression for atomic contexts only
      erofs: use sync decompression for atomic contexts only
      erofs: support adjust lz4 history window size

Ruiqi Gong (1):
      erofs: Clean up spelling mistakes found in fs/erofs

Yue Hu (1):
      erofs: don't use erofs_map_blocks() any more

 fs/erofs/Kconfig        |  14 ---
 fs/erofs/Makefile       |   2 +-
 fs/erofs/data.c         |  19 +---
 fs/erofs/decompressor.c | 272 ++++++++++++++++++++++++++++++------------------
 fs/erofs/erofs_fs.h     |  54 ++++++++--
 fs/erofs/inode.c        |   7 ++
 fs/erofs/internal.h     |  86 ++++++++++-----
 fs/erofs/pcpubuf.c      | 148 ++++++++++++++++++++++++++
 fs/erofs/super.c        | 148 +++++++++++++++++++++++++-
 fs/erofs/utils.c        |  12 ---
 fs/erofs/zdata.c        | 254 +++++++++++++++++++++++++++++---------------
 fs/erofs/zdata.h        |  14 +--
 fs/erofs/zmap.c         | 164 +++++++++++++++++++++++------
 13 files changed, 887 insertions(+), 307 deletions(-)
 create mode 100644 fs/erofs/pcpubuf.c

