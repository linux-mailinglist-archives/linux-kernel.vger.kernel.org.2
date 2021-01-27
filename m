Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE97B3059E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhA0LfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhA0Laa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:30:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB64C06121E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e15so1317309wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXir64Bzd+GxcWUwcbNEQp4j7KexiYWTQQdXLaxG9xM=;
        b=SjJfQVN4LTSFL66kig3SXua8oK6mX5lWoDPFQTgmGBBQeO6VGAXx5gw6YgW6qifq5u
         Ur+obyedN3xqBuv7mY1pTnpyFQFf+/dpBbMAiFc71e3ViXwT4DkUJNIptbT6Z0K9NtUp
         z4X45gNibPLdT4CYrqaeAgrZJDg46VI92J+Q8mO2UT7Yf/lpCl/GsEGCYivwWCm2WGHH
         OkpjzWk/y8zFyEue1yrkjPX4BCqB05TGMBMDQ55GoauFiBuOgbhVb4wixzPQkT8IH+mH
         DoTE95X5RRT1CRjDZ6+c8MAaP8eHx3YpwydJlcw+RdHsYtQ6NMNP2HV+OVrdfP9SdvYK
         VvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXir64Bzd+GxcWUwcbNEQp4j7KexiYWTQQdXLaxG9xM=;
        b=MdrcaGhMOmh4/kM1E8vgCHfkYnCoUD012AruDV8BoBJjUlsz2Ps367x2ptpw15d6rY
         S1oEalyBl7lVD9BnD7dhcr12V2VkWXswZZ+M1MyPpw6ZhzaeMNvn9AkHbci8SjbxWiki
         SJDy/eqxYl6NY1J0qAjP588seYJNANq2c/EQDs5Qmz28n6444VKyRqC+f8fWI+yzE+LP
         QhvS7QOn8iRv0ISHHLUHHAjyg0mc52uzEyODXhMbvPjNQbJgX/YmL95Rs+dSyZJ9j8QM
         CjVVGuH3txF7txGeA+YvZl8bVGFp21xPvYbXX2VF71ldhkd2ZzWG4Gj9P37ez+1ucfeZ
         nMig==
X-Gm-Message-State: AOAM533zQEm5MAzF83t5k9zumECUrT34CCDGzps+cK+ahOIplWfPNR9r
        BlPDSXAjOXXr8etUeke94c9GGw==
X-Google-Smtp-Source: ABdhPJwGkJ0TXvfcvnLi89Ht5JLXKJ+TqLGZp0ZSYCdl953Pw0BxUPvwbBRH4Sp91og+mDF61+x5qA==
X-Received: by 2002:a1c:1f04:: with SMTP id f4mr3839872wmf.98.1611746770928;
        Wed, 27 Jan 2021 03:26:10 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m2sm2040065wml.34.2021.01.27.03.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:26:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 10/12] thunderbolt: icm: Fix a couple of formatting issues
Date:   Wed, 27 Jan 2021 11:25:52 +0000
Message-Id: <20210127112554.3770172-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127112554.3770172-1-lee.jones@linaro.org>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/thunderbolt/icm.c:122: warning: Function parameter or member 'xdomain_connected' not described in 'icm'
 drivers/thunderbolt/icm.c:122: warning: Function parameter or member 'xdomain_disconnected' not described in 'icm'

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thunderbolt/icm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index b8c4159bc32d0..09c4a84413ec0 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -85,8 +85,8 @@ struct usb4_switch_nvm_auth {
  * @set_uuid: Set UUID for the root switch (optional)
  * @device_connected: Handle device connected ICM message
  * @device_disconnected: Handle device disconnected ICM message
- * @xdomain_connected - Handle XDomain connected ICM message
- * @xdomain_disconnected - Handle XDomain disconnected ICM message
+ * @xdomain_connected: Handle XDomain connected ICM message
+ * @xdomain_disconnected: Handle XDomain disconnected ICM message
  * @rtd3_veto: Handle RTD3 veto notification ICM message
  */
 struct icm {
-- 
2.25.1

