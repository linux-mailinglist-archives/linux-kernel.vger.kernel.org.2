Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3833ECA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhCQJOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCQJNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:13:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8CAC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k8so1005711wrc.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQ2nUtCGw1bWUZ6dO/5J8SDUuDM4eCtKGGa2VlanAmM=;
        b=d2Ja2o6tgRGuZu/1gD3cCuRyuA6S6GgUOdhpFLU7iMpXFvkyR0pN3bcibvKm5/vjJT
         YZgukf4UNqYRhDxIpmHDYNPSp07nFKO58rgOk6dR2BMf8HESOZ+DSdkz866QBjDNtzKL
         gC7yavFODON/KcwZduZibWrosEZTVcu1tRBMngCMsXt+55z9TnN5Wp103xRnXcEF0fDf
         RoyiXMRtKLQ8K9sTSsp+qF/HpqpsnjRQ+1wFHZmUXBMKBpLPj2K0gb/rudm9/Ro6PdA1
         yWw9jfy5qs/HQa5xNrMLNReG0nUDtCcRvke6d/OZYJZfhv2Mel8Kawnyeh1QBdkZAHs6
         0vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQ2nUtCGw1bWUZ6dO/5J8SDUuDM4eCtKGGa2VlanAmM=;
        b=dAxFCZufQzXumZYY0zHj+9kOsMKQkS1npY5mOG6wDobCona3cum1KRO5GQfzqU5BHM
         OuVUZrU8SqLKyNHUZNu62rl8vO/CuiTD6Xlcc4hfz2gJ0VcN1WPFnIk6/4AWoI0VhrOE
         XIw3FF3RhPHM9D/uIar8MfSqLclUp5wuKMSWcng+Xu9AQ/qS2OQGrsBnpigaG4eIXIoi
         yDAFIX0I1ViQQBwPMvmfW6l2QSDMSOkYmsehXsEmpWRpUMw6bwuszNVJlAIfHdIubrlv
         sG8ScPMYYN/dySOUCkIL6MRu1y4hM4rTydJMhIx9qt77Lz1P5wDWN5yeDYI1O2vSALdV
         cFwg==
X-Gm-Message-State: AOAM531xNK7YyA/MqwL+2n+K3/wHcyyLuSv4MBkPhKicChbFjdDi3W8a
        EHMEAkylpWa85rBdShQbAd/W0g==
X-Google-Smtp-Source: ABdhPJzR8BmRIRcZ128t7v/YyGXxw48N5CaIKvpt5OSTSELrl5gNmzdel2YmItSBmal7vekMwK6VJg==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr3451873wrs.98.1615972383807;
        Wed, 17 Mar 2021 02:13:03 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:13:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 23/36] scsi: isci: remote_node_table: Fix a bunch of kernel-doc misdemeanours
