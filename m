Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B20638FBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhEYHiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhEYHiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:38:22 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02345C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:36:52 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id j75so29406477oih.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=cj7lEaJdojw6tToUHDcBfi68AsoYVGoJti0faU6Wz9s=;
        b=Zf6B1kqMApPvlu0coGCx/3z1XeVFWe4PKsLT+PKoF5JZQv/QjrKJm1YBpA7/FsdC8X
         mdPU0ZSZzjRUzC9ukJWgPw0BrUpbxvIWpOAr2lZnTdFNNUXJZgMgygQLYrJ2fvzX/6SJ
         9HYG29QW/OIIXH10MNeWJDnMHgKCrGr7V/OPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=cj7lEaJdojw6tToUHDcBfi68AsoYVGoJti0faU6Wz9s=;
        b=l0/N+ut72dUJtNfhazrRhiK3W2qCe2m50Dehjb+gPJSpeEqyhyqR8SFYX2VIJhdaaS
         bkStZwrMV/i1sEHOTBuRkhDmgl9gqc2MD3cs68szVAaCZOBTdDBQ0NrYvIsIW5JaKV9y
         PrSJC9FiVZIZ754qm0Sh26AFlPuCfRA5frhQpWp7iDUMuLSzScoV/TnqwxJwxt0eIFg/
         GvUQ2ufdUFZY9yNKynCz8AL79bx72HFEGVo0cxZBIUUmzHRTlV92Gefbw6oKGunsom8J
         r8+nNVuWg0H5GLQRqCHZLq+Ggr9uFXRnfzV/LxubUnKpevlVqhD+C/BF9MYp7e1z+5mh
         /WMQ==
X-Gm-Message-State: AOAM5328UVu1uXGeJHInjdMeMMytf4wS1W0jbblBMMEO7s+sUKfW/4UU
        gLj1y/qDM4vRQToDrYot6U99Hn7n3rfn0pF8dZ8VIQ==
X-Google-Smtp-Source: ABdhPJw8MGirsVptXluU+maY9ChwTNM4067Sejc7D6ROKDs9nnYroVVTfd20NH25pe766pFd2fLTv605aAJWePO2Xw4=
X-Received: by 2002:a54:4501:: with SMTP id l1mr13372048oil.19.1621928211356;
 Tue, 25 May 2021 00:36:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 May 2021 07:36:50 +0000
MIME-Version: 1.0
In-Reply-To: <20210525085400.15854-1-cuibixuan@huawei.com>
References: <20210525085400.15854-1-cuibixuan@huawei.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 25 May 2021 07:36:50 +0000
Message-ID: <CAE-0n522LiGxorhBXtqE2yj8ZKtnmVCikCPFV_iQp8MJzNA+Zg@mail.gmail.com>
Subject: Re: [PATCH -next] module: fix build error when CONFIG_SYSFS is disabled
To:     Bixuan Cui <cuibixuan@huawei.com>, jeyu@kernel.org
Cc:     sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bixuan Cui (2021-05-25 01:54:00)
>  kernel/module.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index decf4601e943..7287ecc76714 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2794,7 +2794,8 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>  }
>  #endif /* CONFIG_KALLSYMS */
>
> -#if IS_ENABLED(CONFIG_KALLSYMS) && IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> +#if IS_ENABLED(CONFIG_KALLSYMS) && IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) && \
> +       IS_ENABLED(CONFIG_SYSFS)

Thanks for the report. It is the wrong fix though as we don't care that
sysfs is enabled or not. How about this patch?

---8<---
diff --git a/kernel/module.c b/kernel/module.c
index b5dd92e35b02..5be1f8ea4886 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1462,6 +1462,13 @@ resolve_symbol_wait(struct module *mod,
 	return ksym;
 }

+#ifdef CONFIG_KALLSYMS
+static inline bool sect_empty(const Elf_Shdr *sect)
+{
+	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
+}
+#endif
+
 /*
  * /sys/module/foo/sections stuff
  * J. Corbet <corbet@lwn.net>
@@ -1469,11 +1476,6 @@ resolve_symbol_wait(struct module *mod,
 #ifdef CONFIG_SYSFS

 #ifdef CONFIG_KALLSYMS
-static inline bool sect_empty(const Elf_Shdr *sect)
-{
-	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
-}
-
 struct module_sect_attr {
 	struct bin_attribute battr;
 	unsigned long address;
