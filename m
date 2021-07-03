Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154903BA944
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhGCPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 11:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhGCPiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 11:38:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00C9D6191F;
        Sat,  3 Jul 2021 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625326537;
        bh=BGau3C2faHAUS46desgOXcNYKVB792JQpCpQM4+fhnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3DosoVE6TVhnleSh+IOzwn+Nq6MkCjQoyvabppXYYfTNLbITAh2xWBhfPGsLnco3
         P2tuN5EcarvyvuynH/QLkfrgogffqjYaOn2bXuFxSTqX0znOw42FXLGia41zwR5JK2
         5ItHHouRFjBRUQpPukx1ymxjDFN7+AWbuYGPa5hQSuKrEk/sKSJVjeujupefAb4cxe
         sQGRksDM0R3j5fQcGpBMXwymPHD1Qtjv0fkjbz03I7I+czTE7Hh5TFGQ7jHnZ4CKUp
         uR+PESsX5sDBtFYSNhQAwkGCfPIcdzuZTYA6vt2MWTqNPoQ5eK4ChMUGb12b6oMCi9
         asd6/QnvIR0Ng==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf probe: Do not show @plt function by default
Date:   Sun,  4 Jul 2021 00:35:34 +0900
Message-Id: <162532653450.393143.12621329879630677469.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162532651032.393143.4602033845482295575.stgit@devnote2>
References: <162532651032.393143.4602033845482295575.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhriamat@kernel.org>

Fix the perf-probe --functions option do not show the PLT
stub symbols (*@plt) by default.

  -----
  $ ./perf probe -x /usr/lib64/libc-2.33.so -F | head
  a64l
  abort
  abs
  accept
  accept4
  access
  acct
  addmntent
  addseverity
  adjtime
  -----

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Masami Hiramatsu <mhriamat@kernel.org>
---
 tools/perf/builtin-probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 2bfd41df621c..e1dd51f2874b 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -31,7 +31,7 @@
 #include <linux/zalloc.h>
 
 #define DEFAULT_VAR_FILTER "!__k???tab_* & !__crc_*"
-#define DEFAULT_FUNC_FILTER "!_*"
+#define DEFAULT_FUNC_FILTER "!_* & !*@plt"
 #define DEFAULT_LIST_FILTER "*"
 
 /* Session management structure */

