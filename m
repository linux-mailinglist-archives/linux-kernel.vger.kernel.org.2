Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1038A34F25D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhC3UoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhC3UoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:44:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0267CC061574;
        Tue, 30 Mar 2021 13:44:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c204so12971657pfc.4;
        Tue, 30 Mar 2021 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ikt8x9vsRo6fslY+KskypKUYg47GoKmKr0e0fK5lyqs=;
        b=JOV+dSI+6xbFizW0GgAZEadJ7Yl6usRyPRvG8pEMD4usKP+v2u2XOL9I5igrHZ+4Ux
         NuwtPUVfHV44u4dlDxgGdRggIolexZp8vx5fwUXRT6ElTZZ7LyLXCcSu2ZhOuYQw1luW
         8ioLGidpIcdruYRWThFp5pkaUrgrd/ECMlam+UKE85BHzcmdLTt6Af5kTsvUPmJRWgI7
         9E7OjOYrKdUlYjdjuOB08X9y3IlfyCJBZkzkmAC+KR6N6JPH6HXSbUeiQ8c9kSyyX/LN
         yp9pwtsX6/L3wcGODP77YSHph3ZDvoGTuhqRN7cB68wam9MNCWyTxoVKeE5bsJ8U3V0p
         dI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ikt8x9vsRo6fslY+KskypKUYg47GoKmKr0e0fK5lyqs=;
        b=Te2iUjVkT+Pr8qoFScuTV5AfqU05JTUzwwRxa0ZRTNN/skK/7Z052i1wGerJD7pqZu
         TaHSK8gsSCWEkEw9Yf/9ZSGpamcUOwgJ9k8Lvihmv1KpM5QZmgp3OXfMNioMErJb0ca8
         lfSZaT3y5jfy84BhqgVc+jdzp7j0bAB9fqZhPXfmiQiMCdiLDpT7hdFsWgbRdrvX+jAI
         zp7AAGdPjbSGQJWdQG0hyGcvq6Muasn08P8Q97w3y4nYC0EIZrj8n41GO9Vva8QvGWnY
         xpcs0tL2w0G+Pjfpl/gvXbfSrcm6rEOd6beWrNgH3HR/y7irGYbAMCbni3cEWUm9FeRZ
         WI3w==
X-Gm-Message-State: AOAM531HlLwgX9e+4mGVDAB+U8hJKginEE60Xwb4G7xVTyoVHZvJ0Hzo
        TlOeHAQxyxPfJsEekmvVaAA=
X-Google-Smtp-Source: ABdhPJxXNIpzrMiiqr0IM1h/qYcKH97qDHg9IAvuD6XcLfhFJZwojDnKm64sW/vAW7w6ew4gvOOI3Q==
X-Received: by 2002:a63:81:: with SMTP id 123mr29439711pga.307.1617137055341;
        Tue, 30 Mar 2021 13:44:15 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:d1c0:d79d:e260:a650])
        by smtp.googlemail.com with ESMTPSA id b140sm21677434pfb.98.2021.03.30.13.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 13:44:14 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     linux@armlinux.org.uk
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mach-sa1100: fix incorrect kernel-doc comment syntax in file
Date:   Wed, 31 Mar 2021 02:14:07 +0530
Message-Id: <20210330204407.25690-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for arch/arm/mach-sa1100/jornada720_ssp.c follows this syntax,
but the content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes these warnings from kernel-doc:
"warning: Function parameter or member 'jornada_ssp_lock' not described in 'DEFINE_SPINLOCK'"
"warning: expecting prototype for mac(). Prototype was for DEFINE_SPINLOCK() instead"

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210326

 arch/arm/mach-sa1100/jornada720_ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
index 1dbe98948ce3..148bcee3ee58 100644
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  *  arch/arm/mac-sa1100/jornada720_ssp.c
  *
  *  Copyright (C) 2006/2007 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
-- 
2.17.1

