Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84B64104E3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbhIRHs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbhIRHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:48:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B88C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:47:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h3so11936614pgb.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmG7kULAosVeD24CKK0iUu1HsWWrJCRFGs06Wu9DN7M=;
        b=GxqjAe11r1iFVzUpHH78B9JBVmQ0Zu4TvLhf8jPr+yKPPNZcuTgpmAzTKXXtzF5nsk
         WZpW29QgilW7haIhf2jUR9byYWbVIowZRbV3luVt1tCSsf5qxRhLOmil91qZiVrk7C2L
         70lAsbgceSt0fLT+MH01KoH9daHA2i9HYlocBsrfBA8h+EMvpDIt+xKD2Q4GMA9gKMN5
         8ecoMSUQaz8V09oXWsrbc2BIsgOULQRHJEgjfeu/mPGUVs5047VNk2/EfYMUs0OLelhn
         ABxm1L4h/F3XryeBSUhbLR+dFVChhv3/QzGjlneqQbxrasnHKG/68ZvOgY42IzrL4ek8
         +FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmG7kULAosVeD24CKK0iUu1HsWWrJCRFGs06Wu9DN7M=;
        b=KBEQXq3RQ0afeZ8KiREpdajDaJLFCxK2GW1LGnsVWxVUycmoCCQuERQ5KE6GDa7MW8
         HX7U5V0VJis0iPmtxoEdBmPCr9tdL8Dirz1UITe1iHlHFjhp9rIMYPxNgvDECfO8E4r6
         SNxgvdsCyHqPKMmzP2aCDw0irlsDXQXnJx6j/H8LJTuBXZSt0v5RMwcNL0/asaDRIs3m
         a7S4ri3h110o+eloJCKlz1MRGwd6FeJBgApYJR70B/iKKPMHx6Zxm8IIovIYGFLW8Xbo
         TFWm2HjHYMhbKayNH/3+SM1O87JVzJ3oZWWCkzEGMyNPE7Q17+gzMU7ZMNXK6oQkMn9q
         uwlQ==
X-Gm-Message-State: AOAM530AElxii+dfoMisYjI1GJiH0p2SX4ImRtYfSSxyygr2jJVhc7LK
        dSA0+38+qdjGti7C9fkev7U=
X-Google-Smtp-Source: ABdhPJwh3qCt8EFiO4vb8uMP2Fd3JLCnl45BemOQv6Nq7kjXzH3HW8mu3SeNnjq+h9pnF6G4adHU7Q==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr14602460pfj.15.1631951253987;
        Sat, 18 Sep 2021 00:47:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s22sm1223040pfe.76.2021.09.18.00.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:47:33 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     peterz@infradead.org
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>
Subject: [PATCH] Add exception handling
Date:   Sat, 18 Sep 2021 07:47:18 +0000
Message-Id: <20210918074718.240511-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

If the type is abnormal input from argument, the code will be NULL.
So it should return as default;

Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/x86/kernel/static_call.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index f608e6710300..696da3eccf28 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -45,6 +45,8 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void
 		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
 		size = RET_INSN_SIZE;
 		break;
+	default:
+		return;
 	}
 
 	if (memcmp(insn, code, size) == 0)
-- 
2.25.1

