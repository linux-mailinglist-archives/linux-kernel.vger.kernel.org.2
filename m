Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780093FCC91
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbhHaRv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbhHaRvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:51:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF34C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j2so11115360pll.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ec4R9DdZqys8Bz/jvtq0TvEjkN7ulj4EpdQp38psGI0=;
        b=IkbzhqU6lvehapEShI4MMtiHyRVB62dIrmmSEbmZa1DsRMewWmHqxJENNAauuQ6s5w
         yNGXcNUYvrUScaMVXR5ym2S5eaT1oZRkccEKbzBLJqDmOAoU71QRIuIZdcqOK1BvKGxg
         X4yFOLcU9oY2qnUx/mgO3/by70nKm3IIFySZd8PYUivySzI0SJg5aNUadE1eMrVXqglo
         v5S1MXDIwFDQIrhL6t0ufDQS6gWpd7wDSBMoCBx1GAgRoLzxkesNtpz1pOAPChPSJwkI
         Hbh/Qxl5b28c+Ohqumk35aqLgp9zA7N7q/DKijYgAoUq/uRx54ypzS9NnARlHTaT8n62
         A6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ec4R9DdZqys8Bz/jvtq0TvEjkN7ulj4EpdQp38psGI0=;
        b=aCEWSgzDQv2KkpimXMq1xURh/EbiDypJHQevq6G8Or3b56wYkzDJZcqcacNJZJ/76E
         5Xu4Fwk2i+pcfAA5YDmoHI00BRYIxhKlTXMBoQZQc3oy87NbW7vOlQXeqNN1IIw2EFA/
         PB9OFBgDHZrIkQl0XK+ZEv/g9iUQtD3Ja2BYlgCo2bUMvKYw9NiOndnd4J1oL9Mo8w1g
         ZhIj7QhbpCDyX1Hgmn1HcUhIOlNJotzrPBOy0GmZRra4Obx7pLe0DnVPjPlyIAXLyPa1
         nP7oEvlMzOqrIuIe+LbHuQI5gwqusFliMQX8l/bhrB8DfJBWtp46cddhECkUOlWYv5rO
         DXjQ==
X-Gm-Message-State: AOAM5323Lla0x7WzdYcEmZCBYxt/bNAbwkeq8zv17HdYAzUiO4Pj+83v
        IVfLfLE4P/WgeLHKVFmQ/XPSIo3/uT0=
X-Google-Smtp-Source: ABdhPJzAmElP6ge2XbbXnt9ZEXgwMoNIiDtIECdeGNcSF7+SZZWXZ8GRDqCjy2tgWolDd9K7sk2Phw==
X-Received: by 2002:a17:902:7c98:b0:131:21fd:3717 with SMTP id y24-20020a1709027c9800b0013121fd3717mr5751373pll.53.1630432257576;
        Tue, 31 Aug 2021 10:50:57 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id y2sm3855533pjl.6.2021.08.31.10.50.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:50:57 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 05/24] x86/entry: Introduce __entry_text for entry code written in C
Date:   Wed,  1 Sep 2021 01:50:06 +0800
Message-Id: <20210831175025.27570-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Some entry code will be implemented in traps.c.  We need __entry_text
to set them in .entry.text section.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/traps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index f71db7934f90..ef07ae5fb3a0 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -69,6 +69,11 @@
 extern unsigned char native_irq_return_iret[];
 extern unsigned char asm_load_gs_index_gs_change[];
 
+/* Entry code written in C. Must be only used in traps.c */
+#define __entry_text							\
+	noinline notrace __attribute((__section__(".entry.text")))	\
+	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+
 #else
 #include <asm/processor-flags.h>
 #include <asm/setup.h>
-- 
2.19.1.6.gb485710b

