Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF633DD4A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhHBL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:27:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37062 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhHBL1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:27:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0736621ECB;
        Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627903628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=eKM/s+8/w/7+zQFn5663T93zumbiLABfhNEM2wOaeG0=;
        b=XzOWKsgaJ2lAGAgZPfWWw6PrIqHStAsIlt5dOz/gyX48Ud+PhTh+16WxUPT2w/2dnNUIjN
        /JWqGJr7Ujtc379EP7nHBZx/RwxkLPBdfWhuf01L/YXPqztwGmP4tIudX3tGzQa6GS+Ak0
        NI6FeCXgeePzQmMN03qYNmag4GyhhUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627903628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=eKM/s+8/w/7+zQFn5663T93zumbiLABfhNEM2wOaeG0=;
        b=wKd/pThvOGkrIFZZEOZujMF8HYB8MWi0NRvm+C+JvVbBvWa/v4D2yZA//IJL0A/KyiOIj1
        pB8cJLRk0sl406AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id E04C3A3B85;
        Mon,  2 Aug 2021 11:27:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id D0C6F518C0A4; Mon,  2 Aug 2021 13:27:07 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH RESEND v4 0/8] Handle update hardware queues and queue freeze more carefully
Date:   Mon,  2 Aug 2021 13:26:50 +0200
Message-Id: <20210802112658.75875-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[forgot to add the linux-nvme mailing list]

Hi,

This update version makes sure the unfreeze call is done when
recreating the queues. I was able to reproduce hanging I/Os when we go
into error recovery mode for FC and TCP [1]. Unfortunatly, I don't
have access to a RDMA setup to verify but as the code is identically
to the TCP, RDMA looks to like to suffer from the same problem.

Thanks,
Daniel

[1] https://lore.kernel.org/linux-nvme/20210730094907.5vg7qebggttibogz@beryllium.lan/
    https://lore.kernel.org/linux-nvme/20210730113415.wezsrvxv5cu4yz4x@beryllium.lan/


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
 - added 'nvme-*: Unfreeze queues on reconnect'
 - added Hannes' reviewed tags
 

Daniel Wagner (5):
  nvme-fc: Update hardware queues before using them
  nvme-rdma: Update number of hardware queues before using them
  nvme-fc: Wait with a timeout for queue to freeze
  nvme-tcp: Unfreeze queues on reconnect
  nvme-rdma: Unfreeze queues on reconnect

Hannes Reinecke (1):
  nvme-tcp: Update number of hardware queues before using them

James Smart (2):
  nvme-fc: avoid race between time out and tear down
  nvme-fc: fix controller reset hang during traffic

 drivers/nvme/host/fc.c   | 28 +++++++++++++++++++---------
 drivers/nvme/host/rdma.c | 15 ++++++++-------
 drivers/nvme/host/tcp.c  | 18 +++++++++---------
 3 files changed, 36 insertions(+), 25 deletions(-)

-- 
2.29.2

