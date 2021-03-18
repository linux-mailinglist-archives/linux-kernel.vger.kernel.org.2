Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D759C340B65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhCRRMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhCRRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:11:42 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF68C061761
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:11:42 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id e15so20234148pjg.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pXHCPErazdX/nDg2/nb6QksjLfEFTtrkU2uTHlahGRs=;
        b=Jby0dukBhmBgpcZA/U36PC7iwDl1fv9sQJbWlIVJR6zC612oDIVCBEc9ib6jIIxa0Z
         h5H6tDnzD6sQrwQMtWQSrqnjf3jc+BTx3l1kMPLJSmJpjBwlNsG6Ieg3A9gk5xckevvW
         iDnyS60I+9Am2qOYj40KEO3FE6Xz316ybVZVYMUe9gMTHsS1+xCHi/MC2DH9I4fhZO+C
         d515fn/284/aSzYDxgzvA0yX3tKbC3EzzU7nrrgOVnfFeSfAsc2UQmp2/rPxZf9k5Vlq
         1aqhpEgyS537j0Tsx8A/UMEZWjWvxC3GlheGZ6yYXmPEt9TCJDaVY5VxmGIulC5HNXVb
         35Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pXHCPErazdX/nDg2/nb6QksjLfEFTtrkU2uTHlahGRs=;
        b=L7H8GtfnnZTENMWCQtGoGBjI3QPv53qW/a8n8p9i3u7LYQPFPkrBmMunmFekBWNazs
         xk4Zn917nUB2VrZRqYYOhiJiQqP+E9ZXJzPAO4zpR31xv8sSFsjnRnUU/l6VenXTKUqV
         AiT3PeOnmfP3TxRunVdoDinCgUsYctsB680cIia4X6cr3aQULa+6FRI9u92tN/nhyE2d
         xeEEfGf0YgC+aq8sTP+VWdwQe51vJEksLTSx3nOUGCkkmxiSlB5MdosfMMJEZjVJTqnx
         XIZ7hiVhfKri+aVMt2J+tHMCWtpSK5uqpE7ebi7p+0lj17hwIXlG+1ly/sQGaZnrdA8W
         s3MQ==
X-Gm-Message-State: AOAM5306se1BaQoN30ZjBOJpRzb2WxX3tB3C//hILP5fwJeRYcryVXdV
        nnz2d6g+IuIafXPdI9waemsIkfw/KiVFikz1g/k=
X-Google-Smtp-Source: ABdhPJz7QmlOkNqtn9QR9fE9OonDa8rHz2twqoehDg1I2GIjzKha//VEA73ZQxvmwzcKfV3ni3UGXnqikRS1ctkOawE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a62:ea19:0:b029:1ee:5911:c516 with
 SMTP id t25-20020a62ea190000b02901ee5911c516mr4956591pfh.67.1616087501527;
 Thu, 18 Mar 2021 10:11:41 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:06 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 12/17] arm64: implement __va_function
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function addresses in
instrumented C code with jump table addresses. This change implements
the __va_function() macro, which returns the actual function address
instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/memory.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0aabc3be9a75..9a4887808681 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -321,6 +321,21 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
+#ifdef CONFIG_CFI_CLANG
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The __va_function macro always returns the address of the
+ * actual function instead.
+ */
+#define __va_function(x) ({						\
+	void *addr;							\
+	asm("adrp %0, " __stringify(x) "\n\t"				\
+	    "add  %0, %0, :lo12:" __stringify(x) : "=r" (addr));	\
+	addr;								\
+})
+#endif
+
 /*
  *  virt_to_page(x)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(x)	indicates whether a virtual address is valid
-- 
2.31.0.291.g576ba9dcdaf-goog

