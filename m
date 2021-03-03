Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4157232BB95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446651AbhCCMiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839548AbhCCIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:05:00 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B798C061797;
        Wed,  3 Mar 2021 00:04:19 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id l2so15799316pgb.1;
        Wed, 03 Mar 2021 00:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rjVxnqYKDRnpp+0H3PrRTRrCFH/AMSZ2uqlLYU0m0ps=;
        b=WNHYWayIknRxBTPdExIve2oGMYMBdu/TDsqYRghhgk8vVhbOIfZ5QZ+z8l5Dx3xPtD
         3NSZSvDd34WmV+dyneHmK3k1m48n6EG7X0Gn6/xrEGlaiFrK3tsOYAwIAW5cyeP0t+/h
         oNAxdoyslDVzkHxbqelHdd5iF1NEFPQt5MxGOPUIKf6WHZe8qaB9PjNWSgYCH9a1vw9t
         tN15K+TmuFv+ys64U5uPPvhZDjxfXBInurjz0wRsjCwQ/uKsHPCwDbSUl+RD8wXDH414
         rzSTvE8cty3+stoKqjV3G0G7hmxrZ2Hsv1VU7ENehCXWCxfCjWawcO587uXVBd9GPSR3
         obFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rjVxnqYKDRnpp+0H3PrRTRrCFH/AMSZ2uqlLYU0m0ps=;
        b=YTFTgaZZKc+kPHBMzF6ihSBkELr/ZJ06w5hz0UBkBnvZoQDgHZkeaB2Of8IlAc8fEX
         /sLjIngUwZPasECiQdrvJo3rPaMGXzapydRM9+FKdzenpTlic+KPBSpU6p7Iysja0wk+
         lEsljICcO2A+nfriJ3M+ziVWaSMvZAVSwavEKtHhisgWrNuCs9fxBNVp4QaihFMBnCoS
         1mMBdbktXW2HJRS297PF6AEQAlFUxDAOjvhfIyt+kvS2dmiY7ZVYz1N3f7PUnB8OIY3B
         Jqr2BQGPD4reLIdE9NvOJaTS7lNhbYD4yxiKktZAbPRS6+kVmcl3pKV0HBZAxIgZzMBe
         6ORg==
X-Gm-Message-State: AOAM532zJtR2AM4ayWaO1DGdfUd+l1oZ2uYR3vOSGTpYG/0QZGjP2qi0
        aGKyLH9a+J3XNLuyLt2ViaknUkjOeZE=
X-Google-Smtp-Source: ABdhPJyHMBcpjy1TNatRNajWt7A4cSiHkYQiVzk4dlfLIVeLYQwbmLO+z2BISGSyRcQhHfFnqIXWAQ==
X-Received: by 2002:a05:6a00:1507:b029:1e4:d81:5586 with SMTP id q7-20020a056a001507b02901e40d815586mr7176211pfu.53.1614758658297;
        Wed, 03 Mar 2021 00:04:18 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id x1sm5658389pje.40.2021.03.03.00.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:04:17 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     linux-csky@vger.kernel.org
Cc:     guoren@kernel.org, zhang.yunkai@zte.com.cn,
        jiulong@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH] module: remove duplicate include in arch/csky/kernel/entry.S
Date:   Wed,  3 Mar 2021 00:04:10 -0800
Message-Id: <20210303080410.178702-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm/setup.h' included in 'arch/csky/kernel/entry.S' is duplicated.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/csky/kernel/entry.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index c1bd7a6b4ab6..00e3c8ebf9b8 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -9,7 +9,6 @@
 #include <asm/unistd.h>
 #include <asm/asm-offsets.h>
 #include <linux/threads.h>
-#include <asm/setup.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
 
-- 
2.25.1

