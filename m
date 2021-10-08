Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF34C4264E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhJHGuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 02:50:40 -0400
Received: from out28-5.mail.aliyun.com ([115.124.28.5]:36512 "EHLO
        out28-5.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhJHGui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 02:50:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07481803|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00616003-0.00015388-0.993686;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=weidonghui@allwinnertech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.LVleL2x_1633675714;
Received: from INTERNET-137.allwinnertech.com(mailfrom:weidonghui@allwinnertech.com fp:SMTPD_---.LVleL2x_1633675714)
          by smtp.aliyun-inc.com(10.147.38.183);
          Fri, 08 Oct 2021 14:48:41 +0800
From:   unknown <weidonghui@allwinnertech.com>
To:     bp@suse.de
Cc:     akpm@linux-foundation.org, maz@misterjones.org, will@kernel.org,
        rabin@rab.in, linux-kernel@vger.kernel.org,
        weidonghui <weidonghui@allwinnertech.com>
Subject: [PATCH v4] scripts/decodecode: fix faulting instruction no print when opps.file is DOS format
Date:   Fri,  8 Oct 2021 14:47:12 +0800
Message-Id: <20211008064712.926-1-weidonghui@allwinnertech.com>
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

Cc: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Marc Zyngier <maz@misterjones.org>
Cc: Will Deacon <will@kernel.org>
Cc: Rabin Vincent <rabin@rab.in>
Cc: lkml <linux-kernel@vger.kernel.org>
Signed-off-by: weidonghui <weidonghui@allwinnertech.com>
---
 scripts/decodecode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodecode b/scripts/decodecode
index 31d884e35f2f..c711a196511c 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -126,7 +126,7 @@ if [ $marker -ne 0 ]; then
 fi
 echo Code starting with the faulting instruction  > $T.aa
 echo =========================================== >> $T.aa
-code=`echo $code | sed -e 's/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
+code=`echo $code | sed -e 's/\r//;s/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
 echo -n "	.$type 0x" > $T.s
 echo $code >> $T.s
 disas $T 0
-- 
2.22.0.windows.1

