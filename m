Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D687D32DA11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhCDTHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:07:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237800AbhCDTH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:07:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E85764F73;
        Thu,  4 Mar 2021 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614884774;
        bh=aFKUH0krluhOoaCz52J3tQyV7plfsO/cehhJwNOfKq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENINXNEyIy6I/ZUhjh43mh2IEjQi8cyXnPYnYJnVlwf8tLKGgKWKrsuzzIDHhpZGU
         A/tBpy+ayLdUWpZJ2gMAADDhSWouB8zxvQGobbofu52s3I9HOPlijc/EpQzXAl+Pno
         IznOrEhHq/DbNxMq0kZn8DSxccnie5BV+zYFaW6x3Gx3Wt6U08cyFvEqzPwAqQ9GqK
         rKvk/TuXi1W1am3DTIFF8XdON7r8ZQoGGsNEtsaZRL5n8B2bw29InYHAoKHn5V1LQq
         rAASBhyklBOIgey6aUCvLJony1UHPWfJcH0dcMPbQ/amlCjveHsLu4s/lAlLrAHgea
         goo1vpGRxRgKw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 08/11] entry: Make CONFIG_DEBUG_ENTRY available outside x86
Date:   Thu,  4 Mar 2021 11:06:01 -0800
Message-Id: <d5b13da88adf4e732a07fe709263e572cb5ca8de.1614884673.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614884673.git.luto@kernel.org>
References: <cover.1614884673.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In principle, the generic entry code is generic, and the goal is to use it
in many architectures once it settles down more.  Move CONFIG_DEBUG_ENTRY
to the generic config so that it can be used in the generic entry code and
not just in arch/x86.

Disable it on arm64.  arm64 uses some but not all of the kentry
code, and trying to debug the resulting state machine will be painful.
arm64 can turn it back on when it starts using the entire generic
path.

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
index 7937265ef879..76549c8afa8a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1411,6 +1411,17 @@ config CSD_LOCK_WAIT_DEBUG
 
 endmenu # lock debugging
 
+config DEBUG_ENTRY
+	bool "Debug low-level entry code"
+	depends on DEBUG_KERNEL
+	depends on !ARM64
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
2.29.2

