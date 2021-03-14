Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323333A872
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhCNWFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhCNWFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:05:09 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C78C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:05:09 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g185so29952938qkf.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZaPK4lEgxNRFwgYzDF7MyhZ1wZueaIxBKjRKIQkNhsg=;
        b=bz8Q43KX9TlYiBsvim1gpU1heQfrSJVuo3sciwnbrzK9sLsDS7z8OLcfn9sGntGuGU
         tY+bSe20WOA9kQnSbcLUxZ55p+lJ6+zVMYn00RByytGs0lnAFfhJXrOFcyGNtvSfKhdg
         bRrwAHdM2B2GqjuQMne351GBkdY1QquqNGcJg9r4iLPVAJgFkLP7t9OiU5wpMnAZZwN+
         RAKU4gCJAzyUCC9qsCJChjxfj08DkOAaS0GBCoZAjCJP4d8iFM6UoOCxYZSxptUBSNFk
         ebvEDr5y/XCqIiVpJjFiKtwYVPAitCmTy07zQDE9RzluChwzAlvOdQn/YiLcSxPUsCrb
         8Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZaPK4lEgxNRFwgYzDF7MyhZ1wZueaIxBKjRKIQkNhsg=;
        b=WIYWl30eb5dx1ImsUg7ldeKpnmyx5oqv6rIfLe7LMjGgErPmKQ/NnLBxH4V8gNcMsk
         t3UfwA5vFL77HtEjMonfv2t4p2UaDEvHU2u23XBv1mIBhXdfOKOLYcaxVo3YVFknC9l3
         QVZRLyC67VWrA6z9qxG61ZTI0Wm6oysXivP1qLUOedOiS7PCF450Qr+fOJWqk+Qw09hq
         138KcvEasm+dceloUI2LYnogeatDZVphxyhyOnDl8KH3oUpSPfdbVZcAJ+1gPKfZ/MzO
         aYvAbPB1jcJ/sjdVa9aKweG1bALIw5dlRaBq5TatsZMXqlvb9Rd/oEmehDtvxRGCI2aI
         y+/w==
X-Gm-Message-State: AOAM531QRBo+Fp94Wcp/kzpM6QCWzx652ZIXGKgAzHM4n6krIS+RvVbd
        11Uz7Aslty57iLe9fU5FK0Y=
X-Google-Smtp-Source: ABdhPJyytPEIUs/+P7hmkE51/n/lFxJxDU/MwToh6N4ZWlIOvBU0GxDcr5SoLikOznmMIiaHQOo+ng==
X-Received: by 2002:a37:a183:: with SMTP id k125mr22732511qke.332.1615759508632;
        Sun, 14 Mar 2021 15:05:08 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.247])
        by smtp.gmail.com with ESMTPSA id v7sm10837297qkv.86.2021.03.14.15.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:05:08 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, rppt@kernel.org, unixbhaskar@gmail.com,
        oss@buserror.net, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] powerpc: kernel: Trivial spelling fixes throughout the file head_fsl_booke.S
Date:   Mon, 15 Mar 2021 03:34:36 +0530
Message-Id: <20210314220436.3417083-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial spelling fixes throughout the file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/kernel/head_fsl_booke.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index fdd4d274c245..c6fcfca0b0d7 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -113,7 +113,7 @@ _ENTRY(_start);

 1:
 	/*
-	 * We have the runtime (virutal) address of our base.
+	 * We have the runtime (virtual) address of our base.
 	 * We calculate our shift of offset from a 64M page.
 	 * We could map the 64M page we belong to at PAGE_OFFSET and
 	 * get going from there.
@@ -403,7 +403,7 @@ interrupt_base:
 	EXCEPTION(0x2900, AP_UNAVAIL, AuxillaryProcessorUnavailable, \
 		  unknown_exception, EXC_XFER_STD)

-	/* Decrementer Interrupt */
+	/* Decremented Interrupt */
 	DECREMENTER_EXCEPTION

 	/* Fixed Internal Timer Interrupt */
@@ -497,7 +497,7 @@ END_BTB_FLUSH_SECTION
 #endif
 #endif

-	bne	2f			/* Bail if permission/valid mismach */
+	bne	2f			/* Bail if permission/valid mismatch */

 	/* Jump to common tlb load */
 	b	finish_tlb_load
@@ -592,7 +592,7 @@ END_BTB_FLUSH_SECTION
 #endif
 #endif

-	bne	2f			/* Bail if permission mismach */
+	bne	2f			/* Bail if permission mismatch */

 	/* Jump to common TLB load point */
 	b	finish_tlb_load
--
2.30.2

