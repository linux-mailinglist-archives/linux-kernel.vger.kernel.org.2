Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81259325194
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhBYOfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231974AbhBYOfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:35:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6E8564F16;
        Thu, 25 Feb 2021 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614263701;
        bh=8T6cWgIA4YyFKiNd9Yq9e/r3lAf6Xfx2G/lG7LEhHQ8=;
        h=From:To:Cc:Subject:Date:From;
        b=NclfhjdxXtVuc6EEyuQ5aqrGgPnQ0KFTT9qH2P8GlKceFZFU4VZ209mCEVFhE/ivB
         bBu69LiB6JywavncY0A7J9p4zH/anabPeU2HGUmCerRCDTjxbhvH60p8u0eLHRSely
         6oRgL8m900uCaOQp45PjbaP9HnzRDX4j/WcKQXL3AWtNF7Ma4tLHdU5HuwazOJEAyO
         KON0q0IPabGe21w9ZbdWfto8d6bbKLsrkmGcOITLGwOzENB6RZu5MHgK3WDudfDokf
         EyJpjX3qfIdVzsVxW5qeOnkCpR6yxbA8aL0LowYb3DuO6fXaPvaeb0x9NRx6pVpMZj
         2cgRUxc9ATjNg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: lto: add _mcount to list of used symbols
Date:   Thu, 25 Feb 2021 15:34:49 +0100
Message-Id: <20210225143456.3829513-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some randconfig builds fail with undefined references to _mcount
when CONFIG_TRIM_UNUSED_KSYMS is set:

ERROR: modpost: "_mcount" [drivers/tee/optee/optee.ko] undefined!
ERROR: modpost: "_mcount" [drivers/fsi/fsi-occ.ko] undefined!
ERROR: modpost: "_mcount" [drivers/fpga/dfl-pci.ko] undefined!

Since there is already a list of symbols that get generated at link
time, add this one as well.

Fixes: fbe078d397b4 ("kbuild: lto: add a default list of used symbols")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/lto-used-symbollist.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/lto-used-symbollist.txt b/scripts/lto-used-symbollist.txt
index 38e7bb9ebaae..406ada65e926 100644
--- a/scripts/lto-used-symbollist.txt
+++ b/scripts/lto-used-symbollist.txt
@@ -1,5 +1,6 @@
 memcpy
 memmove
 memset
+_mcount
 __stack_chk_fail
 __stack_chk_guard
-- 
2.29.2

