Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13062400C00
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhIDPzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 11:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237039AbhIDPzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 11:55:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A0B560F91;
        Sat,  4 Sep 2021 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630770887;
        bh=PH27WusL+aDFXxl8wFR61uAh4r429AC037WeHWMfjkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/Kse6O68lgK2KKGdMGFHSRCt2Fxx1V81EzqACe7QxxTqllzsur0ziCFArmAsfGOR
         hZRrEkvrLHoo01oFPiKEsAaiNrYEyDW2VHwIDJD4iqVXH75EJ9YcDuDBeGj00Dp492
         59l/U7IWxnhRZwol0E4Jwvp7/LLgcy2GXUgTBvFOtTE5b96saat5old2mw2+xwukM8
         nCHkmO1A5wsLsuejzySwM0e8wEggTWuDgdAOPDMnuQq+t0U/s0KDWXZDDIdzODPf2Q
         YGyG1M0pzmr/emCUEICYWLbQlFTDdiK10QG1nREtT9mZ1XE5rrB16uAAGy8os55eVe
         QQH88/Awun6wQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/6] tools/bootconfig: Show whole test command for each test case
Date:   Sun,  5 Sep 2021 00:54:46 +0900
Message-Id: <163077088607.222577.14786016266462495017.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163077084169.222577.4459698040375322439.stgit@devnote2>
References: <163077084169.222577.4459698040375322439.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show whole test command instead of only the 3rd argument.
This will clear to show what will be actually tested by
each test case.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/test-bootconfig.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index baed891d0ba4..f68e2e9eef8b 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -26,7 +26,7 @@ trap cleanup EXIT TERM
 NO=1
 
 xpass() { # pass test command
-  echo "test case $NO ($3)... "
+  echo "test case $NO ($*)... "
   if ! ($@ && echo "\t\t[OK]"); then
      echo "\t\t[NG]"; NG=$((NG + 1))
   fi
@@ -34,7 +34,7 @@ xpass() { # pass test command
 }
 
 xfail() { # fail test command
-  echo "test case $NO ($3)... "
+  echo "test case $NO ($*)... "
   if ! (! $@ && echo "\t\t[OK]"); then
      echo "\t\t[NG]"; NG=$((NG + 1))
   fi

