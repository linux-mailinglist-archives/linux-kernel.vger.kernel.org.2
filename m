Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0FD413924
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhIURvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhIURvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:51:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3CC061575;
        Tue, 21 Sep 2021 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CQAITQI37oxG2tznc10nHVNjrUiqCNTu55grkoKZ4Fc=; b=N7CiElvch0koZ5Qa4mvNCRIzeQ
        afnhCYCiFYYjYzFQe3zHKd+uZ/IA/9RTxiGa5YJXr030dM/n3OGSbru2/4JONFh4aQYkT6uS06Svn
        DvGRetYYrarcDoJFUgftoKQ1ZZKVQgn6Lg2P4/rcMth38jV4rFmpWZtNBZayRo42ExPziQ2HRsmJg
        Or23NcYnzsbvbWzGzm5Ei6XydEpSV/Cl4pVnK06i8ZTFZWR70aAEF/699+Z3thbLJ5GQfdsxlEHIC
        1is9ix5uBV14GB3GxVXT1556b+IJy2K7BcbiVAU/P3BvNNlC0Q9X5qxMebRXqKYsGIascwjeu8uDx
        rWkn8CGg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSjtx-005OZY-76; Tue, 21 Sep 2021 17:49:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>, Eryu Guan <guan@eryu.me>
Subject: [PATCH] common/module: use patient module removal
Date:   Tue, 21 Sep 2021 10:49:52 -0700
Message-Id: <20210921174952.1286037-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that scsi_debug has been using the patient module removal
for a while, let's generalize its use for the other use cases.
This likey will fix some odd false positives due to races.

Suggested-by: Eryu Guan <guan@eryu.me>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/module | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/module b/common/module
index 0392f20c..ead0f881 100644
--- a/common/module
+++ b/common/module
@@ -16,7 +16,7 @@ _reload_module()
 {
 	local module="$1"
 
-	modprobe -r "${module}" || _fail "${module} unload failed"
+	_patient_rmmod "${module}" || _fail "${module} unload failed"
 	modprobe "${module}" || _fail "${module} load failed"
 }
 
@@ -44,7 +44,7 @@ _require_loadable_module()
 	local module="$1"
 
 	modinfo "${module}" > /dev/null 2>&1 || _notrun "${module}: must be a module."
-	modprobe -r "${module}" || _notrun "Require ${module} to be unloadable"
+	_patient_rmmod "${module}" || _notrun "Require ${module} to be unloadable"
 	modprobe "${module}" || _notrun "${module} load failed"
 }
 
@@ -64,7 +64,7 @@ _require_loadable_fs_module()
 	test -n "${had_scratchfs}" && _scratch_unmount
 	local unload_ok=""
 	local load_ok=""
-	modprobe -r "${module}" || unload_ok=0
+	_patient_rmmod "${module}" || unload_ok=0
 	modprobe "${module}" || load_ok=0
 	test -n "${had_scratchfs}" && _scratch_mount 2> /dev/null
 	test -n "${had_testfs}" && _test_mount 2> /dev/null
-- 
2.30.2

