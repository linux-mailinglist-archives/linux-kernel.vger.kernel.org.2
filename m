Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7F14271D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbhJHUKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231584AbhJHUKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:10:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4976061019;
        Fri,  8 Oct 2021 20:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633723737;
        bh=KmFExuavQRUuydLea0+sQnpoCrziI5QQDHZyRBAlaRk=;
        h=From:To:Cc:Subject:Date:From;
        b=ss4BtCT858+oMIVNCW5FkfXH8WqCytzMnSLRG/Gu0wLcVbXOu5sNrmaUevj/uHJ75
         iZxvxzQsulresQ48q4G3EalGeuN8XoproPlEAGEtULugSKasLWUyxeMeaJxQxYaGV1
         lMTGpbOjqMmUgbAqPSvMzhhjBWbnqKn+zV88Bl+IQv1wWugO2mSw5nYxipI7GqeiYz
         Bw8BclYABXtTRF8A5uGaDI+em5pi+Ad3pUsElcTDb+Qit3sPQygXdcu2kXIu+ObYOk
         sE+j20C5fExvX3cung6DW4Nc9R1yccOofKD87N7mN4b2stt/ps5euQqQDvCez1wgzO
         bdx6NI0H76pWg==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Gao Xiang <xiang@kernel.org>
Subject: [PATCH v2 0/3] erofs: some decompression improvements
Date:   Sat,  9 Oct 2021 04:08:36 +0800
Message-Id: <20211008200839.24541-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This patchset is mainly intended for the upcoming LZMA preparation,
but they still have some benefits to the exist LZ4 decompression.

The first patch looks up compression algorithms on mapping instead
of in the decompression frontend, which is used for the rest patches.

The second patch introduces another compression HEAD (HEAD2) so that
each file can be compressed with two different algorithms at most,
which can be used for the upcoming LZMA compression and LZ4 range
dictionary compression for different data/access patterns.

The third patch introduces a new readmore decompression strategy
trying to improve randread for large LZ4 big pcluster and the upcoming
LZMA decompression. It mainly addresses the previous issue mentioned
in the original big pcluster patchset [1]:

FIO randread
Testdata: enwik9
Kernel: Linux 5.15.0-rc2

pclustersize		Vanilla		Patched
 4096			 54.6 MiB/s	 56.1 MiB/s
16384			117.4 MiB/s	145.6 MiB/s
32768			113.6 MiB/s	203.4 MiB/s
65536			 72.8 MiB/s	236.1 MiB/s

The latest version can also be fetched from
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git -b erofs/readmore

[1] https://lore.kernel.org/r/20210407043927.10623-1-xiang@kernel.org

Thanks,
Gao Xiang

Changes since v1:
 - correct the function name to z_erofs_map_blocks_iter() in the commit
   message pointed out by Yue;

 - fix the readmore logic which mainly impacts the LZMA approach later,
   therefore test the Patched version again.

Gao Xiang (3):
  erofs: get compression algorithms directly on mapping
  erofs: introduce the secondary compression head
  erofs: introduce readmore decompression strategy

 fs/erofs/compress.h          |   5 --
 fs/erofs/erofs_fs.h          |   8 ++-
 fs/erofs/internal.h          |  25 +++++++-
 fs/erofs/zdata.c             | 111 +++++++++++++++++++++++++++--------
 fs/erofs/zmap.c              |  55 +++++++++++------
 include/trace/events/erofs.h |   2 +-
 6 files changed, 151 insertions(+), 55 deletions(-)

-- 
2.20.1

