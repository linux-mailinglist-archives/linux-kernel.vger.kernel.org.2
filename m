Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A72E34529E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhCVWxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhCVWxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:53:16 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4538AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:53:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id u19so9786162pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+51m+w++y282pEpZcxM+4YOYzwIDkEbVJ47KIbTcl4=;
        b=QfXGEo5ueK2zr6oSJZYJYzRNkYnWQhD8Sox7sDDDttvRWM3EmyOUol7F4aqSEgP9NP
         GHQnkPJruXk3pdfbHAo3tir2mS9ZA+cqMqUYRBtFasSBiTyNXM6kW5xisTwJ4HKI0/SG
         Uhh0LjBwDYD72X3FfxRExA1v97vyHlTnxd8Twrvz/8nr5vPakPsWmkvzpeDp1FJzmMut
         ndWh0ftdPenGyc2vKPW3wQPc7/rAEs2LD5kFnJsANnSapLQ/Hp5PT+1MbvPgSryZe3FR
         bBzJrrxt8kQtMJG2L0bksMtfdja64mazMcYG7Hi2tzHeSn76MoHgnEYU1Piswjozpi5E
         rybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+51m+w++y282pEpZcxM+4YOYzwIDkEbVJ47KIbTcl4=;
        b=IL2WqqMYdcqBQu8M2dhTowluavlb0CTl59+lustJT8AkP+x7tM3ZoMNmNbQT6p92vp
         qMwzNrGJTbXkf140Uk1Sien5p9REhAfH43cpQe4yf6iKYEe8dHW+Uih19f6ZJiH+pFk/
         ScaXPVeEPflM8hridUSnE83zFwuCtwoeU7NYN16TExUWeDorvUVU3wYv3Op+zyftnn1i
         tkgBseldf9tarRJYlMce3RZQniuAOZEFF0IL1HbdHYec013WCh1CbDyBh3SVeo1UMgat
         lWSxvuBVBYvzJoE/E6dJx4T6RbgAMUuDFjppzmNrtWf2+GQ7EKevA+omNil1/A+joYql
         kcCA==
X-Gm-Message-State: AOAM532lr6C/8IBuimR4T4Md38iY6XGRqFK83MJZOOlt4WL4JNHfeKLI
        r4OJYeEi5zl23Ooe70AF5yc=
X-Google-Smtp-Source: ABdhPJxcPnFhka+fUqaouhyTukjRJoxO4TigJeQgAm0gNpQv6Kfi5Gbox/7siMadBCOwpDd+Ln8aUA==
X-Received: by 2002:a05:6a00:72b:b029:218:6603:a6a9 with SMTP id 11-20020a056a00072bb02902186603a6a9mr1900419pfm.78.1616453595715;
        Mon, 22 Mar 2021 15:53:15 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id j13sm8878211pfn.103.2021.03.22.15.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 15:53:14 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH 1/4] arm64: expose orig_x0 in the user_pt_regs structure
Date:   Mon, 22 Mar 2021 15:50:50 -0700
Message-Id: <20210322225053.428615-2-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322225053.428615-1-avagin@gmail.com>
References: <20210322225053.428615-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

orig_x0 is recorded at the start of the syscall entry and then it is
used for resetting the argument back to its original value during
syscall restarts.

If orig_x0 isn't available from user-space, this makes it tricky to
manage arguments of restarted system calls.

Cc: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/include/asm/ptrace.h      | 2 +-
 arch/arm64/include/uapi/asm/ptrace.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e58bca832dff..d4cdf98ac003 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -183,9 +183,9 @@ struct pt_regs {
 			u64 sp;
 			u64 pc;
 			u64 pstate;
+			u64 orig_x0;
 		};
 	};
-	u64 orig_x0;
 #ifdef __AARCH64EB__
 	u32 unused2;
 	s32 syscallno;
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 758ae984ff97..3c118c5b0893 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -90,6 +90,7 @@ struct user_pt_regs {
 	__u64		sp;
 	__u64		pc;
 	__u64		pstate;
+	__u64		orig_x0;
 };
 
 struct user_fpsimd_state {
-- 
2.29.2

