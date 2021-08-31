Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCD83FCC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbhHaRvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbhHaRvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:51:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83CBC061764
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fz10so97987pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxWdgKrap3GdzjujnhVXWvy5LHgKLpjaSH03V9gUgtU=;
        b=FH/PXUAx5DLsxxgRgKwipPH6m9KIb80PxgdHXPJKxLTqvkqbQ491bvDAh9m1e/TTWl
         A8qJqO18GopQWeLl6pjfHcF5y5MATy4KTJ0fdZS8JbxxOemRsHFlNQ1DbF7RPVpsLfz8
         fmAIBBN/mx24L8aVLdkWKFq5FM+QDmq7O2+/ZrtMrhiEltwQ453E+csAfpypqJotDPI5
         jcBIv4sRLDttB43mgeguknoG7t5wYcIhW3GsIVuOLjV+D4Ll61oT5ejCaigV2kl+CmSK
         ZGwfR8y4cVZ1lsVja4FLU30RgC3jChawILUX3MpPjeU/tHRSaqSMU3kfmhuCcz+34rmU
         eCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxWdgKrap3GdzjujnhVXWvy5LHgKLpjaSH03V9gUgtU=;
        b=T0L51ZdGOFdOQU3WqUwOVm/ETXLV96KZ9DXN2bEu6K8XNlaXMH2iO7WW6YMHnKxoSm
         /xOcuxR07Xi1p+sntE+XIrhC2L9ybK01YgEid/FsD+tTyl+8ZU9sKC2JY0Nw5ytGkpnu
         GtMUasAz2R/3xqVeYM7DIPie1yXdHcDB4nspKbRZ3T3p4fwhlpqFEjAXNJUvwtXrGvOi
         G0B7gfhMqVF0YvdXbGYysCR4QKekEpLDY44Y+SwewNmRIls1yZze/XIfhBzv9HnU99MR
         NfqCYygrGrndLSSTa6cOTcLZwV+NBBxVcIthFavBd6BRCuWdmRLwFpwfwV/vlvm85uWH
         rElw==
X-Gm-Message-State: AOAM533RSLsrWZrgcw2Kjl85yv2EUB0r48wtjUDA7fNDB5pKRyyaLHxr
        lX3fapwfTzLenStV2+xKzQY38M1d6CU=
X-Google-Smtp-Source: ABdhPJzM1Jz5zMpBDQJJWbb4kFZSVNX2TUtGELpG5yzexTZEFGxU1MBJbMn5GnhDFDg1U3xwK1dq0w==
X-Received: by 2002:a17:902:7882:b0:131:2e12:c928 with SMTP id q2-20020a170902788200b001312e12c928mr5791582pll.74.1630432246153;
        Tue, 31 Aug 2021 10:50:46 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id e12sm18485463pfv.146.2021.08.31.10.50.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:50:45 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 03/24] x86/traps: Move declaration of native_irq_return_iret up
Date:   Wed,  1 Sep 2021 01:50:04 +0800
Message-Id: <20210831175025.27570-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The declaration of native_irq_return_iret is used in exc_double_fault()
only by now.  But it will be used in other place later, so the declaration
is moved up for preparation.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/traps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index a58800973aed..7869343473b7 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -65,6 +65,9 @@
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
 #include <asm/proto.h>
+
+extern unsigned char native_irq_return_iret[];
+
 #else
 #include <asm/processor-flags.h>
 #include <asm/setup.h>
@@ -356,8 +359,6 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 #endif
 
 #ifdef CONFIG_X86_ESPFIX64
-	extern unsigned char native_irq_return_iret[];
-
 	/*
 	 * If IRET takes a non-IST fault on the espfix64 stack, then we
 	 * end up promoting it to a doublefault.  In that case, take
-- 
2.19.1.6.gb485710b

