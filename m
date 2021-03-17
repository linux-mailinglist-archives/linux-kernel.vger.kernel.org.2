Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2BC33F7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhCQSNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232947AbhCQSMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:12:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E7EC64F33;
        Wed, 17 Mar 2021 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616004775;
        bh=aQCDQuscj22XBDbdZ4BioqkQcmvtuU8v9wHZw4up+8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P704zTb0m4mJSI3Vmt+DRzBbt71UsGG9XNy/0ZQrY0NTvbNRVmDvxdIXF85FtUq3o
         8McEMa7KuL9d4aq/NMy2OXnw40LYEHnmSAR9JJuE2agBEHc3aHY3NjwFYCqgbg9xV0
         RtThZteOwwlWspwMqZCIlEUS1RUM5MjW/12bx9Yt2Xy6aoiS8c9YrJWzpNkuPqilak
         4C/eQhxFbdco+u2EAHP4M7lgMI3F9i2lfZHWVT/CBKggluGirafFTglGe9IsfKsh7N
         wXtEWytE4kYeeNATwgZHrCmVIFFcdVukiKksFCpfoaa5szVJ4kWsnzdu+L7ePtm0k6
         syxr2aK30iBSg==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 6/9] entry: Make CONFIG_DEBUG_ENTRY available outside x86
Date:   Wed, 17 Mar 2021 11:12:45 -0700
Message-Id: <958da625d20756dc37935685e5afe45a1313286c.1616004689.git.luto@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616004689.git.luto@kernel.org>
References: <cover.1616004689.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In principle, the generic entry code is generic, and the goal is to use it
in many architectures once it settles down more.  Move CONFIG_DEBUG_ENTRY
to the generic config so that it can be used in the generic entry code and
not just in arch/x86.

This currently depends on GENERIC_ENTRY.  If an architecture wants to use
DEBUG_ENTRY without using GENERIC_ENTRY, this could be changed.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/Kconfig.debug | 10 ----------
 lib/Kconfig.debug      | 11 +++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 80b57e7f4947..a5a52133730c 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -170,16 +170,6 @@ config CPA_DEBUG
 	help
 	  Do change_page_attr() self-tests every 30 seconds.
 
-config DEBUG_ENTRY
-	bool "Debug low-level entry code"
-	depends on DEBUG_KERNEL
-	help
-	  This option enables sanity checks in x86's low-level entry code.
-	  Some of these sanity checks may slow down kernel entries and
-	  exits or otherwise impact performance.
-
-	  If unsure, say N.
-
 config DEBUG_NMI_SELFTEST
 	bool "NMI Selftest"
 	depends on DEBUG_KERNEL && X86_LOCAL_APIC
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7937265ef879..927d913fd471 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1411,6 +1411,17 @@ config CSD_LOCK_WAIT_DEBUG
 
 endmenu # lock debugging
 
+config DEBUG_ENTRY
+	bool "Debug low-level entry code"
+	depends on DEBUG_KERNEL
+	depends on GENERIC_ENTRY
+	help
+	  This option enables sanity checks in the low-level entry code.
+	  Some of these sanity checks may slow down kernel entries and
+	  exits or otherwise impact performance.
+
+	  If unsure, say N.
+
 config TRACE_IRQFLAGS
 	depends on TRACE_IRQFLAGS_SUPPORT
 	bool
-- 
2.30.2

