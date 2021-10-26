Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE05143B3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhJZORA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhJZOQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:16:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD805C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:14:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c4so6530564plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0qjm7jPQqP31FdhJus4GoBFS4vikb3c2lNdWiLTWxY=;
        b=Ggfwe06peSYkfJCJpCFzEdWKERSBo4c/NHpwOXSee18xCOqBThGZijEH68PmGREHXs
         fmoCL3OC8ROxFZrolaGBpmTBqhxCxtYs8SKcI2TMnQgHxs8YOY8+LcYnVBsMf7LoPbAM
         Tqsdg2Uf726MPGtLOlNi7jJXG/Gc59HlS3awTJKVgMJ01guO9mcYjUoO4aLA1RTAF9cF
         Hdy+g/HwYRqOxJvi4Ga3wqI/2dHlZp1SZYyTXvMd2Gw4cfo8cX5tN9aFVm9sKGuscCuQ
         3X31PVcx663BhFQWtoDg1I/+WBNFmvSkpQHPrzCuhsGD0XV3hRfqT22cN7Q4pXrNVkyF
         3ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0qjm7jPQqP31FdhJus4GoBFS4vikb3c2lNdWiLTWxY=;
        b=CY5WpIocN3iGw4U8B3WEtOqOrh+JXM6RAO6Y6GBGopNtaIl5sdErenJ2c+i6UBq71V
         Za8qwf1LPe8esrZgs2Wqh+IMNSUvndYXDouO09dpYsUCy9QHd+q2hpDULDlyiwKIJqeV
         mwh9VnEnPr0LBMoecvl6JhKGwujKVS+xm32yvaoHeew4Inz11nFpVxpIn9iaEOel3qf1
         7xO3zuzWRvxKycGyd7gpUiHxmbxFYv8pCz1S2XZr7cu+1suwu+6l9+q08nR/u9Kx8jxI
         PgZ+jOwUPbC27kekB95pOXl6qbBtfgfm+sluEV9NAUWGaNOdi90bJQ27LVwpx+bw+NGE
         L4Vw==
X-Gm-Message-State: AOAM531TqJyr/+GXe9tsW+z7ZDmQAyXRH7ousVMgjnAweREHleh1BkQg
        6/naVUhRY2BfOCuOl8lZ0Z3FZmuzSE4=
X-Google-Smtp-Source: ABdhPJxRbNyuSHfUqQinYK5ylVj8CEHXmHOhq3aBfkp4H18L9FOXrXrRlVkS3YuiiunWst0h/Bs3bg==
X-Received: by 2002:a17:90a:f990:: with SMTP id cq16mr381028pjb.196.1635257673951;
        Tue, 26 Oct 2021 07:14:33 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id 141sm8353033pge.23.2021.10.26.07.14.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:14:32 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH V4 03/50] x86/traps: Remove stack-protector from traps.c
Date:   Tue, 26 Oct 2021 22:13:33 +0800
Message-Id: <20211026141420.17138-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When stack-protector is enabled, the compiler adds some instrument code
at the beginning and the end of some functions. Many functions in traps.c
are non-instrumentable.  Moreover, stack-protector code in the beginning
of the affected function accesses the canary that might be watched by
hardware breakpoints which also violate the non-instrumentable
nature of some functions and might cause infinite recursive #DB because
the canary is accessed before resetting the dr7.

So it is better to remove stack-protector from traps.c.

It is also prepared for later patches that move some entry code into
traps.c, some of which can NOT use percpu register until gsbase is
properly switched.  And stack-protector depends on the percpu register
to work.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2ff3e600f426..8ac45801ba8b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -50,6 +50,7 @@ KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
+CFLAGS_traps.o		+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.19.1.6.gb485710b

