Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A0433ECA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCQJOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhCQJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:13:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1548C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v4so991903wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZBkTcxO8EifQ0gwNY5E+sYyudmJwbLtlJKo3G5cZ8o=;
        b=luP4yaV+fwkHYQpmk1DQfKhl+/VEMhoQSAs7sCanrHcYLSoAgQnK2dwi1rZfKwJAx+
         hN9QcsMOs6A2/ziGckyvTsgAaFmJA8yUW0+6XBkwnBY8tFsW5Agv1daO8X9N8262Gnys
         J5FAzcFnc49KjptwKOBsBXQk+n/iont0qcvPawzi+U4C1l+Awlln/jDvTN+33pnGDhMg
         Vj0laBJ5WzLaKSbS6Y46Hv3sIn9YS4/zSVQmOo+EwCvuOGLEtS/KNLUqLBEpjIvSFT90
         HhEsUZ1pU/Icj341RTzYgrQXqEyM+yr3Cix0OwHoEZW6+5gZKavUU1S2zd14Kejb1CBV
         LtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZBkTcxO8EifQ0gwNY5E+sYyudmJwbLtlJKo3G5cZ8o=;
        b=ompzY3g54MhgSgRFV9JkRBf/0a8vtprHJu4qSnZJbgjsbxQSP9p9i4VaoWP7Q5CSDt
         IApSEKc0EYA4M0vR30Rn7R3n7/avIxWLz9Y3oxbHNLs5MPKU2p58yeHiSI08qY6+W0sH
         jlSjCtxaXITbF4b7JeZtpStI+hvjGM1KW42K1CVkn6goAQIL3vFjgGaNpxlL8+LkSYfL
         hInQVGEJSYOS1FmuMqPtH2SRJyZrQOtP5NWqYg7B5Jf17lXVmUjsTjVCUIqPc6O/bZYz
         vTLzwHNJNWoxo2X+yG6+36GZRGSnoGtk2WmSu/mYwM3Lf9sfxSA+NeXIA0TWPKGfPR8f
         eR6A==
X-Gm-Message-State: AOAM533ppncPh8vfzWXN9tcvHyrQUqwFE36z9YAwqK5Upj9jSrUfFJl3
        j5iola9rMn6oZwiTRQ/YqCPV3w==
X-Google-Smtp-Source: ABdhPJzVznO51tnz5kJlCysq7Lgnhe+ovKyEx/kGaoveFtardk3TtWKvnnXOUuH5MniiAov32bQ5KQ==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr3534533wrt.28.1615972385442;
        Wed, 17 Mar 2021 02:13:05 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:13:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 25/36] scsi: isci: port_config: Fix a bunch of doc-rot and demote abuses
