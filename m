Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271D14432CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbhKBQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234673AbhKBQG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:06:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5CBD610FC;
        Tue,  2 Nov 2021 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635869013;
        bh=oRT/FmZplSaoJey7CINetDmKzmY3y11l8ZtjzjuLNT4=;
        h=From:To:Cc:Subject:Date:From;
        b=gjK1iB0tJm8BpurKxt3zIG/gnTjtJ3IZDq6pOyzVxRZtqFpM3213F7/Ya6bUjJ11H
         mmjY4YXTRRjmeVnrMx3bQsKkRYbiKI6kbg+FKjbUz9kskmGoLxr3DyTbA/Brj7tAn9
         KMMHiNfEkMevWsoEMaOhtLwV1Q4AUTT4V3mjK/CsXH0OVJiYgQXQCP1o5T1PCgoL/u
         ZxyPMyNOb9uYKqeHMGu5g+PgNCMws2818Bi/e4JLvJVUIxbgdvNrhnTvpfxVEKADBw
         y3dKw37zGqf8bs+RitG7GZmNQq3QXrlTIrmSR5Fe7oS+hwYSOX311p4txg5ZzBCYfJ
         cV8LxObiZ8RNA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] soc: ti: wkup_m3_ipc: Fix return type error in wkup_m3_rproc_boot_thread()
Date:   Tue,  2 Nov 2021 09:03:15 -0700
Message-Id: <20211102160315.1067553-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function should not return a value:

drivers/soc/ti/wkup_m3_ipc.c: In function 'wkup_m3_rproc_boot_thread':
drivers/soc/ti/wkup_m3_ipc.c:429:16: error: 'return' with a value, in function returning void [-Werror=return-type]
  429 |         return 0;
      |                ^
drivers/soc/ti/wkup_m3_ipc.c:416:13: note: declared here
  416 | static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Fixes: 111e70490d2a ("exit/kthread: Have kernel threads return instead of calling do_exit")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/soc/ti/wkup_m3_ipc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 0733443a2631..2238beb40f8d 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -425,8 +425,6 @@ static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
 		dev_err(dev, "rproc_boot failed\n");
 	else
 		m3_ipc_state = m3_ipc;
-
-	return 0;
 }
 
 static int wkup_m3_ipc_probe(struct platform_device *pdev)

base-commit: ac4fdfaf4792d41ad7b24d1c8ab486aeb7ccd495
-- 
2.34.0.rc0

