Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A3130BA3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhBBIsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:48:17 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:52642
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229975AbhBBIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:48:15 -0500
X-Greylist: delayed 680 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 03:48:13 EST
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgBXXLiBERlgGBSsAQ--.28843S3;
        Tue, 02 Feb 2021 16:46:57 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] mm/hugetlb.c: Fix typos in comments
Date:   Tue,  2 Feb 2021 16:46:33 +0800
Message-Id: <1612255593-8451-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgBXXLiBERlgGBSsAQ--.28843S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyrur47trWfXw1DXr4fZrb_yoWxZrXE9a
        yvyrWrG3WYqr9xAF45KryUtr1Ikrn8urnrAay3Cry3ta4FyF95GFyrWw4UuF1YgayUurW3
        CF9Ikw43Cw43ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
        42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUCVW8JwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfU07KsUUUUU
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 18f6ee3..35db386 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3990,7 +3990,7 @@ void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 
 /*
  * This is called when the original mapper is failing to COW a MAP_PRIVATE
- * mappping it owns the reserve page for. The intention is to unmap the page
+ * mapping it owns the reserve page for. The intention is to unmap the page
  * from other VMAs and let the children be SIGKILLed if they are faulting the
  * same region.
  */
-- 
1.8.3.1

