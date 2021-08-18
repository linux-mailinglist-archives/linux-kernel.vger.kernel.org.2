Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1989A3F05A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbhHROFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238566AbhHROFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:05:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F2DC061796;
        Wed, 18 Aug 2021 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eiAdZBFJ/dkIb72t8AnNUyPp8Tvk3ThI3ydnoCcM7/U=; b=vt+S4ra4K8nwjP5ClicGkGq9EX
        gmV4tMe3f21hwW1EnyuFWID7p8Io65Ie7VM78QhvirJY/5ZjS31Qi+1JiMuaegvgU7mGSekBnAa7L
        Jk1LRVLupcWsi2zkIPwE438uRCE5e72XLT4ACGVqchBrnednmdGot+4S9t44kci+0pawbyz4sBtf9
        9l7LV4PgyDkT2QsgwY3GvuuAqOfgr4EfvATEBrHh7aZA1b6Siw2XwbGHy5ULTtzeNWnarvlJq8Whg
        AkdG4jAP12nX6QqbYWI10dxZmDU6Y+Kz3u3sKTpLuV8r6TFscr82orabCQB/NQmyt8O+vsBnegH7W
        4Rf7aZHQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMBF-005oCh-BM; Wed, 18 Aug 2021 14:04:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 2/2] common/scsi_debug: use the patient module remover
Date:   Wed, 18 Aug 2021 07:04:32 -0700
Message-Id: <20210818140432.1384562-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818140432.1384562-1-mcgrof@kernel.org>
References: <20210818140432.1384562-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you try to run tests such as generic/108 in a loop
you'll eventually see a failure, but the failure can
be a false positive and the test was just unable to remove
the scsi_debug module.

We need to give some time for the refcnt to become 0. For
instance for the test generic/108 the refcnt lingers between
2 and 1. It should be 0 when we're done but a bit of time
seems to be required. The chance of us trying to run rmmod
when the refcnt is 2 or 1 is low, about 1/30 times if you
run the test in a loop on linux-next today.

Likewise, even when its 0 we just need a tiny breather before
we can remove the module (sleep 10 suffices) but this is
only required on older kernels. Otherwise removing the module
will just fail.

Some of these races are documented on the korg#212337, and
Doug Gilbert has posted at least one patch attempt to try
to help with this [1]. The patch does not resolve all the
issues though, it helps though.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
[1] https://lkml.kernel.org/r/20210508230745.27923-1-dgilbert@interlog.com
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/scsi_debug | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index e7988469..3c9cd820 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -4,11 +4,13 @@
 #
 # Functions useful for tests on unique block devices
 
+. common/module
+
 _require_scsi_debug()
 {
 	# make sure we have the module and it's not already used
 	modinfo scsi_debug 2>&1 > /dev/null || _notrun "scsi_debug module not found"
-	lsmod | grep -wq scsi_debug && (rmmod scsi_debug || _notrun "scsi_debug module in use")
+	lsmod | grep -wq scsi_debug && (_patient_rmmod scsi_debug || _notrun "scsi_debug module in use")
 	# make sure it has the features we need
 	# logical/physical sectors plus unmap support all went in together
 	modinfo scsi_debug | grep -wq sector_size || _notrun "scsi_debug too old"
@@ -53,5 +55,5 @@ _put_scsi_debug_dev()
 		$UDEV_SETTLE_PROG
 		n=$((n-1))
 	done
-	rmmod scsi_debug || _fail "Could not remove scsi_debug module"
+	_patient_rmmod scsi_debug || _fail "Could not remove scsi_debug module"
 }
-- 
2.30.2

