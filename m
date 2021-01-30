Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB47B3090DB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 01:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhA3AP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 19:15:27 -0500
Received: from ozlabs.org ([203.11.71.1]:34701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhA3APU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 19:15:20 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DSF7T3jhPz9ssD; Sat, 30 Jan 2021 11:14:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1611965653;
        bh=1MVppCoe/fli3aclVF7Dv+Kj2nJ7ONF6cN4JL7mmvxo=;
        h=From:To:Cc:Subject:Date:From;
        b=KgEm+63ZKWWr9V3Rg+NTSqClRVGQYGwbk1mi7wVoNorR2RYctDYOHuGX8cyRrx7N5
         gp0665so7Rfw3kh3sioiEl3WcDgs06aPkjcs5PCjimc8y1Z5f7Z6rp/GMRtI7JHloa
         XDA18fxDen9jZ0Tlm36vAHDd+52Y43TtMuGRjgK13ywis5m1Qh8AoH/IXFRW37m7GT
         d+V8Su3CtrvbIzK0cj2QfCAzm09ICGGQjKPq9AX+SoQL3rA98YWNkkn7DK797Nns6I
         siGonPFQkBHmywE8uKlFJFc2zgRP+xk0oPnx43lgvEkxRLmW53g8uwB5B7u3YJFJer
         ax+hojabbaVeA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     peterz@infradead.org
Cc:     acme@ghostprotocols.net, linux-kernel@vger.kernel.org,
        msuchanek@suse.de
Subject: [PATCH v2] MAINTAINERS: Add pattern that matches powerpc perf to the perf entry.
Date:   Sat, 30 Jan 2021 11:14:09 +1100
Message-Id: <20210130001409.531921-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

The powerpc perf code is under arch/powerpc/perf, add a matching
pattern to the perf MAINTAINERS entry.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
[mpe: Rebase and add change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191113162754.6991-1-msuchanek@suse.de
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..d556d15505b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13930,6 +13930,8 @@ F:	arch/*/kernel/*/*/perf_event*.c
 F:	arch/*/kernel/*/perf_event*.c
 F:	arch/*/kernel/perf_callchain.c
 F:	arch/*/kernel/perf_event*.c
+F:	arch/*/perf/*
+F:	arch/*/perf/*/*
 F:	include/linux/perf_event.h
 F:	include/uapi/linux/perf_event.h
 F:	kernel/events/*
-- 
2.25.1

