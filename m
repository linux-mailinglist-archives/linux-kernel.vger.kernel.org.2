Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABE7447EA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbhKHLRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239149AbhKHLQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:16:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 396CF61359;
        Mon,  8 Nov 2021 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636370054;
        bh=v5kymqxyKmvAvPMLG99lLZzehfZMcI+K0hdQmyDJDP0=;
        h=From:To:Cc:Subject:Date:From;
        b=k61D9dl1CO6u+IxOeGYlKSKxTPYQAHbbqLThEby8SfhBMX0ageW4wKX/P496Gv/Jd
         teRPGeONVdfzR25diD0r0h8E1sSkXICTuaYPb7F+hNm9fByD/+JKZIH1mcUlRaZbRH
         PH/LNDgD+0JggPn4ItGI5hZC9L5NWDe8q2YtV2HAHE/4pUapd3MY4T+J3kPzgMCl20
         0TblZ0t5MKBV4T2HP68As1A+1GzJxH5AlcvoTl0HIelh3PkWzWIGi1n5ma61p5mt5Y
         X4pl1cQne52cLmAd/Ulya4DMIO2GFMvXj1VwjHBG6qLo2pPbciPsui3/SLTs8iQVAc
         QkvnyI+vmbkNg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/balloon: fix unused-variable warning
Date:   Mon,  8 Nov 2021 12:14:02 +0100
Message-Id: <20211108111408.3940366-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In configurations with CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=n
and CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y, gcc warns about an
unused variable:

drivers/xen/balloon.c:83:12: error: 'xen_hotplug_unpopulated' defined but not used [-Werror=unused-variable]

Since this is always zero when CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
is disabled, turn it into a preprocessor constant in that case.

Fixes: 121f2faca2c0 ("xen/balloon: rename alloc/free_xenballooned_pages")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/xen/balloon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index ad9ba1e97450..ba2ea11e0d3d 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -80,9 +80,8 @@
 static uint __read_mostly balloon_boot_timeout = 180;
 module_param(balloon_boot_timeout, uint, 0444);
 
-static int xen_hotplug_unpopulated;
-
 #ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
+static int xen_hotplug_unpopulated;
 
 static struct ctl_table balloon_table[] = {
 	{
@@ -115,6 +114,8 @@ static struct ctl_table xen_root[] = {
 	{ }
 };
 
+#else
+#define xen_hotplug_unpopulated 0
 #endif
 
 /*
-- 
2.29.2

