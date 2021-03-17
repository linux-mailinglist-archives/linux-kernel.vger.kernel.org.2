Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8C33EC54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCQJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCQJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:11:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD9C061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p19so1023531wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tIEkLMKAtbUUByHxgsDytjqimEjUNe0j+Mn0l5iX50M=;
        b=beT5usMG3If2KF1utJqGVevHtxdNjcQepVLaxWYxU1o3CpqNnj4tOgQTOQbx9uvuLX
         XAhIUvVibTUp+QlH5m+orjgjE/+qs/LKGKnd2ek1DXKyzpkUCLq1FAU8PhKV38RtXpqb
         P6uU8D4hoC+FnIoDIvHhFK5CN/uF9UneLa7ytP9q77xdL6XbiQCKM437reUVhm4Iud5p
         +kIQ2VSGGI6U9A7m/wjWyEcD5WBQ49pNr7Jays6D6HECETN3wCNkcaEVg8177PEFoJvO
         pWkHO/n/Quxy+54eNEpA5SnYpHALHwveSqjT8auzMH+onsAsK5jRKETYKNXix+ZJfFU3
         ZrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tIEkLMKAtbUUByHxgsDytjqimEjUNe0j+Mn0l5iX50M=;
        b=eGftnfkCcVcLzJLKp13qJu+6vOgPTBMEJK6K6YPUh0/AEgCUkt5AYpJVpZeWMRFy0V
         ttRKbxGY4l7wKm3fI/+lDQulKsP3Zphhp3nWIcArJ+IVuMDLEQV0w65Aivq81fUhh4rE
         ra80RG80Rjt3CAKqakme1n48O+JloJO/C1z7cSoWrh7jjMoDxtK5ABk3Igi+HyuGfmLR
         dmoikNMUa95ZqNrXZBqn0jezzeU78nTQ/vuGcK/Z1Iz0XwjTeXcPhZEk/ucE4cwe81sq
         9s31eyv4HhVYwz/39SFNzSRazmQeZcEeY/bBzsB2WTN/Qru+Rb3+rpLtHa9F1jw/OLjK
         OzBQ==
X-Gm-Message-State: AOAM530FOlFk9l3tCNwZkGJS2JejBYAice+v/ncx4XNLUFY+fZQb4Ym6
        yq87qHqEBpcu4+X5CkYlVYu+Qw==
X-Google-Smtp-Source: ABdhPJxesWgN9n7epwFj7KRVaeP+ukmkLVjhbB7GXclayYOZWP60lGWAJlD20eoju237hkY9sJ2WtA==
X-Received: by 2002:a1c:318b:: with SMTP id x133mr2752054wmx.154.1615972295255;
        Wed, 17 Mar 2021 02:11:35 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id s83sm1709279wms.16.2021.03.17.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:11:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 7/8] scsi: isci: port: Make local function 'port_state_name()' static
Date:   Wed, 17 Mar 2021 09:11:24 +0000
Message-Id: <20210317091125.2910058-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091125.2910058-1-lee.jones@linaro.org>
References: <20210317091125.2910058-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/isci/port.c:65:13: warning: no previous prototype for ‘port_state_name’ [-Wmissing-prototypes]

Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/isci/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/port.c b/drivers/scsi/isci/port.c
index 448a8c31ba359..5a362ba76d63f 100644
--- a/drivers/scsi/isci/port.c
+++ b/drivers/scsi/isci/port.c
@@ -62,7 +62,7 @@
 
 #undef C
 #define C(a) (#a)
-const char *port_state_name(enum sci_port_states state)
+static const char *port_state_name(enum sci_port_states state)
 {
 	static const char * const strings[] = PORT_STATES;
 
-- 
2.27.0

