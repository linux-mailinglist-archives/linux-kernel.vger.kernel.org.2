Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C746C3FAA7F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhH2JsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:48:21 -0400
Received: from fallback21.m.smailru.net ([94.100.176.131]:45964 "EHLO
        fallback21.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhH2JsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=jSgGiOdf+fnG8IZ3m5jqLrr3KZTuRUM5lJGg/Rg++RQ=;
        t=1630230447;x=1630835847; 
        b=QLqfX7KZgtBJr7oi3m9czBh90X3LIoGOiyd5okhXWJtzE0OFeR4hS3a56aEospLegXM21PXdm00WFjEd0FFqlL82wHRWSK+K1Vz47fgqCwdDUf9z64uweBuGEKZBQsXdakA6Y6cWXBWMzsnvxvwVYZ1ZFBIoVLmpRt3Jlw8EMjI=;
Received: from [10.161.22.27] (port=33960 helo=smtp57.i.mail.ru)
        by fallback21.m.smailru.net with esmtp (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1mKHPR-0006iR-2m
        for linux-kernel@vger.kernel.org; Sun, 29 Aug 2021 12:47:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=jSgGiOdf+fnG8IZ3m5jqLrr3KZTuRUM5lJGg/Rg++RQ=;
        t=1630230445;x=1630835845; 
        b=mFAoCSipaHQsgXu3Le72jmrsIcahm0PqOao3HzprjTr9SnwfW3lkZAQQPYlTWqMCXVRIsF0UbIOZ/PR8k6hKV/9d4ImPlku5rYY6N5USS0Asq7IHM8g2Sc4XRWapah/pOAmu3JERnPCH424vW7tkv3MvgOCRtgoIwnGrzeqUDatEYQ2W8YYxRKDH0nXlQ5CAv+8LhABswf8WJ20WKUv43LIdXZM+4+IYtisAYhnT617HhaybXiZ5YVtP1YXPTNAm+Tf6kfF23lvfnarFUweeB791hChDUXhTH6mU8EGpULJvZbKzowafkTRXF9SFG6iJaZJ1IKhq6Jf3a5OCNu6sFw==;
Received: by smtp57.i.mail.ru with esmtpa (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1mKHPI-0001kD-J4; Sun, 29 Aug 2021 12:47:16 +0300
From:   Sergey Larin <cerg2010cerg2010@mail.ru>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergey Larin <cerg2010cerg2010@mail.ru>
Subject: [PATCH] riscv: vdso: map data page before vDSO code
Date:   Sun, 29 Aug 2021 12:47:08 +0300
Message-Id: <20210829094708.169037-1-cerg2010cerg2010@mail.ru>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD92087353F0EC44DD9C4DAED859F16A63896D62C811FDE4A33182A05F538085040BA0EA00125E37A9F22939653C806C5B719B558F2DB1739A4AB7BD9F243933750
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7EC0B1A4921CAE631EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DB576DCB83B448D28638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8BC0AF3B7D3C2D437E3302B007B5D63036F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE71AE4D56B06699BBC9FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751F2CC0D3CB04F14752D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BBCFBAF3982895081A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC8326B808735A8D2F3AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F79006376ED5CA34E944229DD81D268191BDAD3D698AB9A7B718F8C4D1B931868CE1C5781A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F9D50A20087A7B80B57739F23D657EF2BB5C8C57E37DE458BEDA766A37F9254B7
X-B7AD71C0: AC4F5C86D027EB782CDD5689AFBDA7A213B5FB47DCBC3458834459D11680B505B2981A6A9F07E118CDAF1ADB0D17A639
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C4DDEBE0CC47FE269807F7A0C0B8FB85F8FE9946D354282099C2B6934AE262D3EE7EAB7254005DCED5BFF4D08790331081E0A4E2319210D9B64D260DF9561598F01A9E91200F654B02DA3D96DA0CEF5C48E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3480A9008907CB2FD0E90D0910254786C3E511D8228D2518DBA7891C5E7787C3C2844E4327ED33DE8B1D7E09C32AA3244C5535EF45B5F83C6CA36844B32FD77B577101BF96129E40118D5DD81C2BAB7D1D
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMpcxcuSaa4FNKZyEh75SfQ==
X-Mailru-Sender: B6CA852314BECD1116C83C047D515D65625762A6D6A766E94843780C180FFDFADC955A227012B7B651913ECE9F5D4CE557914126969F3D9578C09B768FF42B7F4F0A872F021F9059A8B6234B51EB8B42EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4EE34287C01580B60BBECB5F85F51D0769F22CDD53ECC1FC268F3CF0E9FE49B6984C502FDBC3AF4E69C48EDA054C7F6BA2A21D2B564A35E2864B7819A16894C8F
X-7FA49CB5: 0D63561A33F958A5884C4EB387943FF58430A5A2AF7FA4A432F5DC45A0889764CACD7DF95DA8FC8BD5E8D9A59859A8B697E92A89321C69D7CC7F00164DA146DAFE8445B8C89999728AA50765F7900637A8978F5A52257794389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC851C368AE3DEE0FB9F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CD97A9D37B0EFBA079735652A29929C6C4AD6D5ED66289B52698AB9A7B718F8C442539A7722CA490CD5E8D9A59859A8B6EB3CAEF51A274264089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C4DDEBE0CC47FE2692A2A9C867DB170C6AA8E69B3DF51ADD19C2B6934AE262D3EE7EAB7254005DCED5BFF4D0879033108699F904B3F4130E343918A1A30D5E7FCCB5012B2E24CD356
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMpcxcuSaa4GV3z7WkkJbEw==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005032BDE78ED4CC6EC3B1F7F1F4466EEDEF6541402F6CB556887D154BA7A9C8918CAD91EC71FC00F3837D2A27E1A8065646C7A2150F6097340301919DCEDD5454186FA049C4F996C4B5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current vDSO implementation assumes that the code size always fits in
single page, and the data page follows it:

	PROVIDE(_vdso_data = . + PAGE_SIZE);

However, this was not the case with my kernel build - the
shared object had the size of 4800 bytes. This, obviously, is more than
4096 and requires second page for the rest of the data.

CLOCK_REALTIME_COARSE clock became broken. It was always returning 0
because vDSO code was reading the second code page, not the
data page. Glibc uses this clock for the time() function.

So instead of computing the offset for the data page (it is necessary to
do in runtime - you can't know the size of the binary while you're
building it) simply move it behind the code like the ARM does:

	PROVIDE(_vdso_data = . - PAGE_SIZE);

This commit also fixes arch_vma_name for the data page - it was
reporting the same '[vdso]' name for it in my case.

Since I don't have the real hardware, the change was debugged with KGDB
in RVVM and also verified in QEMU.

Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
---
 arch/riscv/kernel/vdso.c          | 22 +++++++++++-----------
 arch/riscv/kernel/vdso/vdso.lds.S |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 25a3b8849599..0c49390e9be3 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -44,13 +44,13 @@ static int __init vdso_init(void)
 		return -ENOMEM;
 	}
 
+	vdso_pagelist[0] = virt_to_page(vdso_data);
 	for (i = 0; i < vdso_pages; i++) {
 		struct page *pg;
 
 		pg = virt_to_page(vdso_start + (i << PAGE_SHIFT));
-		vdso_pagelist[i] = pg;
+		vdso_pagelist[i + 1] = pg;
 	}
-	vdso_pagelist[i] = virt_to_page(vdso_data);
 
 	return 0;
 }
@@ -77,21 +77,21 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	 * install_special_mapping or the perf counter mmap tracking code
 	 * will fail to recognise it as a vDSO (since arch_vma_name fails).
 	 */
-	mm->context.vdso = (void *)vdso_base;
+	mm->context.vdso = (void *)vdso_base + PAGE_SIZE;
 
-	ret =
-	   install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
-		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
-		vdso_pagelist);
+	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
+		(VM_READ | VM_MAYREAD), &vdso_pagelist[0]);
 
 	if (unlikely(ret)) {
 		mm->context.vdso = NULL;
 		goto end;
 	}
 
-	vdso_base += (vdso_pages << PAGE_SHIFT);
-	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
-		(VM_READ | VM_MAYREAD), &vdso_pagelist[vdso_pages]);
+	vdso_base += PAGE_SIZE;
+	ret =
+	   install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
+		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
+		&vdso_pagelist[1]);
 
 	if (unlikely(ret))
 		mm->context.vdso = NULL;
@@ -105,7 +105,7 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 	if (vma->vm_mm && (vma->vm_start == (long)vma->vm_mm->context.vdso))
 		return "[vdso]";
 	if (vma->vm_mm && (vma->vm_start ==
-			   (long)vma->vm_mm->context.vdso + PAGE_SIZE))
+			   (long)vma->vm_mm->context.vdso - PAGE_SIZE))
 		return "[vdso_data]";
 	return NULL;
 }
diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index e6f558bca71b..fd8a31075256 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -8,7 +8,7 @@ OUTPUT_ARCH(riscv)
 
 SECTIONS
 {
-	PROVIDE(_vdso_data = . + PAGE_SIZE);
+	PROVIDE(_vdso_data = . - PAGE_SIZE);
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
-- 
2.33.0

