Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26244C067
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhKJMAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhKJMAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:00:35 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBFBC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:57:48 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r28so2101771pga.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0qjm7jPQqP31FdhJus4GoBFS4vikb3c2lNdWiLTWxY=;
        b=Xp+EQODKrpxSG29Jr+xIQCPhDKmavm7Sy/HLU/0wUFcmq9bEcceveTG4QT10Om7vTW
         LxX2VPGGV4z+4gdkeIlp9v0P4cz7WyzxdJefRXf49Y/q+hngZQlpMVRc9PArKdnMThta
         +gzwkRT9FP1GL/BR5403O+zfIUhqJoHFoFcUyz/a8TcjVsTZ8e5uk+FwaLvH9l70e+a2
         2/gXG0nTdCW4q6W7ij7OIIliVq2wcwDvalqbPa4X3ijPMhf8vkd7dXHjfP/wjvfvaLmx
         Y9jRDB5WEWy9EKIDLqGYxTyOaVMqZ6Q8a+nnwvCbnHiMUGCYvsQDHiQJn/VH4q15t4vN
         Be5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0qjm7jPQqP31FdhJus4GoBFS4vikb3c2lNdWiLTWxY=;
        b=gFvMPowAOmJ0x/fFRbv+5wzsEII5lvhAlS2ocWpnN4LT+/EnsY0U851akKCx4YUqjx
         /6+XP+fVJzRPGTh+VjWAhYR0HrQ0RS9Bfm2Ma4RmlH5NZCo6meLJ84QytAceuN7K7d0I
         rdHfBoWumMpUH3J6SOo/bpQ3wlWBqWbnjRoeBw9slzxU6NpxrYEP7rz7ghjtwD3wR8d8
         Wd9Bn2PVDRGi44S6iNVcOba6aPYzUcAYsBxNi4UbI5ktP4ycZk/1TOjOPtq1gw6lLJpQ
         qyQDoudSjH44f2YwQWuDw06V7C+5vXCpUityj+/MdHqcul8DHTEMJzt8NiztpKqgU7bN
         Ogjw==
X-Gm-Message-State: AOAM530h9duW6S3a/i4rSsl4F/fwDnxxPGHN/10gPcIbwovFiUTvHy0L
        3CO3zaHCLoDVc0cBZv6P6/MuCGYCNBo=
X-Google-Smtp-Source: ABdhPJyQlHL6EpwJGXdy3JqGrQcJXZ396MZxGZcr4tyXM0GO+1u6madzi40+Tz9rZifwNaEIdSky0g==
X-Received: by 2002:a63:8bc2:: with SMTP id j185mr11599232pge.237.1636545468068;
        Wed, 10 Nov 2021 03:57:48 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id p3sm5713037pjd.45.2021.11.10.03.57.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:57:47 -0800 (PST)
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
        Juergen Gross <jgross@suse.com>
Subject: [PATCH V5 03/50] x86/traps: Remove stack-protector from traps.c
Date:   Wed, 10 Nov 2021 19:56:49 +0800
Message-Id: <20211110115736.3776-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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

