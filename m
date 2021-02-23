Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81C5322807
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhBWJry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:47:54 -0500
Received: from m12-13.163.com ([220.181.12.13]:36971 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhBWJrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HJQaZ
        cNJ//rTNxUIXY+A3MZAryV+VtXxzjsGLHsl9dk=; b=Hcdvci9az8UDSv+pPNsPa
        ghXSUGRhU7zG6b3+8KYocJczp7vLcc7r9ZNGU0QxDe7LTYGGc2lG+28jniT/s/KJ
        OIO/thLgbSdsS/FwY7UZgX3SocUn+b4yUJIWDT3jb/20RPnlvTeb98Zx5Z1RtUNv
        lVVi8EIEn9/9GWl1R4FNxA=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp9 (Coremail) with SMTP id DcCowABnZQIJyjRgGJ3JgQ--.12282S2;
        Tue, 23 Feb 2021 17:25:35 +0800 (CST)
From:   zuoqilin1@163.com
To:     peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] include/linux: remove duplicate description
Date:   Tue, 23 Feb 2021 17:25:39 +0800
Message-Id: <20210223092539.941-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABnZQIJyjRgGJ3JgQ--.12282S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIJPEDUUUU
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiZQ9CiV8ZM2owagAAsk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

linux/spinlock.h

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 include/linux/spinlock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 7989784..732150e 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -43,8 +43,6 @@
  *
  *  linux/spinlock_api_up.h:
  *                        builds the _spin_*() APIs.
- *
- *  linux/spinlock.h:     builds the final spin_*() APIs.
  */
 
 #include <linux/typecheck.h>
-- 
1.9.1


