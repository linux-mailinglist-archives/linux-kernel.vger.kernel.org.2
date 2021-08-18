Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74093EF9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhHREqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhHREqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:46:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D50FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:45:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so4525847pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d9/DksIpIs6eeSb59VhNgqVboYbLOLwWLPZ+ciNIZIg=;
        b=PV/qqiQgGxjo7nMT7lRvkdKlSW/DEF7UqjsnHuz+aAZZG9j6+yPAiw8ieIE70Z+Z98
         PKUktMDBrsZtmYtRWEbmz8SujoA/UZoeuDMyCxBUwg98IeajHLuTwk+an3fKLpdux5Mm
         zQGr6S7Qj781WqBMWQlUFyCqs8C8+z4HEbhMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d9/DksIpIs6eeSb59VhNgqVboYbLOLwWLPZ+ciNIZIg=;
        b=qH6iQqRVNVY2eMMbaI9aSeqynvXQCP08zA0DNbfhl+VY2dXd4HalIb7/HMUDJ+4XtB
         kavtRZIpMc9BU6+afQrXfWe4Wc0wOF5gL6AY7oVHbDzhztxj9pJBbiIMn58kGdhToc1x
         ScujmXd3iufDx+hWkKrIprJqyc6few8MikS9vsctq+5qZZ31KY479LEcP5jz4cuyLufT
         mp4GpwpvpNg/sGFos9VEs5wsrZu9YEDHQuEiKn8DbXxZTXi6e00XYjjV1P85uWPrAZU5
         8EaxIdp9gKPNzuTET+ykQtJvAJO8KtfBzl5WAUQ4+4xn6fhwUS1xXQu9GAIqAurJgbVi
         5FaQ==
X-Gm-Message-State: AOAM530KRCMKBqiC8i20AQKhTywn1t1aEchamPgcue1r/A2OHh5IOoP5
        rZCOCEltrRC7qhF9+gWB5ZI1Og==
X-Google-Smtp-Source: ABdhPJy/XoxWVOZ2UsCcNas/NWhjgh6P8UutKplGf8x5Azcw1w0XTjxJKYaESs1MRWejDlfGVNOzEQ==
X-Received: by 2002:a17:902:9b87:b029:12c:c3ed:8a1d with SMTP id y7-20020a1709029b87b029012cc3ed8a1dmr5660298plp.7.1629261943752;
        Tue, 17 Aug 2021 21:45:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r11sm3453850pjd.26.2021.08.17.21.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:45:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/heap: Avoid __alloc_size hint warning
Date:   Tue, 17 Aug 2021 21:45:40 -0700
Message-Id: <20210818044540.1601664-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; h=from:subject; bh=DDgzTBXYoMrM8vXwihYDk8DwYREB5xfDvDUf2PPGNps=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHJB0pkodVpAzd0nyN16uoly1WRFapAVyer9x5KK+ juNFZ4CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyQdAAKCRCJcvTf3G3AJqJND/ 9ChnuYNoWillTscUU0T21tkDrddDuyj5UgPQbz1sk06wv60e98M6w9vLFOwN91KdSjpZvJa7sexKob PYVefnFMAoldAF3UujbKZoqUIhjm0aGVeHNO88L2KfLoZwDAJs6jafzziJkrurnIcyAQAn+Q1k+vAj C7LLAajvyOlLkvP/qshbJP19Hikma47IZWgJS/rvW+nvnMeeemVInlM0jTNg+sNwiO+Gp4GdXALswO XGQLT1Oaz4FXpw2kBzZJzPfgPlCB5H0SFILnfuangtSVUXauFPdjvEkN1XQU/m8TfbtQoNzZnZLfYg WLToMw6PaXjZbaQi0rWhAoouQu2jBtqJWt80bEccgLuft2b1g4rzrse5d5QCeWf/QaB/YKUEpBAWzk NildF2+vSzkxv0+6T2mrEfMrL7wh6AtqjVcL6gqfDKzCWQJ5MPrBxHZXUwth5VXff//6mlaJcTT8yO wo2ekVqk7zgF5L+WnS8YJRd9SR41ecE5SCkFRyl2J+ur91qPCOWXh5v8M1KdrZnpNEkkztmWDkgeUl 0d/oXThqjlaPYnrbXjHl4hD593ucEEpccUFV3Ip8sSvHinZNsa84/Q/vZQ1UsTjrmSzKh8RXBL8mVR QLofjNpvtf0J4x8qGeAczzXAnwgU+wYeCGpX3VGj536RV1j2J5dxkWXmKGSg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once __alloc_size hints have been added, the compiler will
(correctly!) see this as an overflow. We are, however, trying to test
for this condition, so work around it with a volatile int.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/heap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 3d9aae5821a0..e59fcbe00ae0 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -12,6 +12,8 @@ static struct kmem_cache *double_free_cache;
 static struct kmem_cache *a_cache;
 static struct kmem_cache *b_cache;
 
+static volatile int __offset = 1;
+
 /*
  * If there aren't guard pages, it's likely that a consecutive allocation will
  * let us overflow into the second allocation without overwriting something real.
@@ -24,7 +26,7 @@ void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
 	two = vzalloc(PAGE_SIZE);
 
 	pr_info("Attempting vmalloc linear overflow ...\n");
-	memset(one, 0xAA, PAGE_SIZE + 1);
+	memset(one, 0xAA, PAGE_SIZE + __offset);
 
 	vfree(two);
 	vfree(one);
-- 
2.30.2

