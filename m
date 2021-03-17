Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF733EE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhCQKdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhCQKdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:33:10 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67633C06174A;
        Wed, 17 Mar 2021 03:33:10 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id t5so1106756qvs.5;
        Wed, 17 Mar 2021 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/w+sq21Krp5a5Y52tCgJU8vrXEY1dtiPgGcnnoxCWfY=;
        b=of22MyFZ8+xWcSuACVvmzK8JH09kar7ZmKB+cMFrvplhkL0cpZyislA0c33uJcslbE
         lNalDO11cHwf1ALeueclI1lI4PpeZW9sKjVVQPGzfgBdHocRD3dUvqvLqfRtWm6ijk6L
         gxSOqZie/YtqxM4w49cRK2BhBkfuePNrsGANRbuwaK7wjKu+ctrhrdvOVUYJ1xY6+80e
         m6ZZ5vpMM8FcHinPtRND96vYKUUMh5PutGJc6fPzdwUf/gJgHe39FgGlQFoeAQVgN5Ct
         RJWHavmamckUEjcremsWGqDTYdTKWVdBLHolV0V3QnTxC7VqCh6uldisIA7ceH4p4V8v
         A5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/w+sq21Krp5a5Y52tCgJU8vrXEY1dtiPgGcnnoxCWfY=;
        b=p7HFWMbQme/HboAEXamxqLvhgZtHhFiUA9HnwKqOKImgJR0H2ESHi3kHpVvnBtNH9z
         5u+aqAVar0oOmBmndSXG9SV7Wpf2zSVlZx70ZfJgYEQQW6RGASA0WRh92+RpiyPQLTi0
         gXvuibYArZ4uoFDQ9PnNSvPyh60fQNajYC/8Sc5/a6RMYEeC2+mst4UAYLAntlurjywN
         wDyupJimFpFO0g3BpAxqpXLrh7fYscyp7xUzXBvGRV0QZbzTx3+jU6uotwVF7j0z5LhP
         DIuiuVlVwUBzHt2vYd4hZHiVHzTuGLgtZ8mzeg+Y/MHrscPaP0qIFa3zxh0cNu2px3mt
         m/gA==
X-Gm-Message-State: AOAM531t0pN6K8O7cRLmegpCC5uRw049yRVM0An6x4IzAkO1QxuJ5Dbg
        hs0kHDWnpxJApTApFFQVvso=
X-Google-Smtp-Source: ABdhPJyDGzVE/NLJPWDPv6z3M2i+mEBFnDX7bV7ER8vOfO2P0/oIMOgmkLC+eLnraUR1987Dax5Y1g==
X-Received: by 2002:a0c:eb87:: with SMTP id x7mr4427358qvo.14.1615977189622;
        Wed, 17 Mar 2021 03:33:09 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id o76sm17341532qke.79.2021.03.17.03.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:33:09 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        unixbhaskar@gmail.com, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] parisc: math-emu: Few spelling fixes in the file fpu.h
Date:   Wed, 17 Mar 2021 16:02:51 +0530
Message-Id: <20210317103251.3526940-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/synopis/synopsis/
s/differeniate/differentiate/
s/differeniation/differentiation/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/parisc/math-emu/fpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/math-emu/fpu.h b/arch/parisc/math-emu/fpu.h
index 853c19c03828..1f313bc38beb 100644
--- a/arch/parisc/math-emu/fpu.h
+++ b/arch/parisc/math-emu/fpu.h
@@ -12,7 +12,7 @@
  *      @(#)	pa/fp/fpu.h		$Revision: 1.1 $
  *
  *  Purpose:
- *      <<please update with a synopis of the functionality provided by this file>>
+ *      <<please update with a synopsis of the functionality provided by this file>>
  *
  *
  * END_DESC
@@ -50,9 +50,9 @@
 #define EMULATION_VERSION 4

 /*
- * The only was to differeniate between TIMEX and ROLEX (or PCX-S and PCX-T)
+ * The only was to differentiate between TIMEX and ROLEX (or PCX-S and PCX-T)
  * is thorough the potential type field from the PDC_MODEL call.  The
- * following flags are used at assist this differeniation.
+ * following flags are used at assist this differentiation.
  */

 #define ROLEX_POTENTIAL_KEY_FLAGS	PDC_MODEL_CPU_KEY_WORD_TO_IO
--
2.30.2

