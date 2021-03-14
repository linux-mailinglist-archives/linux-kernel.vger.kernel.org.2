Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7066D33A88E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhCNWcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCNWcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:32:21 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:32:21 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id j7so7931588qtx.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIR0IKk/2598a66UhLOYWtA8DOagLjMaGf8+iMRmJ60=;
        b=VlGuDWbhQEvvF1nFRHLbuiSk+CwvURg1h5GL0ON3DtzB0gTxdkuxSkM9/fdIU8yF69
         JCK7vQXcgbeWLE8Ck7PyYtkmuhJ+XF7C+kb2CdqwlrVG8SAByoGI249cEhH/AFPhBd9z
         Ofe0LxLhncXkpG4OfgX2lXZIK/XV7f5PA08KEbKlCCsn7gKrHWrS4w7n3s9NfurYIEvo
         R3PZQEYyN0WjRnJxR/O5GDsONwBM8NISaG2Fquvlo/p4WKuhoWx5aiIzB+hrmmu5vmDe
         oKtTKhv4zkG0Q1ZHwmNtgw/QdSSN8ItuwE3qRg53Xmy1wobS27vURCPGhYVdF/hAoxRz
         xmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIR0IKk/2598a66UhLOYWtA8DOagLjMaGf8+iMRmJ60=;
        b=TNjGfJpV4eBA+scTM7MlzF6vpsdeDiM+ZgBABbAU0yc46mxQXdTcT+sX1VJBfzqMJt
         HsQls2MEN9mL0K9HbVkvjb8ODu6OLLPbWdwPQQwniC8gNHmvgn086W+K1Bw7doVJSrqb
         nOSqloH0/pZRHDm48JbefL9XjWGMBiAyDYIns5DDrTRT2doiKVTVIHIvc6V9zjUT1Vxs
         P4tZk2jw7Q51BDyMPNiKyaeTS4dLVHClgi1BH8ZBf6M2nW36NTcYdusZu26smjFRUNVF
         IakI+o7tnfXyBTpaAZ8hYVEly269RZfdNIyglzkbOYTAYnahSywiCdHvRjMqu7uRS9oJ
         Lk1w==
X-Gm-Message-State: AOAM532S7xDyZl7RN/kTF9biQ/IIgI3J65P5hQ0VluhjfzHf+i/u7DKb
        3NaFJ1JiFqACkJJr3f6EeSs=
X-Google-Smtp-Source: ABdhPJwFvY6JSBkLFxdp7FK/zbhyQjB/Ug2xy2CuHJrB8PEPR5HZY9TB9LYngY5yeYo3SUJqJCwSCA==
X-Received: by 2002:a05:622a:109:: with SMTP id u9mr20526930qtw.116.1615761140413;
        Sun, 14 Mar 2021 15:32:20 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.247])
        by smtp.gmail.com with ESMTPSA id i93sm9746984qtd.48.2021.03.14.15.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:32:19 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     masahiroy@kernel.org, Mikhail.Petrov@mir.dev,
        unixbhaskar@gmail.com, dbrazdil@google.com, maz@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] scripts: Mere typo fixes in the file kallsyms.c
Date:   Mon, 15 Mar 2021 04:02:00 +0530
Message-Id: <20210314223200.218402-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ordinary spelling fixes.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/kallsyms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 7ecd2ccba531..4d44aba8c212 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -12,7 +12,7 @@
  *  map char code 0xF7 to represent "write_" and then in every symbol where
  *  "write_" appears it can be replaced by 0xF7, saving 5 bytes.
  *      The used codes themselves are also placed in the table so that the
- *  decompresion can work without "special cases".
+ *  decompression can work without "special cases".
  *      Applied to kernel symbols, this usually produces a compression ratio
  *  of about 50%.
  *
@@ -337,7 +337,7 @@ static void output_label(const char *label)
 	printf("%s:\n", label);
 }

-/* Provide proper symbols relocatability by their '_text' relativeness. */
+/* Provide proper symbols relocate ability by their '_text' relativeness. */
 static void output_address(unsigned long long addr)
 {
 	if (_text <= addr)
--
2.30.2

