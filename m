Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE703874C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347908AbhERJJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347736AbhERJIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:08:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F6C061347
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z17so9311268wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gtHRujbA++rmZKVlVKXeDrh5bnEaeS8o439txwjvSA=;
        b=kTfjDSsgaq9qbDV1ucHbETvQ/8/ik6lZYd1sDSYBYvzO5YOC2355x5r6WEZJsMFAaq
         TjWIPb6hh9Qyd0hvSxCnR9xvlg6lHvM/vDQAp3FLdpWv0R8Yg14Us2FuMOSTqfk58N6+
         DVYackISrNedtzyFqko1Bn0lLIqV5uuAYTt78ggEYlcBeoZz0zgQ2dWp7v52moTMHu0k
         1nLRAjR21BFUJscaSBAVFFb8m536QaQMIjnqjU6zGSi9KmqMhH5uEMUfJFriL2pSSle/
         Lum3CioeDmXQXi+uhQfNU++N4jDqC9I52MCTiWwr86qUBCm7cxVwwfczF2cOQQyFYd8x
         XvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gtHRujbA++rmZKVlVKXeDrh5bnEaeS8o439txwjvSA=;
        b=rgacfSgQtkVApePDrWZQ59Z+SVaq23QUEyeOndzNGLhzFBZ1Dm0EriUltyle5Kh/sP
         ylexXjPkrHPr63PLV84ujYpzSWtRTdebIgPaLgAxWBeiGOOgQWOWvaD2co0DGPd0Ll2W
         OKVX1Rna+1xLX3v5DSKyC1oA3d018HkaTMO3XPQSZPvsWpcDhzkF+Pnb+vhuWEX0c67z
         vpJ7zHWa5Fq52xdbAA8aJ0t7wxaIIJJDWkKeB/mKU7eMiGeyRv6IzPUwHiQugb1mUie/
         zPNinwxufx7h2InJmZwqa5cCicxugeNJSXNQjPL5u6EpNZbj7Bj8PfyQnc5dQIlaqutH
         7owg==
X-Gm-Message-State: AOAM533XbEFh2SE3CK2IbEMFy+yangwi8RPSl4LRQJ1yl/QVsjTQlQ0i
        ODUO7ogCtJJJiTT8S5kjhmE=
X-Google-Smtp-Source: ABdhPJzF3v2NF1BehS+3u+lw1sBLeXSGTnvsmTmfUvY3oAh8WDf0nwHq2EO4QH5xarQi9gLUtb3rjQ==
X-Received: by 2002:adf:fa45:: with SMTP id y5mr5575639wrr.311.1621328832404;
        Tue, 18 May 2021 02:07:12 -0700 (PDT)
Received: from amanieu-laptop.home ([2a00:23c6:f081:f801:91cf:b949:c46c:f5a9])
        by smtp.gmail.com with ESMTPSA id z17sm7520306wrt.81.2021.05.18.02.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:07:12 -0700 (PDT)
From:   Amanieu d'Antras <amanieu@gmail.com>
Cc:     Amanieu d'Antras <amanieu@gmail.com>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 7/8] arm64: Forbid calling compat sigreturn from 64-bit tasks
Date:   Tue, 18 May 2021 10:06:57 +0100
Message-Id: <20210518090658.9519-8-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518090658.9519-1-amanieu@gmail.com>
References: <20210518090658.9519-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's impossible for this syscall to do anything sensible in this
context.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 arch/arm64/kernel/signal32.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 2f507f565c48..e2bdd1eaefd8 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -237,6 +237,10 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
+	/* Reject attempts to call this from a 64-bit process. */
+	if (!is_compat_task())
+		goto badframe;
+
 	/*
 	 * Since we stacked the signal on a 64-bit boundary,
 	 * then 'sp' should be word aligned here.  If it's
@@ -268,6 +272,10 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
+	/* Reject attempts to call this from a 64-bit process. */
+	if (!is_compat_task())
+		goto badframe;
+
 	/*
 	 * Since we stacked the signal on a 64-bit boundary,
 	 * then 'sp' should be word aligned here.  If it's
-- 
2.31.1

