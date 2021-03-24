Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332893479C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhCXNkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbhCXNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:40:14 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4825C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:40:13 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g15so18003244qkl.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hwcrb+R8W88bZvooxgh81cxu5j6eJ4bBtC8MKzp11Lk=;
        b=UZPLEc8VplRig4xeP8uR50MXKKWqbJ6C7Hyg2rW0k1SoDt+4mkVYaVbTlRUnq4Gbfw
         QK8+rjBNQrxjQ7dF9EQhX23gUukrM32mDzLqLtn/h7cb1XblU79OMLHWmH0AQXvIdXVG
         3umVs75ypKpBDOh0oWcI/Wqd5KSeFoi2rFH/KgX4c6GnD0AZtCVTtF1o62PfQ5adZ5/J
         u7ZmVwnsFkj1w6OQaE7qXCY1lvKfEXflZts6InB9BTdhVcbHZiKc3oK2gc2t+yLIPaY7
         If4S1glaEp02xf1+aIyzN/a6O8KelFzjHEXMB1wk/NAFGqHBFhzDuYspuWJ+/hxOvtLn
         BK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hwcrb+R8W88bZvooxgh81cxu5j6eJ4bBtC8MKzp11Lk=;
        b=oqbaRLS2REtjReB13oGWvPR/mYwdnWacJcX65Cc9yTn8QIM5JhVdyFtCMNH3iYlZdo
         fRCIW5pryxQI/1iaQANy+v27Jdng2OH6kyZdPLGhuBq+5Gu67bd96hdSJi1WxL7EoZV1
         HaRRLdncSQuW4XwF4N41JKw3+MPKxz9AIpBskq20p7sjcyjfg2BZc0+Nz2bWyLcFgEbN
         It+DnTyxXES9DOUNddFy8yY8A1GLvNBnrIPbUgU+nhS8G0I6NlYMYY7p0cR+g2b0yQzq
         cLqUDtEZAPBpcRVBt37frpbAhG57FakB5PLB9wGLMze7JKHNzE9Vwfi9KrVr5s6kIoSt
         GaEw==
X-Gm-Message-State: AOAM532Dg67ablqxvn5Us74PE84+YrHMA+9j6w7vt5U9q+bEY1xEvMTT
        bitu/Q5Is484JUA2WoEZq3Y=
X-Google-Smtp-Source: ABdhPJxnSkdLKA7Y58yK/hobhyt2PIcgOrxlo49U02IhLbGPfR92M3P/9vbknqb2FLj1ZeA+/vkBNQ==
X-Received: by 2002:a05:620a:24cc:: with SMTP id m12mr3124767qkn.496.1616593212990;
        Wed, 24 Mar 2021 06:40:12 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.36.138])
        by smtp.gmail.com with ESMTPSA id a20sm1691731qkg.61.2021.03.24.06.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:40:12 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dwmw@amazon.co.uk, luto@kernel.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] x86/apic: Rudimentary typo fixes
Date:   Wed, 24 Mar 2021 19:11:49 +0530
Message-Id: <20210324134149.30445-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/preferrable/preferable/
s/serivced/serviced/
s/distributon/distribution/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/kernel/apic/apic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index bda4f2a36868..e26ee6e67f47 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -619,7 +619,7 @@ static void setup_APIC_timer(void)

 	if (this_cpu_has(X86_FEATURE_ARAT)) {
 		lapic_clockevent.features &= ~CLOCK_EVT_FEAT_C3STOP;
-		/* Make LAPIC timer preferrable over percpu HPET */
+		/* Make LAPIC timer preferable over percpu HPET */
 		lapic_clockevent.rating = 150;
 	}

@@ -1532,7 +1532,7 @@ static bool apic_check_and_ack(union apic_ir *irr, union apic_ir *isr)
  * Most probably by now the CPU has serviced that pending interrupt and it
  * might not have done the ack_APIC_irq() because it thought, interrupt
  * came from i8259 as ExtInt. LAPIC did not get EOI so it does not clear
- * the ISR bit and cpu thinks it has already serivced the interrupt. Hence
+ * the ISR bit and cpu thinks it has already serviced the interrupt. Hence
  * a vector might get locked. It was noticed for timer irq (vector
  * 0x31). Issue an extra EOI to clear ISR.
  *
@@ -1657,7 +1657,7 @@ static void setup_local_APIC(void)
 	 */
 	/*
 	 * Actually disabling the focus CPU check just makes the hang less
-	 * frequent as it makes the interrupt distributon model be more
+	 * frequent as it makes the interrupt distribution model be more
 	 * like LRU than MRU (the short-term load is more even across CPUs).
 	 */

--
2.30.1

