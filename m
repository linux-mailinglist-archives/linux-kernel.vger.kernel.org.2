Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656DD454DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbhKQT3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKQT3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:29:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D64C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:26:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so6071472pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=o00hN7MYHRpbM1Hv9SEJY2YSEXemX+i/2bGeSGVdp1w=;
        b=q3/qEKp7vmZl2Cl4mwb+pWTBMmWTAgURQsBjnglAFmfiL14bi2G0OnV5mLo6gfCYXL
         5Q23JPhlU5GEFsskmqN6w828H9DFgETKFnbfYXUOLlynXRUY348OpLFhwlUi+bbRHLBI
         1iBwFe9QD6JOwoi3PlPzCjtKWKqLt6H4+WLtL/8JdrIZfyCRo1art9kMCmJ4zeTWLtKY
         cqCFdAoSpwwX4hTuvCDHHHWgg4pw0sBLAm1sMuRiqpfN7ft1NFIQFS+zAD0brMgm7QtU
         phX+EenXax5RjSs22ogWD4u9I0kraZrJkoDiJcYDwK/j2qAuF8feK7+fsUgCfFU5CI80
         4JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=o00hN7MYHRpbM1Hv9SEJY2YSEXemX+i/2bGeSGVdp1w=;
        b=JWl3pbIz2EuY8SEAQdNlaReo8yj0swAItty2hwLTmwfoU8J+vTj3MXLX9+Pos80UQq
         FaO5IiXhSJOeVetSxAuoPAZ9201n+OTUqt2XlE+l6ovLGEEvcv4FWZErryWDASTEasYs
         3To1ymJCCHyOs2KXY4w+DF5BMgEjJCH8Bhpchb2/yD/UE8iHuEbVkpunk2YoVeX/Nqrh
         nynp94ypdGn7FMt4/mizDe4lBGmYm64VNcG0inunPG0QI8Io1LOtKWOnuuudfC7u4bH3
         EElQd8H4WVv05Q6PVj2OpbbDHGTZPJAFX6YTZotUR73nWJdXus3m8QFZMsIUXNDMcnHy
         hwrQ==
X-Gm-Message-State: AOAM5312Q2o1Yw1vf19qNgaVpDE24Q0louJvuKkFsmEDJLtg5WeeEOk7
        XyWe56kpI2lPDDdJpPFLJVg=
X-Google-Smtp-Source: ABdhPJwIRMnWmBIHxvO56GOIDUR4lY2QdmERu+Xi+mtxSi4aMcgtHgdCKhzEB7yqvaG7g+7KGKP0GQ==
X-Received: by 2002:a17:90b:3e84:: with SMTP id rj4mr2465932pjb.199.1637177168405;
        Wed, 17 Nov 2021 11:26:08 -0800 (PST)
Received: from makvihas ([103.85.10.92])
        by smtp.gmail.com with ESMTPSA id i185sm403942pfg.80.2021.11.17.11.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 11:26:08 -0800 (PST)
Date:   Thu, 18 Nov 2021 00:56:05 +0530
From:   Vihas Mak <makvihas@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, makvihas@gmail.com
Subject: [PATCH] arch: x86: use swap()
Message-ID: <20211117192605.GA774211@makvihas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cocci gives following warning:

	arch/x86/kernel/unwind_orc.c:212:19-20: WARNING opportunity for swap()

Fix this by using swap() macro.

Signed-off-by: Vihas Mak <makvihas@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/unwind_orc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index a1202536f..a7aaf6bcf 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -196,7 +196,6 @@ static struct orc_entry *cur_orc_table = __start_orc_unwind;
 static void orc_sort_swap(void *_a, void *_b, int size)
 {
 	struct orc_entry *orc_a, *orc_b;
-	struct orc_entry orc_tmp;
 	int *a = _a, *b = _b, tmp;
 	int delta = _b - _a;
 
@@ -208,9 +207,7 @@ static void orc_sort_swap(void *_a, void *_b, int size)
 	/* Swap the corresponding .orc_unwind entries: */
 	orc_a = cur_orc_table + (a - cur_orc_ip_table);
 	orc_b = cur_orc_table + (b - cur_orc_ip_table);
-	orc_tmp = *orc_a;
-	*orc_a = *orc_b;
-	*orc_b = orc_tmp;
+	swap(*orc_a, *orc_b);
 }
 
 static int orc_sort_cmp(const void *_a, const void *_b)
-- 
2.25.1

