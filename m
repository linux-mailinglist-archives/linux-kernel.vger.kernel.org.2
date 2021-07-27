Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5554D3D6E05
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 07:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhG0FYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 01:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbhG0FY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:24:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211EBC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:24:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so14338239plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eK8DOqvzTIA+QnY/7E9eUfZzzNYH4fK9bj2nYZkAiVA=;
        b=dteFSvxfHiolxWExFCYBJpIdo7z7XthW2duKjP9HC9nPVQnFZxCHAaDfYC/WnS+tCs
         Q7bfzBcs2VcLHnHdgtN3Yl58ZdpAMmqjlLP1IaZ/Zz2IWkg+K8X1xHO/NryCoqAItG1j
         Ou3dHWLNXdjeP8RiFRY7QG/mAu5B8BOCOUo7Fz9PPjJzpPQ6KnfiIoYkSrLMeIAf3DK5
         xfC/HxiYc/e+RUzrim8Jp8nO9FbXeM8NhSoG/OZitD3rrAtDsQ2aCIpDW9euJlXcQOO4
         9+wpvm7zzZyQRq8Yqvw6kLxNCjLqjObe0rjc6Bj577cCozYlzYviWuV5gAULASRIDxSX
         1azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eK8DOqvzTIA+QnY/7E9eUfZzzNYH4fK9bj2nYZkAiVA=;
        b=APDs1+PP0+hqnFio81lxrfxtMGx3hTBmY7cjkMrsIceTlxsjMuNnfWIzRf/mrDl5tZ
         0LoqHz0cy0kw+leNicSGOmAS2nq+aQLAAzDcUITyv7hSqIYo7d+KVNK+E7rXFpVpL3nN
         jjlcqm15R60xMAdWqXCL1TbtQc1tSqFzpKRqZB+JFvKsBtsMv/ai0F/Br6JGPqvX/yKN
         jVLW0qyB2elDRR4NKC66fEGTKpkMmffJlP9s/yFljb+94oIigpmYKK6M1eA3UTLHgeI2
         UIH1BobOe/fpu6PEbcSmn2W9g3oIcapiSXUPuXSUlwYg8z6ixxvfSmH4iFV9RtjFTeal
         +Ydw==
X-Gm-Message-State: AOAM531QgmAntOJYKGCoaRX4cigHah0au1mk8Xll7sT6+OC7Q08gUyso
        +euzMRedXzWmSGnBezA4423B0A==
X-Google-Smtp-Source: ABdhPJzRk7RQiqieWBYc81OTRLrRYzwmnBZjPv5WDsKGoRHCVQivVdcYtDMy5wkfqeCcdgrSLdnhHQ==
X-Received: by 2002:a17:902:e843:b029:12b:2260:b634 with SMTP id t3-20020a170902e843b029012b2260b634mr17178785plg.27.1627363465701;
        Mon, 26 Jul 2021 22:24:25 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id k20sm1263589pji.3.2021.07.26.22.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 22:24:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH V4 4/5] uapi: virtio_ids: Sync ids with specification
Date:   Tue, 27 Jul 2021 10:53:51 +0530
Message-Id: <61b27e3bc61fb0c9f067001e95cfafc5d37d414a.1627362340.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627362340.git.viresh.kumar@linaro.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This synchronizes the virtio ids with the latest list from virtio
specification.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/uapi/linux/virtio_ids.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 70a8057ad4bb..3c8e11820fdb 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -54,8 +54,20 @@
 #define VIRTIO_ID_SOUND			25 /* virtio sound */
 #define VIRTIO_ID_FS			26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM			27 /* virtio pmem */
+#define VIRTIO_ID_RPMB			28 /* virtio rpmb */
 #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
+#define VIRTIO_ID_VIDEO_ENCODER		30 /* virtio video encoder */
+#define VIRTIO_ID_VIDEO_DECODER		31 /* virtio video decoder */
+#define VIRTIO_ID_SCMI			32 /* virtio scmi */
+#define VIRTIO_ID_NITRO_SEC_MOD		33 /* virtio nitro secure module*/
+#define VIRTIO_ID_I2C_ADAPTER		34 /* virtio i2c adapter */
+#define VIRTIO_ID_WATCHDOG		35 /* virtio watchdog */
+#define VIRTIO_ID_CAN			36 /* virtio can */
+#define VIRTIO_ID_DMABUF		37 /* virtio dmabuf */
+#define VIRTIO_ID_PARAM_SERV		38 /* virtio parameter server */
+#define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
+#define VIRTIO_ID_GPIO			41 /* virtio gpio */
 
 /*
  * Virtio Transitional IDs
-- 
2.31.1.272.g89b43f80a514

