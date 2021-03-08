Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCBB3310C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCHO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhCHO30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:29:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120D2C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:29:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d13so15068699edp.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZ95HCrzC/uZL3yF3MQHAMzcpcBy+9OivBgQEt2mFp0=;
        b=IGuHWW2xBAY/Gd1G7xqn4N3gKp4SPyZITw0xLNI+qDvAdKJLx5mlPppSSg2Wg02WB0
         IFIafS/IvgfCnfaLHfHiwoYGbnSgrwjHehCAT3F0aNkYzm3kG3XRC61CgjsAHxviIgm+
         Kf6j9M1Y090wEtFmrIq6TA1q1QeXzEF0y3+5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZ95HCrzC/uZL3yF3MQHAMzcpcBy+9OivBgQEt2mFp0=;
        b=gsPUCgZLv71PRDVs7jumMHSRfLjM6qv3YXUwqTtkI5WOpDpcqEGICYgcw5Fiipw0fs
         75d2G3Z4veIb6LBcfRzNPBU/3NTpmWaU9vFSfFCCARx6bc2Nq5Ck5846jE4CmWQwEKwt
         FsyY6Db97IKDDsc5/Y0o+oBcTRD8szvQVZ9RUCqHXVlyBI4sMDyY8OwXUGD12a9vpcvi
         LhjLdeU7hPo9vjLIzHInjk5/3Y0CVMYfQ8zhJ6+xHMkLlwRXRI4wujhp/TBwhuioATXu
         OapZ/+92uMJhLPeK0I53zcNmQS8abGj/rSx1whKBm2V5d8BFjapSfcn7fWan9s9DlH7v
         Rx3w==
X-Gm-Message-State: AOAM532I4juPlkPDFYP5ZKp0MbUxXiD99NidLRgac/YPDoMKGF4j2tU/
        LBtk7s6NK06rmRUdPbT8QGJaGXNaAJgVxv2U
X-Google-Smtp-Source: ABdhPJzwFgkfy/3/HYzExl5Jh7X0iiALW2LDPb2arB71+bIn0TNbrNYiRH0B+w7MpSTUNtTBd15uPA==
X-Received: by 2002:aa7:cd8d:: with SMTP id x13mr22120450edv.286.1615213764852;
        Mon, 08 Mar 2021 06:29:24 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id j24sm6614687eja.61.2021.03.08.06.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:29:24 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: decompressor: remove unused global variable output_data
Date:   Mon,  8 Mar 2021 15:29:21 +0100
Message-Id: <20210308142921.1287584-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

output_data seems to have been write-only since the flush_window()
callback was removed in commit e7db7b4270ed ("arm: add support for
LZO-compressed kernels").

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/arm/boot/compressed/misc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index e1e9a5dde853..fdef4d413d24 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -103,8 +103,6 @@ static void putstr(const char *ptr)
 extern char input_data[];
 extern char input_data_end[];
 
-unsigned char *output_data;
-
 unsigned long free_mem_ptr;
 unsigned long free_mem_end_ptr;
 
@@ -145,7 +143,6 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 {
 	int ret;
 
-	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
@@ -154,7 +151,7 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 
 	putstr("Uncompressing Linux...");
 	ret = do_decompress(input_data, input_data_end - input_data,
-			    output_data, error);
+			    (u8 *)output_start, error);
 	if (ret)
 		error("decompressor returned an error");
 	else
-- 
2.29.2

