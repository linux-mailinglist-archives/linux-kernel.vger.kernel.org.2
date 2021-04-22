Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A253686DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhDVS7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVS7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:59:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:58:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n2so70318119ejy.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=WJ2IsadrDx9PnxmH2ewloOiW+yg8182FU18NrR5hDAU=;
        b=MTjfL02wUNxLz+kZ9maymdmi1cHU5YYnOR3trLr+MguJtVF7RN+Repx08bHTcY9ZO7
         /ppQllAnoR5bTmcVyTzW15RfkWNlq3iTZahg0xXWShVrGU3CMAyaViYlRk75LRCWi039
         sRITa0VhIH5MKEYuOi1ieKJXsPW7Fih0EuQaa5AxLThrbpALOs+ug88pWpYLovDiJHCv
         amkfjMNZffLiei2B9JrrCi6cNaYLk+P4pMKF3NgINHmUXh8ybeIUhWJCGJH8/NzxR9iy
         fsYlli+000t2q2D+XvrabgCZE8cY+E6ge0KlziGfoMuTTUB7dwrDs54l7Jat6n4Tnjsf
         8YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WJ2IsadrDx9PnxmH2ewloOiW+yg8182FU18NrR5hDAU=;
        b=TdHTSSeYvexZJYHq1BLDw/na5eGOeshAmogvnaryIQKp6ROMjb+Qh4LfAInIGm+Tk1
         td23AwwHT/0K5IHFKHiS9yATZ6poamB6ZiUCWuyd8JKlmsxKqnFoJJxQg1qvv6h+w1Mm
         9X8PQEEhmQfKF0pwPXE64mWSkdcvMoDJTubinkRx4du7cY3yXBvBVmKfyABvL6LxHwzA
         KItktpEuNMiPykt2IgTaQ4R+K/2/ZhUWVq2bEQidVQNZcBvjD6g0Fp2bxPMTJXUI+iM5
         kDusmv0/aLAFDPC0FEPCsIpqwv4IAsoxzD7r3Q0t4KClIm6DguhxXLRn5WsuHg7y0a/s
         FvZw==
X-Gm-Message-State: AOAM531+sxWwXSu5z3EB/wY8XTMcFe0xM36de5OjzF9+WyCaAkJCWbeC
        a5e8ewGbKRQeyaCy1eU0VA==
X-Google-Smtp-Source: ABdhPJyIbGJ8vnd+lPVe/Lx6r9907kDJM0rGfZA5Ua7sJ2LWqJmlLHaC3f1aOCRHY0CqG0TtzoCbaA==
X-Received: by 2002:a17:906:a10e:: with SMTP id t14mr103328ejy.103.1619117922234;
        Thu, 22 Apr 2021 11:58:42 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.145])
        by smtp.gmail.com with ESMTPSA id y11sm2887966eds.10.2021.04.22.11.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 11:58:41 -0700 (PDT)
Date:   Thu, 22 Apr 2021 21:58:40 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: delete UD0, UD1 traces
Message-ID: <YIHHYNKbiSf5N7+o@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both instructions aren't used by kernel.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/bug.h |    9 ---------
 1 file changed, 9 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -7,18 +7,9 @@
 
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
- *
- * Since various instruction decoders/specs disagree on the encoding of
- * UD0/UD1.
  */
-
-#define ASM_UD0		".byte 0x0f, 0xff" /* + ModRM (for Intel) */
-#define ASM_UD1		".byte 0x0f, 0xb9" /* + ModRM */
 #define ASM_UD2		".byte 0x0f, 0x0b"
-
-#define INSN_UD0	0xff0f
 #define INSN_UD2	0x0b0f
-
 #define LEN_UD2		2
 
 #ifdef CONFIG_GENERIC_BUG
