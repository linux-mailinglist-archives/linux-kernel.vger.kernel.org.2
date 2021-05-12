Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE37037F00B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbhELXn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243870AbhELXbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:31:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7EC161425;
        Wed, 12 May 2021 23:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620862200;
        bh=QEORmq2Ny594fSMrk1QOxojI6DZ3D9+o356m53w0Y+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZavs9JwILctRNh2ppA6lAumQ09HCTkGMAYyMTE+JQRPaouqWpf1jVpbRJ63Ys48n
         ajQ/ad/25R8cVGftL9nZsVqsfaWMfg+8WizJQ1Cf5PA9swJTW9JJPHGsfMOop3Drgk
         lk+v9CbHbFV/U9nwXpP1vrnjyab4ZArfJkZVZIMl6RW9PFNcj1Q6V3qqoYlvdBXUFJ
         sWGIdsXqkD30mR56CtwdJ2b/NgyK5rWttDY4jd0uYfaF0kpi1LJoEbug3Fq6+H4psh
         zCpI/RZijV8OgBloYkHSozcBqXm1+lsd7wDCZmD1PY+Sm1UZejXSUmXF3QuzpWT+/D
         XoAsGijZJAjQA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 10/10] MAINTAINERS: Add myself as context tracking maintainer
Date:   Thu, 13 May 2021 01:29:24 +0200
Message-Id: <20210512232924.150322-11-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512232924.150322-1-frederic@kernel.org>
References: <20210512232924.150322-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been missing a lot of patches touching context tracking for which
I wasn't Cc'ed these last months. The code looks like a simple single
file but has a lot of subtle tentacles.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..bda71decb316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4601,6 +4601,12 @@ S:	Supported
 F:	drivers/video/console/
 F:	include/linux/console*
 
+CONTEXT TRACKING
+M:	Frederic Weisbecker <frederic@kernel.org>
+S:	Maintained
+F:	kernel/context_tracking.c
+F:	include/linux/context_tracking*
+
 CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
 M:	Zefan Li <lizefan.x@bytedance.com>
-- 
2.25.1

