Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33743403164
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 01:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbhIGXIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 19:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbhIGXI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:08:26 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F4C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 16:07:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u18so511934pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwF+uk4h0Q1umToETm1wSoxu43zMCRIT8w9IMnjEHV0=;
        b=QyrR0miitsDLHFxHwW/c2YMdVouLCh5puRLaMpvMtWaHTod8Jp163Wd9bq+Id67Bn5
         dTxdwqTOM6ACH39p7VvRDEKsY2zv1qbzWOExq+C3wC/5xbx0MSTXgCIjpaFJ6gjtHRjn
         5KfI09NDaUaN+0cAVAQRSWzM6WXAxVnZfodvYQhUOYZsPTPHeZLZtko+OwR45uzZROr5
         JV+4UBsGPX7y6I/rFSlxuatbMjYdUePjB2eUsI+6RfK/uPC7WaHLgZ/JnPa1+bH5CTqm
         O7nS39KbAw1Hkdqb32Nj3h0qiMDY/cG+CN/lpT/F/hoddZX3ZeJaXJY+BfS5sOqISTCH
         xoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwF+uk4h0Q1umToETm1wSoxu43zMCRIT8w9IMnjEHV0=;
        b=KnhAC2lp4jyyYgWo5e//uJO5mBUTAjROE5UyYMFPs/bebq5qTPBfKX/7MKL8U8ohKb
         +pbyhecoPDACJVgA3kJQvMqF+gftw1wmhI35mBnp8IK7JnQ1eP6aZpT0z2V8h6PxU0Ok
         Hw47wi0k6aHe3CDpJHw+6FRBsH8onN4bpZQxWnZxr+JtvuQrKmGMJUYdSD9B0amo/mv6
         lBh4/65tvKGH56DlcdNTG4xoTvUlB2IS+9v8ahwbMNZOdB2KShCOCZ1bOdQZSKcQxYiv
         GiMEraKwbCeg8pS2q4oxAY3shlDd4V+MxUXKX2klD6OQ9Ckxu8nRSFKbk8iVRcbOWeiW
         0iag==
X-Gm-Message-State: AOAM533HCXdsE61XbXqBfE/MuFMa3EIz1t9h8PIKDDCoQ3M1LIh4li8t
        6OFIZF+1ixpLrra9eX0RyUgPQuUJ1WN/bg==
X-Google-Smtp-Source: ABdhPJzaUZo/T2o8TslCQlXEXk0uQ0pMEcLdto5uRhRFUsjbE/uoRTAsNkxRpzw2jPDDh8Dbu6+uLg==
X-Received: by 2002:a65:494e:: with SMTP id q14mr688620pgs.314.1631056039526;
        Tue, 07 Sep 2021 16:07:19 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id x64sm131237pfd.194.2021.09.07.16.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 16:07:18 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Punit Agrawal <punitagrawal@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RESEND PATCH] tools/bootconfig: Fix a compilation issue with missing variable
Date:   Wed,  8 Sep 2021 08:07:10 +0900
Message-Id: <20210907230710.1189193-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking to build bootconfig tool in order to debug a kernel boot
time issue I noticed that tool fails to compile. The broken changes
were introduced by commit e5efaeb8a8f5 ("bootconfig: Support mixing a
value and subkeys under a key").

Fix the compile issue by introducing a "ret" variable to track the
return value from xbc_node_compose_key().

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---

(Apologies for the resend. I fat-fingered the email address for lkml)

Hi Masami,

I am not sure what went wrong but the patch in the lore link[0]
doesn't match the end result (bad merge?). You may want to recheck the
other changes to make sure it all looks sane.

Regards,
Punit

[0] https://lkml.kernel.org/r/162262194685.264090.7738574774030567419.stgit@devnote2
---
 tools/bootconfig/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index f45fa992e01d..fd67496a947f 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -111,9 +111,11 @@ static void xbc_show_list(void)
 	char key[XBC_KEYLEN_MAX];
 	struct xbc_node *leaf;
 	const char *val;
+	int ret;
 
 	xbc_for_each_key_value(leaf, val) {
-		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0) {
+		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
+		if (ret < 0) {
 			fprintf(stderr, "Failed to compose key %d\n", ret);
 			break;
 		}
-- 
2.32.0

