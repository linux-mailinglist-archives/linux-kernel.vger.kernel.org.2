Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F18D39C762
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 12:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFEKUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 06:20:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58366 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhFEKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 06:20:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622888331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGQSnyxSd6gfdoXrtQHIy8tVXnS/aduJxY/LMJIFW4Q=;
        b=Xhph6mntOUK6AhYp0QEBEXsBxxJ2VDL5UJBh97iRggIWwJuOL50M6V5WCglGH1Fz+EdiiS
        TGyESlM5V32sHNoF31wwYHYTA3HN2waSjyk1DGaxL1diD7OXdH7yPch9W8W+qjCbB3YkAP
        cmz8rmqMNan32IbzYqzYW8wMp/6lBuJUuOTDpvdHMBX7g8V9CjoaQVIe8J0e+82JqIbDP5
        bYJLh7Cg7W9kYrXM0diqdPag+oiPLwcoSMOTv8FVaGalRSA262GMgz6sT4yQzsvvWnYbxD
        BL5Cq9E0vWcE7gIc1jy424ft3DheHpad1qSnVO2CT8hq8HvjwfOhVqFWBrXrcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622888331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGQSnyxSd6gfdoXrtQHIy8tVXnS/aduJxY/LMJIFW4Q=;
        b=AqjuWJigPU77v3xps+YZ4GeOifrdD8qNSBtzmBNebvWue0rerbmXMzsQIFtKZNwR01leFV
        BxUPqvDi7ybOnhCg==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [patch 0/8] x86/fpu: Mop up XSAVES and related damage
In-Reply-To: <433086cd-fadf-efe2-955b-0263a2fc969f@intel.com>
References: <20210602095543.149814064@linutronix.de> <433086cd-fadf-efe2-955b-0263a2fc969f@intel.com>
Date:   Sat, 05 Jun 2021 12:18:51 +0200
Message-ID: <87mts4zkac.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04 2021 at 15:04, Dave Hansen wrote:
> The nice Intel 0day folks threw some tests at this series.  It managed
> to trigger an oops.  I can't right this moment publish the source for
> the test, but it looks pretty trivial.  It basically creates a 0'd XSAVE
> buffer, sets XCOMP_BV to:
>
> #define XSAVES_FEATURES ( \
>         XFEATURE_MASK_PT | \
>         XFEATURE_MASK_SHSTK_USER | \
>         XFEATURE_MASK_SHSTK_KERNEL | \
>         0x8000000000000000 \
>         )
>
> Then passes that buffer in to ptrace(PTRACE_SETREGSET, ...).
>
> The oops is below.  It doesn't *look* to be XSAVES-related.  The oops
> looks like it's happening in xstateregs_set() itself as opposed to down
> in the code actually concerned with supervisor state.
>
> No bug is jumping out of the code as I took a brief look at it.  The
> xbuf versus kbuf code looks a bit wonky, but I can't find a hole in it.

I can....

--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -128,7 +128,7 @@ int xstateregs_set(struct task_struct *t
 		xbuf = vmalloc(count);
 		if (!xbuf)
 			return -ENOMEM;
-		ret = user_regset_copyin(&pos, &count, NULL, &ubuf, xbuf, 0, -1);
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xbuf, 0, -1);
 		if (ret)
 			goto out;
 	}
