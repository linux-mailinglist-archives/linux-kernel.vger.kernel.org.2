Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64A14189B4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhIZPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhIZPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:10:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA467C061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:08:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e7so15319954pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nfv8nc9EnTD0UK4iECq5w/diJ84pz017pW/+yUXUYKw=;
        b=OEKhmAuLP034OHHk+q29zfNaDR3caYuJYRXxESr04h4LZ+iGhK7Ev1HJUJm2fMLh7F
         abUkrvTX4Q1NYaQqlhpn/N2tCvY3hwYPsFiW3fz7VxTTtAnxAbeIoYXShu+kSE9cYfkP
         59PycNL1BuHW2gxuOqvkS+XVU7BcBqq+scly1FohsNzNSpMQyMs/+rBYKMaO3Ar/tFY6
         PGCC2S4rFkEfvA51gWn13fitkIoQjC3g8z132p5y66CNtKsKm/OOxI0AJbHALupUPYTY
         moYGIC85qTfF/PEkBvb9Di606KlDLpwcdNpjKrdKVB+R8vahAiA9MXEWZ2XtlRitVjKY
         OI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nfv8nc9EnTD0UK4iECq5w/diJ84pz017pW/+yUXUYKw=;
        b=B48xvZ1cH8SVJSUrtknQp6N5ENV4lAnXXTGEDPH3HLJC1dQs5Mzh3/3R22Wn6Vt6nF
         hwFgqS8M/Y6zp68nwlymOt1ead/Nieb87zhSdOSVt3yU/67Wmjr3rMrgGv5pYKJ7sp+S
         VZ9WlkUUJmyrruugtJbGm7UnnVIuNRScwPEMSxOcgjv8d3xAb8KRZh8kneh2t6vM3kAT
         P4a3JmPgI4KVX+9wHQWBTT576pnJtB0gOI8giTfsfyNABgiBUVLDZfv/u8TQejiqoSYf
         6c9OHRnhV2s4ZUBO5/DIpBiK1d0Eze0jM55BRrMcYmFAy6UTappyxRH5pLCKgZhtV21V
         p1WQ==
X-Gm-Message-State: AOAM532Uuk1/w1BMKW183zsETjkwyAu6PS1iiitNVJZpXEUfnVKQTxm/
        +3Y8uZDRnbez0tZzkYAgUj2Iw3kynWjH5w==
X-Google-Smtp-Source: ABdhPJz8C+efRsjBYY1fvQ2GPMNjVnQJYkMj+QvLL6664+Nv1iVKdp1eB9QFJnRQcnxR4b9nd5kXaA==
X-Received: by 2002:a62:e317:0:b0:43d:e047:a6c4 with SMTP id g23-20020a62e317000000b0043de047a6c4mr18941688pfh.44.1632668927314;
        Sun, 26 Sep 2021 08:08:47 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id 65sm4139732pfv.210.2021.09.26.08.08.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:08:47 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Juergen Gross <jgross@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH V2 02/41] x86/traps: Remove stack-protector from traps.c
Date:   Sun, 26 Sep 2021 23:07:59 +0800
Message-Id: <20210926150838.197719-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
 arch/x86/kernel/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8f4e8fa6ed75..0e054e2304c6 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -48,6 +48,9 @@ KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
 
+CFLAGS_REMOVE_traps.o		= -fstack-protector -fstack-protector-strong
+CFLAGS_traps.o			+= -fno-stack-protector
+
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			:= process_$(BITS).o signal.o
-- 
2.19.1.6.gb485710b

