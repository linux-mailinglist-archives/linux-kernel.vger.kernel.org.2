Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8142D0DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhJNDRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhJNDRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:17:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB32FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:15:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l6so3167711plh.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WM4SI+rtjUFkOGpOJr9Dhig9XU1Hwa4x+tSGFkHYC9Y=;
        b=dNkZ/IumrH2fcnoe/IRQAzHl8O4rp59qzG2J/r+UOLqDxPnYzACNWihjtqoiknVxOi
         fYV09HYItHfFXxV5bEVzQjyzGbxfqFxgLl9Oxh/cUL2PGBwVhF4MM8u7BBaFo+m4kNko
         SiGMdae4ws/c7aZkQ2y1nZDD8QJ5EkXXeOs/SgMr6zTTzoI56ZubkQ2P+jxIpsJRuRkg
         lpK/RIw4rck3ibYyayZx/L3ggG1KOaMguQniXfXPXmt1vVh+/yrCS6j/ApyQZtq5yu60
         nYJ7T23bTOc2x+ZsRaOWLzL7yBKEVh1sTB55xC9XL6+uc4BciV+lpGG7cCX28Zfnzb9O
         W2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WM4SI+rtjUFkOGpOJr9Dhig9XU1Hwa4x+tSGFkHYC9Y=;
        b=FHqle0yx1Sv50VyO5MDEdfmCISVo0Mmg+JVlTh3L0wpClLPSNZnITATRiacatRNBO3
         mS/chetBSFmRGr8Ml6Io+6Ms2sEGMXWLymJIA/IypR0+DWxwg/9Aso/dj5LdX2httxyK
         8vgGDy9JpLoHWtf0TX2FkGH+f5VGAaCDm6qHQT5AILqLk3UcNupkQTdKf6dPehg4fPtZ
         gKp8t1v32sRzee0NMe1k8DHk0d1R7R/aWGlO02uqMHLQVrtJfpgBYttMXAwGwnYBN2hh
         bohsu6J84bZdXFuuZSVn9Tjlgj1KNIpRb22JCWrnZf2StOd8NPZcaRLHiOS8vS51Mj7s
         rD2g==
X-Gm-Message-State: AOAM532Ka0duUe+e9Kj/6Ve5eKs6OSM0stzwgmolP/THOb2dx+Se9dx+
        ZGmjx6BhY4JHGfKXI1DZ+Gzaq1BUn/E=
X-Google-Smtp-Source: ABdhPJy1rFb9nDTz6OzB5+T3BoC17p3aQwOspGW2N1oTpmgvHI2RpX3Ic2s0K0wVO1wrvKj+nIwfGg==
X-Received: by 2002:a17:90b:3ecc:: with SMTP id rm12mr3584612pjb.48.1634181301253;
        Wed, 13 Oct 2021 20:15:01 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id e6sm822398pgf.59.2021.10.13.20.15.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:15:00 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 05/49] x86/entry: Use swapgs and native_iret directly in swapgs_restore_regs_and_return_to_usermode
Date:   Thu, 14 Oct 2021 11:13:28 +0800
Message-Id: <20211014031413.14471-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

swapgs_restore_regs_and_return_to_usermode() is used in natvie code
(non-xenpv) only now, so it doesn't need the PV-aware SWAPGS and
INTERRUPT_RETURN.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0dde5a253dda..c8f7b740a9f1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -606,8 +606,8 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 	/* Restore RDI. */
 	popq	%rdi
-	SWAPGS
-	INTERRUPT_RETURN
+	swapgs
+	jmp	native_iret
 
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
-- 
2.19.1.6.gb485710b

