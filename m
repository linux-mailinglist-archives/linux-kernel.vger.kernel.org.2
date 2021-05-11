Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D0F37AA26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhEKPDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhEKPDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:03:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B030B61364;
        Tue, 11 May 2021 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620745358;
        bh=CuUERNm4Sl05/8TuXuLfVEgbKBAOLkUTkAapTI3XcOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuMJAmKg4N6ziSNl0Bat55g1n8CBKqV5u83Gieo81F3ScyXEJmGWICplH2GDy1la6
         +9IgXZHW9UI0Yg0g8OKI1DpcueQtUwAFRV7YZ0zqPuD9tyM1Idz1eBJnkvhYcAwdp5
         8rlG+ZkOY5cPAJaHv/GHkNyF2mopui9JKL3sV3YFjTKA1p+PtP2wtb1yeR6dffh6Uv
         ++Si6qjzLC6YqjAQtnJMsYmUoMg5oRxRaFomXX5teSowC6pCpzSpZZDauA2KaxsZsf
         +ooOy+5Yr0N9lOaRAyzQ8p6RVz+67aJYPFyoahXjsUVn5SRJrh3bkMM2v4HVY7d1I0
         oS/Y+nICD27aw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 1/2] perf build: Move EXTRA_CFLAGS and EXTRA_WARNINGS at the end of CFLAGS
Date:   Wed, 12 May 2021 00:02:34 +0900
Message-Id: <162074535428.289757.16452586688199107510.stgit@devnote2>
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

Move EXTRA_CFLAGS and EXTRA_WARNINGS at the end of CFLAGS so that
additional flags will be passed to the compiler correctly.

CFLAGS is composed by CORE_CFLAGS, INC_FLAGS, EXTRA_CFLAGS, and
EXTRA_WARNINGS in the following order;

CFLAGS = $EXTRA_CFLAGS $EXTRA_WARNINGS $CORE_CFLAGS $INC_FLAGS

But since CORE_CFLAGS includes "-Wall" and "-Wextra", the other -Wno-*
flags in EXTRA_CFLAGS and EXTRA_WARNINGS are overridden and ignored.

To fix this issue, move those EXTRA_* at the end of CFLAGS definition
as below.

CFLAGS = $CORE_CFLAGS $INC_FLAGS $EXTRA_CFLAGS $EXTRA_WARNINGS

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/Makefile.config |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 406a9519145e..2ad46c66bc7b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -16,7 +16,7 @@ $(shell printf "" > $(OUTPUT).config-detected)
 detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
-CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
+CFLAGS :=
 
 include $(srctree)/tools/scripts/Makefile.arch
 
@@ -340,6 +340,7 @@ INC_FLAGS += -I$(srctree)/tools/lib/
 CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
 CFLAGS   += $(CORE_CFLAGS) $(INC_FLAGS)
+CFLAGS   += $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 CXXFLAGS += $(INC_FLAGS)
 
 LIBPERF_CFLAGS := $(CORE_CFLAGS) $(EXTRA_CFLAGS)

