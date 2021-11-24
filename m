Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7987E45CEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 22:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbhKXVGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 16:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234102AbhKXVGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:06:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9564160FDA;
        Wed, 24 Nov 2021 21:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637787816;
        bh=UEkE1eFZxaD/UOhfXY/SI0jhBkgdLknjQn8B1SzEKXA=;
        h=From:To:Cc:Subject:Date:From;
        b=ssq6LIZn7pm9z3N8QoaewGNfg848JWT57zql3uCA/UDdMZcIKWGaj6T+JzHViEerm
         7WfONkFrX7pkiAh1aXssbwcPcg0tea7AE3RAHAkWSyJjrywCqucPafHxG7sRsWUrkG
         EVWrMGiFy6w/LSQa/8vFyO7VUWnXzghf0JL8aJMhfy3yqIiUvbAX6I4SpV5rTim8al
         ssglqIiF9YgqOzHLqJZqzINYMXol/6Ytl0oWuBU1cxxtn4piVg5XKFxBseq/mZVwvE
         /ahkvfIEGhEI3Uzc8Ill4yGv+V+g5AVQ0OMvc49X9wKEmup4pn0NkLvGks4ZT0ZrRS
         TVX1dt1sZJDqg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     minyard@acm.org, andrew.manley@sealingtech.com
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] ipmi: fix oob access due to uninit smi_msg type
Date:   Wed, 24 Nov 2021 13:03:23 -0800
Message-Id: <20211124210323.1950976-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're hitting OOB accesses in handle_ipmb_direct_rcv_rsp() (memcpy of
size -1) after user space generates a message. Looks like the message
is incorrectly assumed to be of the new IPMB type, because type is never
set and message is allocated with kmalloc() not kzalloc().

Fixes: 059747c245f0 ("ipmi: Add support for IPMB direct messages")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Would it be possible to get something like this to Linus ASAP?
It's flipping over all my test boxes.
---
 drivers/char/ipmi/ipmi_msghandler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index deed355422f4..f0b18c25cbb1 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -5031,6 +5031,7 @@ struct ipmi_smi_msg *ipmi_alloc_smi_msg(void)
 	if (rv) {
 		rv->done = free_smi_msg;
 		rv->user_data = NULL;
+		rv->type = IPMI_SMI_MSG_TYPE_NORMAL;
 		atomic_inc(&smi_msg_inuse_count);
 	}
 	return rv;
-- 
2.31.1

