Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE69E3FEB2B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245455AbhIBJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245456AbhIBJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:27:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83717C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JnunSlEJCIdP9P5c2OtXs84291lvtlHS2UqsTjDRA/w=; b=rmWPG8vxCsZeHaqWF4TMPPOVRD
        qv4QQGU8EcWHGge1jClcrbKp10BEMs1DxkG7uQcTBAqWQMZYGtjcJ/MNiVj5x4VKW7gHTvSyueEZf
        qwpHsAVZNhAVKEM30ZDauHUes4EOjhr311oPmY35PKjSCIwRXhVdONNZGntyV6i4kuXptruc+KmXk
        MC6HgTSr62RJ7AfI2bAecUj75W748Bow5vBHDPGq1l2F5c4q9dmIVLZyX7kzaiNM+TydLyk93YJW9
        jTm0HgfNolrp/EnFT6vs31QAUBFJQ2jW22Lq7tYDdtl8xO3dYk1bY6uecHQYFHJc/OvC2yt0CXCNm
        SmP7n46Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLiyQ-003KJN-79; Thu, 02 Sep 2021 09:25:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AEAEE3001C7;
        Thu,  2 Sep 2021 11:25:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9535E209D9DBB; Thu,  2 Sep 2021 11:25:29 +0200 (CEST)
Date:   Thu, 2 Sep 2021 11:25:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 09/24] x86/traps: Add fence_swapgs_{user,kernel}_entry()
Message-ID: <YTCYiUIGeluu8Bov@hirez.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-10-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831175025.27570-10-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:50:10AM +0800, Lai Jiangshan wrote:

> +/*
> + * Mitigate Spectre v1 for conditional swapgs code paths.
> + *
> + * fence_swapgs_user_entry is used in the user entry swapgs code path, to
> + * prevent a speculative swapgs when coming from kernel space.
> + *
> + * fence_swapgs_kernel_entry is used in the kernel entry non-swapgs code path,
> + * to prevent the swapgs from getting speculatively skipped when coming from
> + * user space.
> + */
> +static __always_inline void fence_swapgs_user_entry(void)
> +{
> +	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_USER);
> +}
> +
> +static __always_inline void fence_swapgs_kernel_entry(void)
> +{
> +	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
> +}

I think slightly larger primitives might make more sense; that is
include the swapgs in these function and drop the fence_ prefix.

Something a bit like...

--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -853,20 +853,22 @@ static __always_inline void ist_restore_
 /*
  * Mitigate Spectre v1 for conditional swapgs code paths.
  *
- * fence_swapgs_user_entry is used in the user entry swapgs code path, to
- * prevent a speculative swapgs when coming from kernel space.
+ * swapgs_user_entry is used in the user entry swapgs code path, to prevent a
+ * speculative swapgs when coming from kernel space.
  *
- * fence_swapgs_kernel_entry is used in the kernel entry non-swapgs code path,
- * to prevent the swapgs from getting speculatively skipped when coming from
- * user space.
+ * swapgs_kernel_entry is used in the kernel entry non-swapgs code path, to
+ * prevent the swapgs from getting speculatively skipped when coming from user
+ * space.
  */
-static __always_inline void fence_swapgs_user_entry(void)
+static __always_inline void swapgs_user_entry(void)
 {
+	native_swapgs();
 	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_USER);
 }
 
-static __always_inline void fence_swapgs_kernel_entry(void)
+static __always_inline void swapgs_kernel_entry(void)
 {
+	native_swapgs();
 	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
 }
 
@@ -896,8 +898,7 @@ struct pt_regs *do_error_entry(struct pt
 		 * We entered from user mode.
 		 * Switch to kernel gsbase and CR3.
 		 */
-		native_swapgs();
-		fence_swapgs_user_entry();
+		swapgs_user_entry();
 		switch_to_kernel_cr3();
 
 		/* Put pt_regs onto the task stack. */
@@ -917,8 +918,7 @@ struct pt_regs *do_error_entry(struct pt
 		 * We came from an IRET to user mode, so we have user
 		 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 		 */
-		native_swapgs();
-		fence_swapgs_user_entry();
+		swapgs_user_entry();
 		switch_to_kernel_cr3();
 
 		/*
@@ -936,8 +936,7 @@ struct pt_regs *do_error_entry(struct pt
 	 * handler with kernel gsbase.
 	 */
 	if (eregs->ip == (unsigned long)asm_load_gs_index_gs_change) {
-		native_swapgs();
-		fence_swapgs_user_entry();
+		swapgs_user_entry();
 	} else {
 		fence_swapgs_kernel_entry();
 	}
@@ -1017,14 +1016,12 @@ static __always_inline unsigned long ist
 	if ((long)gsbase < 0)
 		return 1;
 
-	native_swapgs();
-
 	/*
 	 * The above ist_switch_to_kernel_cr3() doesn't do an unconditional
 	 * CR3 write, even in the PTI case.  So do an lfence to prevent GS
 	 * speculation, regardless of whether PTI is enabled.
 	 */
-	fence_swapgs_kernel_entry();
+	swapgs_kernel_entry();
 
 	/* SWAPGS required on exit */
 	return 0;
@@ -1089,7 +1086,7 @@ void paranoid_exit(struct ist_regs *ist)
 	}
 
 	if (!ist->gsbase)
-		native_swapgs();
+		swapgs_user_entry();
 }
 #endif
 
