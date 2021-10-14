Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9342E0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhJNSMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhJNSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:12:52 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F02C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:10:47 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d11so4431120ilc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VsFoMwmZgw4ow4ILXqze88+h8cPA1iMm1uHsa+VhSA=;
        b=KK5GZQ4wM70tcz2I8BH0qtchBZd0r6YD64AQ3IJcF8A8EFPZwdV1p9E5dNfY8qt1/A
         GKeRKGvj8Ti7eDvbaEhTk8scgQms0cF7R3DjNc48DG5ZL1cNCWTCTLjDePsCpoHfAWIh
         azPx3w7BEAVyP+WarM42L9RkyHoK4fCl/UrDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VsFoMwmZgw4ow4ILXqze88+h8cPA1iMm1uHsa+VhSA=;
        b=Rvqh+clz62pZ5kJ2B7+M9KKhQzsmxWYuL1ZoSUxvFv3TNKTYD6kmRpemVgKkxQFyv5
         S/KfgRj1Ejie5QsxJ9MSqQCbGu2Bs6zzL5DgYOfFp1p+KgHhrnrWt80XQcrF7ZxBSpXf
         uXPGRyavmb6pFWeKOhPOeTd3WXhkgVrt5JdcNwqxcJCgYTGSerG+oPEz6Ko4w/yWtuPj
         xd9S8cTdhe9Vt9yP291sdI96xt8XBKCU8fuTXNXQAOHPJ1MpLfw5PsSBsZpwBmu7rEx4
         huE/Yv+5RlL+2sa4rucbj7Jo3QsZURWMgt3fgvmdWWHgqse6xuOm5suwrrcNmw+cnA8W
         Yfeg==
X-Gm-Message-State: AOAM53312kk8OLgMtXGiYgR8PaqFfXTj+cxUNsLadgjAjQa9MvPc3Xau
        9RFzGXLOl501B5yXoKCe5WGuSQ==
X-Google-Smtp-Source: ABdhPJzhRVzQHcypXTUjA9g79uHmWpp9PuQpzoQv1rXYU2fZJ0Arl6p67ylIMIqR5d946QL7nZGBxg==
X-Received: by 2002:a05:6e02:1a8e:: with SMTP id k14mr351293ilv.77.1634235047055;
        Thu, 14 Oct 2021 11:10:47 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i2sm1716528ilv.63.2021.10.14.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:10:46 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mcgrof@kernel.org, jeyu@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] module: fix elf_validity_check() warns seen on 32-bit platforms
Date:   Thu, 14 Oct 2021 12:10:44 -0600
Message-Id: <20211014181044.24365-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings introduced by

commit: 8b1185a4427b ("module: change to print useful messages from elf_validity_check()")

warning: format '%llu' expects argument of type 'long long unsigned int',
but argument 3 has type 'Elf32_Off' {aka 'unsigned int'}

Fix it by tweaking messages to not print ELF64* fields.

Fixes: 8b1185a4427b ("module: change to print useful messages from elf_validity_check()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 kernel/module.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index d972786b10ba..ebc70239f65a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2950,8 +2950,8 @@ static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 	 */
 	secend = shdr->sh_offset + shdr->sh_size;
 	if (secend < shdr->sh_offset || secend > info->len) {
-		pr_err("Invalid ELF section offset/size: secend(%lu) < shdr->sh_offset(%llu) or secend(%lu) > e_shnum(%lu)\n",
-		       secend, shdr->sh_offset, secend, info->len);
+		pr_err("Invalid ELF section offset/size: sh_offset+sh_size(%lu) < sh_offset || > len(%lu)\n",
+		       secend, info->len);
 		return -ENOEXEC;
 	}
 
@@ -2971,8 +2971,7 @@ static int elf_validity_check(struct load_info *info)
 	int err;
 
 	if (info->len < sizeof(*(info->hdr))) {
-		pr_err("Invalid ELF header len %lu < %lu\n", info->len,
-		       sizeof(*(info->hdr)));
+		pr_err("Invalid ELF header len %lu\n", info->len);
 		goto no_exec;
 	}
 
@@ -2991,8 +2990,7 @@ static int elf_validity_check(struct load_info *info)
 		goto no_exec;
 	}
 	if (info->hdr->e_shentsize != sizeof(Elf_Shdr)) {
-		pr_err("Invalid ELF section header size %d != %lu\n",
-		       info->hdr->e_shentsize, sizeof(Elf_Shdr));
+		pr_err("Invalid ELF section header size\n");
 		goto no_exec;
 	}
 
@@ -3004,9 +3002,7 @@ static int elf_validity_check(struct load_info *info)
 	if (info->hdr->e_shoff >= info->len
 	    || (info->hdr->e_shnum * sizeof(Elf_Shdr) >
 		info->len - info->hdr->e_shoff)) {
-		pr_err("Invalid ELF section header overflow: %ld > %llu\n",
-		       info->hdr->e_shnum * sizeof(Elf_Shdr),
-		       info->len - info->hdr->e_shoff);
+		pr_err("Invalid ELF section header overflow\n");
 		goto no_exec;
 	}
 
@@ -3046,9 +3042,8 @@ static int elf_validity_check(struct load_info *info)
 	if (info->sechdrs[0].sh_type != SHT_NULL
 	    || info->sechdrs[0].sh_size != 0
 	    || info->sechdrs[0].sh_addr != 0) {
-		pr_err("ELF Spec violation: section 0 type!=SH_NULL(%d) or non-zero len(%llu) or addr(%llu)\n",
-		       info->sechdrs[0].sh_type, info->sechdrs[0].sh_size,
-		       info->sechdrs[0].sh_addr);
+		pr_err("ELF Spec violation: section 0 type(%d)!=SH_NULL or non-zero len or addr\n",
+		       info->sechdrs[0].sh_type);
 		goto no_exec;
 	}
 
-- 
2.30.2

