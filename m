Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA944C097
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhKJMDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhKJMDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF22FC06120C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:20 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e65so2059224pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jceiELf+07OtjBut4BS4H9evczr5+JdNRZELuhcbeM0=;
        b=jxz8I99/uWcUu8OLP9t8oRCd+w/auaQTAfUuWSjEXCxQIblBKJCEUtC22GPVF+wXa7
         vf8Qi6Nrml+G4z91seGC7Zp/q7sqhYct4yf2LjlPsi6iwkg36amOV7DqA0hCv8Ldrd/3
         qz5ttItJkOXzo3NKMGRbmObEAddzMqE93DS6DQvR0pbKDKkLG534EVtuXnsJk17+2QUv
         t8be2cOCBM7Uo3lKP54ebVEW1Sp1yfNnBKx0oKY2lhbQBCrfN9rH1FRepzKdlGOHKkTX
         LnGOpK0wsHvBAwc+aZGWBgSudSLGojXS/EhnfmroZjWRLExweRRFM44d7nO1tBw5Vbnd
         8KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jceiELf+07OtjBut4BS4H9evczr5+JdNRZELuhcbeM0=;
        b=JuhZ/+Logne5bmZzlUHZIzDChgpxDGy5RUYt5Gp4334fV2HBaZbPkwll8aYW9wk657
         UC1aVEyNw4zVSQaSC44GOneHUA7eM8RXinY4p71j41ojNgM0dc9l6F+/Uemr6elHKIYu
         SKPGnBBQDkyoItzmFQPiyRUznBm2bwx4UxcJhCcs/kIxXLEZicxVupL82Gm2DDPOu1u2
         ZFDDKC50ohzm4wL95pkMNu4aLthFTvAvWo5665fTsYVunAkdKg7TlMK9+jOv08S+P6n8
         u846eIeUI7WHPizKVkaJWBeVyrkYVQL+5KK9AiqJGbaJybeU9vwKknlHX8tJ5KdTXgCw
         ssZQ==
X-Gm-Message-State: AOAM531vZSDT2vjFGeUhAslfEAEi2CntRb12uT23mI78qRm8LonvR64U
        EAnMaKRBpFQBzQ5eeNhxJSVxIMRGVDE=
X-Google-Smtp-Source: ABdhPJwnt/ThSbijsm/npoh1ZmjCh4fKQ6y4dDRMkiGf1v7/sV08pEDiax3RQR6n2rVnvsHWQQKJuQ==
X-Received: by 2002:a05:6a00:8c7:b0:44c:a7f9:d8d1 with SMTP id s7-20020a056a0008c700b0044ca7f9d8d1mr15886279pfu.49.1636545620282;
        Wed, 10 Nov 2021 04:00:20 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id x9sm5370913pjp.50.2021.11.10.04.00.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:00:19 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH V5 27/50] x86: Remove the definition of SWAPGS
Date:   Wed, 10 Nov 2021 19:57:13 +0800
Message-Id: <20211110115736.3776-28-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There is no user of the pv-aware SWAPGS anymore.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/irqflags.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c5ce9845c999..da41a80eb912 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -139,14 +139,6 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 	if (!arch_irqs_disabled_flags(flags))
 		arch_local_irq_enable();
 }
-#else
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_XEN_PV
-#define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
-#else
-#define SWAPGS	swapgs
-#endif
-#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif
-- 
2.19.1.6.gb485710b

