Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5849B3F3430
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhHTTCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:02:15 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21310 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhHTTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:02:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1629486091; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JTUDp6Rbo0JtCPGZCz8dRy549EBqYLHq+o1SdTAv6vi5Oep7XDn5TbGIqaSE7mveNL1ioqGzJsRlnNeSU72ojPQ9IhtrBtM2XWhb0WElpRDwIZzV2VYpqlBl821J1Ga+HNjnFHOuFvwAW2yWJP2yS+0Fe4ngvkMb0/zaEA9s57Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1629486091; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=+8HoWNe3h5WTtvNvUVVUKYYO+3ldDsTW5LsjKb7EUVE=; 
        b=XcAI4+ynpZA/qSu+x6sXA85WPn+2MjqC8OwnD1ag3JCozWzplmoNmDF0dwI7PQxWT6ZFjL3vEv9QeZ1/LBfQbR6RgUxW+9ZXV721KOklfzEu5wJa5/qudpr9OXh59YzlwKfHnzlJ+ZdTjMWlDa4glfV99oXH1QgHFUyB67n4M2g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1629486091;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=+8HoWNe3h5WTtvNvUVVUKYYO+3ldDsTW5LsjKb7EUVE=;
        b=QrMP5eDi97a9cQGeZSQV2Xzij92iwkWO3o1nK/zobB4BP9+dcrdskv5IXhHnvM+L
        +RTlmzAdgofDkQ0Tmy08cWozsA6Kg+4Eo9m9Tcf6ZPcwgemfnZDgGHT7voN1w7/DdAQ
        lrlZNDtWCEldD6DKeoV+llWV0Vo3caiQ2IDzq5sM=
Received: from localhost.localdomain (106.51.111.164 [106.51.111.164]) by mx.zohomail.com
        with SMTPS id 1629486088755312.1448548868018; Fri, 20 Aug 2021 12:01:28 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4 0/2] Fix syzkaller bug: hung task in hub_port_init
Date:   Sat, 21 Aug 2021 00:31:20 +0530
Message-Id: <20210820190122.16379-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the hung task bug in hub_port_init reported by
syzkaller at:

https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76

Stack:

INFO: task kworker/0:0:5 blocked for more than 143 seconds.
      Not tainted 5.13.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D
 stack:27392 pid:    5 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event

Call Trace:
 context_switch kernel/sched/core.c:4339 [inline]
 __schedule+0x916/0x23e0 kernel/sched/core.c:5147
 schedule+0xcf/0x270 kernel/sched/core.c:5226
 usb_kill_urb.part.0+0x19c/0x220 drivers/usb/core/urb.c:711
 usb_kill_urb+0x81/0xa0 drivers/usb/core/urb.c:706
 usb_start_wait_urb+0x24a/0x4c0 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 hub_port_init+0x82e/0x2db0 drivers/usb/core/hub.c:4759
 hub_port_connect drivers/usb/core/hub.c:5210 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5418 [inline]
 port_event drivers/usb/core/hub.c:5564 [inline]
 hub_event+0x2190/0x4330 drivers/usb/core/hub.c:5646
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The first patch in the series fixes the issue and the second patch does
some refactoring to avoid duplicate code.

Changes in v4:
- Got rid of the log messages as suggested by Shuah.

Changes in v3:
- Split the patch into two patches
- Remove the convenience wrappers as suggested by Shuah
- Remove the WARN as suggested by Greg
Link: https://lore.kernel.org/lkml/20210813182508.28127-1-mail@anirudhrb.com/

Changes in v2:
Use WARN_ON() instead of BUG() when unlink_list is neither unlink_tx nor
unlink_rx.
Link: https://lore.kernel.org/lkml/20210806181335.2078-1-mail@anirudhrb.com/

v1: https://lore.kernel.org/lkml/20210806164015.25263-1-mail@anirudhrb.com/

Anirudh Rayabharam (2):
  usbip: give back URBs for unsent unlink requests during cleanup
  usbip: clean up code in vhci_device_unlink_cleanup

 drivers/usb/usbip/vhci_hcd.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

-- 
2.26.2

