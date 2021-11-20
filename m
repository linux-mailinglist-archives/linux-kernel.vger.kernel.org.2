Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1412457EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbhKTNFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbhKTNEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB64C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:37 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p18so10928946wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWoUinWaSv2kv88O+T+YjDaOXh1PTVnzHG5ig0dJX4s=;
        b=R4xlBHGDCy6bp60WV+2YPPDlFmuVNmkF9sMONZoOQ0AZvr3obr03NP1I60RA4rBBpd
         l9txJq0z9MRcYMHqUj+I5g98voeeuCGlDjuKkisjEWIUJ4xTuacQin5Q8XDT2fpU8/Ju
         eXUwXuADijKrCTsOAuucpmX1MPg2TEZxkSIrIyOWL+qcMiqeUOqX8JI/4sZWfxRl0VlL
         Znk+b49pdTFZDcVmyjGUlspwFKgPkce9nMmzqYojOilA1HzwYdNncKBWbkpsmoePUbYc
         OWU36WXgCSzzITsJobnKlRg2wMGIgvtNSaoFqjAtIM6DqUv3YvBAteQxWBEXd8AWLsiI
         uopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWoUinWaSv2kv88O+T+YjDaOXh1PTVnzHG5ig0dJX4s=;
        b=bgNCpqNH+Iu5goHKG/1w7F8F7Zpx78H/BLG2pFtG+mkATQKOJgV6GLA9f13sLEpBu7
         6m40ROSqb4ii7zwiMECgr+UahKm/XyRWf8gB/WNg/oE/c9PBcmVwAJE4Ezupm1hXA0u8
         t6c/FB9I7GC5Z4j4uV0Gpp5F4z78xO4bCz95j9MhPSSAEVQxAjmNS7bpqLeYgz4xIiDS
         DJx/rjrKbn2m2p7F7fYvjTLDb+mFnAduOitOGkKGTsy9gTJCbEj9RKe7aqFWObFfcdEH
         2J1THk6UsvEAUR9b7JA/3ieWK0AYhbSOnQBmhSse3Cd+7aaQ+kJY7+JAqDjso347tQ2D
         G0+w==
X-Gm-Message-State: AOAM5312o2bihUrWGoghnU4G0j/9wiTtEKqmop0FqoCQ1WbNRw0fSA0V
        DbywQOvmZbsN9ZKqx0gocp68kg5N4sJs+w==
X-Google-Smtp-Source: ABdhPJz8YvpNqajqYhyvGW99UNwyoMx5OpbAg4NLGTQ7LUgzdIZXLCJuJWQYohfq2b9NEMs/HKF3EA==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr9766750wme.116.1637413295795;
        Sat, 20 Nov 2021 05:01:35 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:35 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 18/20] linux/power_of_2.h: Add __IS_POWER_OF_2(n) and __IS_POWER_OF_2_OR_0(n) macros
Date:   Sat, 20 Nov 2021 14:01:02 +0100
Message-Id: <20211120130104.185699-20-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested:

$ cat pow2.c
 #include <stdio.h>

 #define is_power_of_2_or_0(n)  (((n) & ((n) - 1)) == 0)
 #define is_power_of_2(n)       (is_power_of_2_or_0(n) && ((n) != 0))

int main(void)
{
	printf("%i, %i, %i\n", 8, is_power_of_2_or_0(8), is_power_of_2(8));
	printf("%i, %i, %i\n", 7, is_power_of_2_or_0(7), is_power_of_2(7));
	printf("%i, %i, %i\n", 6, is_power_of_2_or_0(6), is_power_of_2(6));
	printf("%i, %i, %i\n", 5, is_power_of_2_or_0(5), is_power_of_2(5));
	printf("%i, %i, %i\n", 4, is_power_of_2_or_0(4), is_power_of_2(4));
	printf("%i, %i, %i\n", 3, is_power_of_2_or_0(3), is_power_of_2(3));
	printf("%i, %i, %i\n", 2, is_power_of_2_or_0(2), is_power_of_2(2));
	printf("%i, %i, %i\n", 1, is_power_of_2_or_0(1), is_power_of_2(1));
	printf("%i, %i, %i\n", 0, is_power_of_2_or_0(0), is_power_of_2(0));
}

$ cc pow2.c
$ ./a.out
8, 1, 1
7, 0, 0
6, 0, 0
5, 0, 0
4, 1, 1
3, 0, 0
2, 1, 1
1, 1, 1
0, 1, 0

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/power_of_2.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 include/linux/power_of_2.h

diff --git a/include/linux/power_of_2.h b/include/linux/power_of_2.h
new file mode 100644
index 000000000000..812fe86eefcd
--- /dev/null
+++ b/include/linux/power_of_2.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_POWER_OF_2_H
+#define _LINUX_POWER_OF_2_H
+
+
+#define __IS_POWER_OF_2_OR_0(n)  (((n) & ((n) - 1)) == 0)
+#define __IS_POWER_OF_2(n)       (__IS_POWER_OF_2_OR_0(n) && ((n) != 0))
+
+
+#endif	/* _LINUX_POWER_OF_2_H */
-- 
2.33.1

