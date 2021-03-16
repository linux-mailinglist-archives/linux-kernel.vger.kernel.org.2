Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E11533D022
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhCPIxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:53:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33872 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235451AbhCPIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:52:39 -0400
X-UUID: 951bbb43011f4072815d6f907817e9e1-20210316
X-UUID: 951bbb43011f4072815d6f907817e9e1-20210316
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <guochun.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1207799967; Tue, 16 Mar 2021 16:52:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 16:52:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 16:52:17 +0800
From:   <guochun.mao@mediatek.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Guochun Mao <guochun.mao@mediatek.com>
Subject: [PATCH v1 1/1] ubifs: only check replay with inode type to judge if inode linked
Date:   Tue, 16 Mar 2021 16:52:14 +0800
Message-ID: <20210316085214.25024-2-guochun.mao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316085214.25024-1-guochun.mao@mediatek.com>
References: <20210316085214.25024-1-guochun.mao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guochun Mao <guochun.mao@mediatek.com>

Conside the following case, it just write a big file into flash,
when complete writing, delete the file, and then power off promptly.
Next time power on, we'll get a replay list like:
...
LEB 1105:211344 len 4144 deletion 0 sqnum 428783 key type 1 inode 80
LEB 15:233544 len 160 deletion 1 sqnum 428785 key type 0 inode 80
LEB 1105:215488 len 4144 deletion 0 sqnum 428787 key type 1 inode 80
...
In the replay list, data nodes' deletion are 0, and the inode node's
deletion is 1. In current logic, the file's dentry will be removed,
but inode and the flash space it occupied will be reserved.
User will see that much free space been disappeared.

We only need to check the deletion value of the following inode type
node of the replay entry.

Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
---
 fs/ubifs/replay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 0f8a6a16421b..1929ec63a0cb 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -223,7 +223,8 @@ static bool inode_still_linked(struct ubifs_info *c, struct replay_entry *rino)
 	 */
 	list_for_each_entry_reverse(r, &c->replay_list, list) {
 		ubifs_assert(c, r->sqnum >= rino->sqnum);
-		if (key_inum(c, &r->key) == key_inum(c, &rino->key))
+		if (key_inum(c, &r->key) == key_inum(c, &rino->key) &&
+		    key_type(c, &r->key) == UBIFS_INO_KEY)
 			return r->deletion == 0;
 
 	}
-- 
2.18.0