Date:   Wed, 17 Mar 2021 09:12:19 +0000
Message-Id: <20210317091230.2912389-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/isci/port_config.c:76: warning: Cannot understand  *
 drivers/scsi/isci/port_config.c:105: warning: Cannot understand  *
 drivers/scsi/isci/port_config.c:148: warning: Cannot understand  *
 drivers/scsi/isci/port_config.c:376: warning: Cannot understand  *
 drivers/scsi/isci/port_config.c:607: warning: Function parameter or member 'ihost' not described in 'sci_apc_agent_link_up'
 drivers/scsi/isci/port_config.c:607: warning: Function parameter or member 'port_agent' not described in 'sci_apc_agent_link_up'
 drivers/scsi/isci/port_config.c:607: warning: Function parameter or member 'iport' not described in 'sci_apc_agent_link_up'
 drivers/scsi/isci/port_config.c:607: warning: Function parameter or member 'iphy' not described in 'sci_apc_agent_link_up'
 drivers/scsi/isci/port_config.c:607: warning: Excess function parameter 'scic' description in 'sci_apc_agent_link_up'
 drivers/scsi/isci/port_config.c:607: warning: Excess function parameter 'sci_port' description in 'sci_apc_agent_link_up'
 drivers/scsi/isci/port_config.c:607: warning: Excess function parameter 'sci_phy' description in 'sci_apc_agent_link_up'
 drivers/scsi/isci/port_config.c:623: warning: Cannot understand  *
 drivers/scsi/isci/port_config.c:701: warning: Cannot understand  *

Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/isci/port_config.c | 37 +++++++++++++++++----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/isci/port_config.c b/drivers/scsi/isci/port_config.c
index b1c1975055792..c382a257b51b9 100644
--- a/drivers/scsi/isci/port_config.c
+++ b/drivers/scsi/isci/port_config.c
@@ -73,7 +73,7 @@ enum SCIC_SDS_APC_ACTIVITY {
  * ****************************************************************************** */
 
 /**
- *
+ * sci_sas_address_compare()
  * @address_one: A SAS Address to be compared.
  * @address_two: A SAS Address to be compared.
  *
@@ -102,9 +102,9 @@ static s32 sci_sas_address_compare(
 }
 
 /**
- *
- * @controller: The controller object used for the port search.
- * @phy: The phy object to match.
+ * sci_port_configuration_agent_find_port()
+ * @ihost: The controller object used for the port search.
+ * @iphy: The phy object to match.
  *
  * This routine will find a matching port for the phy.  This means that the
  * port and phy both have the same broadcast sas address and same received sas
@@ -145,8 +145,8 @@ static struct isci_port *sci_port_configuration_agent_find_port(
 }
 
 /**
- *
- * @controller: This is the controller object that contains the port agent
+ * sci_port_configuration_agent_validate_ports()
+ * @ihost: This is the controller object that contains the port agent
  * @port_agent: This is the port configuration agent for the controller.
  *
  * This routine will validate the port configuration is correct for the SCU
@@ -373,15 +373,16 @@ static void sci_mpc_agent_link_up(struct isci_host *ihost,
 }
 
 /**
- *
- * @controller: This is the controller object that receives the link down
+ * sci_mpc_agent_link_down()
+ * @ihost: This is the controller object that receives the link down
  *    notification.
- * @port: This is the port object associated with the phy.  If the is no
+ * @port_agent: This is the port configuration agent for the controller.
+ * @iport: This is the port object associated with the phy.  If the is no
  *    associated port this is an NULL.  The port is an invalid
  *    handle only if the phy was never port of this port.  This happens when
  *    the phy is not broadcasting the same SAS address as the other phys in the
  *    assigned port.
- * @phy: This is the phy object which has gone link down.
+ * @iphy: This is the phy object which has gone link down.
  *
  * This function handles the manual port configuration link down notifications.
  * Since all ports and phys are associated at initialization time we just turn
@@ -590,11 +591,12 @@ static void sci_apc_agent_configure_ports(struct isci_host *ihost,
 
 /**
  * sci_apc_agent_link_up - handle apc link up events
- * @scic: This is the controller object that receives the link up
+ * @ihost: This is the controller object that receives the link up
  *    notification.
- * @sci_port: This is the port object associated with the phy.  If the is no
+ * @port_agent: This is the port configuration agent for the controller.
+ * @iport: This is the port object associated with the phy.  If the is no
  *    associated port this is an NULL.
- * @sci_phy: This is the phy object which has gone link up.
+ * @iphy: This is the phy object which has gone link up.
  *
  * This method handles the automatic port configuration for link up
  * notifications. Is it possible to get a link down notification from a phy
@@ -620,9 +622,10 @@ static void sci_apc_agent_link_up(struct isci_host *ihost,
 }
 
 /**
- *
- * @controller: This is the controller object that receives the link down
+ * sci_apc_agent_link_down()
+ * @ihost: This is the controller object that receives the link down
  *    notification.
+ * @port_agent: This is the port configuration agent for the controller.
  * @iport: This is the port object associated with the phy.  If the is no
  *    associated port this is an NULL.
  * @iphy: This is the phy object which has gone link down.
@@ -697,9 +700,7 @@ static void apc_agent_timeout(struct timer_list *t)
  * Public port configuration agent routines
  * ****************************************************************************** */
 
-/**
- *
- *
+/*
  * This method will construct the port configuration agent for operation. This
  * call is universal for both manual port configuration and automatic port
  * configuration modes.
-- 
2.27.0

