Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD940A6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhINGZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:25:17 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46664 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239936AbhINGZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:25:14 -0400
Received: from localhost.localdomain (unknown [10.2.5.180])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH2v4P0Bh3U0GAA--.10627S2;
        Tue, 14 Sep 2021 14:23:52 +0800 (CST)
From:   bibo mao <maobibo@loongson.cn>
To:     Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/qxl: User page size macro for qxl release bo
Date:   Tue, 14 Sep 2021 02:23:51 -0400
Message-Id: <20210914062352.6102-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxH2v4P0Bh3U0GAA--.10627S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JF4DuF15ArW5Gr47ZF17Awb_yoW8Jry7pF
        W7Ar1jqr4UX3W7tFZ8J3WYqr1fCa9Ygas7GFZ7X3ySk3W7J34DGr15JF4FyFW8uFWfAFy3
        uF1kKFWaq3W7Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE-syl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUq_b1DUUUU
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures have different default page size, this patch
replaces hardcoded 4096 with PAGE_SIZE macro, since cmd bo size
is page aligned.

Signed-off-by: bibo mao <maobibo@loongson.cn>
---
 drivers/gpu/drm/qxl/qxl_release.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index b19f2f00b215..469979cd0341 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -36,10 +36,10 @@
 /* manage releaseables */
 /* stack them 16 high for now -drawable object is 191 */
 #define RELEASE_SIZE 256
-#define RELEASES_PER_BO (4096 / RELEASE_SIZE)
+#define RELEASES_PER_BO (PAGE_SIZE / RELEASE_SIZE)
 /* put an alloc/dealloc surface cmd into one bo and round up to 128 */
 #define SURFACE_RELEASE_SIZE 128
-#define SURFACE_RELEASES_PER_BO (4096 / SURFACE_RELEASE_SIZE)
+#define SURFACE_RELEASES_PER_BO (PAGE_SIZE / SURFACE_RELEASE_SIZE)
 
 static const int release_size_per_bo[] = { RELEASE_SIZE, SURFACE_RELEASE_SIZE, RELEASE_SIZE };
 static const int releases_per_bo[] = { RELEASES_PER_BO, SURFACE_RELEASES_PER_BO, RELEASES_PER_BO };
-- 
2.27.0

