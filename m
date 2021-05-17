Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D65538286A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhEQJg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbhEQJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A647AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pf4-20020a17090b1d84b029015ccffe0f2eso5230545pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGSkw9plKSGEMATCaLcpHeWn4eFphOp8VaY4MDSi/qM=;
        b=qMCB9Ekig2gSMHXO3XbCn65tfcNcqTKBVM7eane9V8M0N7So+zvNJzuDKzMo6ZPFpx
         8p4pEXqoEL3QLuKIdUhvml755hZRyopMCIzFH6E0eCYFnphplyJDEvEP84xCxZAoy03R
         umnkHxCTJ10rsutPqJgb/os4T/04c2PrvKcldxonf8CIqPcgFVXTsFz+vY2YfJAD39W3
         7wxZkO7NhYLVc+242E5Wxz4yMtg2M0WLP7wkvAa5JgwGFTgsvnsCcg6EpCK9PGqg4r34
         i2F3mfWeVKHoLH8QQ0c/pGZV5PXTyAE9vm2V9EoiH/ciaOjYFrzVAe5NBNudUzbMs8VD
         BZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGSkw9plKSGEMATCaLcpHeWn4eFphOp8VaY4MDSi/qM=;
        b=j/9KRtN4mvzAdu/Hut/zG1XwqbgKTuE7fY2lcL164sz1j+KROX1gOKyZkqe3tsq6wF
         uJi95Gu6fzjPH6UOqB8ro9HcA0xAWPncHGsLE2ZCkbMkd4FF2EOB7s+CUmBlOl1SLNbR
         mCdcq9/RKbBDvqTaT27wIe1j5vy9AvJ34YrJzkX1eNpnsfb4kZ9n0wRRFNRycwxqguqC
         ct6B9XY1Se0cKbV1Z2CdWy2YfXqLzKr/MEGdAEb7Ra9ek4TZXQc+bAsXpSyGc5Jq5cqX
         RY+Rz93CaeRmWbhdKlhf0AlFR5dpMpdQLosO5Doye1RIDCnNo8w3/Cihpy32tTZFpBaX
         GC3Q==
X-Gm-Message-State: AOAM533MqTOimlAdmad81wjCoW2a7woJWGeHfgGjh5OwL9ixN1HCbhQS
        WX/ATz/tgojPuCX4x8xVCnKG
X-Google-Smtp-Source: ABdhPJwiv3/4aQO31UJKBYSU38y5qhLVIiNR9YsXKNFSfnpMmAPUyGebPvSCvoDovHRL10E/AcT/oQ==
X-Received: by 2002:a17:90a:4588:: with SMTP id v8mr25823603pjg.195.1621244110293;
        Mon, 17 May 2021 02:35:10 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id q196sm1865248pfc.208.2021.05.17.02.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:09 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/15] virtio_crypto: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:17 +0800
Message-Id: <20210517093428.670-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now virtio_device_ready() will return error if we get
invalid status. Let's handle this case in both probe
and resume paths.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 080955a1dd9c..18f7ffc37738 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -393,7 +393,9 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	if (err)
 		goto free_vqs;
 
-	virtio_device_ready(vdev);
+	err = virtio_device_ready(vdev);
+	if (err)
+		goto free_engines;
 
 	err = virtcrypto_update_status(vcrypto);
 	if (err)
@@ -479,7 +481,9 @@ static int virtcrypto_restore(struct virtio_device *vdev)
 	if (err)
 		goto free_vqs;
 
-	virtio_device_ready(vdev);
+	err = virtio_device_ready(vdev);
+	if (err)
+		goto free_engines;
 
 	err = virtcrypto_dev_start(vcrypto);
 	if (err) {
-- 
2.11.0

