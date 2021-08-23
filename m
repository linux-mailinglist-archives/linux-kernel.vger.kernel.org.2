Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E923F49B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhHWLYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:24:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37646 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbhHWLYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:24:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EE62D1FFAD;
        Mon, 23 Aug 2021 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629717832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RA4HTkvFglG0/CjS1mPXjBNeKgRNmXs+Fgd4zJqlWOY=;
        b=tZsekKYxNsz1gmeaRFut4Yf7gU5dL2iwHK112uE7+EnjDDEgtbgq20z07l4Gdpwt7oOGxT
        GQzAuOpLlqsannzW3QEDzOL2fjWoGfpydugYU347DWAMxoJvEI4NEq9Avan2O+hkDgUYhM
        SgXnh1bK3Ng8xTiY0tJK6aS2pWX1Ywc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629717832;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RA4HTkvFglG0/CjS1mPXjBNeKgRNmXs+Fgd4zJqlWOY=;
        b=UQNBtlDCCBMGHvDx97dwJ/vtfdFiAVVkfqqEbcQ3G3G+Ienj2HTqOegYiBjYi/mpnxUvUL
        M6ZtkMsqrD0F+wBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2AF4FA3BB8;
        Mon, 23 Aug 2021 11:23:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 18E83518D889; Mon, 23 Aug 2021 13:23:52 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 0/3]  Handle update hardware queues and queue freeze more carefully
Date:   Mon, 23 Aug 2021 13:23:48 +0200
Message-Id: <20210823112351.82899-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After our last discussion in v5, the nvme_freeze_start() is gone
(James provided a new patch). I also updated the commit message of the
first patch which adds the imported bit why we need to update the
number queues first.

Anyway, I think we figured out the details in this path and I am quiet
confident that we nailed it now (yeah, famous last words).

Daniel

v1:
 - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
v2:
 - https://lore.kernel.org/linux-nvme/20210708092755.15660-1-dwagner@suse.de/
 - reviewed tags collected
 - added 'update hardware queues' for all transport
 - added fix for fc hanger in nvme_wait_freeze_timeout
v3:
 - https://lore.kernel.org/linux-nvme/20210720124353.127959-1-dwagner@suse.de/
 - dropped 'nvme-fc: Freeze queues before destroying them'
 - added James' two patches
v4:
 - https://lore.kernel.org/linux-nvme/20210802112658.75875-1-dwagner@suse.de/
 - added 'nvme-*: Unfreeze queues on reconnect'
 - added Hannes' reviewed tags
v5:
 - https://lore.kernel.org/linux-nvme/20210818120530.130501-1-dwagner@suse.de/
 - dropped non nvme-fc patches
 - updated 'nvme-fc: fix controller reset hang during traffic'
v6:
 - updated commit message 'nvme-fc: Update hardware queues before using them'
 - dropped 'nvme-fc: fix controller reset hang during traffic'
 - added 'nvme-fc: Remove freeze/unfreeze around update_nr_hw_queues'

Daniel Wagner (1):
  nvme-fc: Update hardware queues before using them

James Smart (2):
  nvme-fc: avoid race between time out and tear down
  nvme-fc: Remove freeze/unfreeze around update_nr_hw_queues

 drivers/nvme/host/fc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.29.2

