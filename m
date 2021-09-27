Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0BA419254
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhI0Kkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:40:42 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:7747 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhI0Kkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:40:40 -0400
Received: from localhost (scalar.blr.asicdesigners.com [10.193.185.94])
        by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 18RAcwHK021958;
        Mon, 27 Sep 2021 03:38:59 -0700
Date:   Mon, 27 Sep 2021 16:06:48 +0530
From:   Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, jwboyer@kernel.org,
        ramaraju@chelsio.com, rahul.lakkireddy@chelsio.com
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.26.2.0
Message-ID: <20210927103647.GA15266@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the new Chelsio firmware from the following URL.

git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Rahul


The following changes since commit 0268c1b8a06798f5167cbef8fb16241298b3eba9:

  Merge branch 'adlp_dmc_2_12' of git://anongit.freedesktop.org/drm/drm-firmware into main (2021-09-23 12:39:42 -0400)

are available in the git repository at:


  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 70ff1f807c1440efff073b618f82202ba1ecb8be:

  cxgb4: Update firmware to revision 1.26.2.0 (2021-09-27 02:29:50 -0700)

----------------------------------------------------------------
Rahul Lakkireddy (1):
      cxgb4: Update firmware to revision 1.26.2.0

 WHENCE                                         |  12 ++++++------
 cxgb4/{t4fw-1.26.0.0.bin => t4fw-1.26.2.0.bin} | Bin 570368 -> 570368 bytes
 cxgb4/{t5fw-1.26.0.0.bin => t5fw-1.26.2.0.bin} | Bin 675840 -> 676352 bytes
 cxgb4/{t6fw-1.26.0.0.bin => t6fw-1.26.2.0.bin} | Bin 729088 -> 729088 bytes
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename cxgb4/{t4fw-1.26.0.0.bin => t4fw-1.26.2.0.bin} (57%)
 rename cxgb4/{t5fw-1.26.0.0.bin => t5fw-1.26.2.0.bin} (55%)
 rename cxgb4/{t6fw-1.26.0.0.bin => t6fw-1.26.2.0.bin} (61%)
