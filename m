Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF55E35CEA5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbhDLQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344079AbhDLQgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:36:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A795C061371
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:30:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m9so861099wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLMXuiqimbamnVGxeY3wIizCjoU1LFQjurxEMAi/nOU=;
        b=qk1UWmkIqjEB3sQUGZa2ZR66NqTcHku4v4uwBJ0TkdvZpfBrzeZZ0UroO+wxDMKIE+
         BWEShIFwHoOgFOXSnK2LnXIs7oEi/GsNZYwlz3Fbwo95sdhFj1IEMEnw8N6KpxQR8yli
         8gfbSQTpTYoyu0xMVw6mF9mtUVrEqDZc6GDcJ5Lmh7oXi3coRXpLVHM9fnKS8HMHHXiX
         DGMvTZ+pLT5PAhwuqSWe0TDMnYM7hDaGF5KZXqaCus/8seQVEouQSXSr4kkH71MybHc9
         0RNTovXnRXylNd/mmLi9DQ4KK26gXQRE1N+9TvCNIRVPy7/P7/Xbq02D1fp8t/UH74qT
         HVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLMXuiqimbamnVGxeY3wIizCjoU1LFQjurxEMAi/nOU=;
        b=H3laRXD8LK03pFBS8buD4NidYYzjJRMu+TYoB4hJ31XFqSG+8FxiUUP4HMBxg3APCA
         MI7X9S2PcFNQXS8elrTRhVpq7aaspfJhlRvVz7X5+GZm3H9J9BOT8g5Dt8mntvvlSwhO
         wGp2IFu+xCBUjb+SLPmP7k6c2pP5dj+prvdBc2+lAT8lBTpTH4T6ZvatTuawhmHHM8hk
         IrVw6p2FWIsdymb7zyIZDNikVKR8ablobxW4ciVak/0IQShcQQENk5G40+C9ovufNlpk
         MZs/tP7uBjhaXZnwF+yfLY8ZTXfv9Ca6ISiQ5AouUwFoMNzGH3zlNffTMHY3NqCrBQHf
         VF7w==
X-Gm-Message-State: AOAM530mdXbqCUjzV8UQ91MsFOGAkBvLnE5GefpomTTE9gms9hxXSjzF
        JLMalXlfaIZSuPBzV4lRi2E=
X-Google-Smtp-Source: ABdhPJxzCL5vIFCm3zIk5Wki2WZL3IyGLgYci7JiYjpv/yUCHnERZW/FtIssgcWNvReHd0OoMObkNQ==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr9135210wru.305.1618245008945;
        Mon, 12 Apr 2021 09:30:08 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:813f:b20e:675a:834d])
        by smtp.gmail.com with ESMTPSA id b5sm16786524wri.57.2021.04.12.09.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 09:30:08 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Cc:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Subject: [PATCH 2/3] staging: rtl8723bs: hal: Remove extra blank line
Date:   Mon, 12 Apr 2021 17:29:37 +0100
Message-Id: <7f48b48d92b54c1f5db29f0d23c8c1c666236c43.1618243073.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1618243073.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1618243073.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove multiple blank lines to conform Linux kernel coding style.
Reported by checkpatch in file Hal8723BReg.h

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
index 68a56627546f..1279ff82c097 100644
--- a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
+++ b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
@@ -19,8 +19,6 @@
 #ifndef __INC_HAL8723BREG_H
 #define __INC_HAL8723BREG_H
 
-
-
 /*  */
 /*  */
 /*  */
@@ -142,7 +140,6 @@
 #define REG_RQPN_NPQ_8723B			0x0214
 #define REG_DWBCN1_CTRL_8723B			0x0228
 
-
 /*  */
 /*  */
 /*	0x0280h ~ 0x02FFh	RXDMA Configuration */
@@ -158,7 +155,6 @@
 #define REG_RSVD5_8723B					0x02F0
 #define REG_RSVD6_8723B					0x02F4
 
-
 /*  */
 /*  */
 /*	0x0300h ~ 0x03FFh	PCIe */
@@ -355,7 +351,6 @@
 #define REG_BFMEE_SEL_8723B		0x0714
 #define REG_SND_PTCL_CTRL_8723B		0x0718
 
-
 /*	Redifine 8192C register definition for compatibility */
 
 /*  TODO: use these definition when using REG_xxx naming rule. */
-- 
2.25.1

