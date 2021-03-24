Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA824347F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhCXRfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbhCXReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA59C0613DF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w18so28631065edc.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uk7zBDuxVird9hlwDlzfVR+OTGmQfb7Ta2eddUi7FDk=;
        b=oMG1f/lilaXJuU+qkI5svIKpq2nZYEjtZdaiC7WToDBB3y0uP4crnOWItZmd5KHr5M
         ppBNbO7xGEW0qeTEQOMaSVI/NxrQc9apoBqcvRZQskDcbbUdclF4xs3yQIqeSp1BlvXI
         RLon93Usg8XWJgzObbNwpqiYQZhxnf8Mzx0Fe9+MLPXZSgyTMO2vJB3fwOtCjpw9ql3S
         xg2KWjw5PGYNVlkfzDr0/tIIR1Nx3VwX68bC1omsXKzxxge0Ikrzizz5hioI2BbjOrUw
         +ogMVa7xQSDpbXnAexotvhGqPai6VH9Jp9stvVdBDxfdhNFgSITW6aN5pafh0WKfGnrO
         Bkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uk7zBDuxVird9hlwDlzfVR+OTGmQfb7Ta2eddUi7FDk=;
        b=eUpHGt7PH1ozWhB1ncUXLXD0BCiPkfU54WzupumK4kTBEae1wQXr/H5Yz5MyfqH90q
         lVl5mkFUha264U/VWO0+EexuLqO4oofwhKcBMCIRVwRhvrnTMcoBu15xRCaQJT0DS2Qu
         qsVHt1jzjyRpU2J45V3lkNuOe+h1ZUjPKlIGoU21m/hYCrFuRkh8G84uLTfhBE2hZakT
         K0AxIKnl3YWgOO6cA23idahpx7aISoHfXicGfNc7JkG1VZg/WhVbdb+WBZ3MEZXWMT6N
         viK0ADV/gAIfCYewZX6oEnphx/FCiRCxnDg4hjyFdttSn/5n6AXzXnReojzBHnc19o0P
         WrwA==
X-Gm-Message-State: AOAM531LvGIu01jDWAhqJN8GMCLsSmVCQIWe3L29eSl6Xfu5nU3l3cow
        bv7aZtvb1Wj0VIF88YSsrHfhfw==
X-Google-Smtp-Source: ABdhPJzEcz7kA6LloIrNljqPtpYDplJZAPeUfdrb6FoajItVxIad1HesJK9UA1useQFk8yXszTAC9w==
X-Received: by 2002:aa7:d54c:: with SMTP id u12mr4872746edr.234.1616607252099;
        Wed, 24 Mar 2021 10:34:12 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-input@vger.kernel.org
Subject: [PATCH 04/25] HID: intel-ish: Supply some missing param descriptions
Date:   Wed, 24 Mar 2021 17:33:43 +0000
Message-Id: <20210324173404.66340-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/intel-ish-hid/ishtp/bus.c:173: warning: Function parameter or member 'fw_client' not described in 'ishtp_get_fw_client_id'
 drivers/hid/intel-ish-hid/ishtp/bus.c:845: warning: Function parameter or member 'device' not described in 'ishtp_device'
 drivers/hid/intel-ish-hid/ishtp/bus.c:858: warning: Function parameter or member 'device' not described in 'ishtp_get_pci_device'
 drivers/hid/intel-ish-hid/ishtp/bus.c:871: warning: Function parameter or member 'cl_device' not described in 'ishtp_trace_callback'
 drivers/hid/intel-ish-hid/ishtp/bus.c:884: warning: Function parameter or member 'dev' not described in 'ish_hw_reset'

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Uwe Kleine-König" <uwe@kleine-koenig.org>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index ffc9ce5c86ee6..c1c7d5356208d 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -164,6 +164,7 @@ EXPORT_SYMBOL(ishtp_fw_cl_get_client);
 
 /**
  * ishtp_get_fw_client_id() - Get fw client id
+ * @fw_client:	firmware client used to fetch the ID
  *
  * This interface is used to reset HW get FW client id.
  *
@@ -835,6 +836,7 @@ int ishtp_use_dma_transfer(void)
 
 /**
  * ishtp_device() - Return device pointer
+ * @device: ISH-TP client device instance
  *
  * This interface is used to return device pointer from ishtp_cl_device
  * instance.
@@ -851,6 +853,7 @@ EXPORT_SYMBOL(ishtp_device);
  * ishtp_get_pci_device() - Return PCI device dev pointer
  * This interface is used to return PCI device pointer
  * from ishtp_cl_device instance.
+ * @device: ISH-TP client device instance
  *
  * Return: device *.
  */
@@ -862,6 +865,7 @@ EXPORT_SYMBOL(ishtp_get_pci_device);
 
 /**
  * ishtp_trace_callback() - Return trace callback
+ * @cl_device: ISH-TP client device instance
  *
  * This interface is used to return trace callback function pointer.
  *
@@ -875,6 +879,7 @@ EXPORT_SYMBOL(ishtp_trace_callback);
 
 /**
  * ish_hw_reset() - Call HW reset IPC callback
+ * @dev:	ISHTP device instance
  *
  * This interface is used to reset HW in case of error.
  *
-- 
2.27.0

