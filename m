Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC193F0340
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhHRMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:06:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53510 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbhHRMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:06:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3038F20071;
        Wed, 18 Aug 2021 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629288333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zgdwr7t3mBJoUNt/iXm4y9kn1wTY4VfgPeXgvi1oBxY=;
        b=pd5ZkACQrIFnWuJSHc5GfrA0E/dWMuYQ6Ipt7okzRC6iUtBuEjpR/it5KIBPO5AUu8Jj/x
        YntyA+fy6hfo5RVUfNgYQ0Lpl3p6YEheJs9/Nvgz2skMhyvwT2+DIe9FX/vH4vPwMw4OHQ
        BO18ARVDiwgNdQcHx1FymGKW+qBWj8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629288333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zgdwr7t3mBJoUNt/iXm4y9kn1wTY4VfgPeXgvi1oBxY=;
        b=3DOVF2Iyxy/Pl2qrxbO4G2k9JcUBrZcMyKMq0BilNXKYWqFDRAoaKsw7oUaSxkHQNDuRKg
        UpGHdIyYgF978XAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 554A5A3B98;
        Wed, 18 Aug 2021 12:05:31 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 763EE518CF79; Wed, 18 Aug 2021 14:05:31 +0200 (CEST)
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
Subject: [PATCH v5 0/3] Handle update hardware queues and queue freeze more carefully
Date:   Wed, 18 Aug 2021 14:05:27 +0200
Message-Id: <20210818120530.130501-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've dropped all non FC patches as they were bogus. I've retested this
version with all combinations and all looks good now. Also I gave
nvme-tcp a spin and again all is good.

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
 - dropped non nvme-fc patches
 - updated 'nvme-fc: fix controller reset hang during traffic'

Daniel Wagner (1):
  nvme-fc: Wait with a timeout for queue to freeze

James Smart (2):
  nvme-fc: avoid race between time out and tear down
  nvme-fc: fix controller reset hang during traffic

 drivers/nvme/host/fc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.29.2

