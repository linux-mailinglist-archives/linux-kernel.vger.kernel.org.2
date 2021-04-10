Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1AE35AB80
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 08:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhDJGt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 02:49:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16436 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJGtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 02:49:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FHQXt5HmtzqSs5;
        Sat, 10 Apr 2021 14:47:26 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.196) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 10 Apr 2021 14:49:32 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <linqiheng@huawei.com>, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] staging: comedi: tests: ni_routes_test: Remove unused variable 'olddevroutes'
Date:   Sat, 10 Apr 2021 14:49:32 +0800
Message-ID: <20210410064932.12905-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC reports the following warning with W=1:

drivers/staging/comedi/drivers/tests/ni_routes_test.c:215:45: warning:
 variable 'olddevroutes' set but not used [-Wunused-but-set-variable]
  215 |  const struct ni_device_routes *devroutes, *olddevroutes;
      |                                             ^~~~~~~~~~~~

This variable is not used in function , this commit
remove it to fix the warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 .../staging/comedi/drivers/tests/ni_routes_test.c  | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/tests/ni_routes_test.c b/drivers/staging/comedi/drivers/tests/ni_routes_test.c
index 48e4a7a9cd14..652362486ff6 100644
--- a/drivers/staging/comedi/drivers/tests/ni_routes_test.c
+++ b/drivers/staging/comedi/drivers/tests/ni_routes_test.c
@@ -212,7 +212,7 @@ static bool route_set_sources_in_order(const struct ni_device_routes *devroutes)
 
 static void test_ni_assign_device_routes(void)
 {
-	const struct ni_device_routes *devroutes, *olddevroutes;
+	const struct ni_device_routes *devroutes;
 	const u8 *table, *oldtable;
 
 	init_pci_6070e();
@@ -248,7 +248,6 @@ static void test_ni_assign_device_routes(void)
 		 RVI(table, B(NI_AI_ConvertClock), B(NI_PFI(2))) == V(NI_PFI_OUTPUT_AI_CONVERT),
 		 "pci-6070e finds e-series route_values table\n");
 
-	olddevroutes = devroutes;
 	oldtable = table;
 	init_pci_6220();
 	ni_assign_device_routes(ni_mseries, pci_6220, NULL,

