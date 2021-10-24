Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF41438B0F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhJXRq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 13:46:27 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44541 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231759AbhJXRqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:46:25 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19OHi0bF018390;
        Sun, 24 Oct 2021 19:44:00 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] tools/nolibc: Implement gettid()
Date:   Sun, 24 Oct 2021 19:43:23 +0200
Message-Id: <20211024174323.18338-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20211024174323.18338-1-w@1wt.eu>
References: <20211024174323.18338-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

Allow test programs to determine their thread ID.

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 4988866af0b5..c1c285fe494a 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1571,6 +1571,12 @@ pid_t sys_getpid(void)
 	return my_syscall0(__NR_getpid);
 }
 
+static __attribute__((unused))
+pid_t sys_gettid(void)
+{
+	return my_syscall0(__NR_gettid);
+}
+
 static __attribute__((unused))
 int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
@@ -2029,6 +2035,18 @@ pid_t getpid(void)
 	return ret;
 }
 
+static __attribute__((unused))
+pid_t gettid(void)
+{
+	pid_t ret = sys_gettid();
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
 static __attribute__((unused))
 int gettimeofday(struct timeval *tv, struct timezone *tz)
 {
-- 
2.17.5

