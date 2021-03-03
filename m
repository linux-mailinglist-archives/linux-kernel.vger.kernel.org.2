Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398D632BB96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446699AbhCCMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842502AbhCCIFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:05:42 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A597C061797;
        Wed,  3 Mar 2021 00:05:26 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g4so15800966pgj.0;
        Wed, 03 Mar 2021 00:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OkO4sPesb67a4Xc+NzgJGhYGkM0gLKx9VTeWnyCxw08=;
        b=t1wSFc3pRt6x4Dk83aDZFNEHm7OzrtTRlVPD3Jq3GD8O7BS16lMjBJD/6GOouKfl/D
         oVnRukngWEvhAH3VZH1x/C5UgfimvsiwqwFihvpzCz+vO29moeHTXBvJVWNciTHepFaK
         nunuTwLdJK+EUlZhOl00JMRs8fNoRtdqKJz5O+MOdiPkjLi2LhHt7i4JTzSAYjtRlbCT
         tpWkdm8gyQTQ3Ii2JO7/4YjU7f0bUpuiSSkpXjIgcyWMkodun1VwbKTSHSz62WbrBUoK
         SpobWKx0wj6t4jlnLeATeQ6mVqM9D0A1NRMrrloY2R9P2OA/YHhGxffHTwt7RHe3HSUF
         z9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OkO4sPesb67a4Xc+NzgJGhYGkM0gLKx9VTeWnyCxw08=;
        b=N4dRNMTEyYzUpWQZBmjZnBQsXU41WtLwlnS/YGV7vt/v63DWkrR00rh8eY+ArZZi2D
         QHvYuky7geH/XY9vseH7zminLNcfsAyv4Pbyb7KfV0WVRY3LGdgg2o8vtprJN0KU5mg5
         YYMpDeGwA4vGvpoxqkMyT3UriDimW1Uu52ODGle34rPT4bKijQvoZa4qrFQeKOTUdFtt
         W6DYhMlhHtvz8jYYizr9G5nYp/L6SPhXHb910EmAB3ISBaZ7GmIsqTkdF7uyxR1usw6g
         +NFi16DiBmrZadbTbyvFvzlumggU1gdUHGios3Qhg2hbJ46AK5nB3N4MFS+ret8wg5bS
         63xA==
X-Gm-Message-State: AOAM5309PWZruNDxVK55OO6EGOeSGPMgvvxkcP6rxqbGuO6EyOps0W/u
        OeqigZqtC6lekjSUTGPemxI=
X-Google-Smtp-Source: ABdhPJyf71nlJOfyEEHvdDqtGzsYD3u82366/KdOqD3tkSHDPb7h349QjuPxaUgNYnp2oTLjAv2nKQ==
X-Received: by 2002:a62:5ec5:0:b029:1ee:186e:121c with SMTP id s188-20020a625ec50000b02901ee186e121cmr7023016pfb.54.1614758726010;
        Wed, 03 Mar 2021 00:05:26 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm22260887pfv.84.2021.03.03.00.05.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:05:25 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 1/8] ARM: ARMv7-M: Fix register restore corrupt after svc call
Date:   Wed,  3 Mar 2021 16:05:10 +0800
Message-Id: <1614758717-18223-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

For some case, kernel not boot by u-boot(single thread),
but by rtos , as most rtos use pendsv to do context switch.

So, we need add an lr check after svc call, to find out should
use psp or msp. else register restore after svc call might be
corrupted.

Fixes: b70cd406d7fe ("ARM: 8671/1: V7M: Preserve registers across switch from Thread to Handler mode")
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/mm/proc-v7m.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 84459c1d31b8..c93d2757312d 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -137,7 +137,10 @@ __v7m_setup_cont:
 1:	cpsid	i
 	/* Calculate exc_ret */
 	orr	r10, lr, #EXC_RET_THREADMODE_PROCESSSTACK
-	ldmia	sp, {r0-r3, r12}
+	tst	lr, #EXC_RET_STACK_MASK
+	mrsne	r4, psp
+	moveq	r4, sp
+	ldmia	r4!, {r0-r3, r12}
 	str	r5, [r12, #11 * 4]	@ restore the original SVC vector entry
 	mov	lr, r6			@ restore LR
 
-- 
2.7.4