Date:   Wed, 17 Mar 2021 09:12:17 +0000
Message-Id: <20210317091230.2912389-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/isci/remote_node_table.c:66: warning: Incorrect use of kernel-doc format:  *
 drivers/scsi/isci/remote_node_table.c:80: warning: Function parameter or member 'remote_node_table' not described in 'sci_remote_node_table_get_group_index'
 drivers/scsi/isci/remote_node_table.c:80: warning: Function parameter or member 'group_table_index' not described in 'sci_remote_node_table_get_group_index'
 drivers/scsi/isci/remote_node_table.c:80: warning: expecting prototype for This file contains the implementation of the SCIC_SDS_REMOTE_NODE_TABLE(). Prototype was for sci_remote_node_table_get_group_index() instead
 drivers/scsi/isci/remote_node_table.c:101: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:131: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:161: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:194: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:227: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:256: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:283: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:310: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:368: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:428: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:465: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:508: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:553: warning: Cannot understand  *
 drivers/scsi/isci/remote_node_table.c:576: warning: Cannot understand  *

Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/isci/remote_node_table.c | 51 +++++++++++++--------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/isci/remote_node_table.c b/drivers/scsi/isci/remote_node_table.c
index 301b3141945ec..1036ab936626e 100644
--- a/drivers/scsi/isci/remote_node_table.c
+++ b/drivers/scsi/isci/remote_node_table.c
@@ -53,17 +53,15 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/**
+/*
  * This file contains the implementation of the SCIC_SDS_REMOTE_NODE_TABLE
  *    public, protected, and private methods.
- *
- *
  */
 #include "remote_node_table.h"
 #include "remote_node_context.h"
 
 /**
- *
+ * sci_remote_node_table_get_group_index()
  * @remote_node_table: This is the remote node index table from which the
  *    selection will be made.
  * @group_table_index: This is the index to the group table from which to
@@ -98,8 +96,8 @@ static u32 sci_remote_node_table_get_group_index(
 }
 
 /**
- *
- * @out]: remote_node_table This the remote node table in which to clear the
+ * sci_remote_node_table_clear_group_index()
+ * @remote_node_table: This the remote node table in which to clear the
  *    selector.
  * @set_index: This is the remote node selector in which the change will be
  *    made.
@@ -128,8 +126,8 @@ static void sci_remote_node_table_clear_group_index(
 }
 
 /**
- *
- * @out]: remote_node_table This the remote node table in which to set the
+ * sci_remote_node_table_set_group_index()
+ * @remote_node_table: This the remote node table in which to set the
  *    selector.
  * @group_table_index: This is the remote node selector in which the change
  *    will be made.
@@ -158,8 +156,8 @@ static void sci_remote_node_table_set_group_index(
 }
 
 /**
- *
- * @out]: remote_node_table This is the remote node table in which to modify
+ * sci_remote_node_table_set_node_index()
+ * @remote_node_table: This is the remote node table in which to modify
  *    the remote node availability.
  * @remote_node_index: This is the remote node index that is being returned to
  *    the table.
@@ -191,8 +189,8 @@ static void sci_remote_node_table_set_node_index(
 }
 
 /**
- *
- * @out]: remote_node_table This is the remote node table from which to clear
+ * sci_remote_node_table_clear_node_index()
+ * @remote_node_table: This is the remote node table from which to clear
  *    the available remote node bit.
  * @remote_node_index: This is the remote node index which is to be cleared
  *    from the table.
@@ -224,8 +222,8 @@ static void sci_remote_node_table_clear_node_index(
 }
 
 /**
- *
- * @out]: remote_node_table The remote node table from which the slot will be
+ * sci_remote_node_table_clear_group()
+ * @remote_node_table: The remote node table from which the slot will be
  *    cleared.
  * @group_index: The index for the slot that is to be cleared.
  *
@@ -253,7 +251,7 @@ static void sci_remote_node_table_clear_group(
 }
 
 /**
- *
+ * sci_remote_node_table_set_group()
  * @remote_node_table:
  *
  * THis method sets an entire remote node group in the remote node table.
@@ -280,7 +278,7 @@ static void sci_remote_node_table_set_group(
 }
 
 /**
- *
+ * sci_remote_node_table_get_group_value()
  * @remote_node_table: This is the remote node table that for which the group
  *    value is to be returned.
  * @group_index: This is the group index to use to find the group value.
@@ -307,8 +305,8 @@ static u8 sci_remote_node_table_get_group_value(
 }
 
 /**
- *
- * @out]: remote_node_table The remote that which is to be initialized.
+ * sci_remote_node_table_initialize()
+ * @remote_node_table: The remote that which is to be initialized.
  * @remote_node_entries: The number of entries to put in the table.
  *
  * This method will initialize the remote node table for use. none
@@ -365,8 +363,8 @@ void sci_remote_node_table_initialize(
 }
 
 /**
- *
- * @out]: remote_node_table The remote node table from which to allocate a
+ * sci_remote_node_table_allocate_single_remote_node()
+ * @remote_node_table: The remote node table from which to allocate a
  *    remote node.
  * @table_index: The group index that is to be used for the search.
  *
@@ -425,7 +423,7 @@ static u16 sci_remote_node_table_allocate_single_remote_node(
 }
 
 /**
- *
+ * sci_remote_node_table_allocate_triple_remote_node()
  * @remote_node_table: This is the remote node table from which to allocate the
  *    remote node entries.
  * @group_table_index: THis is the group table index which must equal two (2)
@@ -462,7 +460,7 @@ static u16 sci_remote_node_table_allocate_triple_remote_node(
 }
 
 /**
- *
+ * sci_remote_node_table_allocate_remote_node()
  * @remote_node_table: This is the remote node table from which the remote node
  *    allocation is to take place.
  * @remote_node_count: This is ther remote node count which is one of
@@ -505,8 +503,9 @@ u16 sci_remote_node_table_allocate_remote_node(
 }
 
 /**
- *
- * @remote_node_table:
+ * sci_remote_node_table_release_single_remote_node()
+ * @remote_node_table: This is the remote node table from which the remote node
+ *    release is to take place.
  *
  * This method will free a single remote node index back to the remote node
  * table.  This routine will update the remote node groups
@@ -550,7 +549,7 @@ static void sci_remote_node_table_release_single_remote_node(
 }
 
 /**
- *
+ * sci_remote_node_table_release_triple_remote_node()
  * @remote_node_table: This is the remote node table to which the remote node
  *    index is to be freed.
  *
@@ -573,7 +572,7 @@ static void sci_remote_node_table_release_triple_remote_node(
 }
 
 /**
- *
+ * sci_remote_node_table_release_remote_node_index()
  * @remote_node_table: The remote node table to which the remote node index is
  *    to be freed.
  * @remote_node_count: This is the count of consecutive remote nodes that are
-- 
2.27.0

