Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB8403E8A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352667AbhIHRr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352492AbhIHRrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:08 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F0CC06129D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id bb10so1789897plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dHmKNReYOY7Wne1mHOCbaVArJVjT8YTojOEreYW01tU=;
        b=mhffb2sxFFqraGBxX6A7vwy6ZV0rlDStInb42S5Feh6ZWjd6WU8M7vwVtfEN8oJ5Hc
         txPRtcVNjrUhJ28UltBlb5cqxXPeyG8pob9pLF7ws1X+hnMZcCRxmm0HlspFTkyl8JsW
         rmbPthyg4kOSec09TXFHQgCOVEBkV7K8jmoiaORbtCQxf751kpRL6lfUeqqAWqgPKy2n
         +RFNypAKNd2vxNkS+CPSOemX6s9vltbOEfLsYAdhgi0BUAu/c6fmL00/Wn/4dy9oSDbS
         8IimZeTLEBSCPfek81p4WUN97+DkASg0FwJu3A6oSvDfodXyQ2Dj+mUPJ3cPTbmYkJSo
         a3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dHmKNReYOY7Wne1mHOCbaVArJVjT8YTojOEreYW01tU=;
        b=JZHoiiRe1WZGiGRQlajpwWbvwR1Z+djaUBvN7lC3777u7iXGVb78Q0QJ16/I/kkSNy
         kUYlMbsEJey5jpjRetmJM5e/ppk7lP/zF22qT/nVdsHUhIY/XFbJ7rgPB7DA1jm2KgV1
         MqxsZxaC9AoSo/xzC7dH/DHPwNY1Z6LrN96YZUW6Eg/7YG+y+LltD/J25ddPB8vm2Tn0
         pFdmXfWfLmM95agqOiutjazxK6wmRTi0rCm5DhjMwRVF4rqY+AE6BiMQO1kik+/9dZRU
         zU5cWlrtXSU0EHyw3w++0lLiEq2el8QSWZ0xAKR2H6FI3QS1pK1cCSdcxWYji+ilaOdU
         WQZA==
X-Gm-Message-State: AOAM530psnLoeAvMqjE3kxUw1z1VrGl4ZDJwFg+WDfdQCCsBlpuW5Eic
        Fo3VZm3zFWj7AtJy05EAsAq4xA==
X-Google-Smtp-Source: ABdhPJwDyMUrSgiFUYqmOehVYqsKKgOtaFO5zRpVdI9VavSDwPShfDCO9ywvf6Iagr11iezOjyS88g==
X-Received: by 2002:a17:90a:bd81:: with SMTP id z1mr5363737pjr.207.1631123157743;
        Wed, 08 Sep 2021 10:45:57 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:57 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 14/21] riscv: Use CSR_STATUS to replace sstatus in vector.S
Date:   Thu,  9 Sep 2021 01:45:26 +0800
Message-Id: <ee930020bbd2a52064e4c51cf3b476a24d670cc5.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should use the same logic here in both m-mode and s-mode.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/kernel/vector.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
index 4c880b1c32aa..4f0c5a166e4e 100644
--- a/arch/riscv/kernel/vector.S
+++ b/arch/riscv/kernel/vector.S
@@ -32,7 +32,7 @@
 
 ENTRY(__vstate_save)
 	li      status, SR_VS
-	csrs    sstatus, status
+	csrs    CSR_STATUS, status
 
 	csrr    x_vstart, CSR_VSTART
 	csrr    x_vtype, CSR_VTYPE
@@ -53,13 +53,13 @@ ENTRY(__vstate_save)
 	REG_S   x_vl, RISCV_V_STATE_VL(vstatep)
 	REG_S   x_vcsr, RISCV_V_STATE_VCSR(vstatep)
 
-	csrc	sstatus, status
+	csrc	CSR_STATUS, status
 	ret
 ENDPROC(__vstate_save)
 
 ENTRY(__vstate_restore)
 	li      status, SR_VS
-	csrs    sstatus, status
+	csrs    CSR_STATUS, status
 
 	li      m_one, -1
 	vsetvli incr, m_one, e8, m8
@@ -79,6 +79,6 @@ ENTRY(__vstate_restore)
 	csrw    CSR_VSTART, x_vstart
 	csrw    CSR_VCSR, x_vcsr
 
-	csrc	sstatus, status
+	csrc	CSR_STATUS, status
 	ret
 ENDPROC(__vstate_restore)
-- 
2.31.1

