Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D494D3A4849
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFKSFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhFKSFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA57C0613A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:02:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so5975917wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXl1KSAWalKHypWMK2Rv+QZUIbpb6VTOkcajVQ0qe6M=;
        b=GhJOdbdXoOCpFLXkze0+tXd2EkphxUhEAoYS+A3lSV3zTiiK64MauNDi1/0k9XfG/M
         Yg+YQADsDiJQstgkcwcKPyLslPY2pUlY8UvVy+taVcKv36a1Jtrf+BTfMtVDvbEB3Dj3
         aXwu1rNTtk5RLYuonjgGLzFp4T513qUvyzJanDzWNGDgCXXdPjXyVqvSjI2txTVdIq4Y
         ElPy9ilG6PuZZnZz1XC9AHf0z2gxlwlplG+sC188WiMfB8iagaU+bS+jC/vyjMzmEMKa
         DmCvmTX/PIWbanWNYWaBYcq68NTP07cW05eu5+7L7IeQiztoO8RR8eMZW0twPk1zKPy7
         m7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXl1KSAWalKHypWMK2Rv+QZUIbpb6VTOkcajVQ0qe6M=;
        b=ubX+X/MA7XkwDEFG3O0/h0m9extqXbSaXDeSE07P3UbOTn/D/B2A6EC7fhP47DbBrl
         p0aYHbEfhxKvW7PfwRofD4sXDW4XCgjirkjgX5zEmdTUUr57ZOQOfFqMuxCxOT07JxtQ
         UQxpRUKqWH+/Bz76FJ9GDuRBBobSqbKfz485flKdk9THAKLMkk+YEYQ6MdviTW1ucRZc
         QJn4o9w0WW/QzM9nbY4NirUkFXmQf4+uhR3uykAB7Cndba9LOj+iPfyuxdmmzWgILd9Z
         nHtbqrYWuC1h+OxMUIpTadbKCiEuu0PdA466yph1uO/BKUvyagWsGrd2Ne+wHeiF3oca
         zsIg==
X-Gm-Message-State: AOAM530AT08k0C7jPTgldvto0LXoeFFBiqub/dpNz514bs30SFzZKUJA
        dNs0gZ0SBuL0xiHT+J7PmWeNa2tag9CO31jV
X-Google-Smtp-Source: ABdhPJyV44X34c0kkYHD5u2p0DOY6xXJbSq2O0QsULdydqaONPZQKkBYTJ79M5CvwQ4F6QN6ylikww==
X-Received: by 2002:a1c:a54b:: with SMTP id o72mr5066811wme.124.1623434577968;
        Fri, 11 Jun 2021 11:02:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:02:57 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH v3 06/23] elf: Remove compat_arch_setup_additional_pages()
Date:   Fri, 11 Jun 2021 19:02:25 +0100
Message-Id: <20210611180242.711399-7-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users rely on detecting bitness of the task by checking
in_compat_syscall(), remove compat_arch_setup_additional_pages() macro,
simplifying the code.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/compat_binfmt_elf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index fad63a4f842e..0d1aedc3bbf0 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -110,11 +110,6 @@
 #define START_THREAD		COMPAT_START_THREAD
 #endif
 
-#ifdef	compat_arch_setup_additional_pages
-#undef	arch_setup_additional_pages
-#define	arch_setup_additional_pages compat_arch_setup_additional_pages
-#endif
-
 #ifdef	compat_elf_read_implies_exec
 #undef	elf_read_implies_exec
 #define	elf_read_implies_exec compat_elf_read_implies_exec
-- 
2.31.1

