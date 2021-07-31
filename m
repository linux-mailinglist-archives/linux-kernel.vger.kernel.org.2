Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABFF3DC382
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 07:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhGaFXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 01:23:43 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:28797 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhGaFXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 01:23:41 -0400
Received: from localhost.localdomain ([133.106.57.58]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 16V5MZEJ012804;
        Sat, 31 Jul 2021 14:22:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 16V5MZEJ012804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627708964;
        bh=O51ucNk/DyXX316Webqd+/JWqyztTjxUNjBg3BdRBv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgrNOboKFopfEZybZI+WcwraZOHKA7QEjOY4I+FHcLbaHMhCHjSt8Iu8Vg/buQT2v
         2zMGyxoRCrBMV6zjEIR5wjMhgMgesUNGmsf+Bw6OryEdPFwsVjYPAmyjcnrX5sisNy
         hQpEutIFJ4PCMxMk2eaPfGZyvsKfkzZBpfFVU7nAOoOD7f71T+8Bu39JP/v7UE0xXL
         5e7W1MRpIfGHLq4P4wbMaK31MFiBKpHIVz/NwJqsxpZHX0udakrzQ/ikvej9O8+aUr
         c9pMpRihvl5/N5fSvFBcXXKxmu+kSof+L+Ec+UU1CuzmEyCCb65cclYiBS+VyGvCaO
         tVDmAW/ZGPi6Q==
X-Nifty-SrcIP: [133.106.57.58]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] trace: remove redundant dependency from IRQSOFF_TRACER
Date:   Sat, 31 Jul 2021 14:22:33 +0900
Message-Id: <20210731052233.4703-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210731052233.4703-1-masahiroy@kernel.org>
References: <20210731052233.4703-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQSOFF_TRACE is already guarded by a stronger condition,
TRACING_SUPPORT.

'depends on TRACE_IRQFLAGS_SUPPORT' is redundant.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/trace/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 9d3f918b5867..b39e67db644e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -265,7 +265,6 @@ config TRACE_PREEMPT_TOGGLE
 config IRQSOFF_TRACER
 	bool "Interrupts-off Latency Tracer"
 	default n
-	depends on TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS
 	select GENERIC_TRACER
 	select TRACER_MAX_TRACE
-- 
2.27.0

