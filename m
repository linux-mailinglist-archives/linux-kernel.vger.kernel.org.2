Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20E04415A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhKAIwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKAIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:52:30 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C193CC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 01:49:57 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bk22so9121493qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lok2ON3VQbUU0lcMD7OWSV5wnShQqyRArqp1wNtotkw=;
        b=pR/aL95ZtL3uIDXyO1OMGo18MQrYpUHPr+0uU+vhu/cbcZYSQvALplt2+g/VH+Jxwx
         9EzUVcW6Q7Z8fWm+kPAAAdUUFJuxt6aqcBLD9HXMLIiaA2qF5rnoA4CcvHtqHYSbSX5o
         vWm2cid6YPqws44JMcV4gVJqr/CzEaJVNIzmPGp6niHEDiZwywVro7CzZbF2U7QI/lUk
         46Isvvi3bc4+/s4Qdwxe45IdGG0RR8bohQX2N8mOEzn7pkyfPCG4MYQp+71BAouWdRmL
         NIZpY+0U4SJ85/b3358NBjASfsb0rx1nvkhckgM/HazYNbwNn5ZMbIiiQ5lOQIuNFAZb
         gXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lok2ON3VQbUU0lcMD7OWSV5wnShQqyRArqp1wNtotkw=;
        b=0Qy29vsNj4yjL6tmZLF0rzNqk6+1OpkPNw5GFQsSf2lAHjjqyW8Yz+J5gwKM5AJOyH
         seiZjrVSUc3GsabCEWJ7ReUYzU+BTbZtgbEJw3q4qnJtxqhrWUHPWOETz3JYoJnE32Kw
         xqBHYf5RPsTXZkhAtVUmBoyclhkPKXKVOuX070lSu4YUwZaZcMK2OUbs0BpO5G3n3Fqr
         5FBtaC2NiEY+QoQ3AFAuC8KJQzUVKEmzsUWgDhefUzVsjmULmRbdeEXP6zNhRWv8WFXq
         /kDGDSkTNSHiUqAd1dfFHpFE3YheTzIYAPg2G7R+zbH/4xSkDlG9R3dVypoWR7J0LjrO
         TpvQ==
X-Gm-Message-State: AOAM530EP4K5gmsFss14kmnCyNeZ/OmxDTQo2h8dtN9iMphDVwkSzJ9s
        Qc5PeBQkB8pbVgtkBcymCdI0pUH8YPo=
X-Google-Smtp-Source: ABdhPJzKsXTqbvlExehTyn8Ow/zYN8yu0PB1Rs7N2mECXarrtQ05CZ/wSAZ+sfGzrMxX4uTMye7X/g==
X-Received: by 2002:a05:620a:38e:: with SMTP id q14mr7432666qkm.491.1635756597061;
        Mon, 01 Nov 2021 01:49:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u11sm10213408qko.119.2021.11.01.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 01:49:56 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        deng.changcheng@zte.com.cn, jiapeng.chong@linux.alibaba.com,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] x86/kaslr: fix boolreturn.cocci warning
Date:   Mon,  1 Nov 2021 08:49:48 +0000
Message-Id: <20211101084948.36868-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

./arch/x86/boot/compressed/kaslr.c: 671: 8-9: WARNING: return of 0/1 in
function 'process_mem_region' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 67c3208b668a..a4a10c7c5330 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -672,7 +672,7 @@ static bool process_mem_region(struct mem_vector *region,
 		}
 	}
 #endif
-	return 0;
+	return false;
 }
 
 #ifdef CONFIG_EFI
-- 
2.25.1

