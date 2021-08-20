Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4572C3F23F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 02:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbhHTADQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 20:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbhHTADM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 20:03:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C96AC061757;
        Thu, 19 Aug 2021 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eiAdZBFJ/dkIb72t8AnNUyPp8Tvk3ThI3ydnoCcM7/U=; b=AIjuVC5UgWFWnFXqx7Bn2i+zUQ
        5e/ydjNH0PEFuNjC93ph7fDH9LRhqQKEmRUFaxPli3UoY70ktRL9USHskNG3rT2eMR7IyyP/kefCZ
        9wRttJBSPNun7sISavUkuJSwSjJr5NPEAJAySDpGJrnBzuMDAHdoS54SbpxOKTmyaJCi11zn89lrf
        59mJmGKMFJD9kJ0wIKwZ+UxrQhs8/PBvM6okpSoc+G5WiEIyC/XcM1UXbTZKJpvASijmowswwWHif
        F2RCIR+9gkx2G41bFabHIihCmVGA2conPJ1+PcwC6q/+5c++m9zm0zl8uA2RQKvt4o3liVP65d6Ht
        AdOaEawA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGrzX-009mxy-0Y; Fri, 20 Aug 2021 00:02:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 2/2] common/scsi_debug: use the patient module remover
Date:   Thu, 19 Aug 2021 17:02:34 -0700
Message-Id: <20210820000234.2333125-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210820000234.2333125-1-mcgrof@kernel.org>
References: <20210820000234.2333125-1-mcgrof@kernel.org>
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

