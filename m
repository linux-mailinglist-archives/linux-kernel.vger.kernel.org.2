Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEDE4189B5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhIZPKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbhIZPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:10:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C76C061604
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:08:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so11310964pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADz7NrPOTpj5cH5eFLTAbuzyUTNwCvRtncteUJ2axN0=;
        b=mRGrmQKCeyfZO1vkUkxfxWtIH5ebNTFnu0VuQU7fqGHVVXfc/LkeAbpYqCi57oBpkJ
         aC9H5Yq7DspxeQqkR9C33pDl6JjCJYb8Yyi/WcuqjMgYuxzzZT6B6HXBhJXDRYfh6bMz
         WCHNYuXGepTogHGihoDBqbx4T7xwSRiTaRYqdZVz44JLxG36XTwYJkPjhQpXbkWI/K73
         LELs4VjM773hOVYRnvcJni5PFG+4yMYB6usBVzsK0+n1z2swrmb4IgaklhGVdu1VqhJs
         8a/3yqe9oRjgYMq3wdbLnupHtnr903d8a9b7js7o4/s4gL4TPMWwRnbC2mw1GV7jdbZz
         0EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADz7NrPOTpj5cH5eFLTAbuzyUTNwCvRtncteUJ2axN0=;
        b=O6hEgEDRcArpEpEBSZ3SR/bXwZ5MLEwjpNp0n9XTNJcvsZCPGGUEpm4gkxiUTMSmqn
         gqKA3l/h7Q1h3a5onPrXJUirQkFO6nVdhlxlHOxZZr8k7r1Vof8rUJMOzexSPqRNTcZ4
         VOyAP5+GmQhPLvUX8o8f39B1vZ2MfL03sb5zcRDpPtMZVO8op2CbD86q/5XHeR1uFQWH
         C0LNYF+10tUgtCE5qaEdZB/lIvfEbTiPxZHWYx1sfR8OiDY9cD7lYRa5bBLx5hyJZZ72
         9D59KZHT5H1++hx2ntxczBhcRg4opDhfnhJq4PAPdIkhRs22EVq4gu3Sk5+nZMGRI885
         4Kkw==
X-Gm-Message-State: AOAM5321j1hAlAQrytcegqzZdl5vH/LAqeExWFLFVaPbc8gJI0ujOJg3
        TWiCDf89yahieIaWjA7JDF+Ow4Ikg6XOWQ==
X-Google-Smtp-Source: ABdhPJyrVdyVaWbSP+/EYYw2dscbXau/JotzcwJK5Vq4ULXJLbyu8HUqhsmz+gQjOIyndZ3TW7IQiA==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id w16-20020a170902a710b029012b9b9fc461mr18126885plq.59.1632668935277;
        Sun, 26 Sep 2021 08:08:55 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id a10sm14160271pfn.48.2021.09.26.08.08.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:08:54 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH V2 03/41] compiler_types.h: Add __noinstr_section() for noinstr
Date:   Sun, 26 Sep 2021 23:08:00 +0800
Message-Id: <20210926150838.197719-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

And it will be extended for C entry code.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/compiler_types.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b6ff83a714ca..3c77631c68bd 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -208,10 +208,12 @@ struct ftrace_likely_data {
 #endif
 
 /* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))	\
+#define __noinstr_section(section)				\
+	noinline notrace __attribute((__section__(section)))	\
 	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
 
+#define noinstr __noinstr_section(".noinstr.text")
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
-- 
2.19.1.6.gb485710b

