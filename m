Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA232765C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 04:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhCADOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 22:14:24 -0500
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:48474 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhCADOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 22:14:21 -0500
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Feb 2021 22:14:20 EST
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 656A15401A3;
        Mon,  1 Mar 2021 11:03:08 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Wang Qing <wangqing@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib: fix inconsistent indenting in process_bit1()
Date:   Mon,  1 Mar 2021 11:02:54 +0800
Message-Id: <1614567775-4478-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZH09MTBodT0xCTUgYVkpNSk9OTUxMQ0NNTE9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzY6EBw6Oj8LPRA*OT0OPR42
        CxoKFDBVSlVKTUpPTk1MTENCS0tIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTkhDNwY+
X-HM-Tid: 0a77ebbd5028b038kuuu656a15401a3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch gives the warning:
	lib/decompress_unlzma.c:395 process_bit1() warn: inconsistent indenting

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 lib/decompress_unlzma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/decompress_unlzma.c b/lib/decompress_unlzma.c
index 1cf409e..20a8580
--- a/lib/decompress_unlzma.c
+++ b/lib/decompress_unlzma.c
@@ -391,7 +391,7 @@ static inline int INIT process_bit0(struct writer *wr, struct rc *rc,
 static inline int INIT process_bit1(struct writer *wr, struct rc *rc,
 					    struct cstate *cst, uint16_t *p,
 					    int pos_state, uint16_t *prob) {
-  int offset;
+	int offset;
 	uint16_t *prob_len;
 	int num_bits;
 	int len;
-- 
2.7.4

