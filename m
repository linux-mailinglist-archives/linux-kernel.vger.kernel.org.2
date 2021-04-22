Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9AE36822D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbhDVOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbhDVOKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:10:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ADBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:09:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s20so7755478plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUQtN/I+EDS4RtvAAmZnEOQmRyFVPsDaWOFvWef9gus=;
        b=m405sN+jsIKKqYpelEt0LNiff9JTDxA9Eel+hymId7NuhOeBSniqqwsAJnLNdtlY8I
         GzwY7TnfQYG6tdhZsF9PnG/g64ql7vxy28mWXS+G0TEFfft8EbW+3Mo+oqhbodfNetqJ
         e33ijCit5j4TesiVTu/CSZxQeZPtkbDL8Sv1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUQtN/I+EDS4RtvAAmZnEOQmRyFVPsDaWOFvWef9gus=;
        b=QCEl8BuyqOzOaLQFy+bIB/7apfFzK644JzmE7rymrku0iX+McUvRk25pn1KUZ5V3l4
         4yFNMjH1CoVZc6/meEbIQMMcv+iAak/nSbR6vhahKUj+i1/gkgFI6tuRM3L3exJ3uDrh
         dr4NluXbi9CKZbtTz/KKad9N0sidjmrcOpBdPap6RcoFhVb1c2s/NNNGGUw9e70XBRQM
         0KVKIc8agi59FLM2F1xF9j9VBsLjslAT2TC98Cx+RmWl+O60mdf7qZqGf5UMgWTeywEB
         vhvqtENKys1mzDB4vhnperSF50fK4Lf+aGPESNVukx3fiqwCM9V3pXvNYnKAeJQh8zHu
         vnmg==
X-Gm-Message-State: AOAM530ffO+Bc2SPLjyYIZULu9/AyvtrSOmq93SfetaEIBZV6NRVnodc
        69oZP33n5twDDNG0wdvLYeY+yQ==
X-Google-Smtp-Source: ABdhPJw3kSgPde9ZOzM0kdFE70SeNfH0jf8NhTpk/jrK2Bo1OaaYS2GMKA4tRypu1GDE76E+p/tTOg==
X-Received: by 2002:a17:90a:f309:: with SMTP id ca9mr239059pjb.200.1619100599585;
        Thu, 22 Apr 2021 07:09:59 -0700 (PDT)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id p12sm5278968pjo.4.2021.04.22.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 07:09:59 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, arnd@kernel.org, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>
Subject: [RFC PATCH 1/2] ARM: mstar: Add header with macros for RIU register access
Date:   Thu, 22 Apr 2021 23:09:44 +0900
Message-Id: <20210422140945.4131092-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210422140945.4131092-1-daniel@0x0f.com>
References: <20210422140945.4131092-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registers connected to the CPU via "RIU" (Maybe Register Interface
Unit) are 16bits wide with a 32bit stride.

For IPs that came from 3rd parties that have natively 32bit
registers they are annoyingly mapped with the 32bit register
split into two 16bit registers.

This means that any existing driver (i.e. the usb and ethernet)
cannot be used as is and needs to use a special readl()/writel()
to fix up the address of the register that needs to be accessed,
do two readw()/writel()s and stitch the values together.

To avoid having this code in every driver add a header with an
implementation of readl()/writel() that patches over the insanity.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS             |  1 +
 include/soc/mstar/riu.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 include/soc/mstar/riu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 19dc2eb0d93b..9600291e73a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2155,6 +2155,7 @@ F:	drivers/gpio/gpio-msc313.c
 F:	drivers/pinctrl/pinctrl-msc313.c
 F:	include/dt-bindings/clock/mstar-*
 F:	include/dt-bindings/gpio/msc313-gpio.h
+F:	include/soc/mstar/
 
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
diff --git a/include/soc/mstar/riu.h b/include/soc/mstar/riu.h
new file mode 100644
index 000000000000..5aeea9c1e7eb
--- /dev/null
+++ b/include/soc/mstar/riu.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _SOC_MSTAR_RIU_H_
+#define _SOC_MSTAR_RIU_H_
+
+#include <linux/io.h>
+
+static inline u32 riu_readl(__iomem void *base, unsigned int offset)
+{
+	__iomem void *reg = base + (offset * 2);
+
+	return readw_relaxed(reg + 4) << 16 | readw_relaxed(reg);
+}
+
+static inline void riu_writel(__iomem void *base, unsigned int offset, u32 value)
+{
+	__iomem void *reg = base + (offset * 2);
+
+	/*
+	 * Do not change this order. For EMAC at least
+	 * the write order must be the lower half and then
+	 * the upper half otherwise it doesn't work.
+	 */
+	writew_relaxed(value, reg);
+	writew_relaxed(value >> 16, reg + 4);
+}
+
+#endif
-- 
2.31.0

