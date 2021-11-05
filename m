Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271EB445D62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhKEBlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhKEBlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:41:05 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8B3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:38:26 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g13so5520167qtk.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7jmwbzRfe4ViZ3UmdAXqWcwYspkOIX/cD7v15It0jc=;
        b=LwrxvUDNr1WcluyF87vqkxj5m5CkTMPDtEKwRDbOTZ/hHPht1Dxb0pl4oAry8W4aTQ
         /6euwl7P6NHXVucfeOd6DE5VvZC2zGC472IyBVaP9opY/caivJfTqYV/1+XQtepJL49w
         VVvewz2WtrC5vTSzxwxWJqdJLe/bMGAjWQNB1iX/Vy4p9+CaWF3BNLE/MR1d6J06boud
         hugd1aVhYd18BR5CA/lFX6X0A5S0uiJKO2fAYdUxMr/jxxzYHS96E8oNVUe8w2sDM9B3
         XKwKuEuJjhGWNoTN3D4/q+Ay6mngLlXjFf55hBmbPUTEluoav5SMIIGeJyx5bpZN77dL
         OOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7jmwbzRfe4ViZ3UmdAXqWcwYspkOIX/cD7v15It0jc=;
        b=0Vuf0J7mAxYgT28zURwTzPwaTP4lPtFHcInFRFDp6qxp5KmsRKgL9hot+f4Sc5pM+T
         VcKNbxzZkYRCClj0I/2R8/AKwH9/bQ7AkhHsuMLOrZL81b75Q0BNGHowFAza4Vz/6giw
         QCAclFHd549ugyxIbqaB2N1253U3IUiGD7t43fqY7fJ7e9RvsfDDl9KmOSxAA7NxcZee
         DAo1LbbzY02xS0qlCn2h6DupZ+vua97tRpP+vVr5rm9dHeGO7TklHA/MXESVR0HCUPlN
         qkX2soAarEslPjwO8VoiXzjHTrW/b0ZuMuwHtDvh/a6Sr/BOhZ3phq4PXPt3JZyAFxm7
         ra0Q==
X-Gm-Message-State: AOAM5305t8VBH+ggtwx3OqCm9JXTGtJ9Er9jSx/truHmM4VZvLEPCeUs
        +gNYi/O1fJ0IAZxxW+dTqu8=
X-Google-Smtp-Source: ABdhPJwnpCKghjSO7MCH5FicB6SiXeOQ9bRoOI3rbVOYzeCkQaQaUs3jh4YQZF2IPjKc52gkQeP6cQ==
X-Received: by 2002:ac8:530f:: with SMTP id t15mr10911088qtn.72.1636076305691;
        Thu, 04 Nov 2021 18:38:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f1sm4613755qkj.84.2021.11.04.18.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:38:25 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     jesper.nilsson@axis.com
Cc:     lars.persson@axis.com, linux@armlinux.org.uk,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] arm:Remove unneeded semicolon
Date:   Fri,  5 Nov 2021 01:38:19 +0000
Message-Id: <20211105013819.75014-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Eliminate the following coccinelle check warning:
arch/arm/mach-artpec/board-artpec6.c:42:2-3

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 arch/arm/mach-artpec/board-artpec6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-artpec/board-artpec6.c b/arch/arm/mach-artpec/board-artpec6.c
index d3cf3e8603e8..c27e7bbcd7bc 100644
--- a/arch/arm/mach-artpec/board-artpec6.c
+++ b/arch/arm/mach-artpec/board-artpec6.c
@@ -39,7 +39,7 @@ static void __init artpec6_init_machine(void)
 		 */
 		regmap_write(regmap, ARTPEC6_DMACFG_REGNUM,
 			     ARTPEC6_DMACFG_UARTS_BURST);
-	};
+	}
 }
 
 static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
-- 
2.25.1

