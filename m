Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE2334BA9F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 06:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhC1EOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 00:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhC1EOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 00:14:09 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD0EC061762
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 21:14:08 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so9076144oto.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 21:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkEqsh8oqC0Vlr5FpbbYclfjdNDL2PkvOPENDTwD1M8=;
        b=adHv5kLXz/AZpKXmOF2J4msoTqQbyhggAScH3khzezuTe0OHeVwNaLd3yRjkTJ9y1l
         POVCGO1LPSXyaQAGDaehLLZ6FHRA7APQtlF77SA3MZWtOuq1xrMPaxDqH4pr2dqdCOmA
         fEETneZil75rhobBH87BnG3xj18Hf7Uzd7CsGlHGCVRxuMMzvZv3KKUlMIr9ewoiBph/
         EAVDZiFirwapW4DQz0dXKQjrLaKuagky7v5eMYTt5sZUaNvFKsllk5lSTLx7FcIQv1X3
         XJxIoopyEfIjIGRJtgZHlY+Gok82J6hv+NH8cxN8HjsicxSfI8Guw0aAVOPnBGsNOZBD
         HAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kkEqsh8oqC0Vlr5FpbbYclfjdNDL2PkvOPENDTwD1M8=;
        b=MaONlC395W0j9VIAm2V7YOmoE14ycfUPPmx1P/q/A87TEnh3nxuZmgAN2ErYFviduc
         od+4hQONtV4d0ZRUqgy3JRtzIN7aUTBoEMjZrObKfVyAIC0p+y3gME+ay78LUcUC2uaS
         ookxKMOl2GjSgbeovev/PODOV2a8LUFUnouYj64B5QiU6S85IgcutoxfkAbREtRity6p
         GHQdZtWa78ZhzNj3dyrCxlBG3oC6L0c+scpNOGJ7JIvbsv41yQZAKps+qGojqcyqiVrZ
         TSqQ+2RDReufmbbUrOeGqlixFW2uaG+kKVQtkk60TY99MWhqgBG0EZic2SE0Bs2Anc6J
         vtHA==
X-Gm-Message-State: AOAM530zirXNY7sJPxRIjcaUJG8iY9PdziFPj2FTenGLgxtYmD74KeQ6
        evfl2C/N3cg79xpLsRIi5O36DJ9JMvASxi56
X-Google-Smtp-Source: ABdhPJwc3aD+vF7PYZj4WL9ELcLdZemVUMbuH8OC5DWriHYeUrUqABA9YsgkhjFqnUtobbA6pe1riQ==
X-Received: by 2002:a05:6830:799:: with SMTP id w25mr17276754ots.15.1616904847814;
        Sat, 27 Mar 2021 21:14:07 -0700 (PDT)
Received: from kde-neon-desktop.orld.fl.wtsky.net ([208.64.158.251])
        by smtp.gmail.com with ESMTPSA id c205sm2779037oib.40.2021.03.27.21.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:14:07 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     akpm@linux-foundation.org
Cc:     geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
Date:   Sun, 28 Mar 2021 00:13:59 -0400
Message-Id: <20210328041359.50149-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
is disabled, Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
  Selected by [y]:
  - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86

Depending on ARCH_WANT_FRAME_POINTERS causes a
recursive dependency error.
ARCH_WANT_FRAME_POINTERS is to be selected by the architecture,
and is not supposed to be overridden by other config options.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2779c29d9981..8d53ed423899 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1665,7 +1665,7 @@ config LATENCYTOP
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 	depends on PROC_FS
-	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
+	select FRAME_POINTER if MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 	select STACKTRACE
-- 
2.25.1

