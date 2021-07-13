Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00AE3C6F00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhGMKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:55:54 -0400
Received: from foss.arm.com ([217.140.110.172]:40732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235484AbhGMKzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:55:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C84681FB;
        Tue, 13 Jul 2021 03:53:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACD163F7D8;
        Tue, 13 Jul 2021 03:52:59 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 1/5] locking/atomic: simplify ifdef generation
Date:   Tue, 13 Jul 2021 11:52:49 +0100
Message-Id: <20210713105253.7615-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210713105253.7615-1-mark.rutland@arm.com>
References: <20210713105253.7615-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gen-atomic-fallback.sh's gen_proto_order_variants(), we generate some
ifdeferry with:

| local basename="${arch}${atomic}_${pfx}${name}${sfx}"
| ...
| printf "#ifdef ${basename}\n"
| ...
| printf "#endif /* ${arch}${atomic}_${pfx}${name}${sfx} */\n\n"

For clarity, use ${basename} for both sides, rather than open-coding the
string generation.

There is no change to any of the generated headers as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 scripts/atomic/gen-atomic-fallback.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 317a6cec76e1..2601ff4f9468 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -128,7 +128,7 @@ gen_proto_order_variants()
 	gen_basic_fallbacks "${basename}"
 
 	if [ ! -z "${template}" ]; then
-		printf "#endif /* ${arch}${atomic}_${pfx}${name}${sfx} */\n\n"
+		printf "#endif /* ${basename} */\n\n"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
-- 
2.11.0

