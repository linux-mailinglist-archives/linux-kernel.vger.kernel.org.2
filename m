Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1811F376501
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhEGMVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEGMVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:21:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 862746144F;
        Fri,  7 May 2021 12:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620390045;
        bh=+UDEkNthDyGtOTchh5vC4lABQ4yWmQP1bEakFLVxwqA=;
        h=From:To:Cc:Subject:Date:From;
        b=MbqFpogPuHpoSOYx5L+TYLP/gBK2PW4sjx96WeYJoujBi7bdXbYX01kKDiAC/GPD9
         DLtrqzWrigSSoIzGxB8DdvDiYyUjwEhDa8B6hnBpkd/N+NpQJ6nWlkqJtKrcXVZ45M
         uZdqldj0c5tYEwruktElmk/ysc76vPeIZ+BFSRD1mBlBQDBUQCHvlGR9I8lD10e0Ph
         nS6/KZC8nFYKXlol/QJ7lhG6Oul0jgvd9zbWWNjTxK/PRgV751384pZklx6iXDrEiN
         5KfKu7aDADwP47esOLMeGYP7yFPIUZmAR91PhRMxUABomBZaRgNg/mRVFPtxhVG6Db
         HUiVgYHOReyxg==
From:   Jessica Yu <jeyu@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] ARM: module: treat exit sections the same as init sections when !CONFIG_MODULE_UNLOAD
Date:   Fri,  7 May 2021 14:13:22 +0200
Message-Id: <20210507121322.6441-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic code patching (alternatives, jump_label and static_call) can
have sites in __exit code, even if __exit is never executed. Therefore
__exit must be present at runtime, at least for as long as __init code is.

Additionally, for jump_label and static_call, the __exit sites must also
identify as within_module_init(), such that the infrastructure is aware
to never touch them after module init -- alternatives are only ran once
at init and hence don't have this particular constraint.

Previously, the module loader never loaded the exit sections in the first
place when CONFIG_MODULE_UNLOAD=n. Commit 33121347fb1c ("module: treat exit
sections the same as init sections when !CONFIG_MODULE_UNLOAD") addressed
the issue by having the module loader load the exit sections and then making
__exit identify as __init for !MODULE_UNLOAD. Then, since they are treated
like init sections, they will be also discarded after init.

That commit satisfied the above requirements for jump_labels and
static_calls by modifying the checks in the core module_init_section()
function in kernel/module.c to include exit sections. However, ARM
overrides these and implements their own module_{init,exit}_section()
functions. Add a similar check for exit sections to ARM's
module_init_section() function so that all arches are on the same page.

Fixes: 33121347fb1c ("module: treat exit sections the same as init
sections when !CONFIG_MODULE_UNLOAD")
Link: https://lore.kernel.org/lkml/YFiuphGw0RKehWsQ@gunter/
Link: https://lore.kernel.org/r/20210323142756.11443-1-jeyu@kernel.org
Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 arch/arm/kernel/module.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index beac45e89ba6..9d403fc1893b 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -56,9 +56,16 @@ void *module_alloc(unsigned long size)
 
 bool module_init_section(const char *name)
 {
+#ifndef CONFIG_MODULE_UNLOAD
+	return strstarts(name, ".init") ||
+		strstarts(name, ".ARM.extab.init") ||
+		strstarts(name, ".ARM.exidx.init") ||
+		module_exit_section(name);
+#else
 	return strstarts(name, ".init") ||
 		strstarts(name, ".ARM.extab.init") ||
 		strstarts(name, ".ARM.exidx.init");
+#endif
 }
 
 bool module_exit_section(const char *name)
-- 
2.31.1

