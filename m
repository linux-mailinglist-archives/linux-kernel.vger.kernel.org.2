Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0043B3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhJZOXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbhJZOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:23:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABB0C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:21:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f11so14454278pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WM4SI+rtjUFkOGpOJr9Dhig9XU1Hwa4x+tSGFkHYC9Y=;
        b=oYvKh6bEDYow/5SRWY/ESW/BxLi1waI1mBLazQDizpU9qdWWKtWlsGOTnRX+QNljoN
         p8V2+ek9qDVRT9+upy/5oaxRUEkpF8Z+eI2p+BdIJEXdG6UX5+nvP/33tj8XvoLma1se
         9MdeaFRYsi+1VRShROGbkSmxOuJZPBnI01NeC91JXqIRsyUDFleb1QhkW2QybNJu+z3c
         7sWxUE0A0zmTJK1sY4eUWI2i2e+6SbjPDhp6+WaWEP2uWrjUTsRXhIeo8vlGLljM7Sqd
         mhVha6J/IdvGqp+cREmRDQDIWif6vFJ0jNLtN/fS6ZbSwnRHF2fSPwCG+tPZznDLrj8l
         NfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WM4SI+rtjUFkOGpOJr9Dhig9XU1Hwa4x+tSGFkHYC9Y=;
        b=JamuQKuI7UyHoBV3god5Em4hAoTlW1MVlHk4oxq4jk1f3smWwF8Mi/3wcZC5zlFyXV
         lL4Xfs/joE0+3zXJ2gafitdRFmkAdfkFMfdS2zhUOZ7PumXTE+0u71NH6fCpBPvQ33kl
         N+up9xA88EcKIfzbro+WKryvn5BfsZKcL0GTK8seUNn1iZCdKTu+7HN1EJADcXc3mU9/
         oz5NxKFQZLmc1nuN0zhVqrZ7l9ZZQX+pk2A5y2UyaAJmq9d32X2lloFEpwtTL4Mqzzmf
         LbeiVPDoyKlQv75Ha44qatF8aT+y3SIW7yRltVWQaj+WArWf4vpF2cqiAxyNCXi3spse
         8jEQ==
X-Gm-Message-State: AOAM531BoleOhQMltVWF+71XeYGlZ2vaHFmrjAotU9FfHxu8uSkwsZQW
        ShwtNmt+uOQ0dIKFtoJJdZGsfRqAgBo=
X-Google-Smtp-Source: ABdhPJzYn/8ymrJei+rXtZ4NJaUI33F92xojqAhlpo8byGuwDZjNbwG01rFPXp3wHoK8OfMMRi9mXA==
X-Received: by 2002:a62:e310:0:b0:47b:d6c1:2c65 with SMTP id g16-20020a62e310000000b0047bd6c12c65mr22307723pfh.21.1635258082522;
        Tue, 26 Oct 2021 07:21:22 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id b3sm20993437pfm.54.2021.10.26.07.21.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:21:22 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 05/50] x86/entry: Use swapgs and native_iret directly in swapgs_restore_regs_and_return_to_usermode
Date:   Tue, 26 Oct 2021 22:20:13 +0800
Message-Id: <20211026142058.17702-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

swapgs_restore_regs_and_return_to_usermode() is used in natvie code
(non-xenpv) only now, so it doesn't need the PV-aware SWAPGS and
INTERRUPT_RETURN.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0dde5a253dda..c8f7b740a9f1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -606,8 +606,8 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 	/* Restore RDI. */
 	popq	%rdi
-	SWAPGS
-	INTERRUPT_RETURN
+	swapgs
+	jmp	native_iret
 
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
-- 
2.19.1.6.gb485710b

