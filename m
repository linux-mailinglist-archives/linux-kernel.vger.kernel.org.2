Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B7F43AE26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhJZIg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233353AbhJZIg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B32FA60E75;
        Tue, 26 Oct 2021 08:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635237243;
        bh=KhCKgXvLcov+EFdzf9jDKXqDhuGa1G79WzeoutDBO6I=;
        h=From:To:Cc:Subject:Date:From;
        b=CaXii8800WZSoF23eIYDmA7cfV9mylwV8iQfy1vaZ8vkIRAqjqH50N4ctyYllVGdA
         zYgqyIaPQKVw8W41zfqj5jFyZprrSOaFZLoyBQ0lDWDa1m6v6UbwHolEfH7AxTnE6d
         NEBR5EkR176h+e+uhbVxEilFaOsz9zxn9QnSYum2I6UbQ6PrWvpRHKEgArWftyXoYb
         o9zaPvDWyZNcvM2khqlzGbM0k//2q+/83E+yyE6weQTaXUCeZ14m/xMERcXm2/eSWv
         tPF1eYGSIvWV9BD09Sc0Xid0emLxD6Mcgdqwu31WCC01SiH9P4MijSP3O3SiRUMv/S
         mVsgx7cCIxu6A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Bonnici <marc.bonnici@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_ffa: remove unused 'compat_version' variable
Date:   Tue, 26 Oct 2021 10:33:50 +0200
Message-Id: <20211026083400.3444946-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added ffa_compatible_version_find() function causes a
build warning because of a variable that is never used:

drivers/firmware/arm_ffa/driver.c:180:6: error: unused variable 'compat_version' [-Werror,-Wunused-variable]
        u32 compat_version;

Fixes: 8e3f9da608f1 ("firmware: arm_ffa: Handle compatibility with different firmware versions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/arm_ffa/driver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 12f4c87c4555..14f900047ac0 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -177,7 +177,6 @@ static struct ffa_drv_info *drv_info;
  */
 static u32 ffa_compatible_version_find(u32 version)
 {
-	u32 compat_version;
 	u16 major = MAJOR_VERSION(version), minor = MINOR_VERSION(version);
 	u16 drv_major = MAJOR_VERSION(FFA_DRIVER_VERSION);
 	u16 drv_minor = MINOR_VERSION(FFA_DRIVER_VERSION);
-- 
2.29.2

