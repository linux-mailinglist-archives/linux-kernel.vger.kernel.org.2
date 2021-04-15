Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E62360767
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhDOKpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhDOKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:45:49 -0400
X-Greylist: delayed 411 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Apr 2021 03:45:27 PDT
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:45:27 -0700 (PDT)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4FLbR84XjKz8vJJ;
        Thu, 15 Apr 2021 12:38:28 +0200 (CEST)
Authentication-Results: mx-rz-1.rrze.uni-erlangen.de; dkim=none;
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:ca:a714:1700:84d6:d253:8cf6:4739
Received: from uni-erlangen.de (p200300caa714170084d6d2538cf64739.dip0.t-ipconnect.de [IPv6:2003:ca:a714:1700:84d6:d253:8cf6:4739])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+c3+KQmswcoImi8NOqTbiQsoVWK/3ECfw=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4FLbR62SBbz8slf;
        Thu, 15 Apr 2021 12:38:26 +0200 (CEST)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     jonas.rabenstein@studium.uni-erlangen.de
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: vfp: fix misspelled identifier in documentation
Date:   Thu, 15 Apr 2021 12:39:55 +0200
Message-Id: <20210415103955.38983-1-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation comment for vfp_notifier misspelled
THREAD_NOTIFY_SWITCH as THREAD_NOFTIFY_SWITCH.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 arch/arm/vfp/vfpmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2cb355c1b5b7..4f8c6f583b79 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -140,7 +140,7 @@ static void vfp_thread_copy(struct thread_info *thread)
 /*
  * When this function is called with the following 'cmd's, the following
  * is true while this function is being run:
- *  THREAD_NOFTIFY_SWTICH:
+ *  THREAD_NOTIFY_SWITCH:
  *   - the previously running thread will not be scheduled onto another CPU.
  *   - the next thread to be run (v) will not be running on another CPU.
  *   - thread->cpu is the local CPU number
-- 
2.26.3

