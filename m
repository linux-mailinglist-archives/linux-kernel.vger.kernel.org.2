Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE7F3F1A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbhHSNeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:34:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59084 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhHSNeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:34:19 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DBFC2196C;
        Thu, 19 Aug 2021 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629380022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cvj0xH+3AqKLJJhx1EO2FesxLVWy3ps5cwtf6AlxzyQ=;
        b=Q4s4DyWQ5toZ4PBiMRxsh+S/vr0rQq/PLaLH9r+ewMntj9vUwMXcf3QJjtgBtW5hwtnuVV
        1wu5upv5Idv5laxU1HJM7XWSZl2eSxFIwGuxtjBQslgncqMJtAE0bFQHtSm+kv3dZHoDtP
        TcmZqrGFV0YtX4ef9jn2o9ODgoWmuyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629380022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cvj0xH+3AqKLJJhx1EO2FesxLVWy3ps5cwtf6AlxzyQ=;
        b=/R4lBWgN5D+HFURRe70/+8RvbkjpBZU73SSUJGQsQKqplo/+aGL+i+DAheunq5Rt5xtOde
        xkzWMjm2m0NAAGAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4F98C1363C;
        Thu, 19 Aug 2021 13:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id rhKwEbZdHmFjegAAGKfGzw
        (envelope-from <jroedel@suse.de>); Thu, 19 Aug 2021 13:33:42 +0000
Date:   Thu, 19 Aug 2021 15:33:40 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: x86/boot/compressed/64: Lenovo Ideapad Miix300 bug report
Message-ID: <YR5dtDvvcgekoIJu@suse.de>
References: <20210819100230.GA28768@agape.jhs>
 <YR4uffjFuqvrz1Tp@zn.tnic>
 <20210819121653.GB28768@agape.jhs>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ih4w7RdvR2e7jEi+"
Content-Disposition: inline
In-Reply-To: <20210819121653.GB28768@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ih4w7RdvR2e7jEi+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Fabio,

thanks for your report!

On Thu, Aug 19, 2021 at 02:16:53PM +0200, Fabio Aiuto wrote:
> I rebuilt a plain v5.13 kernel (no reverts) with that config
> disabled and everything goes fine.

Can you please try the attached patch? I think the problem is that the
32-bit EFI boot path sets up its own IDT before ExitBootServices() is
called.

Regards,

	Joerg

--ih4w7RdvR2e7jEi+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot-idt.fix"

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 95a223b3e56a..99cfd5dea23c 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -39,7 +39,7 @@ SYM_FUNC_START(__efi64_thunk)
 	/*
 	 * Convert x86-64 ABI params to i386 ABI
 	 */
-	subq	$32, %rsp
+	subq	$64, %rsp
 	movl	%esi, 0x0(%rsp)
 	movl	%edx, 0x4(%rsp)
 	movl	%ecx, 0x8(%rsp)
@@ -49,14 +49,19 @@ SYM_FUNC_START(__efi64_thunk)
 	leaq	0x14(%rsp), %rbx
 	sgdt	(%rbx)
 
+	addq	$16, %rbx
+	sidt	(%rbx)
+
 	/*
-	 * Switch to gdt with 32-bit segments. This is the firmware GDT
-	 * that was installed when the kernel started executing. This
-	 * pointer was saved at the EFI stub entry point in head_64.S.
+	 * Switch to idt and gdt with 32-bit segments. This is the firmware GDT
+	 * and IDT that was installed when the kernel started executing. The
+	 * pointers were saved at the EFI stub entry point in head_64.S.
 	 *
 	 * Pass the saved DS selector to the 32-bit code, and use far return to
 	 * restore the saved CS selector.
 	 */
+	leaq	efi32_boot_idt(%rip), %rax
+	lidt	(%rax)
 	leaq	efi32_boot_gdt(%rip), %rax
 	lgdt	(%rax)
 
@@ -67,7 +72,7 @@ SYM_FUNC_START(__efi64_thunk)
 	pushq	%rax
 	lretq
 
-1:	addq	$32, %rsp
+1:	addq	$64, %rsp
 	movq	%rdi, %rax
 
 	pop	%rbx
@@ -132,6 +137,9 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	 */
 	cli
 
+	lidtl	(%ebx)
+	subl	$16, %ebx
+
 	lgdtl	(%ebx)
 
 	movl	%cr4, %eax
@@ -166,6 +174,11 @@ SYM_DATA_START(efi32_boot_gdt)
 	.quad	0
 SYM_DATA_END(efi32_boot_gdt)
 
+SYM_DATA_START(efi32_boot_idt)
+	.word	0
+	.quad	0
+SYM_DATA_END(efi32_boot_idt)
+
 SYM_DATA_START(efi32_boot_cs)
 	.word	0
 SYM_DATA_END(efi32_boot_cs)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a2347ded77ea..572c535cf45b 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -319,6 +319,9 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
 	movw	%cs, rva(efi32_boot_cs)(%ebp)
 	movw	%ds, rva(efi32_boot_ds)(%ebp)
 
+	/* Store firmware IDT descriptor */
+	sidtl	rva(efi32_boot_idt)(%ebp)
+
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax

--ih4w7RdvR2e7jEi+--
