Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35373441450
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 08:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhKAHqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKAHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 03:46:23 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48421C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 00:43:50 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 19so13509774qtt.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ww+iuNc4Aes8+PjyRrh9Ey0Ld9Q1orZV59Lg8GR2Wkw=;
        b=Mb3305lndxQDhfkFli0mJ3Z4NjP/X22yo/v3yOkTJMkOhcsdfnx4T5Ncx/lESrnx2f
         BS97N75HXdz6EXDuKsNmOtSe68xZcpI9mQzeZ/iU5ahNYsXUvFK3WWFeRtxctj2XMokM
         EOG8QeTAt9eHl9iYwGmMpL5KaujveP2AHJE8xi8UJ0eT0dEPseBQKsaUz02xHBcz/M44
         IIWvk3iy/aPLrKOYlzwHsjcc0NHNOYY1SBJINGQa60Tz87gaqx4SB8eJ/tKetd2E+xlt
         cq2LPWSCAiYZT9ysgeonnRjjbQ0Ugir1vTrcJYaUvST0IFa40o6ZRcrYk7vBLGQD4NUw
         muag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ww+iuNc4Aes8+PjyRrh9Ey0Ld9Q1orZV59Lg8GR2Wkw=;
        b=Tuj3+DZ6rc3RMmV1h38QnjVJ7Z1DsWatOY7V6QFQa7jh+l9on3y8ueGTRfvepLJXxj
         8nC2vbZSCVTWhs1Sz5ugScPbsfl1oov92YiyxNGCh/4+ZSv7LSJTiUOpZ+Xl2FImeDjg
         a/PlBfXl05CHsx9wQJiPTqkcaVdRkeBs3N1kyp06Xrg4A5l3jxf2S607AUMFv07znF/x
         +ebwExJwT4q5W2rCxKKdCy7PUaWEfcYSi5V2n98JGl8kmvUNbL4Bef78vomfIALY1XUT
         HwAmY6n3PuwipwsBz6ysExFUPKegWQEuHv1qBIrl5/URBQfMd8OS+wnNir+dqfPZo0oI
         DvLw==
X-Gm-Message-State: AOAM530g4cyanZyS1Op7Nbu4FgaGkXG1FSd9RzS09RqZio+PpEPuyhxh
        dU2HLOOkXt/aFlNW/udrxCs=
X-Google-Smtp-Source: ABdhPJzww3g3FogFv4MfZI+FjLISuIIsDXHgUx1CFBThekGop6yGdBbM9YTG3c4yU3FjDZuHzuHfUg==
X-Received: by 2002:a05:622a:c3:: with SMTP id p3mr28674975qtw.161.1635752629359;
        Mon, 01 Nov 2021 00:43:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z19sm9458373qts.96.2021.11.01.00.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 00:43:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     jack@suse.cz
Cc:     zhang.mingyu@zte.com.cn, krisman@collabora.com, amir73il@gmail.com,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] signal: remove duplicate include in signal.c
Date:   Mon,  1 Nov 2021 07:43:38 +0000
Message-Id: <20211101074338.35680-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

'asm/fpu/xstate.h' included in 'arch/x86/kernel/signal.c'
is duplicated.It is also included on the 45 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 arch/x86/kernel/signal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index ec71e06ae364..fad9c4adcda6 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -42,7 +42,6 @@
 #include <linux/compat.h>
 #include <asm/proto.h>
 #include <asm/ia32_unistd.h>
-#include <asm/fpu/xstate.h>
 #endif /* CONFIG_X86_64 */
 
 #include <asm/syscall.h>
-- 
2.25.1

