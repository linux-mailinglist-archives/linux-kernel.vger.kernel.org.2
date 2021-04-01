Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F938350D19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhDADaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233348AbhDAD36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:29:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08CCA61057;
        Thu,  1 Apr 2021 03:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617247798;
        bh=ayAkeL0VLe+N5D0j988my840XAx2GJVEPGLaDd2n74g=;
        h=From:To:Cc:Subject:Date:From;
        b=fe0gbA14lMM1BIDPttKh5aUavw9GWDtoZNR1jNuLDgWxt6KqAh5vtdzogtp1Fv3Vc
         qbLMl89T6HgjZuaKn03sQavafpZ4dT6iIBNJdq87vAF7xq/um3e3KntVVn1AJ3hyWG
         BrVG315eMGw9M5IYGQLjJa79mIy27qZvg+Ih+YRIiWq041G5+6jH8kZ4wdRLechxWI
         IQ07tYXTh7NDmJ3fEjOBkcZzhTDToAiJlgK21BhcBQ9q0AfiKz2fo9srpBi85Mq75M
         ZQTV+CYXzX9AH5E/zwMvT4gcAS1N9FLIiK/Z09GMiogwiiP0UWu4O/YW9evfyrYbkd
         HseozfIvS3fHw==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Gao Xiang <xiang@kernel.org>
Subject: [PATCH v2 00/10] erofs: add big pcluster compression support
Date:   Thu,  1 Apr 2021 11:29:44 +0800
Message-Id: <20210401032954.20555-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is the formal version of EROFS big pcluster support, which means
EROFS can compress data into more than 1 fs block after this patchset.

{l,p}cluster are EROFS-specific concepts, standing for `logical cluster'
and `physical cluster' correspondingly. Logical cluster is the basic unit
of compress indexes in file logical mapping, e.g. it can build compress
indexes in 2 blocks rather than 1 block (currently only 1 block lcluster
is supported). Physical cluster is a container of physical compressed
blocks which contains compressed data, the size of which is the multiple
of lclustersize.

Different from previous thoughts, which had fixed-sized pclusterblks
recorded in the on-disk compress index header, our on-disk design allows
variable-sized pclusterblks now. The main reasons are
 - user data varies in compression ratio locally, so fixed-sized
   clustersize approach is space-wasting and causes extra read
   amplificationfor high CR cases;

 - inplace decompression needs zero padding to guarantee its safe margin,
   but we don't want to pad more than 1 fs block for big pcluster;

 - end users can now customize the pcluster size according to data type
   since various pclustersize can exist in a file, for example, using
   different pcluster size for executable code and one-shot data. such
   design should be more flexible than many other public compression fses
   (Btw, each file in EROFS can have maximum 2 algorithms at the same time
   by using HEAD1/2, which will be formally added with LZMA support.)

In brief, EROFS can now compress from variable-sized input to
variable-sized pcluster blocks, as illustrated below:

  |<-_lcluster_->|________________________|<-_lcluster_->|
  |____._________|_________ .. ___________|_______.______|
        .                                        .
         .                                     .
          .__________________________________.
          |______________| .. |______________|
          |<-          pcluster            ->|

The next step would be how to record the compressed block count in
lclusters. In compress indexes, there are 2 concepts called HEAD and
NONHEAD lclusters. The difference is that HEAD lcluster starts a new
pcluster in the lcluster, but NONHEAD not. It's easy to understand
that big pclusters at least have 2 pclusters, thus at least 2 lclusters
as well.

Therefore, let the delta0 (distance to its HEAD lcluster) of first NONHEAD
compress index store the compressed block count with a special flag as a
new called CBLKCNT compress index. It's also easy to know its delta0 is
constantly 1, as illustrated below:
  ________________________________________________________
 |_HEAD_|_CBLKCNT_|_NONHEAD_|_..._|_NONHEAD_|_HEAD | HEAD |
    |<------ a pcluster with CBLKCNT --------->|<-- -->|
                                                   ^ a pcluster with 1

If another HEAD follows a HEAD lcluster, there is no room to record
CBLKCNT, but it's easy to know the size of pcluster will be 1.

More implementation details about this and compact indexes are in the
commit message.

On the runtime performance side, the current EROFS test results are:
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


* Squashfs grabs more page cache to keep all decompressed data with
  grab_cache_page_nowait() than the normal requested readahead (see
  squashfs_copy_cache and squashfs_readpage_block).
  In principle, EROFS can also cache such all decompressed data
  if necessary, yet it's low priority for now and has little use
  (rand9m is actually a better rand read workload, since the amount
   of I/O is 9m rather than full-sized 1000m).

More details are in
https://lore.kernel.org/r/20210329053654.GA3281654@xiangao.remote.csb

Also it's easy to know EROFS is not a fixed pcluster design, so users
can make several optimized strategy according to data type when mkfs.
And there is still room to optimize runtime performance for big pcluster
even further.

Finally, it passes ro_fsstress and can also successfully boot buildroot
& Android system with android-mainline repo.

current mkfs repo for big pcluster:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-bigpcluster-compact

Thanks for your time on reading this!

Thanks,
Gao Xiang

changes since v1:
 - add a missing vunmap in erofs_pcpubuf_exit();
 - refine comments and commit messages.

 (btw, I'll apply this patchset for -next first for further integration
  test, which will be aimed to 5.13-rc1.)

Gao Xiang (10):
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

 fs/erofs/Kconfig        |  14 ---
 fs/erofs/Makefile       |   2 +-
 fs/erofs/decompressor.c | 216 +++++++++++++++++++++++++---------------
 fs/erofs/erofs_fs.h     |  31 ++++--
 fs/erofs/internal.h     |  31 ++----
 fs/erofs/pcpubuf.c      | 134 +++++++++++++++++++++++++
 fs/erofs/super.c        |   1 +
 fs/erofs/utils.c        |  12 ---
 fs/erofs/zdata.c        | 193 ++++++++++++++++++++++-------------
 fs/erofs/zdata.h        |  14 +--
 fs/erofs/zmap.c         | 155 ++++++++++++++++++++++------
 11 files changed, 560 insertions(+), 243 deletions(-)
 create mode 100644 fs/erofs/pcpubuf.c

-- 
2.20.1

