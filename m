Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8B3D781F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbhG0OHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbhG0OHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:07:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A097C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:07:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ga41so22125936ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwb7ro3ON5FeVYMNGe8yOwscdFk4k7lbmDY8UlQSSSU=;
        b=iqHRjUeutkLa07LJEsbbN8Qbxtt7AqNx3rAb4eK8VA6OmzCjB8OJltFYJJnCTta3BM
         +Mubj0UK2NE/onK+X2/+K8WeC1Ee3+b7STmvCCR0pHgqD7dtlZ07AHOevbXt6Y2yBHIH
         uUnJpIg6wB4ZCVojyeOrQUw7KMjrPb4YtkH1s/lD2DTewhS0U7P+Zl0MfLowU0GjfpNf
         /X6GFBz1+uTvyMkLoDlc+Cf6fT8dAtt4luHIvRFyb/wJaAwVJxCtNOOjHJSpqxd8rJtk
         eERWadJ7u6c9h+9FjZ6hbtPmeVSw49vDRTl7rkrZsXy0y1iW0FUDWFA4THnXapa/z/n4
         ZBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwb7ro3ON5FeVYMNGe8yOwscdFk4k7lbmDY8UlQSSSU=;
        b=VjNLln22Hp5948jis2xGKf9iZcTbKCrCwyzuWvhb3tuDpmDV2W8wX2dmT18vg8f49E
         dzVPD2909hpYKesvUeyUUFCp0pDwtZFcEymLjq+xRR58OZwVr8os4jn3s5J4pdBNsuue
         O7Ew+LarLv6uTNJ1Vcml0mFCRt0Ez2hQ0cDNCQjXgvoLtE1ln//F8RJ4BlrVyDHaRn7m
         /SMwByrAppKayWxLlyWhqKomHChP4ur4zYMkxlzaYekYpAwCDpPBebp1Bj5Z6ovJ1ur5
         AVJXwnBzaG2b3JcsxmmjeHwZPQpbM8I/KTnxUxpgH5zDm/Ln1xBvsQKbDj5JXPYaVvbb
         UZGw==
X-Gm-Message-State: AOAM530234ZoybI0wqTjH2nuIg6ckhiYM+557ENi5GTLxRRbAtM++pMQ
        pPJ25enhZvtAdtnp30CMECI=
X-Google-Smtp-Source: ABdhPJyCC9eTL+glb7i0tzS1QSoFohRSFp2+KNknJelo7Vrov9grqyogMw7xzUBzzp0yfe4Zg8IEOQ==
X-Received: by 2002:a17:906:4551:: with SMTP id s17mr21257939ejq.26.1627394821179;
        Tue, 27 Jul 2021 07:07:01 -0700 (PDT)
Received: from pswork.ad.harman.com ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id c7sm1326089edn.45.2021.07.27.07.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 07:07:00 -0700 (PDT)
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     jeyu@kernel.org, keescook@chromium.org
Cc:     samitolvanen@google.com, treasure4paddy@gmail.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v2] kallsyms: strip ThinLTO postfix ".cfi_jt"
Date:   Tue, 27 Jul 2021 16:06:15 +0200
Message-Id: <20210727140618.19130-1-treasure4paddy@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210727131853.GA18032@pswork>
References: <20210727131853.GA18032@pswork>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang ThinLTO adds a postfix ".cfi_jt" to a symbols of extern functions.
For example this breaks syscall tracer that doesn't expect such postfix,
so strip out the postfix from the output.

Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
---
Change in v2:
  - Use existing routine in kallsyms to strip postfix ".cfi_jt" from
    extern function name.
  - Modified the commit message accordingly

 kernel/kallsyms.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 0ba87982d017..e9148626ae6c 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -166,16 +166,20 @@ static unsigned long kallsyms_sym_address(int idx)
 
 #if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
 /*
- * LLVM appends a hash to static function names when ThinLTO and CFI are
- * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
- * This causes confusion and potentially breaks user space tools, so we
- * strip the suffix from expanded symbol names.
+ * LLVM appends a hash to static function names and just ".cfi_jt" postfix
+ * for non-static functions when both ThinLTO and CFI are enabled,
+ * i.e. for example foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
+ * This causes confusion and potentially breaks user space tools and
+ * built-in components, so we strip the suffix from expanded symbol names.
  */
 static inline bool cleanup_symbol_name(char *s)
 {
 	char *res;
 
 	res = strrchr(s, '$');
+	if (!res)
+		res = strstr(s, ".cfi_jt");
+
 	if (res)
 		*res = '\0';
 
-- 
2.17.1

