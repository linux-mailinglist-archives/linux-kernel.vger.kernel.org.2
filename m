Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C9E33ECA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCQJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhCQJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:13:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C509FC061762
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x13so1003266wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hdrx4ZDIqWWXCMIUIHjqy5M6xHh5UviAprBwzcqZnso=;
        b=ADMZ9cq3UjXb3mFr70/P7f/svyjPjcoI6pNxsw1Z1In3b/CCiehItfmDGj8ShIivIK
         sqy6mFvwDowypd8BjJdYzyNHlfOODXxH4ib+zKFotJmkyDk1TtlCP9FxCXd1KkVXFkWq
         o3vGEzMNGbkrur5BODNFI8Y7taNO03DnMXv94iTr22aM4s6jshxXVQcaOswE+f7ujBqQ
         CshP9pNxx6hBEOd0Ax9ftbmnyyWwZ7gksmrOrcHBcF4ZJljDletomLYVyIe+I1Dqh6AV
         EUdgHWw/dUTY+Hi7+fz9ehbY4/3g1vElEs4m3fnHjEEl2JDohvhaxoDrje99Tx0eSPZ7
         pRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hdrx4ZDIqWWXCMIUIHjqy5M6xHh5UviAprBwzcqZnso=;
        b=lc//qgai/zBF9eGmqgxNOU1Y6b3Dr6rOR19+EDdiFvosQH4PqXy41vlOjGwT1n9g2r
         X+xWgqlTpFBpi06PJ0gQjZiVC7R1hml4IL00pKNjcpHoR6kj15Ak+cCylYuXo+JqxPyZ
         1WcK3eY3el+oSyOg0+l4YZ/Nmz/BY/5A4JjI2ZoRsxWB7vA6dmOjNZXlmJUrJ9AQcyiE
         s4A2RKEAq5BX/rSAnGt0TpUDp+bupFOO13Yy29eJa8WxrzowbTe5c6g0Ho2EZrGOrLzM
         qavlRR8+/+osNk03wFojMnP7fIbf3aEh9FHLYPObu39BD8zWfOFLEFlG6ESpTUxty4PJ
         RVQg==
X-Gm-Message-State: AOAM533rYAGb3TH4HHy+THB8RNXAZRzWCydoAvNzFv2UnXd3mobtTAQE
        aqzOJMid5IBc0exEi8hVd9Ot2Q==
X-Google-Smtp-Source: ABdhPJyce6n27wI17PtQ5IRp7saOtwmxNB3UD47OIgyBOc+bS91ofdwq9UrHv3TIgOn7PvWLJ8/jDg==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr3404299wrt.294.1615972389604;
        Wed, 17 Mar 2021 02:13:09 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:13:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 29/36] scsi: isci: remote_node_context: Demote kernel-doc abuse
Date:   Wed, 17 Mar 2021 09:12:23 +0000
Message-Id: <20210317091230.2912389-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/isci/remote_node_context.c:206: warning: Function parameter or member 'rnc' not described in 'sci_remote_node_context_notify_user'
 drivers/scsi/isci/remote_node_context.c:206: warning: expecting prototype for This method just calls the user callback function and then resets the(). Prototype was for sci_remote_node_context_notify_user() instead

Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/isci/remote_node_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/remote_node_context.c b/drivers/scsi/isci/remote_node_context.c
index 7a576b995afae..77ba0291134e2 100644
--- a/drivers/scsi/isci/remote_node_context.c
+++ b/drivers/scsi/isci/remote_node_context.c
@@ -197,7 +197,7 @@ static void sci_remote_node_context_setup_to_destroy(
 	wake_up(&ihost->eventq);
 }
 
-/**
+/*
  * This method just calls the user callback function and then resets the
  * callback.
  */
-- 
2.27.0

