Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C724F3CED79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384860AbhGSSij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:38:39 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:33552 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383807AbhGSSLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:11:30 -0400
Received: by mail-ej1-f47.google.com with SMTP id bu12so30520289ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fJcg77fkN9975oTUE4LNPWB7ZTJgrFp5GEAXqgIgBp8=;
        b=rOCHsGUbwHgVwaFofQnQ35Knv6YewC+yII6QhoaDKr4cGpz2zy8kgX4yYI89ajwxVM
         xIlni2tsJf6mkx40m20IOk+atYdDnnmQOgDOR69sTzZg8ECh8vKKV3uoZznlWiE3lH4d
         gr22wcLqbYhxGnhdzvlwpd/xbla4ZENkFvVhw9jqbPojk6bO2JKEZtN62/TR7WR2QgVR
         ot83gQzC++Hd4gS7hTAfCPNxoBUh5+ePFCss9vAd+3QSYj6bRvm/WRsM1Cwv1XkviqfS
         Z1KuhbtEkBuZJ7hGEcmE7dtS1GesTMJf8sRqulmrd1Sz/TjXEOCqcEkFVG4HhWb7NnkC
         z9XQ==
X-Gm-Message-State: AOAM533YrxcYNsTVBQP8gaxcr/h1In9LuEycyiAh0gLqk4GPHZgImbLG
        AlERYqYpJJBPis7U8l/Weu0e5t257oQ=
X-Google-Smtp-Source: ABdhPJw4hFoC7EQoPs0i5IamhPt4gQiBFVr8uJdT2WzMpqVV8rIBhqdpgQaH/g5J8HGNyqDj9XOP1w==
X-Received: by 2002:a17:906:2413:: with SMTP id z19mr28082455eja.215.1626720728519;
        Mon, 19 Jul 2021 11:52:08 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-95-250-115-52.retail.telecomitalia.it. [95.250.115.52])
        by smtp.gmail.com with ESMTPSA id g3sm6217408ejp.2.2021.07.19.11.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:52:07 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/test_string.c: move string selftest in the Runtime Testing menu
Date:   Mon, 19 Jul 2021 20:51:58 +0200
Message-Id: <20210719185158.190371-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

STRING_SELFTEST is presented in the "Library routines" menu.
Move it in Kernel hacking > Kernel Testing and Coverage > Runtime Testing
together with other similar tests found in lib/

	--- Runtime Testing
	<*>   Test functions located in the hexdump module at runtime
	<*>   Test string functions (NEW)
	<*>   Test functions located in the string_helpers module at runtime
	<*>   Test strscpy*() family of functions at runtime
	<*>   Test kstrto*() family of functions at runtime
	<*>   Test printf() family of functions at runtime
	<*>   Test scanf() family of functions at runtime

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 lib/Kconfig       | 3 ---
 lib/Kconfig.debug | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index d241fe476fda..5c9c0687f76d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -683,9 +683,6 @@ config PARMAN
 config OBJAGG
 	tristate "objagg" if COMPILE_TEST
 
-config STRING_SELFTEST
-	tristate "Test string functions"
-
 endmenu
 
 config GENERIC_IOREMAP
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 831212722924..5ddd575159fb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2180,6 +2180,9 @@ config ASYNC_RAID6_TEST
 config TEST_HEXDUMP
 	tristate "Test functions located in the hexdump module at runtime"
 
+config STRING_SELFTEST
+	tristate "Test string functions at runtime"
+
 config TEST_STRING_HELPERS
 	tristate "Test functions located in the string_helpers module at runtime"
 
-- 
2.31.1

