Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2523BF791
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhGHJaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:30:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60730 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhGHJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:30:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6EF6320198;
        Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625736488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+8D8Ux8ubyfH6HW48VcTiWCCSH0ipd0TmwlTxseTRGE=;
        b=HMJ6DMoT9fosQqtiCD9Y+Cvnie1kO4BWC61y0mIu5QPmqKN51RJp/7VX/ivbt5sLuZ9vh8
        nU71kWoie0AYcAz4ENi9PdAgrhmekIelz3UBDK4HVSOQVjeq4kgi40RAI3YfjmQ8gpen42
        OFsBq7WShfuUBO0wkQzB/GELfsbyFVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625736488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+8D8Ux8ubyfH6HW48VcTiWCCSH0ipd0TmwlTxseTRGE=;
        b=EDo6+Q9j7X5XUhjj1f2uD2fMiWpAUWQdnynm98ngyUT1uiLVWER5/7kjyt0bKxA09Z5GEH
        1p9oFfSYgaYN86DQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 63B9AA3B84;
        Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 54140517114A; Thu,  8 Jul 2021 11:28:08 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/5] Handle update hardware queues and queue freeze more carefully
Date:   Thu,  8 Jul 2021 11:27:50 +0200
Message-Id: <20210708092755.15660-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've tested this on top of Ming's patches 'blk-mq: fix
blk_mq_alloc_request_hctx'[1] which fixes all problems (including the
hanger in nvme_wait_freeze()).

Thanks,
Danie

[1] https://lore.kernel.org/linux-nvme/20210629074951.1981284-1-ming.lei@redhat.com/

v1:
 - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
v2:
 - reviewed tags collected
 - added 'update hardware queues' for all transport
 - added fix for fc hanger in nvme_wait_freeze_timeout


Initial cover letter:

this is a followup on the crash I reported in

  https://lore.kernel.org/linux-block/20210608183339.70609-1-dwagner@suse.de/

By moving the hardware check up the crash was gone. Unfortuntatly, I
don't understand why this fixes the crash. The per-cpu access is
crashing but I can't see why the blk_mq_update_nr_hw_queues() is
fixing this problem.

Even though I can't explain why it fixes it, I think it makes sense to
update the hardware queue mapping bevore we recreate the IO
queues. Thus I avoided in the commit message to say it fixes
something.

Also during testing I observed the we hang indivinetly in
blk_mq_freeze_queue_wait(). Again I can't explain why we get stuck
there but given a common pattern for the nvme_wait_freeze() is to use
it with a timeout I think the timeout should be used too :)

Anyway, someone with more undertanding of the stack can explain the
problems.


Daniel Wagner (4):
  nvme-fc: Update hardware queues before using them
  nvme-rdma: Update number of hardware queues before using them
  nvme-fc: Wait with a timeout for queue to freeze
  nvme-fc: Freeze queues before destroying them

Hannes Reinecke (1):
  nvme-tcp: Update number of hardware queues before using them

 drivers/nvme/host/fc.c   | 26 +++++++++++++++++---------
 drivers/nvme/host/rdma.c | 13 ++++++-------
 drivers/nvme/host/tcp.c  | 14 ++++++--------
 3 files changed, 29 insertions(+), 24 deletions(-)

-- 
2.29.2

