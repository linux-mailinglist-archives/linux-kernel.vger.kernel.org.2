Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B091441D149
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347746AbhI3CGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:06:50 -0400
Received: from out28-4.mail.aliyun.com ([115.124.28.4]:57764 "EHLO
        out28-4.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347294AbhI3CGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:06:49 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07507384|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00546256-0.000187962-0.994349;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=weidonghui@allwinnertech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.LSQfo5n_1632967501;
Received: from INTERNET-137.allwinnertech.com(mailfrom:weidonghui@allwinnertech.com fp:SMTPD_---.LSQfo5n_1632967501)
          by smtp.aliyun-inc.com(10.147.41.187);
          Thu, 30 Sep 2021 10:05:05 +0800
From:   unknown <weidonghui@allwinnertech.com>
To:     bp@suse.de, akpm@linux-foundation.org
Cc:     maz@misterjones.org, will@kernel.org, rabin@rab.in,
        linux-kernel@vger.kernel.org,
        weidonghui <weidonghui@allwinnertech.com>
Subject: [PATCH v3] scripts/decodecode: fix faulting instruction no print when opps.file is DOS format
Date:   Thu, 30 Sep 2021 10:04:39 +0800
Message-Id: <20210930020439.3605-1-weidonghui@allwinnertech.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: weidonghui <weidonghui@allwinnertech.com>

If opps.file is in DOS format, faulting instruction cannot be printed:
/ # ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
/ # ./scripts/decodecode < oops.file
[ 0.734345] Code: d0002881 912f9c21 94067e68 d2800001 (b900003f)
aarch64-linux-gnu-strip: '/tmp/tmp.5Y9eybnnSi.o': No such file
aarch64-linux-gnu-objdump: '/tmp/tmp.5Y9eybnnSi.o': No such file
All code
========
   0:   d0002881        adrp    x1, 0x512000
   4:   912f9c21        add     x1, x1, #0xbe7
   8:   94067e68        bl      0x19f9a8
   c:   d2800001        mov     x1, #0x0                        // #0
  10:   b900003f        str     wzr, [x1]

Code starting with the faulting instruction
===========================================

Background: The compilation environment is Ubuntu,
and the test environment is Windows.
Most logs are generated in the Windows environment.
In this way, CR (carriage return) will inevitably appear,
which will affect the use of decodecode in the Ubuntu environment.
The repaired effect is as follows:
/ # ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
/ # ./scripts/decodecode < oops.file
[ 0.734345] Code: d0002881 912f9c21 94067e68 d2800001 (b900003f)
All code
========
   0:   d0002881        adrp    x1, 0x512000
   4:   912f9c21        add     x1, x1, #0xbe7
   8:   94067e68        bl      0x19f9a8
   c:   d2800001        mov     x1, #0x0                        // #0
  10:*  b900003f        str     wzr, [x1]               <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:   b900003f        str     wzr, [x1]

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Marc Zyngier <maz@misterjones.org>
Cc: Will Deacon <will@kernel.org>
Cc: Rabin Vincent <rabin@rab.in>
Cc: lkml <linux-kernel@vger.kernel.org>
Signed-off-by: weidonghui <weidonghui@allwinnertech.com>
---
 scripts/decodecode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodecode b/scripts/decodecode
index 31d884e35f2f..77a3b518aacc 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -126,7 +126,7 @@ if [ $marker -ne 0 ]; then
 fi
 echo Code starting with the faulting instruction  > $T.aa
 echo =========================================== >> $T.aa
-code=`echo $code | sed -e 's/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
+code=`echo $code | sed -e 's/\x0d//;s/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
 echo -n "	.$type 0x" > $T.s
 echo $code >> $T.s
 disas $T 0
-- 
2.22.0.windows.1

