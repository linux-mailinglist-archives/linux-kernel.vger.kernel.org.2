Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B530141CBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345715AbhI2SUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343727AbhI2SUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:20:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E07AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:19:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b204-20020a1c80d5000000b0030cd967c674so338231wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFzH5hITTRN1V5OZpNAVPp73YgNW/RpLchp3GtiSXo4=;
        b=W1TUAZlaw/e8DQIF7edqAaicu+IQNIuf0gyontypngQe8+38JwnhEdZYOPXfDsr91B
         9iEkIZ5zL59YTdyfuwChWIQItLAySgEpGmiIOiRzC2J5PYabyCCg8MvOAaTW90G+6bqm
         5Ap5US6WbLQOjbM91roVUFwKzIKZsZI0a9YW5bVZhOHC4uZGCGwHXZL1i39v/s6ipJo4
         lA2vCyYGrDlHZ8BkI3iceDFP+dAC+/CvCMf/AijKA2x62aEEpYCmPK8h5kkVa9PRvbCA
         WgvQX50RSYQ3Htzu1dI/YD4NgWAyKFw6y+qEEOC2sAVVleVEF7DOvFQOebY/65ve39Ye
         Jobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFzH5hITTRN1V5OZpNAVPp73YgNW/RpLchp3GtiSXo4=;
        b=OVBGCC8nFVeA6E5Yfms4ilm1EsflLjQbQXPNz7hPVj3LYQ0fFDaqhV5LNkD+vBVAqV
         6w4IBp6Tl730d8EMSnN9A4JGRNKzGhLVZR/7OT863+SOqGUFVXExM9QF8Sd3ioKtEAtS
         0nLRQO+0ThES28nSvAUwWBT3YTWjkeDhM6HiwZTOxZ355hUkLifEQd/7epEmOFMYWcSY
         Se+Wr5rZAhfi1jzUaz87LRmp6IEuFe6ElK4k4kh9CVic0al+nFMZ2D4kRALNuJRZjXB8
         tv4EdWFfqP36ie55Ap6n0pCanrvfOrFr2wJjTMyoCZp6s12Ztd4yyuXsaROPmSbnX+QL
         4aEQ==
X-Gm-Message-State: AOAM532U9dPtHJLjFOvwt4ddG6AA72Upob6V8WJ61h1HZCVV/A8wlylX
        L7Q0172hEndf0yn4j/CnWSc=
X-Google-Smtp-Source: ABdhPJxHrE5APi8qWcepSYnhoXLeO3mw2C4m/dEVIjbr6POCv1tQ7PKeXKeXepotIdvv9g5VrgX3RQ==
X-Received: by 2002:a1c:94:: with SMTP id 142mr7940052wma.116.1632939542071;
        Wed, 29 Sep 2021 11:19:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id d24sm534998wmb.35.2021.09.29.11.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:19:01 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     linux@armlinux.org.uk, linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Subject: [PATCH] ARM: handle CONFIG_CPU_ENDIAN_BE32 in arch/arm/kernel/head.S
Date:   Wed, 29 Sep 2021 20:16:45 +0200
Message-Id: <20210929181645.21855-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My intel-ixp42x-welltech-epbx100 no longer boot since 4.14.
This is due to commit 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel
mapping regression")
which forgot to handle CONFIG_CPU_ENDIAN_BE32 as possible BE config.

Suggested-by: Krzysztof Hałasa <khalasa@piap.pl>
Fixes: 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel mapping regression")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/kernel/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 29070eb8df7d..3fc7f9750ce4 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -253,7 +253,7 @@ __create_page_tables:
 	add	r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ORDER)
 	ldr	r6, =(_end - 1)
 	adr_l	r5, kernel_sec_start		@ _pa(kernel_sec_start)
-#ifdef CONFIG_CPU_ENDIAN_BE8
+#if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDIAN_BE32
 	str	r8, [r5, #4]			@ Save physical start of kernel (BE)
 #else
 	str	r8, [r5]			@ Save physical start of kernel (LE)
@@ -266,7 +266,7 @@ __create_page_tables:
 	bls	1b
 	eor	r3, r3, r7			@ Remove the MMU flags
 	adr_l	r5, kernel_sec_end		@ _pa(kernel_sec_end)
-#ifdef CONFIG_CPU_ENDIAN_BE8
+#if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDIAN_BE32
 	str	r3, [r5, #4]			@ Save physical end of kernel (BE)
 #else
 	str	r3, [r5]			@ Save physical end of kernel (LE)
-- 
2.32.0

