Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963CB36D85F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbhD1Ng4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhD1Ngy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:36:54 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4278C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 06:36:09 -0700 (PDT)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4FVfm52xT0zPlDh;
        Wed, 28 Apr 2021 15:36:05 +0200 (CEST)
Authentication-Results: mx-rz-2.rrze.uni-erlangen.de; dkim=none;
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:ca:a725:dc00:6ce5:3887:ad87:1dc5
Received: from uni-erlangen.de (p200300caa725dc006ce53887ad871dc5.dip0.t-ipconnect.de [IPv6:2003:ca:a725:dc00:6ce5:3887:ad87:1dc5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19Z3az2CUOw4sz1J5s4sgTGfcb5Q7xzIn0=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4FVfm30bFFzPjln;
        Wed, 28 Apr 2021 15:36:03 +0200 (CEST)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     Russel King <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH RESEND] ARM: vfp: fix misspelled identifier in documentation
Date:   Wed, 28 Apr 2021 15:35:26 +0200
Message-Id: <20210428133525.7932-1-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210415103955.38983-1-jonas.rabenstein@studium.uni-erlangen.de>
References: <20210415103955.38983-1-jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation comment for vfp_notifier misspelled
THREAD_NOTIFY_SWITCH as THREAD_NOFTIFY_SWTICH.

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

