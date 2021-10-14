Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC36442D0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJNDQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJNDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:16:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:14:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so3753507pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0qjm7jPQqP31FdhJus4GoBFS4vikb3c2lNdWiLTWxY=;
        b=fHqGMMqqS+dxpGPANvS5UYl9EBZPCuGt/cJGTd4lCMGAZSChCx8MUGyl3tgGa4UUcq
         1FmghmDG+lKgEqIgCxAHnQMggXhDemSpCZiyyZGzx7uYoEfL6Ml+u8AWCws7Q90Zrf4F
         hXSCg94t9NRjKyVuE4L+/nYa+kCVqRa6jOhYHHbS/8udikPY8Ys6uCF8d2x4q8nY38pZ
         Ub7KJ1StmAF0YRvXJnL2k8kBk17hJ/7XA71zjWu8uI7bsP0c+nGBobYxpyaSnSG9T0GE
         5G2Ds0QcT33astNV2TY+nEoToRRkRaJZNZG5mMMyP+h4i531sjnO6b1RBDdPWQV74YHx
         kOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0qjm7jPQqP31FdhJus4GoBFS4vikb3c2lNdWiLTWxY=;
        b=czdkQgXUiPV+maOKe8XXkUd/0tbjyA5KXFDZd9HYfKPFHOzJatRiV6ezwQB3SBfdgy
         bfdEibNpOquOu3hQAjwq5zGd3w13VDgOiUNvS3BK9jZ2YL9Z4+roNJgj4Br5kp1FgWiq
         id9xQe++4SLQREL19mwyTkOC5mBShI9617weCPwW/GpGpPOngxxoAlxI0y2/LiiFUZiF
         UYbkcghi4m/bQTOKZu73Ni5EKyBT1ouhz6DLKfAVQDnzXpq/UEciscL2GOiqckcpEK8y
         chvudUJd9+TS1JW4Uw6oWFtG0c6S6C+m9M+84XVJzpunEgXnyj1GNpewBuU1x6RyChhu
         uZvQ==
X-Gm-Message-State: AOAM53272wMRNBHy3qDr2zuNluk51voI1W8q++u/A7QPYQJuXEq8s4el
        9bj4jnWUW3awBTZwZHAoDS7Y+VmaQkg=
X-Google-Smtp-Source: ABdhPJwbRfJSf6IAdM1hrDU8LtpUM6cnr3a3lsCNBno/VDuxg9HlOqcWuUw/JWUp6X/ZAR0NalQ5lg==
X-Received: by 2002:a17:902:e5cb:b0:13f:25b7:4d50 with SMTP id u11-20020a170902e5cb00b0013f25b74d50mr2756213plf.38.1634181289535;
        Wed, 13 Oct 2021 20:14:49 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id me18sm812400pjb.33.2021.10.13.20.14.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:14:49 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>
Subject: [PATCH V3 03/49] x86/traps: Remove stack-protector from traps.c
Date:   Thu, 14 Oct 2021 11:13:26 +0800
Message-Id: <20211014031413.14471-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

