Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4843C8690
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbhGNPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhGNPFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:05:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56301C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:02:33 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id n77-20020a3740500000b02903b496f6f425so1469803qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rfNndXM+S/Q4LzZ3k/0GQiSEjOYU8QVEpoa3Fqz1qiY=;
        b=HxrlxZJLnqYwbmGRC7IWewZ3IqxBn+Lc+82yzbFIL0mOOAB6dsGqZuzbybBrOPA1Cl
         UKWcctz98Z2Q3s6i3MoR51yCXWF4ANdN4psZgRxHUn0rozRSKOPnknTTXJMJ29cUlGZj
         QvLGA9HZcglqOcqGXyH3lZzkKeLAHxXjiAJ/aU2tt7ouda2Is8fTPsCk851nffecH7bY
         kjMcXDq3RMVSEsNQf9Gm1d5q74g5BiiwY1yyImk3T5LDYMmTM/7tYf8wDdzDEAxHfsv8
         Q6x1r6QH5ZYP9y/FpvIOoB3l07h7qWUfbJHGS6ZkHIQUMQ+e8a6ruDoPC6rpfPTn81ma
         1v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rfNndXM+S/Q4LzZ3k/0GQiSEjOYU8QVEpoa3Fqz1qiY=;
        b=T3BvCq0bAFV2GCYgZ1M4mxOvtDNBNiSd53AGjPdTMcq6O7JaRyadZXBQr6paxTx3wq
         GnpWxnlDOuWxuVljrpA+zMnznEQ1x5pMu2AXy2Jg7/mpjiNiXGaAs/HPeX72+wizJXVL
         oBozzdpd5QJ0L/1FpHbNcsUiSA6lmDgEqZz20cj/DdLIvde5/L2OP7kB0SYSdLN6ygfD
         8F4gJ/JKMak/5klgn6BB51cZt/YDP85Ho1Jc/a0ingjE3ddnk5nB8ctR69IMX1WwGw6W
         uTifCZyKiRuTBk0IDgwX7E0OPHFZJvXvRHibQnyqkFT58hIYJ+l5sKmQdJrawhdlqnPj
         Nvdg==
X-Gm-Message-State: AOAM531V+CXMiFkTmxIN6/tLypDEfoKKDiAgTUdOpV05ssWYVpiPvL9H
        6woeqRs58di/+0IzNuC+nbkQHbkQmg==
X-Google-Smtp-Source: ABdhPJxhCP879XfywFcMX3yYGZUTqT+VdLVGkCRfRhB7+RIjYVbYWlynlHe+1P4nH41xHjkpl4hfpJViDg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:41c4:bc71:d9ee:7fdc])
 (user=elver job=sendgmr) by 2002:a0c:ba05:: with SMTP id w5mr11509612qvf.60.1626274952115;
 Wed, 14 Jul 2021 08:02:32 -0700 (PDT)
Date:   Wed, 14 Jul 2021 17:01:59 +0200
Message-Id: <20210714150159.2866321-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] compiler_attributes: fix __has_attribute(__no_sanitize_coverage__)
 for gcc 4
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix __has_attribute(__no_sanitize_coverage__) for GCC 4 by defining
__GCC4_has_attribute___no_sanitize_coverage__.

Fixes: 540540d06e9d ("kcov: add __no_sanitize_coverage to fix noinstr for all architectures")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler_attributes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 2487be0e7199..67c5667f8042 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -37,6 +37,7 @@
 # define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ 1
 # define __GCC4_has_attribute___no_sanitize_undefined__ 1
+# define __GCC4_has_attribute___no_sanitize_coverage__ 0
 # define __GCC4_has_attribute___fallthrough__         0
 #endif
 
-- 
2.32.0.93.g670b81a890-goog

