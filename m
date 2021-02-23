Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39F3229B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhBWLvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:51:45 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:32382 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhBWLvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:51:19 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 11NBnUO9008768;
        Tue, 23 Feb 2021 20:49:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 11NBnUO9008768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614080971;
        bh=20NjcQU1B4ppYgU8kV+rHnRJALmX62Ugp8OGsXDr/9I=;
        h=From:To:Cc:Subject:Date:From;
        b=B7p58B5NuCKSZsK7xj/VBZxjYqSvlwQHs2EaAYVIbFv0ohc/Sr9gtQMAL3FySuPMy
         Yuufc20mBNG9AAT3XNESXXeQVIB1di7IB3WVF3kprfctGW+OfzsaznS8FUIcl3VdX5
         mWtH6di+/9vS9CX1jJVgRrkC1RaMRJGhFh+NS8EnzUZO9Oyx14BBvHCd4icRxZoMMa
         cMmyym2n6h+6CXHtTkLX6BwtJ71zsM4RP86twRP0WSt6KYPXKmpnhGQ737l/uodlDQ
         nf/v/XiKakkwyPCRDpzhRoRH0yfh5vKgSaZzW4Rbfa+rCeSOvzxGAw+NClfDTLccY4
         rhF94kMXUtZAQ==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Will Deacon <will@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Xiaoming Ni <nixiaoming@huawei.com>
Subject: [PATCH] compat: remove unneeded declaration from COMPAT_SYSCALL_DEFINEx()
Date:   Tue, 23 Feb 2021 20:49:24 +0900
Message-Id: <20210223114924.854794-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compat_sys##name is declared twice, just one line below.

With this removal SYSCALL_DEFINEx() (defined in <linux/syscalls.h>)
and COMPAT_SYSCALL_DEFINEx() look symmetrical.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/compat.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6e65be753603..4b69ab7c723f 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -75,7 +75,6 @@
 	__diag_push();								\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
 		      "Type aliasing is used to sanitize syscall arguments");\
-	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
 	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
-- 
2.27.0

