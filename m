Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C5A37AA27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhEKPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231643AbhEKPDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:03:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2B3E6128E;
        Tue, 11 May 2021 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620745367;
        bh=7M04momrw9UfAQbfxbhrWjXH0nHWhxJ4njod7fmbSSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFalfDVgviwdSWyP/kOSiuxcjZM7fPByc89K5MvaPBZ/ofbeP5vhMar8ywjDi7wS7
         FNOcInbdv53aHq6LM16iV42KN0ZLO3XSWDOykRaGEdtKkDMgk1jv4Gl5WvTBJkv+Sf
         IZ1XdB+dMHOFTD5IkiSW4j+I+LaK0o7dWrVgpNqV3P3AT8k0+4YeF+VFTKOL/w+ysa
         TpgbooqvezVd6v4itlSwxptuFZirHhEkU3gcTcbe6MNiFTGVG7MuzqKk3k8yXSaFkc
         hHM8/0FaUQQK/d291elony3InmFNgO15vpuEvmKGyqAgMlP+drW32+VB9XxJwiratu
         KyBBzEKjKMylg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/2] tools: Add -Wno-missing-field-initializers to for clang
Date:   Wed, 12 May 2021 00:02:43 +0900
Message-Id: <162074536334.289757.5292387320537578325.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162074534493.289757.1243545574686276554.stgit@devnote2>
References: <162074534493.289757.1243545574686276554.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since clang's -Wmissing-field-initializers warns valid syntax of
initializing data structure (e.g. initializing static data
structure with single NULL, the rest of fields are initialized
with zero), it is better to disable this warning option
for clang for now.
This can stop building perf because -Werror is also specified.

Note that same issue on gcc has been fixed in 4.7.0, so we don't need
this for gcc.

 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36750

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/scripts/Makefile.include |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index f9271f3ea912..4fd5d33ded03 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -89,6 +89,10 @@ ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
 endif
 
+ifneq ($(CC_NO_CLANG), 1)
+EXTRA_WARNINGS += -Wno-missing-field-initializers
+endif
+
 # Hack to avoid type-punned warnings on old systems such as RHEL5:
 # We should be changing CFLAGS and checking gcc version, but this
 # will do for now and keep the above -Wstrict-aliasing=3 in place

