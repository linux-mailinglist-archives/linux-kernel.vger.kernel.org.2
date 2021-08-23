Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13373F4F26
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhHWRPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhHWROi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C3C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f8-20020a2585480000b02905937897e3daso17023527ybn.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rn4Ov6fZtIeuYv4qe0duX3eTx27b0q1rGV7B2MFXCkM=;
        b=j4Fz5nKfDBIg6wGCX99oSD3qw+9mbpkBIV+gOiN5gOqYPBf8xKsRiv4NCnNtfxvGz5
         y6GKY3b2JbRDDfueb2CkhEeI7beflC6wiiafJimcNoeQuObystNTTA5pIsa3xFvCYBt9
         ydA7gzBTHz+lU829Kc2bHhqZ/+yQA2cWyKSLMUcfRQoj7/diGWT8gV6nbeEULgSN2jDp
         vx+68GUIHcdhTyPglZY63BqqWy3IJ01MOVpGI9RuO6V+xS6YNJEYrXZBZ3OHpJrRdUoB
         MUMFhySVjh/SWbsNoFpcgTJLlKudWt9G4AYFp27LraAAM3EOOBusIJm01Y9mGSVFLTo3
         E1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rn4Ov6fZtIeuYv4qe0duX3eTx27b0q1rGV7B2MFXCkM=;
        b=H0orRpXNEjOUDii/gLVGl7si8DuNkt8htiWf7XtW89i6q3uoeC42UCyrw7T9PTpcqu
         7F6+R1+8Td5ZiFM/yvd1VSrGbgzvVDUAKdKyKBLR2DgjZqxNcQGdZ/wCRNOhmoAMpLNz
         6SmSxi8++w2dAt8K+ZH6gqCX+XDZrh/mSUNBvxMbo71VjfzR1is8Bb+4m3DY93Bg/aKx
         aUcS3jOzIJWr7fONssai27TEv2wRRkF95aWKFU3CuxYmKpK5F0AT8VONcFTKQW6HMcod
         1r29wXiAN9N/SRdnKT2+9Zvi86AQv4OWtcT5OfzEbj559//9v0yu/MIwb2C+n/HfxX9t
         a6Eg==
X-Gm-Message-State: AOAM53251FoyOI88b8SZSBo3OVxcx1MfZ1jscIuafI2Wiugz1z5oKIMB
        hPS0SEmbCee8xN7e9TpJ9EuOoK5rWHFu06hC/60=
X-Google-Smtp-Source: ABdhPJzC7ogvonrsSKVnw0YC87eH29k88ofugQafcLSHc1QP/Ose4p2Mx7EWK3xZS3bmJ/eC6x7NMo3scppuISgjSb0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a25:55d6:: with SMTP id
 j205mr46404895ybb.395.1629738834582; Mon, 23 Aug 2021 10:13:54 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:18 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 14/14] x86, build: Allow CONFIG_CFI_CLANG to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled with
Clang >=14.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 88fb922c23a0..c487c482ed67 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -107,6 +107,7 @@ config X86
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_CFI_CLANG		if X86_64 && CLANG_VERSION >= 140000
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
-- 
2.33.0.rc2.250.ged5fa647cd-goog

