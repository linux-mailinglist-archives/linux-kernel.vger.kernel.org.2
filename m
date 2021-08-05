Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FBC3E0C71
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 04:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhHECaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 22:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhHECaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 22:30:08 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F26EC061765
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 19:29:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so5859412pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 19:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gTOag6iNgEboHEjQCKxxPjC49dhZbZiovCGHlps5Jc=;
        b=LBtsYvq4Z5uHgYzZ9yA8bl7KfsA+E5GO/w+rRQ5uMqFk8bMZm8ARdzvt7ErC25E4Wr
         tiYNzHEfwdIWJhySGDCxLBmhCu0G5q1fcgyDQsZbjyyN6+q5guSvoAzKrIrfFFpmBT7P
         UTYs3iP0g9S/Twwb3emUwHXg3kcskDvaENB9Yk4mzaz3Kbma8axUfjpMP8MNpEdtpKpC
         0upB1wyzC7H4/+ZPLN7yZ1wTaRX4MrFViSgeTSmOLNe6zKRv1guD8IWBUgc1dlT9YElH
         REf5eKCQPwGj+OSHDuxfjxLb3xsQdJTiDmP3uj3UCdCU8kaY3MuQL3jzScKRfukJqK2S
         uSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gTOag6iNgEboHEjQCKxxPjC49dhZbZiovCGHlps5Jc=;
        b=m06lRRB0Cdm/ygJBmolquujp6rP9xg/ELesWkFF73OFHOynWiYUmMZ0DXMSfjsKMTB
         OjC/0kOHzc3FKlpO2gnRjVopirEy52p7nWIy5T8PY0yJiMIlkLd6gMTLpZxD/tC2FPE+
         TnFibVhCDZG7pagtgw4oKVsbShneCOGbUH/dE3xmScjkRKrg8NZnN4wraoajV9eDeF3x
         tvlqbW3vzgebfMpHe6DeQgDS1bpw4zoX/FzffJ2WI62eI6Ou4uAiGpp+lRoQMD9iuj7G
         lZW8Xodjsp7I144n/illoQDtxaNaRx22kpQYEmE0hJ8LchrMgHMXiXDEZtrj1xl4oYP9
         IA+Q==
X-Gm-Message-State: AOAM531AmNz/KnL8rgcqtVn6z1nG9bShKDjhRC6AF+zdPK1vu6C3N8A8
        NIJgtAgCimj4No/oo47NfkOA0rjyOxU=
X-Google-Smtp-Source: ABdhPJy63G+9/MlgSHa+cL4GWuSr84aC8RxAjYTnhod8cy3bWb/N4QEXWDhWs2/hFEshiht6W36ttQ==
X-Received: by 2002:a17:902:8348:b029:12b:b2a0:941b with SMTP id z8-20020a1709028348b029012bb2a0941bmr2276489pln.62.1628130594547;
        Wed, 04 Aug 2021 19:29:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 5sm4508434pfp.154.2021.08.04.19.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 19:29:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yong.yiran@zte.com.cn
To:     linux@armlinux.org.uk, yong.yiran@zte.com.cn
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ARM:sa1100/hackkit:Remove duplicated 'linux/tty.h' include in 'hackkit.c'
Date:   Wed,  4 Aug 2021 19:30:39 -0700
Message-Id: <20210805023039.625968-1-yong.yiran@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yong yiran <yong.yiran@zte.com.cn>

'linux/tty.h' included in 'hackkit.c' is duplicated.
Remove all but the first include of linux/tty.h from hackkit.c.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 3085f1c2e586..3fe34ee7c0ab 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -18,7 +18,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-- 
2.25.1

