Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D12398312
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhFBHgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhFBHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:36:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D1C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 00:34:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l1so1546631pgm.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kPYLu8xbAIOv7Q1oQZKxgzwnMunzTs+Q84KnZRYcuT4=;
        b=VBCp0K7vNGPqb1NLvv9BxPv45d6+m9ix9wfOk0T4siFr/bokfpg76NH16TxTP9YUuP
         0qXEe6VaVAhegZpnjogJYddQLDZ4O8oko/Ottqt02MxPZ4TYDOMApU1IRPB2wCTJMjed
         uw7J6HBPTIwNc98lTb/OGoJ6Xdy61JZVhCyd/G0eG0CH9U2xhFfWS0hQ1iIxwHj37xCm
         LqHmNakQHO3pDTOdAVk8HF5Iai0fCOwFAIKL8cthyayIVjWUOJCZp5wJ8sEHjQ0IVINj
         tIcS96eKin2ioFQ5RATfBN9779JjOC1Owt87+xKsnRgHGWCIIf9fmvT6AhnSnrPDlgJh
         MPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kPYLu8xbAIOv7Q1oQZKxgzwnMunzTs+Q84KnZRYcuT4=;
        b=lTuVprp4NP6/8Rnl/c0Ke/OpEEaUbY+goTy9cTzzFdfCLMhWiPyfK7W8k8A0zem38S
         UhNdGk19Pz5+HPtWtfyZnI0ddcLk64SkovqJGL13QWqNWOHXiw1ZIdhngQY8ikMdtxr5
         E30r6DqXjZR0KO0SQQcmmuJyV7+3QgMs9bA+BwCec21BFqWuVWGnp6xqDRbBbo4DKIhN
         MIb6NFLIebtFA+NHa16oPg3n2veSoBtO4X7eRVWOdg2u7jhfRZbUZS42Bc0At7KojXdx
         PEyFJ/MZJpgO7t6JKJWeNoHXB9MginWm8p36sMFhZ7ZDEAu9kmBSHgxYGiuSZj3Qw80u
         SrTg==
X-Gm-Message-State: AOAM533m0ujXb9H3Vqy8ciCZWAxhQbSUn40ZSV6jKW1kqb6fm3qC7m2i
        /xDj4GYMsqbiid9eYGtBMIz0vHQgCRf7vLpY
X-Google-Smtp-Source: ABdhPJwbNo3bIo61LUDHn6Kn5OZsjLMBIBJPs6FkIXO8m14CZ6EUTjVTJG3EoSDP3Crun/ra+2pGpw==
X-Received: by 2002:a62:b419:0:b029:2e8:e879:5d1e with SMTP id h25-20020a62b4190000b02902e8e8795d1emr25603729pfn.3.1622619298425;
        Wed, 02 Jun 2021 00:34:58 -0700 (PDT)
Received: from sz-dl-056.autox.sz ([151.248.69.100])
        by smtp.gmail.com with ESMTPSA id r28sm16239478pgm.53.2021.06.02.00.34.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jun 2021 00:34:58 -0700 (PDT)
From:   Yejune Deng <yejune.deng@gmail.com>
X-Google-Original-From: Yejune Deng <yejunedeng@gmail.com>
To:     tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org,
        mingo@kernel.org, keescook@chromium.org, dave@stgolabs.net
Cc:     linux-kernel@vger.kernel.org, Yejune Deng <yejunedeng@gmail.com>
Subject: [PATCH] softirq: Remove the unnecessary CONFIG_TRACE_IRQFLAGS
Date:   Wed,  2 Jun 2021 15:34:42 +0800
Message-Id: <1622619282-12077-1-git-send-email-yejunedeng@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local_irq_enable() and local_irq_disable() had two definitions that
include CONFIG_TRACE_IRQFLAGS or not.

Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
---
 kernel/softirq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4992853..a81d804 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -362,9 +362,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 {
 	WARN_ON_ONCE(in_irq());
 	lockdep_assert_irqs_enabled();
-#ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_disable();
-#endif
 	/*
 	 * Are softirqs going to be turned on now:
 	 */
@@ -385,9 +383,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	}
 
 	preempt_count_dec();
-#ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_enable();
-#endif
 	preempt_check_resched();
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
-- 
2.7.4

