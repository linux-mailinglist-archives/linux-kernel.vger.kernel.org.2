Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93203DD2B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhHBJOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:14:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58762 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhHBJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:14:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D0BDD1FF54;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627895661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=M0wV6lwFfROco+TITXP/8PqqejX24mSDpZVSzC6Ez5w=;
        b=ejlpYeDlMy0PHYo/D0CWo36OsQsSj7ejGv9CX4w1f/zcfiDNlFht75Mkkli/+nLzZ32QMX
        OJqI/OwXvQGP9W/BFAugmCYIi4uagLiiMmKXp9DPkRmPzops0N7LLToehzmyPzIUmnb2aq
        tsbOhWb//ntnt70Vd9Ffb74wNBhwn3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627895661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=M0wV6lwFfROco+TITXP/8PqqejX24mSDpZVSzC6Ez5w=;
        b=BLSWB3QfiZmFyMbDlnhNktttJkxpeNHo95bUITJcF/ymEMeU3eXD5TJP4dnWPfJ9nOY1bR
        rmTKDlj/IXhQFPDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 06F04A3B83;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id ECB7C518C087; Mon,  2 Aug 2021 11:14:20 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 0/8] Handle update hardware queues and queue freeze more carefully
Date:   Mon,  2 Aug 2021 11:14:11 +0200
Message-Id: <20210802091419.56425-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

