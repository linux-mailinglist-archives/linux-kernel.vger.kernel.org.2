Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BCC3512D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhDAJzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:55:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:38078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233383AbhDAJyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:54:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C985AEA6;
        Thu,  1 Apr 2021 09:54:20 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Chao Leng <lengchao@huawei.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/3] Export fast_io_fail_tmo to sysfs
Date:   Thu,  1 Apr 2021 11:54:09 +0200
Message-Id: <20210401095412.84254-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v1:
 - use sysfs_emit instead sprintf
 - simplify logic in nvme_ctrl_loss_tmo_store() and
   nvme_ctrl_io_fail_tmo
 - updated commit message (dropped wrong statement about
   hard coded value)

Daniel Wagner (3):
  nvme: Use sysfs_emit instead of sprintf
  nvme: Remove superflues else in nvme_ctrl_loss_tmo_store
  nvme: Export fast_io_fail_tmo to sysfs

 drivers/nvme/host/core.c      | 73 +++++++++++++++++++++++++----------
 drivers/nvme/host/multipath.c |  8 ++--
 2 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.29.2

