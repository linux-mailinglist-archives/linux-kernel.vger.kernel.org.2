Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EC73B4156
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFYKUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:20:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhFYKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:19:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6E8F51FE7B;
        Fri, 25 Jun 2021 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624616218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Dfo/oMFhioRwNqYhFs8xw+OHX0Au8i83hWIWvQKrzA8=;
        b=Fp35AvFdFTLqdyWdfxu4IfEbP7+LYZ43dHp49PGhPfr8YvXoQPs6UbA0gmWpJNjjZuE7cn
        hopY7wse8Jy303pIKR7qPwDOiHS9bBKW+cuM9N2Ih4Pzxda8CujcqgOAz80sUDeTUPbjKm
        QhPPE/VAVWfTgOcPUk8776ZaTDJ5+3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624616218;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Dfo/oMFhioRwNqYhFs8xw+OHX0Au8i83hWIWvQKrzA8=;
        b=NsZFF+P6sxEcIq5+9jClWXR6PH5Kve3okMiy1jZrXw/CRYuBvCP2hX9aDt1M5uoIUB9GG/
        PmAE2bWOII5FRMDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 94354A3BEE;
        Fri, 25 Jun 2021 10:16:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 81C5E51709BB; Fri, 25 Jun 2021 12:16:57 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 0/2] Handle update hardware queues and queue freeze more carefully
Date:   Fri, 25 Jun 2021 12:16:47 +0200
Message-Id: <20210625101649.49296-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

Thanks,
Daniel


Daniel Wagner (2):
  nvme-fc: Update hardware queues before using them
  nvme-fc: Wait with a timeout for queue to freeze

 drivers/nvme/host/fc.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
2.29.2

