Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA940A7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbhINHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241196AbhINHhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:37:11 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6725DC0613A2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d46f:7eb5:4a37:9d14])
        by albert.telenet-ops.be with bizsmtp
        id tjat2500J2aSKa106jatMY; Tue, 14 Sep 2021 09:34:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQ2xx-004PJK-4U; Tue, 14 Sep 2021 09:34:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQ2xw-00GINF-J5; Tue, 14 Sep 2021 09:34:52 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     SeongJae Park <sjpark@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH trivial] mm/damon: Grammar s/works/work/
Date:   Tue, 14 Sep 2021 09:34:51 +0200
Message-Id: <20210914073451.3883834-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct a singular versus plural grammar mistake in the help text for
the DAMON_VADDR config symbol.

Fixes: 3f49584b262cf8f4 ("mm/damon: implement primitives for the virtual memory address spaces")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 mm/damon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 37024798a97caf0b..ba8898c7eb8eb35e 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -30,7 +30,7 @@ config DAMON_VADDR
 	select PAGE_IDLE_FLAG
 	help
 	  This builds the default data access monitoring primitives for DAMON
-	  that works for virtual address spaces.
+	  that work for virtual address spaces.
 
 config DAMON_VADDR_KUNIT_TEST
 	bool "Test for DAMON primitives" if !KUNIT_ALL_TESTS
-- 
2.25.1

