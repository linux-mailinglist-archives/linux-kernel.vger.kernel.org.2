Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A555A3A4C70
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFLDhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:37:09 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:6270 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFLDhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:37:08 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G23BC4HCjz1BLdg;
        Sat, 12 Jun 2021 11:30:11 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 12 Jun 2021 11:35:02 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 12
 Jun 2021 11:35:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: trident: Fix build error
Date:   Sat, 12 Jun 2021 11:34:58 +0800
Message-ID: <20210612033458.42928-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/pci/trident/trident_memory.c: In function ‘set_tlb_bus’:
sound/pci/trident/trident_memory.c:85:35: error: ‘pagetr’ undeclared (first use in this function); did you mean ‘page’?
  for (i = 0; i < UNIT_PAGES; i++, pagetr++) {
                                   ^~~~~~
                                   page

Fixes: 74fb98311c4e ("ALSA: trident: Drop shadow TLB pointer table")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/trident/trident_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/trident/trident_memory.c b/sound/pci/trident/trident_memory.c
index f831ec02702f..4ad3855101c9 100644
--- a/sound/pci/trident/trident_memory.c
+++ b/sound/pci/trident/trident_memory.c
@@ -82,7 +82,7 @@ static inline void set_tlb_bus(struct snd_trident *trident, int page,
 {
 	int i;
 	page *= UNIT_PAGES;
-	for (i = 0; i < UNIT_PAGES; i++, pagetr++) {
+	for (i = 0; i < UNIT_PAGES; i++, page++) {
 		__set_tlb_bus(trident, page, addr);
 		addr += SNDRV_TRIDENT_PAGE_SIZE;
 	}
-- 
2.17.1

