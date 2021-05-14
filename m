Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D039738115C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhENUG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhENUG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:06:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C1C16134F;
        Fri, 14 May 2021 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621022745;
        bh=6HQ4i41x2W6L18KGACfxOUHJl8ZeDEuYjx2rHL7bWwA=;
        h=From:To:Cc:Subject:Date:From;
        b=lmmWfaUO8gcZsen3JNvjqN/INR+pmOieZahdIuOJauyxJbht7az+xaNJSgRaMjSWr
         gr4Mc3wLhYleXIgmAa/tx6KMM22oJE2JDogSDLB0nVJDcpyiIweYVN9GJsw8HZUnQn
         sH0FjsczMNaG5VKWGObFZiCt7mxQgt0JG5TcsZKDThC2MvHBSv1q3quo82YQ1mAhYW
         BMhV/7lg/r6ALhUNoycu7hLXtd9wJUK9BX+/hbIOkMDuF/lcMBYmtwzFLKR5X788o+
         qtG4MeA1heZfOlREHaTwRBRAA9YuroLIOSNkmAj6wV9/zWa0E8mG0QfKgshBTOBohN
         6h0FrELO/aMLg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] platform/surface: aggregator: avoid clang -Wconstant-conversion warning
Date:   Fri, 14 May 2021 22:04:36 +0200
Message-Id: <20210514200453.1542978-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang complains about the assignment of SSAM_ANY_IID to
ssam_device_uid->instance:

drivers/platform/surface/surface_aggregator_registry.c:478:25: error: implicit conversion from 'int' to '__u8' (aka 'unsigned char') changes value from 65535 to 255 [-Werror,-Wconstant-conversion]
        { SSAM_VDEV(HUB, 0x02, SSAM_ANY_IID, 0x00) },
        ~                      ^~~~~~~~~~~~
include/linux/surface_aggregator/device.h:71:23: note: expanded from macro 'SSAM_ANY_IID'
 #define SSAM_ANY_IID            0xffff
                                ^~~~~~
include/linux/surface_aggregator/device.h:126:63: note: expanded from macro 'SSAM_VDEV'
        SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, tid, iid, fun)
                                                                     ^~~
include/linux/surface_aggregator/device.h:102:41: note: expanded from macro 'SSAM_DEVICE'
        .instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,                        \
                                               ^~~

The assignment doesn't actually happen, but clang checks the type limits
before checking whether this assignment is reached. Replace the ?:
operator with a __builtin_choose_expr() invocation that avoids the
warning for the untaken part.

Fixes: eb0e90a82098 ("platform/surface: aggregator: Add dedicated bus and device type")
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use __builtin_choose_expr() instead of a cast to shut up the warning
---
 include/linux/surface_aggregator/device.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 4441ad667c3f..6ff9c58b3e17 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -98,9 +98,9 @@ struct ssam_device_uid {
 		     | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),	\
 	.domain   = d,								\
 	.category = cat,							\
-	.target   = ((tid) != SSAM_ANY_TID) ? (tid) : 0,			\
-	.instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,			\
-	.function = ((fun) != SSAM_ANY_FUN) ? (fun) : 0				\
+	.target   = __builtin_choose_expr((tid) != SSAM_ANY_TID, (tid), 0),	\
+	.instance = __builtin_choose_expr((iid) != SSAM_ANY_IID, (iid), 0),	\
+	.function = __builtin_choose_expr((fun) != SSAM_ANY_FUN, (fun), 0)
 
 /**
  * SSAM_VDEV() - Initialize a &struct ssam_device_id as virtual device with
-- 
2.29.2

