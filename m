Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBA45EB4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376853AbhKZK0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376662AbhKZKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:24:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC3C061761
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso7675077pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rggk4Wz28/tanhWvVYfUkI6dZy0E3llR541aTdNtC5E=;
        b=oxLBDB++3vR3N67E5QW7ulIlwoxxuvS/7RQpyP6O2Z6jSxmECIou803pkWx7AeKHZX
         mZER7Hu6cKzJaSKccr4wmlsyb7F4IgaRekIjOmXhj19zRkaJjj15n1g/szHaD4kpMccd
         lV8gIqdi7YoXFkUiCkxCf/8RPPMY9n/vD/XHZCRHO37eEyZdTeKRQKJEKytTnUlYZarM
         9UP/kwoTcRxf1takCyIygCdESPCX0mxoa/LIhY8MTWD4FDcwKkxztRTCCSj4gIQXARS2
         /tSptCfvo9IvLDTexeygJDs4xlWpNDUb+5EpfoSVrOmxI92Tp5bDv0bVZwgd7qBKdsSy
         UEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rggk4Wz28/tanhWvVYfUkI6dZy0E3llR541aTdNtC5E=;
        b=cLmtJ7sdS0G/uE9lUdkkGx8eqo/WeTC7oY76UwHSfeEdWb5MH2c2qofc6+oVMLiDt1
         0C71Fg7P0vzuckStlj/JLYpXxCJ2h3923BWa7OWNMkqDanvs1zg2fWlysqoZYs1HV16i
         FhbyEArO+/kgTN4gaLheg6ul2RBNEEVxxYTrPdJ1QEPdrjBmtuDHaNHcCg3QLJXi4+am
         swKDT/BvkTFIY9GJsX88oaydkQvoa1e6QRUIOT7YZhXciFxkPn20byNOQZnRfhttTeRA
         XFat1ji4fT2ptn/XgEwO34vO1V7VMayzSlF8mgCqRO9r+d4s/i8bqt8Yf9j19ozP/pUe
         Lsaw==
X-Gm-Message-State: AOAM5312t58RAMDLq184NaFXu3S4CT2lHdMbNHEsbZX10Sc2vzYCAtDs
        egk79jC1RO6biTHY3g4pq+NWlfRAdWo=
X-Google-Smtp-Source: ABdhPJxG9291oz0WZqEgKJyGJ4AJ1EAqxmjTusuexpsnz1em/EFLtgWQtUymVFVYHAWWQWsdeBgZyw==
X-Received: by 2002:a17:903:120e:b0:143:ca35:11f6 with SMTP id l14-20020a170903120e00b00143ca3511f6mr37176479plh.76.1637921567771;
        Fri, 26 Nov 2021 02:12:47 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id h3sm9933281pjz.43.2021.11.26.02.12.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:12:47 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V6 08/49] x86: Remove unused kernel_to_user_p4dp() and user_to_kernel_p4dp()
Date:   Fri, 26 Nov 2021 18:11:28 +0800
Message-Id: <20211126101209.8613-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

kernel_to_user_p4dp() and user_to_kernel_p4dp() have no caller and can
be removed.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/pgtable.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..65542106464b 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1200,16 +1200,6 @@ static inline pgd_t *user_to_kernel_pgdp(pgd_t *pgdp)
 {
 	return ptr_clear_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
 }
-
-static inline p4d_t *kernel_to_user_p4dp(p4d_t *p4dp)
-{
-	return ptr_set_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
-{
-	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
 /*
-- 
2.19.1.6.gb485710b

