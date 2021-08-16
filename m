Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D63ED312
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhHPLa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhHPLa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:30:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F756C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:29:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so16445859pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8IhNnYi0xnyfOJVE77VjkAVRbghDFzOqFFDQLqlryo=;
        b=RXx5iRib2uJajCWxLuyyU34YzY1rRxYep4O3W9B5ev1H2dw4s74g/a/qNFE5bjtChw
         0Wt3CFzPq3uXNzkihb0xl4P8sJn2EQY84igKb6Wg1aTvNcUIA0tbQOSpmTM8kJE4kjI0
         7sBIzOQkiSX9Vxt/8a4DcSZTMN3ASiKC+/o143Q9fDUYb1PL7K8zi94f7LuKGpAP9StO
         j1AeXFkY0q3MU9N4KmgiLI5Foyi7vDAa7Xk+zSwd1jSulaCXu+9T74zyn6O3RTt7h6M4
         tA+Y/DfrN7nagBOljZubpMD6RwH0IO/RFzvbG/FYf81042/xeE3yLTB/FS53NRTVpywd
         39IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8IhNnYi0xnyfOJVE77VjkAVRbghDFzOqFFDQLqlryo=;
        b=umH+WfU58owAfVb8Xsm61q9NWWtUmzssNgXUkwLyz2ETi2WCVJufQ486Fhy/VIHrn3
         s5NqqrebvAqRCL0ayRWzdDtKxnARF18WLQj1DhnF0GHCaUiqJ4I5ZDCuYVwJth++o1QJ
         cZzYj0tzNr6pWYsAm72k3zAu2cG8Tk692M3J+tdg1FrH0wsuRsdX+mUzFZ2Li1rfy+Tc
         FcTL/R9fa7lLMIAo44rNNqsxb3Zy+IyNnOWRHb92SuaDzbic82tJ6nPyzqqMjkDxDYA4
         xoGH7k8bIk5FKImbii+Z40oLRh2VXVKszzKmxWY8Wq/Vl3EXAGB+k9JI1nAExWFDb4YZ
         kyKw==
X-Gm-Message-State: AOAM530E9Aia7k8TQ2lOFU7cuQdLHFjBFe+S5sAcS1bSL6s0cGw7k1bt
        tJZ57KCCCMPJG0wDIJ87i8s=
X-Google-Smtp-Source: ABdhPJybhm5nK0tss6jj88+sOp7rUsaMCKNszs2d0b5cUBxe6cy1nSZf6Y0jYmGXhUSpQCG0pJwmJw==
X-Received: by 2002:a17:903:49:b0:12d:9c6c:a1df with SMTP id l9-20020a170903004900b0012d9c6ca1dfmr11560981pla.81.1629113396005;
        Mon, 16 Aug 2021 04:29:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k9sm3682424pfu.109.2021.08.16.04.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:29:55 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     linux@armlinux.org.uk
Cc:     yang.guang5@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] module: remove duplicate include in interrupt.c
Date:   Mon, 16 Aug 2021 04:29:16 -0700
Message-Id: <20210816112917.126675-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

'asm/interrupt.h' included in 'interrupt.c' is duplicated.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
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

