Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0974534A9E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhCZOfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhCZOfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C0C0613B4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b9so5845033wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdgFIP4Ey3DU3/Bk4Kw+HV9BNhlKbYnUBqgpZv4uG1E=;
        b=d6INxl4zZP1t4Ec5hvZNbzYKCqsprbycn/+myx5F8Ser+KW/Vh11ZMDbZZBgIsw4ag
         0QYJL4tsjV2fN3ea3Cy/icF6I2jfn9U62p1ekikhR+d8FHIAmdUAKVn8QaEzZHM/GM/n
         4p+V3u3VsUIMtGb3Jr2/uoE9M8IaRfgJwNSGOeNCiUCQ/iA2aKo3EBWI7wdLF3H+rDpK
         br/ahWUm+IbFf4kLHidS2k5krganrlvxzJjQvaMofKl5HoM/CnuD6CmwIy2AGqHrTqGI
         IuYbuNgDyoPuJhJvvG/fJHjN4MQSxTMrSX/mDqfhBrdJ7vK6a3n6/VQU57kBli1umuNn
         HTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdgFIP4Ey3DU3/Bk4Kw+HV9BNhlKbYnUBqgpZv4uG1E=;
        b=jmQR19jbiV2qk736a18MPZxnVRE/D6gLTIMoTlzZeaQb9vbELaa9pz659jddr3eG3N
         It/ZdNw03yffA50Zmt0rwgP2GdLaxxV6petUCawdv3qYRvWFp8AoACrLSX/yR+S5AkmT
         NMbfVn7sJgdP30dgQadvvq42eC6tv8KlRAwdq1xfZ9rvFlYgU5QP+mVmvCTXXnXBgERW
         IP/9puXTHMXOhmSJ5y+bAEFAdqbiUg2B9aG1J9R3Gwy96+/VlKYm9mBcmcZZZlUisSSe
         rKW6r7CMncL6+BeNjPAutuDcyyvpGUvvFXzt4WvS9JCOs7cYDyICE8i5fFStkV7CgJr+
         dwjQ==
X-Gm-Message-State: AOAM533ixaGc95uXnsaIsVVjk0TcxU+6Md4mvMs29jSaNRd0TiFULJp8
        yWQZuVfRwvXDElMlxVWdX0/2YQ==
X-Google-Smtp-Source: ABdhPJyXs3KlUi7iOdPWxatL4DJcaZHu6NnzdgGpexJkxA6o/CUtEyKwJ8M7M12AOQEZ/ApCaopMhg==
X-Received: by 2002:a5d:44c5:: with SMTP id z5mr14273093wrr.319.1616769307150;
        Fri, 26 Mar 2021 07:35:07 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 05/25] HID: intel-ish: Fix a naming disparity and a formatting error
Date:   Fri, 26 Mar 2021 14:34:38 +0000
Message-Id: <20210326143458.508959-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/intel-ish-hid/ishtp/hbm.c:409: warning: expecting prototype for ishtp_client_disconnect_request(). Prototype was for ishtp_hbm_fw_disconnect_req() instead
 drivers/hid/intel-ish-hid/ishtp/hbm.c:433: warning: wrong kernel-doc identifier on line:

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/hbm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c b/drivers/hid/intel-ish-hid/ishtp/hbm.c
index dbfae60f26216..9c031a06e4c40 100644
--- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
+++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
@@ -398,7 +398,7 @@ static void ishtp_hbm_cl_connect_res(struct ishtp_device *dev,
 }
 
 /**
- * ishtp_client_disconnect_request() - Receive disconnect request
+ * ishtp_hbm_fw_disconnect_req() - Receive disconnect request
  * @dev: ISHTP device instance
  * @disconnect_req: disconnect request structure
  *
@@ -430,7 +430,7 @@ static void ishtp_hbm_fw_disconnect_req(struct ishtp_device *dev,
 }
 
 /**
- * ishtp_hbm_dma_xfer_ack(() - Receive transfer ACK
+ * ishtp_hbm_dma_xfer_ack() - Receive transfer ACK
  * @dev: ISHTP device instance
  * @dma_xfer: HBM transfer message
  *
-- 
2.27.0

