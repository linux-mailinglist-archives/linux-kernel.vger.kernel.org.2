Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DFB3A3F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhFKJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:43:19 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:46826 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFKJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:43:18 -0400
Received: by mail-pj1-f44.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso5663957pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UiYyysxa8FbFF88sTCEIkeBaA7xaRxxxp+zb2ITpl2I=;
        b=Xfy2NCmlQagBB4n6bBcPNqLaKviq5lRJ1kUfKGah73ftrEFPh5D85RXIF/OvimJGPD
         PZ8VumOFGfz8OIWPy2i/HzWQcXrqmnAOPP7Pjlbj8xtmc0c/FH+jO4xCoFQBRbN3pdgK
         O2s6PnRJo1C/jAENvYdDS+mOWTzR/jwqtgoJ3ElX9WYxw2z6TFhIL4GNIVBSZ1ZfV3ea
         4bUxYzlqlAOWCsKh+dd/N6Y0acvPTRsXAWOpZcYyug8IV8d2p7LXBvhqBszbNzTwyk9C
         XQ/KovmpBaO6xHlfNp1gLn309TDgrV5sN3hVVBYKVptr7jV9hbewLhXx+VovYKhUWmNS
         d4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UiYyysxa8FbFF88sTCEIkeBaA7xaRxxxp+zb2ITpl2I=;
        b=TBIQicOpguULcFNf9/nj2yLfpJFr5mv+i3pl5NbJ+LlBc2FcEYP7fU4xWIt3UPtQhz
         DOIrio4mY/3wroULwIcqPSZvD7W53Mtt5axhIbhcj8Twmgq4C9Wk5DCplO8ke+ujcIw9
         AOhz4NyWIDvSjiq4lqpyzxuqrEdGghfjs1O4Qfvn/038zxaUSL5d6/ap8ABDBJX+rY+Y
         THX4+t0zTrw/3ToJgjfwGySjfOc3uCuuU5hZ5eOecSduBtRFAuyIY6qacW5Q6X7zveCd
         MVvmqloKANmnRQzg49Xk83H9Avunh7278mpub1BjrVUKV9u5qMtJz619TVqEEWGw55EL
         DpGA==
X-Gm-Message-State: AOAM532vdSzjUOY99qK3JzWD1sVGXEyCd/26t/2E4mCmJw2nLtRTd5rq
        YAwtIzbaPHXaiXbVPH4tNPla7ifTXmQ=
X-Google-Smtp-Source: ABdhPJwk6CVhwcQCCU3mNV8l1fIG+6nd8MCmX5/fhcDWE6sVG26WI4YDz1YS20xV//UgCqgQhqpz3A==
X-Received: by 2002:a17:902:ee8c:b029:fe:dc5f:564 with SMTP id a12-20020a170902ee8cb02900fedc5f0564mr3181764pld.71.1623404409647;
        Fri, 11 Jun 2021 02:40:09 -0700 (PDT)
Received: from bobo.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id o139sm4981655pfd.96.2021.06.11.02.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 02:40:09 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v4 1/2] module: add elf_check_module_arch for module specific elf arch checks
Date:   Fri, 11 Jun 2021 19:39:58 +1000
Message-Id: <20210611093959.821525-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210611093959.821525-1-npiggin@gmail.com>
References: <20210611093959.821525-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The elf_check_arch() function is used to test usermode binaries, but
kernel modules may have more specific requirements. powerpc would like
to test for ABI version compatibility.

Add an arch-overridable function elf_check_module_arch() that defaults
to elf_check_arch() and use it in elf_validity_check().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[np: split patch, added changelog]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/moduleloader.h | 5 +++++
 kernel/module.c              | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 9e09d11ffe5b..fdc042a84562 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -13,6 +13,11 @@
  * must be implemented by each architecture.
  */
 
+// Allow arch to optionally do additional checking of module ELF header
+#ifndef elf_check_module_arch
+#define elf_check_module_arch elf_check_arch
+#endif
+
 /* Adjust arch-specific sections.  Return 0 on success.  */
 int module_frob_arch_sections(Elf_Ehdr *hdr,
 			      Elf_Shdr *sechdrs,
diff --git a/kernel/module.c b/kernel/module.c
index 7e78dfabca97..7c3f9b7478dc 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2946,7 +2946,7 @@ static int elf_validity_check(struct load_info *info)
 
 	if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) != 0
 	    || info->hdr->e_type != ET_REL
-	    || !elf_check_arch(info->hdr)
+	    || !elf_check_module_arch(info->hdr)
 	    || info->hdr->e_shentsize != sizeof(Elf_Shdr))
 		return -ENOEXEC;
 
-- 
2.23.0

