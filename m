Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA0433FF70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCRGPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCRGPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:15:18 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD959C06174A;
        Wed, 17 Mar 2021 23:15:17 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a9so927248qkn.13;
        Wed, 17 Mar 2021 23:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGm7NDIPJjCsLFZ6tnghxBXyR6MEo70lHWJC6J/P594=;
        b=a51vWDnzAGqhmGyVNrv+QHxOUVsCl7VhzWdgzJSgZi0JVESwW2RNjvCh3aMjBrvGTf
         wzclHBzF9to7l86hHqhPGEbZeLC7OpObViVB/7q8AzgA9mkQLPywqj/Qt6u0jo3H2jpp
         nAlNxmNmbDaGBtwbUIUSDdq7BNTbl6fat7vzWnoni8pyNdb+btcq34xkKa2U0ajFWjZI
         KqNSrscJZ3aVunohQ2nD+szINEDbQxgrWzOLKEoOwz1il39xuhd63XeFAcEbsEpDq9ZF
         Q7Zj0X5NSV9Xj7AAcnqfhvjQl4zdSUJ1RVSLzntGrCI7oEck59b1EOrTeH12Um4t95H8
         O9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGm7NDIPJjCsLFZ6tnghxBXyR6MEo70lHWJC6J/P594=;
        b=eM2UPUOOOelnZV6pCGXEzts8FatHomtVjzQoe1Z1Qr7LJJucvGHPwh6cKPphtLZKYx
         zD78V4euaQ6HokYLS3C5RkUyrK8a7YpyOUf7g1XX4O1d3w4B/ZzNLG96KRw4LX7zRfEj
         /DaiKNNprkR08qbyBCsEtOLgz66f3o2Ldqiu9yKIxCOYx/5a6T3uzXC6XuHmaioeDJUr
         CoBOBw8p5Z4oBFnipy9XJrNfHHPCXphx+rLwGYmpzmuXNm/4+8WyrfCG2uXTHRp2eVGF
         ZBcJYoTk4LCWFwsZ6qwW4WjBYhSdwWsLMpu223uPvnL3NlK4gPFmxnWsuK2Dk1bSz/YY
         oS6Q==
X-Gm-Message-State: AOAM5328bIBrV+LTI84LllkrevsqfoGASphd0izUUBy6a4wjdJ8s/bCJ
        Tn/GiBvxO4Zls9UN3CipmZQ=
X-Google-Smtp-Source: ABdhPJy56e0YJoP2SqJM/xh3/4dgFjsOBO48iD0obwi33OUyX1n5fvWyxSn0Ji7UGAJWu63MiUFXfA==
X-Received: by 2002:a05:620a:641:: with SMTP id a1mr2788150qka.257.1616048117151;
        Wed, 17 Mar 2021 23:15:17 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.26])
        by smtp.gmail.com with ESMTPSA id 77sm1095932qko.48.2021.03.17.23.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 23:15:16 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dvhart@infradead.org, andy@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        unixbhaskar@gmail.com, gregkh@linuxfoundation.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] x86/platform/intel-quark: Fix a typo
Date:   Thu, 18 Mar 2021 11:42:51 +0530
Message-Id: <20210318061250.8593-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/secton/section/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/platform/intel-quark/imr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index 0286fe1b14b5..122e0f37b1f5 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -551,7 +551,7 @@ static void __init imr_fixup_memmap(struct imr_device *idev)

 	/*
 	 * Setup an unlocked IMR around the physical extent of the kernel
-	 * from the beginning of the .text secton to the end of the
+	 * from the beginning of the .text section to the end of the
 	 * .rodata section as one physically contiguous block.
 	 *
 	 * We don't round up @size since it is already PAGE_SIZE aligned.
--
2.20.1

