Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47F8432D11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhJSFTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhJSFTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:19:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651FFC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i5so6618776pla.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6r9uuaSaQZOZcWbXapdVBGjLI4WO4y0f9iAtrk3atGc=;
        b=MPLfyt/v8S7RH7sSWL5jeNIK0PF5zQZI0s+K5bCajXyJt9/EiqTbo7UywNhzbWLNYg
         yi1p0PbpgrhjCC45XBw2WFvkZFSYd5GE71FHy0TA/Lqi/tlvAiNMNlkL4lcMGYyh6K4e
         q/h/LlGM6cTKBcmEjjVcul5yLeTvdoUUDdwjl5LO2jDZLZ6G6gT9LajxYxeo663W8+Qv
         iw4wsFsR+flRgqnbQcDuxi/p/3YwSq1TGSTvdKuORbCOWtKVi0rb2PZ9RdMlTAuHKavM
         B06tYzPv1mIEQAJMJZCrcUhweQMc2QSZ3qBzzb0WPZFrt22CQ2fWI4JN5x/LJhKk4i/L
         jtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6r9uuaSaQZOZcWbXapdVBGjLI4WO4y0f9iAtrk3atGc=;
        b=GVa12yXTD7VFEDSK0EWSOYoXXVQPRbHYTlnW2JkTwTQWU5RtMasqNy//GcXf1rWT70
         3JUeifodG/mgx0LfjFrZvLHOYc7cutg/8ivrQKjJV+H0iC3QtdjohkXM+Zkn/17UYi97
         U1QZLOfB4+EiTars/q+yfUmjMXDfqmc8NBW+N/yahlERRe3PZshKRjSuTGFhZWvD6dJp
         yKIRrQVKj7BQBMKXhdyLbIVLAMfXZJuhd2DUuvmb11CK0cRFrG7JK4wOK6v0WZRjB+4L
         G7u57zGL0BUTQO9sP4cP7NsA3jol7c7kys21Pd9VASkNx4YTr71zUu01s5rm29OIzJbh
         R5Zg==
X-Gm-Message-State: AOAM533l8CsTdMeurCXzhsM8mZRDqsO7mIIE4ROAtXEeZveQboa1fb98
        8SfQc7ngJtriPNGDFoPR+NDx1cI3TVM=
X-Google-Smtp-Source: ABdhPJxaEdUpej54qai1ADPu3VIMJ2hHGgTa+GDAAwJ+/8i4W+Q/4RMdkRWNjsRhUTTUTr1vv2yIDA==
X-Received: by 2002:a17:90b:4f88:: with SMTP id qe8mr3987153pjb.223.1634620655943;
        Mon, 18 Oct 2021 22:17:35 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:35 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 01/10] xtensa: move _SimulateUserKernelVectorException out of WindowVectors
Date:   Mon, 18 Oct 2021 22:17:07 -0700
Message-Id: <20211019051716.4173-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019051716.4173-1-jcmvbkbc@gmail.com>
References: <20211019051716.4173-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In configurations without window registers support the section
.WindowVectors.text may never be linked.
_SimulateUserKernelVectorException is a common handler for high priority
interrupts, it does not belong in that section anyway. Move it out of
that section and mark it as __XTENSA_HANDLER so it gets bundled with
other vector helpers.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/vectors.S | 40 +++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/xtensa/kernel/vectors.S b/arch/xtensa/kernel/vectors.S
index 1a7538ccfc5a..0eed5aa82914 100644
--- a/arch/xtensa/kernel/vectors.S
+++ b/arch/xtensa/kernel/vectors.S
@@ -650,6 +650,25 @@ ENTRY(_Level\level\()InterruptVector)
 	irq_entry_level 5
 	irq_entry_level 6
 
+#if XCHAL_EXCM_LEVEL >= 2
+	/*
+	 *  Continuation of medium priority interrupt dispatch code.
+	 *  On entry here, a0 contains PS, and EPC2 contains saved a0:
+	 */
+	__XTENSA_HANDLER
+	.align 4
+_SimulateUserKernelVectorException:
+	addi	a0, a0, (1 << PS_EXCM_BIT)
+#if !XTENSA_FAKE_NMI
+	wsr	a0, ps
+#endif
+	bbsi.l	a0, PS_UM_BIT, 1f	# branch if user mode
+	xsr	a0, excsave2		# restore a0
+	j	_KernelExceptionVector	# simulate kernel vector exception
+1:	xsr	a0, excsave2		# restore a0
+	j	_UserExceptionVector	# simulate user vector exception
+#endif
+
 
 /* Window overflow and underflow handlers.
  * The handlers must be 64 bytes apart, first starting with the underflow
@@ -680,27 +699,6 @@ ENTRY_ALIGN64(_WindowOverflow4)
 
 ENDPROC(_WindowOverflow4)
 
-
-#if XCHAL_EXCM_LEVEL >= 2
-	/*  Not a window vector - but a convenient location
-	 *  (where we know there's space) for continuation of
-	 *  medium priority interrupt dispatch code.
-	 *  On entry here, a0 contains PS, and EPC2 contains saved a0:
-	 */
-	.align 4
-_SimulateUserKernelVectorException:
-	addi	a0, a0, (1 << PS_EXCM_BIT)
-#if !XTENSA_FAKE_NMI
-	wsr	a0, ps
-#endif
-	bbsi.l	a0, PS_UM_BIT, 1f	# branch if user mode
-	xsr	a0, excsave2		# restore a0
-	j	_KernelExceptionVector	# simulate kernel vector exception
-1:	xsr	a0, excsave2		# restore a0
-	j	_UserExceptionVector	# simulate user vector exception
-#endif
-
-
 /* 4-Register Window Underflow Vector (Handler) */
 
 ENTRY_ALIGN64(_WindowUnderflow4)
-- 
2.20.1

