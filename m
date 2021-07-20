Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCD3CF9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbhGTMGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:06:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51754 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhGTMDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:03:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DD3BC202DB;
        Tue, 20 Jul 2021 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626785038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pyoIzDS0Og6G7hqh3R55JAHhxOyRBm5TYSAA13eeovs=;
        b=vPSfm7GnLAOMZk+HyFANz4xD5SmaHkpKb/seGitaJtIeWIpLRmvuSCUcZqqetMnMkzb/xo
        LsiL444a8UFKufBwa9umYg5I++SCdkG7Bjwu8hhkWMesxF/ZySVGqeHRL/g82R1z9DBkeI
        Q7HhJ+bxS7FRutyqk18hhQvBj5VAS50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626785038;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pyoIzDS0Og6G7hqh3R55JAHhxOyRBm5TYSAA13eeovs=;
        b=8nm9X6PB4AmOW2AQglGomcL7X1yl+xfu19pn/N00x/YIFJAqY+amI986HFHH4gAcQfxt9w
        SEsW24UGDT4qRuCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 0E078A3BA8;
        Tue, 20 Jul 2021 12:43:58 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id EB0FD5171926; Tue, 20 Jul 2021 14:43:57 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 0/6] Handle update hardware queues and queue freeze more carefully
Date:   Tue, 20 Jul 2021 14:43:47 +0200
Message-Id: <20210720124353.127959-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've replaced my 'nvme_start_freeze' patch with the two patches from
James and gave it another test run on top of Ming's 'v2 fix
blk_mq_alloc_request_hctx' series. All looks good.

Thanks,
Daniel


v1:
 - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
v2:
 - https://lore.kernel.org/linux-nvme/20210708092755.15660-1-dwagner@suse.de/
 - reviewed tags collected
 - added 'update hardware queues' for all transport
 - added fix for fc hanger in nvme_wait_freeze_timeout
v3:
 - dropped 'nvme-fc: Freeze queues before destroying them'
 - added James' two patches


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

Daniel Wagner (3):
  nvme-fc: Update hardware queues before using them
  nvme-rdma: Update number of hardware queues before using them
  nvme-fc: Wait with a timeout for queue to freeze

Hannes Reinecke (1):
  nvme-tcp: Update number of hardware queues before using them

James Smart (2):
  nvme-fc: avoid race between time out and tear down
  nvme-fc: fix controller reset hang during traffic

 drivers/nvme/host/fc.c   | 28 +++++++++++++++++++---------
 drivers/nvme/host/rdma.c | 13 ++++++-------
 drivers/nvme/host/tcp.c  | 14 ++++++--------
 3 files changed, 31 insertions(+), 24 deletions(-)

-- 
2.29.2

