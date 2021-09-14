Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626C940AAAF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhINJVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:21:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45406 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhINJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:21:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A302B200E2;
        Tue, 14 Sep 2021 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631611209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aXMOFohVAzO6sN5gTXO7JBsgcuVaS1dswQOzd4j9vyg=;
        b=u43fm3Ku9uiZ/wUZ6vv86MbfxYidYg8tw8sO+mZTKB5z17xoyNB7fevlbHxvonsU26AzG2
        kGNxoPfep4Vj/DIUdHQ5pvJtVzzb70Ftcz8hR5SO7m8f5H+s+ANPaLxpMOStFiq3s4VPnd
        bZBYANOh2LtEvMmTzXwdhLx11/IchrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631611209;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aXMOFohVAzO6sN5gTXO7JBsgcuVaS1dswQOzd4j9vyg=;
        b=/mb3eug1Ej/gHrxxauu7kI+B9DbCOXuEO0lyoE7V1Gpxia+RhULkCVDMYlbD1XEOO6JKWj
        SDh95sDRW5XuS2DQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 931DCA3BCC;
        Tue, 14 Sep 2021 09:20:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 7FA71518E627; Tue, 14 Sep 2021 11:20:09 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 0/3] Handle update hardware queues and queue freeze more carefully
Date:   Tue, 14 Sep 2021 11:20:05 +0200
Message-Id: <20210914092008.40370-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v7 is addressing the comments from Sagi (wrong commit id and add an
explenation why the queues are empty).

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
 - https://lore.kernel.org/linux-nvme/20210823112351.82899-1-dwagner@suse.de/
 - updated commit message 'nvme-fc: Update hardware queues before using them'
 - dropped 'nvme-fc: fix controller reset hang during traffic'
 - added 'nvme-fc: Remove freeze/unfreeze around update_nr_hw_queues'
v7:
 - updated commit id in last patch
 - added explenation why the queues are empty in last patch

Daniel Wagner (1):
  nvme-fc: Update hardware queues before using them

James Smart (2):
  nvme-fc: avoid race between time out and tear down
  nvme-fc: Remove freeze/unfreeze around update_nr_hw_queues

 drivers/nvme/host/fc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.29.2

