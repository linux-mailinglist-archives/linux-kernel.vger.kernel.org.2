Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140D132BCD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359687AbhCCOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843035AbhCCKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:41 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EC4C0610CC;
        Wed,  3 Mar 2021 00:45:58 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id g20so13660466plo.2;
        Wed, 03 Mar 2021 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmJdMgIWJS2+LE0PVLUNCj+DeQ/GkaT0iZieh9QTlU4=;
        b=tDKPficthK4Zq8qdpioUFOGezAWuIvADjkelR+F8ISuIzYF1ndZGsl8gGMlkGYmZls
         djR17Ws9a9CIk1hrMOSLbWMwaP7Zp7mU3wbRT5U1CEzBz/OeoDoA8rVjl8g4VnjOwv6S
         0NMRycbcmOQwpn9pzsdiHqB0iglbUwyvVFttIakQRuik2hbqtDFv9z0uLcioXVpHqp35
         Iqc1+Q8X09W3q0cqq/hHsfnWAEvoYg2/wApI5i204RCoYt0rYQ6ovLMR4O1enwyU061n
         sf4AIF/0rOYyCrlk7ht4UDAsTAfoF5xEDd4dBrFVzvSrQRKvb3qYxPmHg/4PPXrA2Ebt
         zXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmJdMgIWJS2+LE0PVLUNCj+DeQ/GkaT0iZieh9QTlU4=;
        b=avUJeYygfBwCZJutDHSMEXYDqyQIQnzPesudU+wj4as4ewoNgbZvR+71z2gXWeDHvO
         qt+4UiBByW6xgaCNbB1VkZa7t+wYeAiLbn6z11FfSKc1xt3+XDjpeZ/HyJpBeArIEdgJ
         ZUvrx9+GTWw+u2Rpn+x7VG1uj+F/0HpALiyJz8E8XNBHvfppzayoBzwtg60OH1V4VTfk
         ag/STUB5csPjSTKjzSbeUho8SJ4+iMyOImCBXh00UqY9iW6v3CKYoZeV+f9V89gF9ZX3
         AAzYGUdDwgV2UmnDneWQHsxjxaQ4Sy/HcCfCFXmw423+ZmhO+F3iQH6dROiQ4mMBzrVC
         41Sw==
X-Gm-Message-State: AOAM531Ul5lnZAOAaLROvswlU4m/mfnuOUUfMPXYie7i3VMEnCWSQTjz
        O2ay21fTj02pC9JHNdZosXhvxtJw9qo=
X-Google-Smtp-Source: ABdhPJwuDbFMd4XGHEm/Arn01/ajOGKybAx/GpNgAHEN3qZ0FTy08hXh2IRPGDSpDzXZHlPQT5zN0w==
X-Received: by 2002:a17:902:e54e:b029:e1:2817:f900 with SMTP id n14-20020a170902e54eb02900e12817f900mr24021942plf.15.1614761157590;
        Wed, 03 Mar 2021 00:45:57 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id b7sm22845466pgh.37.2021.03.03.00.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:45:57 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     linux-ia64@vger.kernel.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        zhang.yunkai@zte.com.cn, linux-kernel@vger.kernel.org
Subject: [PATCH] module: remove duplicate include in arch/ia64/kernel/head.S
Date:   Wed,  3 Mar 2021 00:45:49 -0800
Message-Id: <20210303084549.179346-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/pgtable.h' included in 'arch/ia64/kernel/head.S' is duplicated.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/ia64/kernel/head.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/ia64/kernel/head.S b/arch/ia64/kernel/head.S
index 30f1ef760136..81b64d1adad5 100644
--- a/arch/ia64/kernel/head.S
+++ b/arch/ia64/kernel/head.S
@@ -33,7 +33,6 @@
 #include <asm/mca_asm.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
-#include <linux/pgtable.h>
 #include <asm/export.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.25.1

