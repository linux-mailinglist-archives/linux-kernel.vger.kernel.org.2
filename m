Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAF7366953
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhDUKiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234891AbhDUKiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:38:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E15D6144E;
        Wed, 21 Apr 2021 10:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619001464;
        bh=xw+/InUrxEC+M8lFeasl+kkDMp6sJjaHfaOXZd7hZkw=;
        h=From:To:Cc:Subject:Date:From;
        b=r5ddFMlfVUemm6Kg9WNXbbnhNc5AMK5D7gCOhl1GZubIpE3F0ZO99+Jj6z8AGrz0B
         4CveMJ3D2/MGGkHZKEuhXSHKQIVzqmEKi+NitDa5nVh7f8MGB1Dfc925lOzdO1LbyU
         l2kplFQfR5l2IQ3iZtFzxYk679nwq5LyEScRuDQU5YxypuRXjlt2gh8hTl4WXEx8IV
         0YNn4Qorr+xrLMPBy0TuPxOTRJ0l+mE0NzyulUvCwuxs8EyrDBUSbZ/sHzM5elINIh
         jR4XPKj+4uI6p5lJtzYuXxBJoLgJ7Wz0zuiKVMsYQ/YXrVmR5Wz7C1pFESUqLFzoId
         TMTrGDXYa4inA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] MAINTAINERS: Add myself as context tracking maintainer
Date:   Wed, 21 Apr 2021 12:37:39 +0200
Message-Id: <20210421103740.17141-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been missing a lot of patches touching context tracking for which
I wasn't Cc'ed these last months. The code looks like a simple single
file but has a lot of subtle tentacles.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..82870ec99258 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4505,6 +4505,12 @@ S:	Supported
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

