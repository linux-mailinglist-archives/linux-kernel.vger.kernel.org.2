Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311753A7405
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFOCfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhFOCfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:35:31 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:33:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t40so16582262oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=/26rAjAQD532aMV33kxWrl6Z5akeGf8wTzm+VtoFAIk=;
        b=BiKG15ykC+48N69GiJAk682DfkkUFAYcudu9PVVb4CxuMdOdzXfdPEk3lsBN779Ul1
         PMRH4AqNSBP8qGnbtdjj6FmMn9LNc2NE4fCZffHTWPUdwaOLcMxfHWHnr4PUNujOIdGH
         PoxocM57YzKshDkcvSkeT8BGvxQuZszI6IaIUYHOZi6MNiFuP53z6NovlctOxExvUolG
         kNLOFnVJZ4jJ1SA2y7vm8Ieyi0ROV8nJVrrAC6//tzZitQB4Wk7Z2LxOU2bwOsbvRgEr
         9mGs+oSC9BPfYZMdkDMYqASyBkxTsCxjlVrBNOKF53rdsrsuAlCmHW4PyXcF602h41Gp
         qZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=/26rAjAQD532aMV33kxWrl6Z5akeGf8wTzm+VtoFAIk=;
        b=UgXY7iWDdymPtx7uDzzncYu8l7Wq9/9ijHl6fgz0VuKQRsf1QozQmKtCvjF4FIg0SV
         UU2//G34Q4GtbRdWTFTtYfO7N3b/HomrW2EZ0o0pcPw+9J9Qf7W4yt0kwbCiuvaS8zZq
         PS18h9gYBdlubd/VK9whCG1r8UFRSg70e6mOdoGyan19PKrAx+lbQO0g6VzbE1hyiqgM
         Cg2aOaHlnpOn780dD2Q13gp5t3YfhUcQiXvWaC13kTDBkCkMkZ4iLT2cT8Qan7wXGVJs
         +GLYJwznTbyfDTj55tbj01J/MWdy7LdBZPqK25iNRrrlvzXnYUhMiCOUPWYkfmiZQK9i
         F4CA==
X-Gm-Message-State: AOAM5301GoikeD6eGV93GaxR0TUWIPcaeqC5i6VfyqVccdFY8Kd3CDAD
        iy4nGTb7HJAVet16GWVmcgMcj4uJsf4=
X-Google-Smtp-Source: ABdhPJxBXvT2cqEVnszms6D+WEFTva3OAy+sF5MqCZfIDeWLB2YaQhkHMVo+AThKhax0NwzCEjp32g==
X-Received: by 2002:a17:90a:528d:: with SMTP id w13mr2193869pjh.135.1623722756431;
        Mon, 14 Jun 2021 19:05:56 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id t12sm14132849pfc.133.2021.06.14.19.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 19:05:56 -0700 (PDT)
Date:   Tue, 15 Jun 2021 12:05:51 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?iso-8859-1?q?Such=E1nek?= <msuchanek@suse.de>
References: <20210611093959.821525-1-npiggin@gmail.com>
        <20210611093959.821525-2-npiggin@gmail.com>
        <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
In-Reply-To: <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
MIME-Version: 1.0
Message-Id: <1623722110.amu32mwaqs.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Jessica Yu's message of June 14, 2021 10:06 pm:
> +++ Nicholas Piggin [11/06/21 19:39 +1000]:
>>The elf_check_arch() function is used to test usermode binaries, but
>>kernel modules may have more specific requirements. powerpc would like
>>to test for ABI version compatibility.
>>
>>Add an arch-overridable function elf_check_module_arch() that defaults
>>to elf_check_arch() and use it in elf_validity_check().
>>
>>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>[np: split patch, added changelog]
>>Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>---
>> include/linux/moduleloader.h | 5 +++++
>> kernel/module.c              | 2 +-
>> 2 files changed, 6 insertions(+), 1 deletion(-)
>>
>>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
>>index 9e09d11ffe5b..fdc042a84562 100644
>>--- a/include/linux/moduleloader.h
>>+++ b/include/linux/moduleloader.h
>>@@ -13,6 +13,11 @@
>>  * must be implemented by each architecture.
>>  */
>>
>>+// Allow arch to optionally do additional checking of module ELF header
>>+#ifndef elf_check_module_arch
>>+#define elf_check_module_arch elf_check_arch
>>+#endif
>=20
> Hi Nicholas,
>=20
> Why not make elf_check_module_arch() consistent with the other
> arch-specific functions? Please see module_frob_arch_sections(),
> module_{init,exit}_section(), etc in moduleloader.h. That is, they are
> all __weak functions that are overridable by arches. We can maybe make
> elf_check_module_arch() a weak symbol, available for arches to
> override if they want to perform additional elf checks. Then we don't
> have to have this one-off #define.


Like this? I like it. Good idea.

Thanks,
Nick

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 9e09d11ffe5b..7b4587a19189 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -13,6 +13,9 @@
  * must be implemented by each architecture.
  */
=20
+/* arch may override to do additional checking of ELF header architecture =
*/
+bool module_elf_check_arch(Elf_Ehdr *hdr);
+
 /* Adjust arch-specific sections.  Return 0 on success.  */
 int module_frob_arch_sections(Elf_Ehdr *hdr,
 			      Elf_Shdr *sechdrs,
diff --git a/kernel/module.c b/kernel/module.c
index 7e78dfabca97..8b31c0b7c2a0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3459,6 +3459,11 @@ static void flush_module_icache(const struct module =
*mod)
 			   (unsigned long)mod->core_layout.base + mod->core_layout.size);
 }
=20
+bool __weak module_elf_check_arch(Elf_Ehdr *hdr)
+{
+	return elf_check_arch(hdr);
+}
+
 int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
 				     Elf_Shdr *sechdrs,
 				     char *secstrings,
