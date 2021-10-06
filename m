Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21758424424
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhJFRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:30:27 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:60696
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhJFRaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:30:24 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E7DC83FFE4;
        Wed,  6 Oct 2021 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633541311;
        bh=pPk5dCPPW2RNEpebScPcrw2OoSwA7+zGEwKS8BQvN9I=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=YWol+DExS1hl6PHDrTTgNS62HQKzz9IKOoNxRNWPT5XpoqCigHZ8U8rm5d0zww7Q5
         3SDilFT6z0/Kw/EyFGtMAc/8hecB0NXNXcLZm9yWISOuh+2EwBwIDD3k6MUMsebQsA
         F9nk28RYha/wbUbJ5lHlPBhVDCoKQnrqPZhMuijJ5+bM6PS9gkkw47TGV/jr3A8r4b
         H30P/RK5zJiiiUikewGeFPbphDbYfZZNFVAXnXKjAZqtv8+ubGFcNPuajMBNc7TZu1
         UAkOaopZPl+qQZaq/+Agd5PpYq+Qg5twVWti0xiL7rdD9D657IkN65Xo9zeiIbhpo5
         GG4dfOR2QhEmQ==
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: fix missing * in comment block
Date:   Wed,  6 Oct 2021 18:28:30 +0100
Message-Id: <20211006172830.1025336-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a missing * in a comment block, add it in.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a6061a69aa84..f01e442716e2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2506,7 +2506,7 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
  * events.  However, for convenience, users are allowed to directly
  * specify an event field in an action, which will be automatically
  * converted into a variable on their behalf.
-
+ *
  * If a user specifies a field on an event that isn't the event the
  * histogram currently being defined (the target event histogram), the
  * only way that can be accomplished is if a new hist trigger is
-- 
2.32.0

