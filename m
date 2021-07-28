Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EB23D97BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 23:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhG1VsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 17:48:11 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:41750
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbhG1VsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 17:48:09 -0400
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net [80.193.200.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0F1503F22A;
        Wed, 28 Jul 2021 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627508886;
        bh=KTx7uSHZFWtdvze48agVBSI9iZgb4TB+WGbELF87yVo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=ZKK/b0cFdj90WL36PnosAuS6AGPi+VcD6ZZml2KZl6SyA1mM0VUQsyfrEf05kjVZ/
         328t5Iq0W93TF/JQuiQLHJNhpoFIvmDtxKwWvO/PRx3Gf3VTakR84ga+DXSyHaeztf
         8MxH8Wt2jz4lYiel+V0Bn0+Gr9nej/J6c4Z0Dr9sEVAquGfA/fco8d87I7idqlG+lN
         YTR0F3RYnVPqQVxU/FAusnAfHPbTCVHaHZ0t8jrq/Ag7Xk/yxPFJa6//Q23Wt0QP8l
         EXCm9IwTr5QPXRn+qShMXcUvW2//evOf5RScYWLeOH26ZqjYrs18xnbwhjOkpUv0b8
         crRyl0/bNJK1w==
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] trace: Fix spelling contraction "wont" -> "won't" in Kconfig
Date:   Wed, 28 Jul 2021 22:48:02 +0100
Message-Id: <20210728214802.191667-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/trace/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d567b1717c4c..61f5d91b4bdd 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -857,7 +857,7 @@ config RING_BUFFER_RECORD_RECURSION
 	default y
 	help
 	  The ring buffer has its own internal recursion. Although when
-	  recursion happens it wont cause harm because of the protection,
+	  recursion happens it won't cause harm because of the protection,
 	  but it does cause an unwanted overhead. Enabling this option will
 	  place where recursion was detected into the ftrace "recursed_functions"
 	  file.
-- 
2.31.1

