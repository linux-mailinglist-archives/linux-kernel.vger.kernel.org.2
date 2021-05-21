Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278D138CE46
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbhEUTja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbhEUTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:39:28 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:38:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laumann.xyz; s=key1;
        t=1621625880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a3RbctWiG7mAdUUaLQidbfNDvZPWuModxVqgzLZX4KE=;
        b=3uStrjdMUAh67PvequT0+uDQLtG+z+dzxZmwZVOUVct2vyblsfyqG+OmW+xG2BZL7EC6Wt
        zD9yHPELUl6nVTmbG7Eq4agpGJMcZaMrOX2lEex8o6C+JDd8p4ojc96DA1E9hkpsdvuSOM
        Nnp/ssBqfd/Sz0BDNKGPBZEa7YFLBPY5xX9gzy/6UAAt/h64fv1rluheG8bZXPAiz8pOVE
        oj6huqazgzlmQ/5Zwj0YXFMuk4ddguA05FEOCDfdU37bOuVvISxUiyJlfMMD4E0xsFBVAB
        QO/pgY4kM65PJVxKQ76fBFeQKj2bXIMWT5G1Fb8fuGDEfDWJ690meUwdLn0iHg==
From:   Thomas Bracht Laumann Jespersen <t@laumann.xyz>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Bracht Laumann Jespersen <t@laumann.xyz>
Subject: [PATCH] staging: rtl8192e: Fix shadowed variable name
Date:   Fri, 21 May 2021 21:37:12 +0200
Message-Id: <20210521193711.5457-1-t@laumann.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: t@laumann.xyz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:

drivers/staging/rtl8192e/rtllib_tx.c:884:32: warning: symbol 'tcb_desc' shadows an earlier one
drivers/staging/rtl8192e/rtllib_tx.c:569:24: originally declared here

Signed-off-by: Thomas Bracht Laumann Jespersen <t@laumann.xyz>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 89ec72b1895a..37715afb0210 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -881,7 +881,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 
  success:
 	if (txb) {
-		struct cb_desc *tcb_desc = (struct cb_desc *)
+		tcb_desc = (struct cb_desc *)
 				(txb->fragments[0]->cb + MAX_DEV_ADDR_SIZE);
 		tcb_desc->bTxEnableFwCalcDur = 1;
 		tcb_desc->priority = skb->priority;
-- 
2.26.3

