Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDEC3EF870
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhHRDSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHRDSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:18:46 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79548C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:18:12 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c17so795051pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5+GyHW/4S3DPa6ifrE4AkuMeTrhrVLTRLEjOxHyD2Q=;
        b=jvz7/vMzC87FldKmkHelmV6pkdk0P1wtKugQDFaobnoogyZyd9WTlD+2gY3JoPs3a4
         uNgNQ5EYnBU09ao/wHlDQhOnOvFmC6o0zsSadfSlcMQo1CzXJaGWWkVwTRrOZ72SKLBh
         STpOMnZlEgMrj5TqH6O0zTJQp5fRZmJGUaQqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5+GyHW/4S3DPa6ifrE4AkuMeTrhrVLTRLEjOxHyD2Q=;
        b=C7Kq0jWFHQ/DQFq5p4AGZrEr5bJH3WB15icI2BzSSHEdqKIum7ZnqU7yvpGZ3mQZiS
         vM2Peqbs7+iaSFX1A8OFD9TBKHmjovp6/p7epGCSmT7BmIbbNV5U20bSUZs+3NSceefT
         sPkx4JZ0ArzuTovnhOYTPgkvamlPin3L0tVy1O/je0kRrG7z00FFg2N+D7wIwXxUOYsM
         Qq47xgONSSj87KCT+4FFKLbOfHF6GPfuTNtgO/+6XDYMO63venBoyE0C+GTQwJgMjxft
         lVVxi3Do6wYNE/pCpbEra3p5vRWyrgTds8VUTqsTmihs4ZOWu2U/U/tUzXPUpWhAjQdr
         wQAA==
X-Gm-Message-State: AOAM532wYbMU/whLu8I8qIIp8siNBZvRtSgMwel6tsNQa5dTzgnaO6Ow
        yRb0lg+ifPK3QYuJahENjwBA9w==
X-Google-Smtp-Source: ABdhPJxHgAcD+t24XepH6prWsbYT0xI/k6k9nDSdr1WcHPOqrmKg34/1qtWr4o5hweEMC438oWNP3g==
X-Received: by 2002:a65:6a09:: with SMTP id m9mr6595093pgu.269.1629256691973;
        Tue, 17 Aug 2021 20:18:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n15sm3984352pff.149.2021.08.17.20.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 20:18:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     Kees Cook <keescook@chromium.org>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] parisc: math-emu: Avoid "fmt" macro collision
Date:   Tue, 17 Aug 2021 20:18:09 -0700
Message-Id: <20210818031809.735689-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; h=from:subject; bh=BAykg0i7p0/8eJzpRw9Ux1XnGwbtnouiM7jianmwKDc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHHvwNns9GPVFId5XpY/rjNKgrEk3HM9CwndqYGZ7 iLquAeSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRx78AAKCRCJcvTf3G3AJq44D/ 0Rww7PARe1v7Xrgq0fvsUfOXkQFNiuN9/WGA/RNTsk7WD8KC5I6eMlNvPOB3pKqFkiHbjneOi4jxp6 3ISKQJZgvNBDN7w+S1EEA3/NUHPdx7JTNXPubGlGknV7ylACCjzmoWHEP6LkDV+WGX0Del8/uGkgsb 8glYxbiKMGmM90igS0t8WXnYA8Z1f1T3943k7gNMm0DysLq+8SjNquGNlRCvMSvkbLjrjA6oCB3RTz i3Ki9kTg67GPto1gQFrLigc0mJkYmHQ93fOU9x3THcxoEVd8tATIWW4GLTiJaahlWnPrVqADOlf2B1 w/SQJmuIDYd1B4+V2RBQFnT1T1WJWM0pvgIN+9P9QeB8atEaCt69h74iMqpZJvGKEpMOL3evxp3qIr 64WWCoFh9VIH8yJvUrc2fsZlK8DcpubB52SM5m30/5SredsM8am0AzHv409+4ZyQnmr9ivec/VpD2g ZcM2Uht7+Znwbv3VdqH7PTgr8y6lfBZPcda4tiQ/KxJlUDAvLq7qGlLqF1B1Pr6Hd/6rbRUN39t3Ko BColCL/X+f5hvu04ZbIUic5OPjBu7ZXEvqoIE6za///Fz93Gigi1aMkCENMpm6PRnJ2iDO8zAkywF8 YobNhFKAqeftYClqJvOMkakeyVc4X7NmvOQ3WC1jVB1LHj7mgVIf6Ri1mMLA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk "fmt" macro was colliding. Rename like the others with a
"bits" suffix. Fixes a build failure:

arch/parisc/math-emu/decode_exc.c: In function 'decode_fpu':
arch/parisc/math-emu/decode_exc.c:49:14: error: expected identifier before numeric constant
   49 | #define fmt  11 /* bits 19 & 20 */
      |              ^~
./include/linux/printk.h:379:6: note: in expansion of macro 'fmt'
  379 |     .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
      |      ^~~
./include/linux/printk.h:417:3: note: in expansion of macro '__printk_index_emit'
  417 |   __printk_index_emit(_fmt, NULL, NULL);   \
      |   ^~~~~~~~~~~~~~~~~~~
./include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                          ^~~~~~~~~~~~~~~~~
arch/parisc/math-emu/decode_exc.c:339:3: note: in expansion of macro 'printk'
  339 |   printk("%s(%d) Unknown FPU exception 0x%x\n", __FILE__,
      |   ^~~~~~

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/parisc/math-emu/decode_exc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/math-emu/decode_exc.c b/arch/parisc/math-emu/decode_exc.c
index cd8ffc6ceadf..494ca41df05d 100644
--- a/arch/parisc/math-emu/decode_exc.c
+++ b/arch/parisc/math-emu/decode_exc.c
@@ -46,7 +46,7 @@
 #define SIGNALCODE(signal, code) ((signal) << 24 | (code))
 #define copropbit	1<<31-2	/* bit position 2 */
 #define opclass		9	/* bits 21 & 22 */
-#define fmt		11	/* bits 19 & 20 */
+#define fmtbits		11	/* bits 19 & 20 */
 #define df		13	/* bits 17 & 18 */
 #define twobits		3	/* mask low-order 2 bits */
 #define fivebits	31	/* mask low-order 5 bits */
@@ -57,7 +57,7 @@
 #define Excp_instr(index) Instructionfield(Fpu_register[index])
 #define Clear_excp_register(index) Allexception(Fpu_register[index]) = 0
 #define Excp_format() \
-    (current_ir >> ((current_ir>>opclass & twobits)==1 ? df : fmt) & twobits)
+	(current_ir >> ((current_ir>>opclass & twobits) == 1 ? df : fmtbits) & twobits)
 
 /* Miscellaneous definitions */
 #define Fpu_sgl(index) Fpu_register[index*2]
-- 
2.30.2

