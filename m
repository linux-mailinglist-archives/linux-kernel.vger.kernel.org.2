Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC23EECF9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhHQNDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229721AbhHQNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629205388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oQqo8hoVlThMMKnyM3FPqRihSiJEUC2ucaiuvvbW2TA=;
        b=DKiX0UtfvSE9CLEB2umsy3lhsLqfmK1K5hDhfFLc6k7dutJcQwGfNLTcjFBWWduRjbTfn1
        pQ0fp1N9RXM2z+FWH5x+kpJY+RnP++Yi/z7fHPUv0GdVvlQGozg378poNy/jG+me5ji/TT
        mhmnMWfDxTWOY0V3s8AlHTfmXlsbPlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-sR4Wrbx7Nd6psWd4z1W6HQ-1; Tue, 17 Aug 2021 09:03:06 -0400
X-MC-Unique: sR4Wrbx7Nd6psWd4z1W6HQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5013EC73A0;
        Tue, 17 Aug 2021 13:03:05 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.208.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 514A95C1D5;
        Tue, 17 Aug 2021 13:03:03 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jstancek@redhat.com
Subject: [PATCH/RFC] powerpc/module_64: allow .init_array constructors to run
Date:   Tue, 17 Aug 2021 15:02:54 +0200
Message-Id: <920acea9aa18e4f2956581a8e158bdaa376fdf63.1629203945.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcov and kasan rely on compiler generated constructor code.
For modules, gcc-8 with gcov enabled generates .init_array section,
but on ppc64le it doesn't get executed. find_module_sections() never
finds .init_array section, because module_frob_arch_sections() renames
it to _init_array.

Avoid renaming .init_array section, so do_mod_ctors() can use it.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
I wasn't able to trace the comment:
  "We don't handle .init for the moment: rename to _init"
to original patch (it pre-dates .git). I'm not sure if it
still applies today, so I limited patch to .init_array. This
fixes gcov for modules for me on ppc64le 5.14.0-rc6.

Renaming issue is also mentioned in kasan patches here:
  https://patchwork.ozlabs.org/project/linuxppc-dev/cover/20210319144058.772525-1-dja@axtens

 arch/powerpc/kernel/module_64.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 6baa676e7cb6..c604b13ea6bf 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -299,8 +299,16 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 					  sechdrs[i].sh_size);
 
 		/* We don't handle .init for the moment: rename to _init */
-		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init")))
+		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init"))) {
+#ifdef CONFIG_CONSTRUCTORS
+			/* find_module_sections() needs .init_array intact */
+			if (strstr(secstrings + sechdrs[i].sh_name,
+				".init_array")) {
+				break;
+			}
+#endif
 			p[0] = '_';
+		}
 
 		if (sechdrs[i].sh_type == SHT_SYMTAB)
 			dedotify((void *)hdr + sechdrs[i].sh_offset,
-- 
2.27.0

