Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289B637AA25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhEKPDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231681AbhEKPDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:03:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87F2261364;
        Tue, 11 May 2021 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620745349;
        bh=/XImDV5sgCmcBlCL4ysSJnszRrAvj/76UpKAEnMjGa8=;
        h=From:To:Cc:Subject:Date:From;
        b=onwPM+Yx3FyrCteLKMViH7ZZTgrDYpUTWxaXd+Hp+fZ6mxaCcK8Tkz/9GT7/apK4x
         2h4rgzhLJKwqcihYLfNVNtj07APEKwv1h5qAOZ5nN6htTNBDSdtqN/4Qm/QcDS08Px
         LaMVngrfqz72nxi8SDATxAuuof2ORBMrSF8QX2feTLogEtmvvfwr1NMjvV3iHIz+lk
         BwbH9aEKY+v8NMgEGYiIvjK1AmZ3aXwnmeHjD+JkkeVLJReHJwV5y2iCdnGqPPkKlJ
         tPSg5azA+jLdm4UFXq9gwH+l7MyVJx+PyvDZNanyxMKbavDIB0RDWUCwDKEqGODPDT
         mIym7w0wKa/Bw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 0/2] tools/perf: tools: Fix perf build issues
Date:   Wed, 12 May 2021 00:02:25 +0900
Message-Id: <162074534493.289757.1243545574686276554.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are the patches to fix the perf build issues which I reported in
the previous email.

https://lore.kernel.org/lkml/162037766527.94840.4323848545957010011.stgit@devnote2/

There are 2 issues I found and are fixed with these patches.

 - Since the EXTRA_CLFAGS/WARNINGS are listed before -Wall/-Wextra in
   CFLAGS, all -Wno-* flags in the EXTRA_CFLAGS/WARNINGS are ignored.
   This makes EXTRA_WARNINGS ignored and developers can not use EXTRA_CLFAGS
   for debugging compiler warnings.

 - Clang's missing-field-initializers warning is too sensitive compared
   with GCC. I think "{ NULL }" kind of syntax is allowed for simplify code.


Thank you,

---

Masami Hiramatsu (2):
      perf build: Move EXTRA_CFLAGS and EXTRA_WARNINGS at the end of CFLAGS
      tools: Add -Wno-missing-field-initializers to for clang


 tools/perf/Makefile.config     |    3 ++-
 tools/scripts/Makefile.include |    4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
