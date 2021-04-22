Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78A936822F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhDVOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbhDVOKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:10:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81771C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:10:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h11so739989pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XI2YCUz+44Zy3orKtb7KsqGSJx1mxyhuJPFi/bk0Zs0=;
        b=MuN9hvNrvNcaR2Q0CvGD3fjuOLDw3jSpv+b/lcondYlgWvEhQoK13ZyYYwnoNuNKhW
         CANvDi0TQlBXbQQ7fu6/gfqdiZO+AERaSLLULgxsLdTtmRoGBEg7+PypOV3c1mo0n3wI
         nr3vPRFWEyNzINgfF58HLykvl0iioGHIOlpuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XI2YCUz+44Zy3orKtb7KsqGSJx1mxyhuJPFi/bk0Zs0=;
        b=JO0uXeAvhVvyHPcD3EbJ6sU7gqOuPg17voKdnEoeiAukEZms6TmnNsxDcwZpLTQ+cN
         5kSkh/BK0w8OaM6uQbUeGxY1QkpC7KnWEBfFRpIFzYiKKybeP1NuDgJ3PiTVuX/yCFHu
         UJ0hoku6st/5Kouwp0WmWA0itRmh2dTyq6zQMbRzuIz1W72ztysUh+Vm3UgZns9I2qUu
         WnQUrhCgszRQTnKEULftXmhbhDW4cojVuDPlLGHB0khaZTbcBTGYz/0wd63NlRbwayn5
         1csHROTrq+MrRRmDj/V/dInUKGQIjl23UwfCO5XnEANqhcCiFIjvW4JAwF0TD3zr79U4
         QD1w==
X-Gm-Message-State: AOAM530iulnrMxZoEeGyDEbk9rbAuIWCcEPwYQwVGHqPR9I1k4bk7liz
        vSpMWaDOl8rxirYCXChpBWsEoA==
X-Google-Smtp-Source: ABdhPJxbqXR3mq6opveJ55gQ9DzentSPq3ekpWCG3BOngL0oH1sTNoSfTn7mZGttpyiuDUHFb0Ds2Q==
X-Received: by 2002:a62:7d46:0:b029:247:baa2:d95c with SMTP id y67-20020a627d460000b0290247baa2d95cmr3635339pfc.15.1619100602037;
        Thu, 22 Apr 2021 07:10:02 -0700 (PDT)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id p12sm5278968pjo.4.2021.04.22.07.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 07:10:01 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, arnd@kernel.org, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>
Subject: [RFC PATCH 2/2] ARM: mstar: Add header with macros for XIU register access
Date:   Thu, 22 Apr 2021 23:09:45 +0900
Message-Id: <20210422140945.4131092-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210422140945.4131092-1-daniel@0x0f.com>
References: <20210422140945.4131092-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registers connected to the CPU via "XIU" (Maybe eXtended Interface
Unit) are 32bits wide with a 64bit stride.

Apparently someone realised that splitting 32bit registers into
two 16bit ones was silly but at the same time didn't want to
fix all of the register offsets used for "RIU" in their code.

This means that any existing driver (i.e. the usb and ethernet)
cannot be used as is and needs to use a special readl()/writel()
to fix up the address of the register that needs to be accessed.

To avoid having this code in every driver add a header with an
implementation of readl()/writel() that patches over the insanity.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 include/soc/mstar/xiu.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 include/soc/mstar/xiu.h

diff --git a/include/soc/mstar/xiu.h b/include/soc/mstar/xiu.h
new file mode 100644
index 000000000000..d658338b8006
--- /dev/null
+++ b/include/soc/mstar/xiu.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _SOC_MSTAR_XIU_H_
+#define _SOC_MSTAR_XIU_H_
+
+#include <linux/io.h>
+
+static inline u32 xiu_readl(__iomem void *base, unsigned int offset)
+{
+	__iomem void *reg = base + (offset * 2);
+
+	return readl_relaxed(reg);
+}
+
+static inline void xiu_writel(__iomem void *base, unsigned int offset, u32 value)
+{
+	__iomem void *reg = base + (offset * 2);
+
+	writel_relaxed(value, reg);
+}
+
+#endif
-- 
2.31.0

