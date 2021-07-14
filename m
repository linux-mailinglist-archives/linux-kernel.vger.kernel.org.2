Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722053C8246
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbhGNKCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbhGNKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:01:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED8AC061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:59:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o8so1223017plg.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ToADbup+MfTcTpglli3NLkX2Wd5wYfKIe/K2kf6rNBQ=;
        b=Bm0nGwXC1+3vIZuFsqmqFFkDVyv4H+yw/oCyHEFUNrjUwzDfFhEinIq6VEJHhumP8q
         8YBEt3k77xz7rNVpBszjuY1GRRmlGGrhe3exOvxWRAPLCPqSTRFvjYqRAibBQ+3eGaCC
         ZlULeS6pAbg0adnyqaTjgGlKt2hfzwPDTM4EozrdgDTcPF1yUFQqiR7TdvsOTsAaUKjm
         lk9Lvfzpimn4v2LVUPsayU8Gbjhh8dWeFNYleEKdZ2lIrJAQCaYsVXzwObZjmJN6ZzoY
         QMVbl5Hj4/n8344XpSP65M8nMT5OmUBLSyPvNUFCjK/ayPZCFX40Vrv3T1KwMxf/qAoY
         RFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ToADbup+MfTcTpglli3NLkX2Wd5wYfKIe/K2kf6rNBQ=;
        b=DV5SF8+56VwvisE+1Pio18K2VLRpInS9s7EeRpoCcGollJ7pUgcqOKLfsFD63suYDK
         UvgNlSDxGh63Gks8oE0pcAg6TiEF3vGhhoZHwncwBAZiCsLDLVjXhL53X+tPL6BXTvYE
         wF+tALSEKV157CjyZ3ElgfVJSG3L4/YwWGGXjLED25KHuK5xD/ekLn5EicTprYUU4rbW
         nUiWAZS4LSwG/CG6DE3aMFibIsfSDwX5VmRod1iDDOFGtZC7jdxV3jQ7zMC7pwg/mbDS
         6ku90btv54wwEC+RBJEcSU9Vr5pYnPyw0uVA51zK+QGcmLnmP1Wc4J8dB/cHG4L5v93B
         YOCg==
X-Gm-Message-State: AOAM532GPwYzaS4XgyDiYdrfN7zSltI8KxLU7Y1ObX5KeW5WL3pURkAH
        Ge1p1dqqDWC1FJcKw4wgMKf5iA==
X-Google-Smtp-Source: ABdhPJyaZ05UA4Nk36Abw5RVyDDb1ciSkKP0wmY3pLKxX2qeHryYINSqgme8/521alXputJLQ+2AEQ==
X-Received: by 2002:a17:902:7042:b029:12b:2b94:30 with SMTP id h2-20020a1709027042b029012b2b940030mr7210927plt.9.1626256747422;
        Wed, 14 Jul 2021 02:59:07 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g1sm2283304pgs.23.2021.07.14.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:59:07 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Luca Weiss <luca@z3ntu.xyz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/2] reboot: Export symbol 'reboot_mode'
Date:   Wed, 14 Jul 2021 17:58:48 +0800
Message-Id: <20210714095850.27185-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714095850.27185-1-shawn.guo@linaro.org>
References: <20210714095850.27185-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers like Qualcomm pm8941-pwrkey need to access 'reboot_mode'
for triggering reboot between cold and warm mode.  Export the symbol, so
that drivers built as module can still access the symbol.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index a6ad5eb2fa73..31bf2611ee12 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -32,6 +32,7 @@ EXPORT_SYMBOL(cad_pid);
 #define DEFAULT_REBOOT_MODE
 #endif
 enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
+EXPORT_SYMBOL_GPL(reboot_mode);
 enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
 
 /*
-- 
2.17.1

