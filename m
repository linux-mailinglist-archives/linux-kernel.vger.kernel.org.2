Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC04D34AED7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCZS4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhCZS4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:56:08 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264A0C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:56:08 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id d12so6626633oiw.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWdyboS1c42dWfZLLx4PpC5NvuwH2pvCjrUIV8KIgkE=;
        b=oi59r0kr8HL57RAuiy9QxrrxKMMSl6heCaZFti3hDzs/+Fw47VoHCFs3Le9xddxXrl
         T1KZsLFZkqL4CpwboP+OYT+0UQjQGgkbsjrq5VTgdrGJmxaZNvRIy3FGVW61xAFUZib3
         XLEX9KHSKemOiWNz6jWnqxbAiBDjcEFKrw2P+dQRBYXfcqGaoXyuxwreumfUaJYBb87o
         EgbGj8fjhkaNMvZLnbZFKqcPTw04taRZUdlDmVZTZjSkflAS/DeTjtkNBfazH3yxcCw3
         OzIvS1qgHAsaaxkNncHzECP0BZk1Rk1P3yv44EwP7kyGKjMhbHJTPx2Xekg5wnzHp5Ae
         uqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OWdyboS1c42dWfZLLx4PpC5NvuwH2pvCjrUIV8KIgkE=;
        b=h8hJdhuZaQ/vTx/HP4ymID7DhMvKWmP3x0zwkh3w7vzvJslzt48iumImFn9DG5Nfbn
         WPNMVDj+cWlP23CyeFBbfvmhAtiOgl9/nQYyuQeT/8k4iE+2qKGnwLFMtVJmAvwz7Js5
         ibDJgFgChRTZ+xEr0empiVbvHXAszX2sVAbkDIpIfDPVjY/LaoSe8/dyhqo4R9+hSAiG
         vrGRbgm579+UEO3N8DVe2aYqNlZ0PQ/Y01yU1ivPIho5oXGmgOW0FHXy1HGKMdZLKUub
         QMKyZRKT4Nrq9b44o3LLWjqvV8gdbKFJLZ0/Gq6M+65Y9rLzr9jFzsuDn+90kA/aiPev
         gnFQ==
X-Gm-Message-State: AOAM531+QeaxC94XWXWjhE5Y3E1Hr87sSw+dSQEbbM+bnH6GdHp6iGJ7
        C4OgHYJMr4wN62Md6GDcfxk=
X-Google-Smtp-Source: ABdhPJx4dFHvvRZMMzF3HkubZ+Ut9TIrrJyPE5bsD5OvcCSNZEPXxlqopXsKdKOhXYJdnE0Qi86UtA==
X-Received: by 2002:aca:cf44:: with SMTP id f65mr2520344oig.13.1616784967515;
        Fri, 26 Mar 2021 11:56:07 -0700 (PDT)
Received: from kde-neon-desktop.orld.fl.wtsky.net ([208.64.158.251])
        by smtp.gmail.com with ESMTPSA id i3sm2056423oov.2.2021.03.26.11.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 11:56:07 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     ley.foon.tan@intel.com
Cc:     linux-kernel@vger.kernel.org, fazilyildiran@gmail.com
Subject: [PATCH] arch: nios2: fix unmet dependency for SERIAL_CORE_CONSOLE
Date:   Fri, 26 Mar 2021 14:55:54 -0400
Message-Id: <20210326185554.30993-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When EARLY_PRINTK is enabled and TTY is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for SERIAL_CORE_CONSOLE
  Depends on [n]: TTY [=n] && HAS_IOMEM [=y]
  Selected by [y]:
  - EARLY_PRINTK [=y]

This is because EARLY_PRINTK selects SERIAL_CORE_CONSOLE
without selecting or depending on TTY, despite
SERIAL_CORE_CONSOLE depending on TTY.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/nios2/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
index a8bc06e96ef5..f453d5c1fd38 100644
--- a/arch/nios2/Kconfig.debug
+++ b/arch/nios2/Kconfig.debug
@@ -3,6 +3,7 @@
 config EARLY_PRINTK
 	bool "Activate early kernel debugging"
 	default y
+	depends on TTY
 	select SERIAL_CORE_CONSOLE
 	help
 	  Enable early printk on console
-- 
2.25.1

