Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C49F4563F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhKRUV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhKRUVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:21:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00746C061574;
        Thu, 18 Nov 2021 12:18:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so9172774pju.3;
        Thu, 18 Nov 2021 12:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9iqkBuwh2oBbOQex6wXCJkgQSskeomvSoH5LdhU3E8=;
        b=Wn3EVL2HrAGRVK+UfTN2sO7UPszZ3PCZ191oTQyHI1lBXRSFst9XRLqnkRcXUJXb0I
         ENn8AN2sWGkiFfss5EiGBuKDthUtTi+XMWO5Ak++YVIrQEartis+aAzoDyGFtaIS7V5o
         J/yWdAYTID5GrE47qzQ0pP6vstzBsT8lZIyxWqUNegfqIe43ZHrQ27qr1PcI3Z0/dEPQ
         OwVursFdu2V3g6jBW6I8DwQEFo4We4Dv2/FlL6ThbsV8gm56Aci4pnWhsy9HuGXDmHAm
         h6BvvjGTO8iJiyKiInuSaOPc20JVtwCBS1vc/he2PimeZMtD6+dy5Bz6lkFJ34F8D+LW
         kqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9iqkBuwh2oBbOQex6wXCJkgQSskeomvSoH5LdhU3E8=;
        b=7PE/GQ7I9wlehkxOFN0ifvAL6Ll38n+dkgYri88SkPo/8u++yvMkyZVgMsVjWheicr
         ixc7Ia8IFUBn0B+GrX7hqT2v9kov37TWsVcg31IFaQ486o1Ge9NdgBLiGXguafBugFY4
         hNErlPtma4Hk1q5ymrrHoIaKBGBOLJKRwJhEhH4Ua1exqQeor/h1fR7ynYBgSZD62eO3
         FLJizm38bgKnDYA7J6/5bQLZK3/akbu6YzbAwlgrmTxQZFN0Tdd76cgtWLYcbQMjn6Em
         /CGUXMw2A/NaVIxLY6wBS93ZOk/syLMFZrFsyxeNSifGgb6DYCjOjYonHyr7w5qtwomf
         t4Rw==
X-Gm-Message-State: AOAM533O7gjaendeTHx1pdc7ekweUCY79EMJFbX5ym9vwas6hsz7D17k
        m0x9okLBcJ3deyGBlFIQqDP1q8FhepM=
X-Google-Smtp-Source: ABdhPJyJH9h+EyN3aTund7m5/HaocT8ffIq9R0nn/uc/0qVEDw4QK4xBdZEQqrvmGAcQW/IiMQ1uzA==
X-Received: by 2002:a17:902:f54f:b0:143:b899:a9ce with SMTP id h15-20020a170902f54f00b00143b899a9cemr55297936plf.28.1637266704083;
        Thu, 18 Nov 2021 12:18:24 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j22sm439943pfj.130.2021.11.18.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:18:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     james.morse@arm.com, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: entry: Use SDEI event constants
Date:   Thu, 18 Nov 2021 12:18:10 -0800
Message-Id: <20211118201811.2974922-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SDEI_EV_FAILED instead of open coding the 1 to make it clearer how
SDEI_EVENT_COMPLETE vs. SDEI_EVENT_COMPLETE_AND_RESUME is selected.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/kernel/entry.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 2f69ae43941d..772ec2ecf488 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -966,8 +966,10 @@ SYM_CODE_START(__sdei_asm_handler)
 	mov	sp, x1
 
 	mov	x1, x0			// address to complete_and_resume
-	/* x0 = (x0 <= 1) ? EVENT_COMPLETE:EVENT_COMPLETE_AND_RESUME */
-	cmp	x0, #1
+	/* x0 = (x0 <= SDEI_EV_FAILED) ?
+	 * EVENT_COMPLETE:EVENT_COMPLETE_AND_RESUME
+	 */
+	cmp	x0, #SDEI_EV_FAILED
 	mov_q	x2, SDEI_1_0_FN_SDEI_EVENT_COMPLETE
 	mov_q	x3, SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME
 	csel	x0, x2, x3, ls
-- 
2.25.1

