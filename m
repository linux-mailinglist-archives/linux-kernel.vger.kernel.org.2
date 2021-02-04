Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F1030F69F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhBDPmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237468AbhBDPkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:40:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08A5964F45;
        Thu,  4 Feb 2021 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612453173;
        bh=XTFLMa/UxoOM0Hs6QWQqKQ+VwM3an2Nk3IYqSINJUCg=;
        h=From:To:Cc:Subject:Date:From;
        b=kA7j7SlPHHthFW27pKp32Q2yWwvLaZEjkEkbcP3iu0QOGroxg69nI6fljDslp9eeW
         VMJOrBbJJHzrRKhwTSQwLBQk5XopFAqDH5VtCC7FLl4lGNGwh2mDG6vjF2P56sgQL8
         jkArptFqcjN1n3NqZgB2GQYQdoTonQks/ii5aZh0R2YBDju291le2vvxjK5GCf4uSM
         DIEnGHXr5ZLriSFfx8pvFYfUNQnmszj7ZFHpYIE4C8uGtBTqrlbOH+V7Y/JqNFlNnN
         +pZbMGwmZs8I31kcjNaICYPUWD9cI3+AeQKOlrSDELO7XUfTH+lHUmiryW8lIF4lAh
         4vo4yRtvympKw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ike Panhc <ike.pan@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nitin Joshi <njoshi1@lenovo.com>, Tom Rix <trix@redhat.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH] platform/x86: ideapad-laptop/thinkpad_acpi: mark conflicting symbols static
Date:   Thu,  4 Feb 2021 16:38:54 +0100
Message-Id: <20210204153924.1534813-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Three of the newly added functions are accidently not marked 'static' which
causes a warning when building with W=1

drivers/platform/x86/thinkpad_acpi.c:10081:5: warning: no previous prototype for function 'dytc_profile_get' [-Wmissing-prototypes]
drivers/platform/x86/thinkpad_acpi.c:10095:5: warning: no previous prototype for function 'dytc_cql_command' [-Wmissing-prototypes]
drivers/platform/x86/thinkpad_acpi.c:10133:5: warning: no previous prototype for function 'dytc_profile_set' [-Wmissing-prototypes]

The functions are also present in two files, causing a link error when
both are built into the kernel:

ld.lld: error: duplicate symbol: dytc_cql_command
>>> defined at ideapad-laptop.c
>>>            platform/x86/ideapad-laptop.o:(dytc_cql_command) in archive drivers/built-in.a
>>> defined at thinkpad_acpi.c
>>>            platform/x86/thinkpad_acpi.o:(.text+0x20) in archive drivers/built-in.a

ld.lld: error: duplicate symbol: dytc_profile_get
>>> defined at ideapad-laptop.c
>>>            platform/x86/ideapad-laptop.o:(dytc_profile_get) in archive drivers/built-in.a
>>> defined at thinkpad_acpi.c
>>>            platform/x86/thinkpad_acpi.o:(.text+0x0) in archive drivers/built-in.a

ld.lld: error: duplicate symbol: dytc_profile_set
>>> defined at ideapad-laptop.c
>>>            platform/x86/ideapad-laptop.o:(dytc_profile_set) in archive drivers/built-in.a
>>> defined at thinkpad_acpi.c
>>>            platform/x86/thinkpad_acpi.o:(.text+0x220) in archive drivers/built-in.a

Mark these all as static to avoid both problems.

Fixes: eabe533904cb ("platform/x86: ideapad-laptop: DYTC Platform profile support")
Fixes: c3bfcd4c6762 ("platform/x86: thinkpad_acpi: Add platform profile support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/ideapad-laptop.c | 11 ++++++-----
 drivers/platform/x86/thinkpad_acpi.c  | 10 +++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index cc42af2a0a98..6095a4d54881 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -656,8 +656,8 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
  * dytc_profile_get: Function to register with platform_profile
  * handler. Returns current platform profile.
  */
-int dytc_profile_get(struct platform_profile_handler *pprof,
-			enum platform_profile_option *profile)
+static int dytc_profile_get(struct platform_profile_handler *pprof,
+			    enum platform_profile_option *profile)
 {
 	struct ideapad_dytc_priv *dytc;
 
@@ -673,7 +673,8 @@ int dytc_profile_get(struct platform_profile_handler *pprof,
  *  - enable CQL
  *  If not in CQL mode, just run the command
  */
-int dytc_cql_command(struct ideapad_private *priv, int command, int *output)
+static int dytc_cql_command(struct ideapad_private *priv, int command,
+			    int *output)
 {
 	int err, cmd_err, dummy;
 	int cur_funcmode;
@@ -710,8 +711,8 @@ int dytc_cql_command(struct ideapad_private *priv, int command, int *output)
  * dytc_profile_set: Function to register with platform_profile
  * handler. Sets current platform profile.
  */
-int dytc_profile_set(struct platform_profile_handler *pprof,
-			enum platform_profile_option profile)
+static int dytc_profile_set(struct platform_profile_handler *pprof,
+			    enum platform_profile_option profile)
 {
 	struct ideapad_dytc_priv *dytc;
 	struct ideapad_private *priv;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 18b390153e7f..42e0a497d69e 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10078,8 +10078,8 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
  * dytc_profile_get: Function to register with platform_profile
  * handler. Returns current platform profile.
  */
-int dytc_profile_get(struct platform_profile_handler *pprof,
-			enum platform_profile_option *profile)
+static int dytc_profile_get(struct platform_profile_handler *pprof,
+			    enum platform_profile_option *profile)
 {
 	*profile = dytc_current_profile;
 	return 0;
@@ -10092,7 +10092,7 @@ int dytc_profile_get(struct platform_profile_handler *pprof,
  *  - enable CQL
  *  If not in CQL mode, just run the command
  */
-int dytc_cql_command(int command, int *output)
+static int dytc_cql_command(int command, int *output)
 {
 	int err, cmd_err, dummy;
 	int cur_funcmode;
@@ -10130,8 +10130,8 @@ int dytc_cql_command(int command, int *output)
  * dytc_profile_set: Function to register with platform_profile
  * handler. Sets current platform profile.
  */
-int dytc_profile_set(struct platform_profile_handler *pprof,
-			enum platform_profile_option profile)
+static int dytc_profile_set(struct platform_profile_handler *pprof,
+			    enum platform_profile_option profile)
 {
 	int output;
 	int err;
-- 
2.29.2

