Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E81D322417
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhBWCUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhBWCUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:20:07 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:19:26 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z6so7854801pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=Znb49U0fEt0CVCPRv4tUDB1WYbHL9iuhJS+GaAXOMNA=;
        b=Rj/m5ZFfwQ1f/T0Vi9kLqmBt/MR0TOYP+fKuw9rcp9XRaoBzE5+WcqRg/+JxF0iNRs
         7xc8vGrHd8hBe/fPKpG0bOapoF0BT3/3S+RfnEveMawDi7awhF/VQeKhh1EtBiO+00ft
         F6q0fLe3fr+SUbUetY9INIfhUaehK/Sda1ut2JsQlQkolvwg6aGN/NRjGCuBDOKbePDb
         oRVhRGcADOFHJhn8sus+41yjVnKi0Ej1ufr1i2Zq6nyvdEl05VkOZgN8vUHYSYCbvdgX
         f+dAMkVsGiWY/IhpnWBIEXMzWSb7bwabYs+LrV3N/k5Xz0mOFatVjjK8U9+XI6Ul/nmy
         4kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Znb49U0fEt0CVCPRv4tUDB1WYbHL9iuhJS+GaAXOMNA=;
        b=ulLtj3P6LLyxVK7anTg6qNSz5kpE23cRs8CJku/a7hg3GRm8maahUisO84wj1FBxTj
         ekahYfvYJzSEpGWdK2LWiV3olcqy8TYTINs+lSjwrrqf6KATMC4YrOD4gJiP/n/6uCpw
         fXj0sh/eJzDY44hBzxuZKlb6IMW6YPLC3Wh21hZILgW1ntbGAq/0vTNUtvW5JauiKQ0P
         slaTgdrfbJvTl0+qIdFLLYl2psYyMy9hC8TLmABA2jHK3E5y8JSLKFYox6ArLgnxdzGV
         PUCYkqkgBTBukuuaqMfxY0VimQxnkOAzNl6WevKeo5XvsJt6a3bZD1xSm6PgL2X4KHc7
         YbmA==
X-Gm-Message-State: AOAM531RHQLzuUMl4eGj3yPz0+J6aBTYR7QErAOyshH6ZKihvMN6X/UP
        hd8aalsvXjM+Rqjd1+l9LeH4yKQXsASxI0VD
X-Google-Smtp-Source: ABdhPJxQ5J5mg+pdwIVFC652E8gocwCjkQfWfKRwdZOI4Y5d1+XfWa9b+leU5Tkke9j1v9g2lzsUtg==
X-Received: by 2002:aa7:961d:0:b029:1ed:c1d7:b57d with SMTP id q29-20020aa7961d0000b02901edc1d7b57dmr3790657pfg.9.1614046766151;
        Mon, 22 Feb 2021 18:19:26 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z10sm846730pjn.11.2021.02.22.18.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:19:25 -0800 (PST)
Subject: [PATCH] soc: canaan: Sort the Makefile alphabetically
Date:   Mon, 22 Feb 2021 18:18:58 -0800
Message-Id: <20210223021858.3809234-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        pczarnecki@internships.antmicro.com, leonard.crestez@nxp.com,
        peng.fan@nxp.com, joel@jms.id.au, linux-kernel@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

The rest of these are alphabetically sorted, and leaving it this way
causes a merge conflict.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

---

I missed this when reviewing these patches, but happened across it when
test merging from Linus' tree.  It goes back a way so I'm hesitant to
rebase this one out just for cleanliness, but if I have to go back that
far before sending the merge window PR I'll squash it in.
---
 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index fa7071246546..34b23645be14 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
+obj-$(CONFIG_SOC_CANAAN)	+= canaan/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
@@ -29,4 +30,3 @@ obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
 obj-y				+= xilinx/
 obj-$(CONFIG_ARCH_ZX)		+= zte/
-obj-$(CONFIG_SOC_CANAAN)	+= canaan/
-- 
2.30.0.617.g56c4b15f3c-goog

