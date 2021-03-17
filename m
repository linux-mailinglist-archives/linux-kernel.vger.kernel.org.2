Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51A633ECA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhCQJN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhCQJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:12:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40F9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e9so996482wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kAs8M6LvCni1AxZtMiy/7Jhupvn0PeB9iWWImdUoyng=;
        b=dOuwjexZ6wC8sNSwRHSAJd1yffddWk6tT8J1eOur7C8+ACY+A5MFIVQVuJXLmhjO6z
         gz/R9JxHMYZe2O3cac18XIhV8puI8vVnAa0BZL9XpUzPmBhAxE2Fg4zTRsmU0gaQbvG5
         O3sNTwgd425gBcT/ykPCHfWIeKT8mfZpWEdgQSVAmrmO0xb0h7KnpmaVTn/1vnM7Y/Tz
         MhFmn2Yg8fUiIGDnG+Yne1uqE+3v37KRRFZFBPOW46pkkAqCa02WkA3MnaZpLw6NkTLM
         83C5cxThHKyzD8DRA5QaL5D8gz/oEkE2h0UJKjiTYYtoIZu/clC/+qBTdseSaTmRXC1t
         Yx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kAs8M6LvCni1AxZtMiy/7Jhupvn0PeB9iWWImdUoyng=;
        b=fY91pE5lnixrI+kTGfeOO4Gqmi2EiJyNDghjXtM53slkEQsDw8KH7SqwZmAAcOp4wi
         uuvo8CA7DQmjP1YHS6HZkxZbcQ2kD1hUIHGd6F/lSFLYbEAEfOlgmp1gZueKAv7yZ4Qn
         d6C8mUjhtyhrFwciFDPRfQcD7NmU7C60VMjExPv5aoJpK2mINWNjRwsON613vZwPnYkw
         f7bVoJiuFDoVOeOqrtYJQ8kIE1cwJLdJmKm5KiXgZkt/2ObWyEaL8Jribcsi8Khwaj/A
         ynm9IWQ6s4fXn2J+4fij1PcscpVeSvaODr6cvvXZc4ZssG+dzGfyn/ER/5sDS6LUJiPq
         Dg5Q==
X-Gm-Message-State: AOAM531RI1eiGENAbFNuGJKo2pIruWGrazYxfcOmSQKImIA/V3gbWyNH
        ufnFx+f+iE9IIgzsznhyHVbHCiEnUfjI0g==
X-Google-Smtp-Source: ABdhPJz87LgDJk6bdnRGOz/oyloTXfjhfKQExDuJHNaGjhZQYurzHSIPsqlaMz2jgwU93Ei/Hf+Q8A==
X-Received: by 2002:a5d:4e85:: with SMTP id e5mr3415639wru.218.1615972376578;
        Wed, 17 Mar 2021 02:12:56 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:12:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 16/36] scsi: isci: phy: Fix a few different kernel-doc related issues
Date:   Wed, 17 Mar 2021 09:12:10 +0000
Message-Id: <20210317091230.2912389-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/isci/phy.c:354: warning: Function parameter or member 'iphy' not described in 'phy_get_non_dummy_port'
 drivers/scsi/isci/phy.c:354: warning: expecting prototype for If the phy is(). Prototype was for phy_get_non_dummy_port() instead
 drivers/scsi/isci/phy.c:364: warning: wrong kernel-doc identifier on line:
 drivers/scsi/isci/phy.c:401: warning: wrong kernel-doc identifier on line:
 drivers/scsi/isci/phy.c:611: warning: Function parameter or member 'iphy' not described in 'sci_phy_complete_link_training'
 drivers/scsi/isci/phy.c:611: warning: Excess function parameter 'sci_phy' description in 'sci_phy_complete_link_training'
 drivers/scsi/isci/phy.c:1170: warning: Cannot understand  *
 drivers/scsi/isci/phy.c:1222: warning: Cannot understand  *
 drivers/scsi/isci/phy.c:1432: warning: Function parameter or member 'sas_phy' not described in 'isci_phy_control'
 drivers/scsi/isci/phy.c:1432: warning: Excess function parameter 'phy' description in 'isci_phy_control'

Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/isci/phy.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/isci/phy.c b/drivers/scsi/isci/phy.c
index 1b87d9080ebeb..7ca7621f77479 100644
--- a/drivers/scsi/isci/phy.c
+++ b/drivers/scsi/isci/phy.c
@@ -361,11 +361,9 @@ struct isci_port *phy_get_non_dummy_port(struct isci_phy *iphy)
 }
 
 /**
- * This method will assign a port to the phy object.
+ * sci_phy_set_port() - This method will assign a port to the phy object.
  * @out]: iphy This parameter specifies the phy for which to assign a port
  *    object.
- *
- *
  */
 void sci_phy_set_port(
 	struct isci_phy *iphy,
@@ -398,11 +396,11 @@ enum sci_status sci_phy_initialize(struct isci_phy *iphy,
 }
 
 /**
- * This method assigns the direct attached device ID for this phy.
+ * sci_phy_setup_transport() - This method assigns the direct attached device ID for this phy.
  *
- * @iphy The phy for which the direct attached device id is to
+ * @iphy: The phy for which the direct attached device id is to
  *       be assigned.
- * @device_id The direct attached device ID to assign to the phy.
+ * @device_id: The direct attached device ID to assign to the phy.
  *       This will either be the RNi for the device or an invalid RNi if there
  *       is no current device assigned to the phy.
  */
@@ -597,7 +595,7 @@ static void sci_phy_start_sata_link_training(struct isci_phy *iphy)
 /**
  * sci_phy_complete_link_training - perform processing common to
  *    all protocols upon completion of link training.
- * @sci_phy: This parameter specifies the phy object for which link training
+ * @iphy: This parameter specifies the phy object for which link training
  *    has completed.
  * @max_link_rate: This parameter specifies the maximum link rate to be
  *    associated with this phy.
@@ -1167,8 +1165,8 @@ static void sci_phy_starting_final_substate_enter(struct sci_base_state_machine
 }
 
 /**
- *
- * @sci_phy: This is the struct isci_phy object to stop.
+ * scu_link_layer_stop_protocol_engine()
+ * @iphy: This is the struct isci_phy object to stop.
  *
  * This method will stop the struct isci_phy object. This does not reset the
  * protocol engine it just suspends it and places it in a state where it will
@@ -1219,7 +1217,8 @@ static void scu_link_layer_start_oob(struct isci_phy *iphy)
 }
 
 /**
- *
+ * scu_link_layer_tx_hard_reset()
+ * @iphy: This is the struct isci_phy object to stop.
  *
  * This method will transmit a hard reset request on the specified phy. The SCU
  * hardware requires that we reset the OOB state machine and set the hard reset
@@ -1420,7 +1419,7 @@ void isci_phy_init(struct isci_phy *iphy, struct isci_host *ihost, int index)
 /**
  * isci_phy_control() - This function is one of the SAS Domain Template
  *    functions. This is a phy management function.
- * @phy: This parameter specifies the sphy being controlled.
+ * @sas_phy: This parameter specifies the sphy being controlled.
  * @func: This parameter specifies the phy control function being invoked.
  * @buf: This parameter is specific to the phy function being invoked.
  *
-- 
2.27.0

