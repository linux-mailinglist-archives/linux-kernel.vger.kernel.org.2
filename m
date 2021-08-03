Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9E3DEC1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhHCLg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbhHCLgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629EC061757;
        Tue,  3 Aug 2021 04:36:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h14so24935893wrx.10;
        Tue, 03 Aug 2021 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y2VSHMn+RIipKgw8kmM352Y+RR0g+qvVwzlhEmrZdkM=;
        b=Kr/UxJCmWic3i+nzcjYERyYj78r17U7GCvThFcBCKGkkwqAnIGCQ+2wecRUeEocnCT
         l4+mkX2qvVFrLlXA97k9DrBrFeqN1DlqFoRz2c+72SfwPAFkeTuZTJj0kk4nJPRkQ3YO
         SklOfC7SLqEkJr11RLnzKpcEk7a+FlIFm5KXo3AuPkulFhCSDT725U+sN82D3hJQkglr
         IbBSv8uVUCQ3i9b9yse7B0qMF+v3gXm2aGdWmncwg/ABIYLTAcsIKUuDEDTfAvQJ+VQ7
         By9pmOrisiEzYJeSNUiZgj4SesIlhFMt0NlXGaWfXtTu4oSnr61fu5QaQEwUyUpgv41O
         3ADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y2VSHMn+RIipKgw8kmM352Y+RR0g+qvVwzlhEmrZdkM=;
        b=C4iN65Wma50fb3VG8pOYSlyzn8wdL8NkiJR1ZjOAWMJEX7Cj+pNSBbH4ut95/7WgHR
         AYp2TXbbDdaGvTRyc1J+qe6Ja+UvSf6WmRiRQk3OnFy+C9CXdZ/6aZwkWT5JJNCKwwy2
         AiQplaf2GAmTPzqZRcn7d71PBKWRpP3z9ttb+3WlQX1cBcAr9/9HrYqf3Ye2lkEZcE/B
         xQYCLhtMi/ph8xkml2oB6c+ap6bZtU9TriGoZ56NHeVAc2RiQra/0UkOUvTLWTNYQ1lC
         eHtPJc0QiMjHYOH8kfyuwb6f4Oo4NDmU0Q6x4OCRk5Xl7+8AZx7Qs34O1egGTwPOHzN4
         p/Jw==
X-Gm-Message-State: AOAM531UMCaCI9KDd5Ne8noSWz5ciPVR8HHTAE+KCPp88Qr4+B5aOs3H
        QK7nibLP81uhJfguFLTn1iA=
X-Google-Smtp-Source: ABdhPJyPHgAWBHT1oVSQMCPNc19j+J4dI7EvSOVUT53XgLreSQ4onxp6i6wiBzGaiYyy20wR19moLA==
X-Received: by 2002:a5d:424d:: with SMTP id s13mr22789911wrr.356.1627990586340;
        Tue, 03 Aug 2021 04:36:26 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id m14sm13961364wrs.56.2021.08.03.04.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:36:25 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 7/9] x86/uaccess: adjust comment for endif of CONFIG_CC_HAS_ASM_GOTO_OUTPUT
Date:   Tue,  3 Aug 2021 13:35:29 +0200
Message-Id: <20210803113531.30720-8-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 865c50e1d279 ("x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT")
adds an ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT, and a comment on the
corresponding endif. However, it refers slightly mismatching to
CONFIG_CC_ASM_GOTO_OUTPUT instead.

Hence, ./scripts/checkkconfigsymbols.py warns:

CC_ASM_GOTO_OUTPUT
Referencing files: arch/x86/include/asm/uaccess.h

Adjust the comment on endif to the actual ifdef condition.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c9fa7be3df82..e7fc2c515e08 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -411,7 +411,7 @@ do {									\
 		     : [umem] "m" (__m(addr)),				\
 		       [efault] "i" (-EFAULT), "0" (err))
 
-#endif // CONFIG_CC_ASM_GOTO_OUTPUT
+#endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 /* FIXME: this hack is definitely wrong -AK */
 struct __large_struct { unsigned long buf[100]; };
-- 
2.17.1

