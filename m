Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193BC37376E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 11:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhEEJYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 05:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhEEJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 05:24:32 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB8C061364
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 02:22:26 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id o18-20020a1ca5120000b02901333a56d46eso1382284wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ipcG+5uCgsazZ7SR+haE6w/wCwHthGEmmd5v1cTEP/8=;
        b=Wa7jknldLVEb+Ol4xnPiuV/by6Xwx4KIWfE7GTQKnuTxRAGxxs3qS5SQlcZBc+xADO
         DL96Rlb9gm9TTh/fOLdUZO/U9VvqE3OtwXOrz7yBhsiaXeYvoeFavL0vkwa7Eck5guIR
         rcxZPLO/8E7AeU3v+5eRfUPBolRf0WX/ATU8MzjrRyATplxxTmi25YGYQngESpYuwJsB
         jPBLYp+5x+WOkoYrLtm+Hs3YVO4K8uNv13Sajwz1RQXDKn787107qHhuom4DwnqdIfwE
         Hio49NiWO8+2aAVsRvspwe+5aM39tyKwqobRQiuAnlG5tUJyi9OZktyWOmt/ZRZno0Od
         eRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ipcG+5uCgsazZ7SR+haE6w/wCwHthGEmmd5v1cTEP/8=;
        b=n3qYuOaFgjzgYTttBcvvyCQwoKSNC+VhYXdCNylP2rb06L8E2ftzyqcz0oCU+jSuQg
         AZoyt0BdQmjyTIpeSnmxK2HbI7KOna4j+r1Rj9PCaI+IH26l0g9t0g9NOL2eFjwDmzRc
         Sm2eN7FNQzhCmQ4MyvZDd7PdNxH/hcdKQ4phOiS7ApwukKR1tB2LXPbboeBL7nmfzA8P
         JzRomTXof+SETZQVTK3RSgYrVtM1gTFQGl8ozU/ijTCm83qtFg4Cyvx2p3vSCyins7FK
         ixMFBX0gI1bhHuGiAruL+/MWkrzzUexKMfgUF3G/pASpoe8TPYqFgxIrF3+me3bu+/0F
         D8Gg==
X-Gm-Message-State: AOAM533k0tdsHyIUcVroeWyjEyUJUEOCMsqubcTXujCFU1N6jTr1BFCb
        hL8w5SfARbFX5R/GwPaHXaH2iakb6SI=
X-Google-Smtp-Source: ABdhPJyd3wD7aqm0Q6dV9thF2Jtc8bjPMmzJ11889eWBiQDyjJkcxXsOzHIhFasJFXHmVQufCvN5HY+g+1g=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:75a3:1d6a:25a4:791b])
 (user=glider job=sendgmr) by 2002:adf:f38c:: with SMTP id m12mr31190888wro.282.1620206544799;
 Wed, 05 May 2021 02:22:24 -0700 (PDT)
Date:   Wed,  5 May 2021 11:22:18 +0200
In-Reply-To: <20210505092218.2422386-1-glider@google.com>
Message-Id: <20210505092218.2422386-2-glider@google.com>
Mime-Version: 1.0
References: <20210505092218.2422386-1-glider@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 2/2] kasan: use dump_stack_lvl(KERN_ERR) to print stacks
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, pmladek@suse.com, mingo@kernel.org
Cc:     bo.he@intel.com, yanmin_zhang@linux.intel.com,
        psodagud@quicinc.com, dvyukov@google.com, elver@google.com,
        linux-kernel@vger.kernel.org, ryabinin.a.a@gmail.com,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the contents of KASAN reports are printed with pr_err(), so use
a consistent logging level to print the memory access stacks.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Prasad Sodagudi <psodagud@quicinc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kasan/report.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 14bd51ea2348..8fff1825b22c 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -230,7 +230,7 @@ static void print_address_description(void *addr, u8 tag)
 {
 	struct page *page = kasan_addr_to_page(addr);
 
-	dump_stack();
+	dump_stack_lvl(KERN_ERR);
 	pr_err("\n");
 
 	if (page && PageSlab(page)) {
@@ -375,7 +375,7 @@ void kasan_report_async(void)
 	pr_err("BUG: KASAN: invalid-access\n");
 	pr_err("Asynchronous mode enabled: no access details available\n");
 	pr_err("\n");
-	dump_stack();
+	dump_stack_lvl(KERN_ERR);
 	end_report(&flags, 0);
 }
 #endif /* CONFIG_KASAN_HW_TAGS */
@@ -420,7 +420,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 		pr_err("\n");
 		print_memory_metadata(info.first_bad_addr);
 	} else {
-		dump_stack();
+		dump_stack_lvl(KERN_ERR);
 	}
 
 	end_report(&flags, addr);
-- 
2.31.1.527.g47e6f16901-goog

