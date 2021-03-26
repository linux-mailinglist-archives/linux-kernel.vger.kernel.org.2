Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B6B34AA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhCZOgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCZOfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F8DC0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z2so5872348wrl.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJdO66bBiMjdzl40aPWSxjSxYbd7b06CD4GwxwSgEOE=;
        b=oVXBaSdzja21bLFS3YKojWhTspCiskPc7lUKekQuR/j9cR93Rwf9uysg2BjcZ9Z27U
         B2l2s8IIwAWFB9C6ncYz2DkG/DlgonSbi6LFDvDJmr3Z7alQ+o/MBmqKjBqPl37tfoa2
         1CupoabpsVd65MqH4Dl7w+RpMtLyfAyhy/9HLpFOYkyHlJHUIeNaKZx9t+HMITZB3SNn
         0qz/FJ0oD8bMBp9FGdQM/L2GiSPZLmMhklY/0ICvm6qU3H0nguYmjo77q4Ouk9K8obdN
         H/0MNhsikXBVl+w+KDM2jil8AJNJNsnjLShkFp/mfm+N9EjAkk7WoDDped3QJxIqXg8O
         H8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJdO66bBiMjdzl40aPWSxjSxYbd7b06CD4GwxwSgEOE=;
        b=bn+vRuWfy55LrKqznlT0ykkEFMdfqk7VVlF73ArJkq/0yfSr/uR2zYXHeYy+g+enT5
         /LVGqskDMFG1gw+suW5NajTDeK77yqedLvptyLqmCVVNqkehYZ37dwenVhsuJrRMO8G6
         k7K0gFOzbr/fseEGusKd/zLFtyAUhDZqw9Oc+bnKjjcl3AETvfJyz+K38YwEI6BZEEWi
         3Jkt4inl4brbV5l+mhZmXKZFXwZbEQYG5nykP5xoJF0Ope3VhPsM8+AKC+OQGWhqVZOi
         YACqVNFVba/B7WUhcMmLSoimnRf91LrMi7AezDicqkp+GoXs2lTw+X4yalfaPr/IGfiz
         J59g==
X-Gm-Message-State: AOAM533Q+ny0wO7OZOuyQZtA6i+ZrxT6rwpMOaJhGc/TsT63vK1Q3pWB
        z68W3xv3MkfzRhdN6pBBzr+TWQ==
X-Google-Smtp-Source: ABdhPJzcEyClgXLnv43H5eGGmUS6hcRJB94AGPu07sy9CmEwQHq2sO2bCC6k/4Kduzrxiv4bqTNuTw==
X-Received: by 2002:adf:90f0:: with SMTP id i103mr14537444wri.318.1616769315151;
        Fri, 26 Mar 2021 07:35:15 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Drubin <daniel.drubin@intel.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 13/25] HID: ishtp-hid-client: Fix incorrect function name report_bad_packet()
Date:   Fri, 26 Mar 2021 14:34:46 +0000
Message-Id: <20210326143458.508959-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
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
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

