Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346CB426082
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbhJGXgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:36:55 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:59700
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239415AbhJGXgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:36:49 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8ACC13FFE8;
        Thu,  7 Oct 2021 23:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633649692;
        bh=RPQpln4G93Q7K4DTSU9GOAGrfF0KJBA8LQyljPm4gZk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=cwOh0nomoH6as2C9XYWCWQl3dQh6kjl5PXbJCYOW+eXyVP8QFEDTYYesuEIH2PSAh
         /kpSg5HQ8uPNeMQvSZqN1tjy66rHz3fxNRuouoir3t5NS75NMUuYjNf7AWa9VUzizt
         CwJIxOtPJXOu8CDauB0etnUE/1XH1eu8n2Tq06xnIOHHkgkxNrNLQutiY5e1GcCiD1
         5ShFmt6IqWfl6W1GQQBbBDrr8nvxkL32IqsW4jZQJjE+FBVWJgS4tRchWlBdl2cttJ
         3+9O7qZ4VxN8nFjmtUVzbrzQ6+xhHISAaB4rGVg1Wnoc/uF9I2D/W3SFARlny/N05N
         GxMbmhwOIrC/w==
From:   Colin King <colin.king@canonical.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2/dlm: Remove redundant assignment of variable ret
Date:   Fri,  8 Oct 2021 00:34:52 +0100
Message-Id: <20211007233452.30815-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being assigned a value that is never read, it is
updated later on with a different value. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ocfs2/dlm/dlmrecovery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index e24e327524f8..52ad342fec3e 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -2698,7 +2698,6 @@ static int dlm_send_begin_reco_message(struct dlm_ctxt *dlm, u8 dead_node)
 			continue;
 		}
 retry:
-		ret = -EINVAL;
 		mlog(0, "attempting to send begin reco msg to %d\n",
 			  nodenum);
 		ret = o2net_send_message(DLM_BEGIN_RECO_MSG, dlm->key,
-- 
2.32.0

