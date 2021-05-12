Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4AF37BBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhELLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhELLeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:34:22 -0400
X-Greylist: delayed 1109 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 May 2021 04:33:12 PDT
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8302AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=mZI7ZExTBINztIuffG4TVSvWvJNlZh2frkQUdiKerGQ=; b=O7
        IxDJ/7IFms35iWhAnanBMRTxyMrY1o7Zp2R4F3rZu7P9hAL6JrrO2hXFu3ayPd6FhE1/1VUPQYeWC
        hMopxIWCe0bqxIMck90vi3SV1nJcoyy3GGkyUMWZ2nQbJKSs6uKFRIQjJ9/vRJ3YWLaRqfMZaXIgT
        VCscWkLnvR//poDq1ZZmAQzrdSqovLC+6kcPeA7gcqrYXgryDyP0irJkdHxq31wf6pHLLBJJbN5H2
        JLnMGb9LD/jSvhfgoUve+hx1qNELQADyfvPhisruHEgxquncqa3wfDaGzTZ7N9SafwOnSkQE8Mq1d
        wfBrpm54TyVrFB9rzwIEBmtZYTOmuSlA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1lgmoz-000232-M0; Wed, 12 May 2021 12:14:33 +0100
From:   John Keeping <john@metanate.com>
To:     dm-devel@redhat.com
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH] dm: verity: fix module param permissions
Date:   Wed, 12 May 2021 12:14:21 +0100
Message-Id: <20210512111421.1828191-1-john@metanate.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The third parameter of module_param() is permissions for the sysfs node
but it looks like it is being used as the initial value of the parameter
here.  In fact, false here equates to omitting the file from sysfs and
does not affect the value of require_signatures.

Making the parameter writable is not simple because going from
false->true is fine but it should not be possible to remove the
requirement to verify a signature.  But it can be useful to inspect the
value of this parameter from userspace, so change the permissions to
make a read-only file in sysfs.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/md/dm-verity-verify-sig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
index 29385dc470d5..db61a1f43ae9 100644
--- a/drivers/md/dm-verity-verify-sig.c
+++ b/drivers/md/dm-verity-verify-sig.c
@@ -15,7 +15,7 @@
 #define DM_VERITY_VERIFY_ERR(s) DM_VERITY_ROOT_HASH_VERIFICATION " " s
 
 static bool require_signatures;
-module_param(require_signatures, bool, false);
+module_param(require_signatures, bool, 0444);
 MODULE_PARM_DESC(require_signatures,
 		"Verify the roothash of dm-verity hash tree");
 
-- 
2.31.1

