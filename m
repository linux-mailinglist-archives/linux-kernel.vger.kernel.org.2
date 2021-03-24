Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69240347F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbhCXRe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbhCXReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6F7C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt15so24778858ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rL2mdk6qmLyu4l9CO1LjB/Fy6Q7Estk6EutMx9RWcNQ=;
        b=cGfmb9Ahj4GoVdknRK5zBEm0WRV/rmSsCFJCDiQqtA6qYIzMEz1WKGh1kDUOyYxQON
         J3KH9Lv/o/PxeWE72TIy+zT4wy4Yqh5zR+/9F2zLduHYhpBRk7kygdVtFMEQdEuL70Z+
         GebqGQtq7UCn8M6FWc385+DryjwLfMyS3ejU4qMo6qGspPGwsuB8tzUcr3f7vmedDepo
         s6uqVzuGZNym0/kEkc3Yj/rmDC9gNaa1oJNBFemtHcHiz3+3PeByXXq1VnHtEPoP4yyV
         x845RvkxhV0krjmMg5hb9q81wOkjLP02ocX7jxRG3GD7vsT/iNFWLyx4QW6IBTJ1pQTQ
         dVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rL2mdk6qmLyu4l9CO1LjB/Fy6Q7Estk6EutMx9RWcNQ=;
        b=qhUaF/CA7YEjqImz6OlxeJUtYZiSbKxHHbGVHOF5v7pB6SaMXpt08LUSccM1jJWm8Q
         TOYSRHwdk+hgxZEdu17brer8m07sebuYn1CfjenhB2igp/6Jhp+bayRv/79ObQBwaGWS
         FCXpjL3t1dlJn8QdhOHWrDzSyy8D6rF+24I0TUPPaPILXaWqebrWr+JSD/6EOvx5Sve1
         gadN/3i0P3bJT3z26O1r8v3ueIH60l8gsFzCre4QAahKrKBT/xgWl0C76VpuyGK0uxG7
         qhzU1O+tasLHKesSRU5zw7tSSj58tike6mhiv1h3g3GeZeiDBuqg8DZTbZdHZ7X36jeU
         kVmg==
X-Gm-Message-State: AOAM533KBImZx5X2XIAxtGmwcjVZM0ShfezxGWMMTlg1C34SnETJ0d0S
        cqg+wlQ/OXNgjHNUDRupvCfJYVI+v1yQuQ==
X-Google-Smtp-Source: ABdhPJwf02ng7fpjFAextXu71pHqM94bIT0ggGpD3yLNfVBOz2yVq6Lvqj/SEV4Q1l09yryl7SL5dw==
X-Received: by 2002:a17:906:f896:: with SMTP id lg22mr4809036ejb.124.1616607261450;
        Wed, 24 Mar 2021 10:34:21 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Drubin <daniel.drubin@intel.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 13/25] HID: ishtp-hid-client: Fix incorrect function name report_bad_packet()
Date:   Wed, 24 Mar 2021 17:33:52 +0000
Message-Id: <20210324173404.66340-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/intel-ish-hid/ishtp-hid-client.c:36: warning: expecting prototype for report_bad_packets(). Prototype was for report_bad_packet() instead

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Daniel Drubin <daniel.drubin@intel.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 24599280105d8..042a7091802dd 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -23,7 +23,7 @@ static const guid_t hid_ishtp_guid =
 #define cl_data_to_dev(client_data) ishtp_device(client_data->cl_device)
 
 /**
- * report_bad_packets() - Report bad packets
+ * report_bad_packet() - Report bad packets
  * @hid_ishtp_cl:	Client instance to get stats
  * @recv_buf:		Raw received host interface message
  * @cur_pos:		Current position index in payload
-- 
2.27.0

