Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93043B3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbhJZOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhJZOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:24:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08FC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:21:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m14so14480064pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+aBXblOzZqJuR0UK2CQdqjmBsiSpe5p02x8xalNLhY=;
        b=p0L6PhokxFBGsHOHyv5/prJS1buAFRF8i9pQpCPA54EjX/uYhGEC9am/gQ0xVS37Zr
         4W7shxOxldxplWRid56RPv6NQEF4mvey30srOtPbB/tMqbScYklf419+vrkgRfhCs6lG
         ai4wSsp8xbQ2vz49iHgGKxmVsnjJYPO/+1sgOeSFNLNny0GjUChtqy8OKNquiKv41OzJ
         6TFhZkRYQyGgT19GzCA6TJrpZ8SKDwYYO+8sYb8y8QgQztnbd9E5ttS+SejAQ4VAQ6G5
         GRRw/q3u4uM1msYCQwfGDaNun0LElFh0wgIcSKAt1CddyczE0qKWLuaYPULaaAzpg1lv
         4DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+aBXblOzZqJuR0UK2CQdqjmBsiSpe5p02x8xalNLhY=;
        b=YpM285BahiOJ2//W4sCeA1crqIAceDq7eGckrs7z7mzpR8Zu2XQ92Skx6XFZt8+KLk
         CljPu6E2TVGDEKUTHuqJgZPT7lyQGEYwT4Otdt7+n/L2Hwk7BghwxG+ZgHJePQHWOiXV
         3swGQ8+k5zzMgfHJ06vb291VeF/eDm2ZPsQUxVc4wgyCgkgSB1d4dXOhz2Q0vSg0okC5
         6ig/p5HaYmvluGZ+9NGcL90MGK7+24XnVBpxD4MsBUx3fHCwS2gUKaP2tpK34KvVTbfW
         WGKJMwVL8XGAdZjbn3aR5Y5HhVh0H92K8sZrJuWUEsVhci/KmSUBbb/qx7y9R/4C3lxA
         yq2Q==
X-Gm-Message-State: AOAM530JI1nYix48GDCv7oS4YOPKXNwGD4kdRVVOQhjprmPicxyq8bnh
        NzGdlUc33IrviNIzdnhEurH9BtRNHLE=
X-Google-Smtp-Source: ABdhPJx5pwXwVB0z4UdT9p0aONEAYfoCV4Yz7Vigmx5Kkvh41fNmy08UjsZNkidOxSBb0vEAGAxEOg==
X-Received: by 2002:a63:470b:: with SMTP id u11mr18939711pga.441.1635258112070;
        Tue, 26 Oct 2021 07:21:52 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id i13sm19553821pgf.77.2021.10.26.07.21.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:21:51 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V4 07/50] x86/entry: Introduce __entry_text for entry code written in C
Date:   Tue, 26 Oct 2021 22:20:15 +0800
Message-Id: <20211026142058.17702-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Some entry code will be implemented in C files.  __entry_text is needed
to set them in .entry.text section.  __entry_text disables instrumentation
like noinstr, but it doesn't disable stack protector since not all
compiler supported by kernel supporting function level granular
attribute to disable stack protector.  It will be disabled by C file
level.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..6779def97591 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,6 +11,9 @@
 
 #include <asm/irq_stack.h>
 
+/* Entry code written in C. */
+#define __entry_text __noinstr_section(".entry.text")
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
-- 
2.19.1.6.gb485710b

