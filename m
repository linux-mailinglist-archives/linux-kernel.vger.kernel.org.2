Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6423ACE63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhFRPRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:17:07 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:48988 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFRPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:17:06 -0400
DKIM-Signature: a=rsa-sha256;
        b=Bz0r8uYyPM98aHAe5UMPi4gZvyNYM1hyGSpqr5L/MeQ6Q3znO7eCvOwMco0C4DKvdXpdlnlArpG1HrGJy+M1SgqY9PVNjUJeJLGT6Huvwd3L3xqfD5oJkuy0Mu0MZYN2FgdDvt6K9dcBoGHJW8TNS+rc2RwNmXHJ2obC4zyK3WI=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=WUFv4LRD+NHrRC3a1phX1cKlBvVWd+7I1lPNQTHkgM8=;
        h=date:mime-version:subject:message-id:from;
Received: from wanjb-KLV-WX9.. (unknown [121.229.73.16])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 8BF8BAC0167;
        Fri, 18 Jun 2021 23:14:50 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] mm/percpu: Fix gfp flag in pcpu_balance_populated
Date:   Fri, 18 Jun 2021 23:14:36 +0800
Message-Id: <20210618151436.38217-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGhhCHlZOSB1NGEsaHUMYQk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46Myo*Gj8LN0IdVgEaHUIY
        MTgKCyFVSlVKTUlPS0lCSUJKS0xIVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlK
        SUpVSUlCVUxIVUpNWVdZCAFZQUpDQkw3Bg++
X-HM-Tid: 0a7a1fb060e5b039kuuu8bf8bac0167
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:

./mm/percpu.c:2045:19-29: ERROR: function pcpu_balance_populated
called on line 2232 inside lock on line 2228 but uses GFP_KERNEL

When pcpu_balance_populated() is called in pcpu_balance_workfn(),
it helds spin_lock but use GFP_KERNEL to alloc mem, which is unsafe.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index b4cebeca4c0c..4031f32e6975 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2042,7 +2042,7 @@ static void pcpu_balance_free(bool empty_only)
 static void pcpu_balance_populated(void)
 {
 	/* gfp flags passed to underlying allocators */
-	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
+	const gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
 	struct pcpu_chunk *chunk;
 	int slot, nr_to_pop, ret;
 
-- 
2.30.2

