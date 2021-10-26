Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC1343B448
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhJZOhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbhJZOhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:37:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44532C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:34:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q187so14349494pgq.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lwz3W6gdRhlQ67BdKOZO6Xlc6cjt/VXhoMM+nLKwRyk=;
        b=p03n0whKOz84QBUHv41illdfN4SadONs3aFGoMFyBSoTfxVDRv4LnbL1KrKdZcY57k
         /KBFo5uvIuZTUYNrm92z47rTZys21plIbk3+thQuzIZ0WUnuVB1HEXycDjVmy+Z9MEoU
         3vnVokIS/t9pOF3VKfxCts0ued0PrihimWMmnMNUtfqbfVRreqQSVK8lpqWY6P0cohj/
         N90mwQEMtrfO+2XfoOZ77YwnYz4HOPJyamuiKCm2WKhwKmxJ9lgpgrr8Q7HbGdpuZdin
         4q5JGObSHgIjqxOthnqAOaVDH8kqTGnyJfNt26TG+e8f+sPMNz9wHWs4whDPjZlE1Y2o
         tq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lwz3W6gdRhlQ67BdKOZO6Xlc6cjt/VXhoMM+nLKwRyk=;
        b=GYVrm+39yaMCobAm6BA0wnCXvvMimVOV720euDGz13s0xIron9/kD2dehlRAyfxIrT
         Wi5tnVzVctf+WH0/IZTYJCKxhMO4A6w6tjTl89LBkcT7K0DF6o09NbDLpzdWR0wdNTj2
         kOn+VLt5czCA3hUGRnUXXej1qm+LzWsLq9V/GV6B7bhSKz3ek+n6OtXjXfe56E14zGtz
         wgOVpwUKEFhIHS080FjMEAsnv9x+NUHJwaZO6oM74hJEsqDlcDK21pRiYTw9ZF1Ji6s9
         ejvrX64lQHN6ZpuqGGsztsb5gw+CuKn26V1anpdpHe8nh1Z3kIE6/GSi3yV1ry9DlL1C
         DOiQ==
X-Gm-Message-State: AOAM532LnVbTAGG7nEA15IJ7yoqZXAXAdbpCtzqj70q2sdJjyRdkx0RJ
        XLm+lfH4PkaaetvGqRjWx0sMQvpkCfY=
X-Google-Smtp-Source: ABdhPJyoyLzm5Lg7KlHjBUpMouFDa4S0C0Hes1rnRlbNwNrFjn0KbF7iKtKFRUxEEQj6+noa1F5pQQ==
X-Received: by 2002:a63:7247:: with SMTP id c7mr19058848pgn.365.1635258898732;
        Tue, 26 Oct 2021 07:34:58 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id a3sm25829631pfv.174.2021.10.26.07.34.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:34:58 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 26/50] x86/entry: Convert SWAPGS to swapgs in entry_SYSENTER_compat()
Date:   Tue, 26 Oct 2021 22:34:12 +0800
Message-Id: <20211026143436.19071-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

XENPV has its own entry point for SYSENTER, it doesn't use
entry_SYSENTER_compat.  So the pv-awared SWAPGS can be changed to
swapgs.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64_compat.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index ad20302246e4..0b9661edf652 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -49,7 +49,7 @@
 SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
 	/* Interrupts are off on entry. */
-	SWAPGS
+	swapgs
 
 	pushq	%rax
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-- 
2.19.1.6.gb485710b

