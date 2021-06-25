Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE83B4A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFYVPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:15:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:13:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u20so1904169wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6XYBMrwVTdQxoLB9SPfxd1XM05darClXQ6jHNS1NjRI=;
        b=hUf13KjShXbfe06XEQuWSUKWNcBFoHHGMMDquxCtkd4jnQchK0NDQA09WV1LJDhnmA
         5IoAcuIKmmUkbN1PUgUbXMFhjteWW2GQlgRw/tnww4eSJe6iPvi1islp9n8vk1/ujjBQ
         F973HKIVdQsfikT25NpWwSUs9dnfIMAJZILaakVwajGf8zG44arm//0U3PUk/lskdjQM
         psw9LYKlmNigxw6smC8oj3zG61z8NPyxe5M9zQFE/kte5onffxyG8T3JwOFMJLgSl3WS
         +DYvZDo3IrJunWbRUQDsB+ua7lCHslZ+bbqkLJlWj4mLBIEKd1KkSlj4Ylgp0chA7tqd
         BqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XYBMrwVTdQxoLB9SPfxd1XM05darClXQ6jHNS1NjRI=;
        b=MnpQAIKyaSE4UDjnoRKvnRaMa734rzW72N9oiakoBHCkgGSXxgEuCeaWgO60V+agwK
         hBfY6OHnQg7tEkK7CrobZs7v+Np6QDrFTJvrMFbZ54MXPr9LSYvDxrbIoUEFc6hGzIVX
         oBIQ4XvFAMcTXHdeJ2iiM2kdwdkYyZgfgmSZsALp2W9TcdxamXwcM82ntD7Dr4V7JFV1
         b1NB2TSGWQFeRdeKq+U39fMrXmYcfiQk9uVY/sw/6DKg6Lf+9cgK2amQB2QOTgaPQ5f2
         TwRiaafxt25kjbBKRpCehxxUJJQYKS1l0CGuw4rHo/nsF2qDDLyvJuugq1t2/eC6xqRd
         8yKA==
X-Gm-Message-State: AOAM530N+CMV/OI0VFPNTGb+YgBaaH8fVWavPtH0CxVfp7AqNk9k3NUv
        Krla3kRtnQPLurZ0oesxRA==
X-Google-Smtp-Source: ABdhPJyymj3oXldYty3T64V5rPU9Y5cKX9ukIaddp0yC2C4N3ZCC+oJ5A9vl6ryfr70dTlLLOZQlHw==
X-Received: by 2002:a05:600c:198f:: with SMTP id t15mr13106774wmq.27.1624655594730;
        Fri, 25 Jun 2021 14:13:14 -0700 (PDT)
Received: from localhost.localdomain ([46.53.250.16])
        by smtp.gmail.com with ESMTPSA id c12sm8173229wrr.90.2021.06.25.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 14:13:14 -0700 (PDT)
Date:   Sat, 26 Jun 2021 00:13:12 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v2] ELF: add and use SUPPRESS_WARN_UNUSED_RESULT
Message-ID: <YNZG6N0W/7gjG7Gm@localhost.localdomain>
References: <YNYz+hVeqsQmiEqN@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNYz+hVeqsQmiEqN@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last write to the "error" variable in load_elf_binary() is dead write.

Add and use SUPPRESS_WARN_UNUSED_RESULT macro to express intent better.

Credit goes to Ed Catmur:

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425#c34

Macro doesn't work for WUR functions returning structures and unions,
but it will work when gcc copies clang.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c                     |    3 ++-
 include/linux/compiler_attributes.h |    4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1290,7 +1290,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		   and some applications "depend" upon this behavior.
 		   Since we do not have the power to recompile these, we
 		   emulate the SVr4 behavior. Sigh. */
-		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
+		SUPPRESS_WARN_UNUSED_RESULT
+		vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
 	}
 
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -284,6 +284,10 @@
  * clang: https://clang.llvm.org/docs/AttributeReference.html#nodiscard-warn-unused-result
  */
 #define __must_check                    __attribute__((__warn_unused_result__))
+/*
+ * "(void)" is enough for clang but not for gcc.
+ */
+#define SUPPRESS_WARN_UNUSED_RESULT	(void)!
 
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
