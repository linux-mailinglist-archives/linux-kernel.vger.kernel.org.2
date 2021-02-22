Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCDB321B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhBVPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhBVPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:14:10 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33CDC06121C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:12:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i7so84447wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9B3We5q5jUlMWnG7lj9lYkkhNy18/R2y/H2GADaTPU=;
        b=J2kQ3vgVupU7YxCo469wvYqdCl6XIMH1CifuQ6lqo0nfRC2HC6qL/Hu7pPCFG3wVO1
         AJazkQBjIjycD2lZ2tVJtpvRGnBbWvjygTtzO12wMEmdOoqMIugwge6SiA/Mm5obxsQr
         xXpUUBL9z6E+LMv2K1hQSqXMteumLji9331jU57wo5EZTBponbsQF1QtOv3ibUuWxkHO
         N+SUraB7WMmiVjmFhmv9Mgg65zS+YNWiqPx1ByHJvn7Sdk/lEeXk5zzivUQgdj8w8ky2
         bFKG71ukVVa4UrLln4GZ/r1c+3Q5U1+p6+5vMMXCIASLnj7jIEcdH8m4E+FqvfH3U3Ey
         dkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9B3We5q5jUlMWnG7lj9lYkkhNy18/R2y/H2GADaTPU=;
        b=qVy7jIz1ywjQ+axfnjmGFk3ttkrvkfUHmF5EF9nWC7jI/0/xl3dsQbq/75SATSqam1
         fjAgyifa7qub9xFQ6A42dy4/y8Ajv8o9PaIcKiw+X0Cfhk8+p6ys/UfKvjOambXl3vRg
         aevrSuGSDa0quND6ILvDrleODqdFy7yG2hUkbqUgk/oh6mX0Wwu+3i1gVOWuK8V6yZsa
         sRHCaXWIZqiRr8s/6QtqomlypPRFdNhPfcyBvXDEAZs/bS5BsMSw+lSuWVW899TylWqc
         ZxyO370ZapJ1KzQWoQHu5WDha8LWrzSEm89nGGrhhALg+XHqIBpl16y9umnVRkVvwml4
         BSBg==
X-Gm-Message-State: AOAM5314Hucg6RE7L8kxEzq4pjbrdmhj4gFtC6Dhf3K+6punNJIFkptC
        Dw08+Xs6JNk3QyVEgv2ReZpxq9HmtgfCKheQqFY=
X-Google-Smtp-Source: ABdhPJxDf8AHZgB69k5I3nPeFatACq/O425spQLOXZFJX8APIsbJQSLk4JPCzbFKiTm033Oj1UXGFw==
X-Received: by 2002:a1c:1bc4:: with SMTP id b187mr20410506wmb.18.1614006774481;
        Mon, 22 Feb 2021 07:12:54 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id j29sm4279343wrd.21.2021.02.22.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:54 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com, Jessica Yu <jeyu@kernel.org>
Cc:     Romain Perier <romain.perier@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] module: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:21 +0100
Message-Id: <20210222151231.22572-11-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 kernel/module.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 4bf30e4b3eaa..46aad8e92a81 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2814,6 +2814,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 	Elf_Sym *dst;
 	char *s;
 	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
+	ssize_t len;
 
 	/* Set up to point into init section. */
 	mod->kallsyms = mod->init_layout.base + info->mod_kallsyms_init_off;
@@ -2841,8 +2842,9 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 			    mod->kallsyms->typetab[i];
 			dst[ndst] = src[i];
 			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
-			s += strlcpy(s, &mod->kallsyms->strtab[src[i].st_name],
+			len = strscpy(s, &mod->kallsyms->strtab[src[i].st_name],
 				     KSYM_NAME_LEN) + 1;
+			s += (len != -E2BIG) ? len : 0;
 		}
 	}
 	mod->core_kallsyms.num_symtab = ndst;

