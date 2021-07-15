Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4BF3C9A03
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhGOID3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOID2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:03:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFB8C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:35 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q10so4377443pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjMzSWeTCK/CfwMasOtNqKKa11mu7wMZkdYved+KPaE=;
        b=X5RFVNPapfo8YaQaMThT4EV37esY/uwnclIV0AKCcaifq7mvPb90JleTAuq6qVc+wF
         oss8sZpJMZ5EhnIS35cswmNV0pTs9QqqlVXXxawAIRq8HW1Ir8l5VA1rsNVyW5Q+4sL1
         O4NSRgAlf9ETd7XkvuibgYtxnnhVT3D/jfBPDF08IcfD+qqQyp41Tq6FUTBVHbdWLB31
         rTagYhLgDeRpkXyh7Fs1UlpAVqABjo6t2BEypVrVjoYyhD1TwAsHqTknJajcnkYaJNQ4
         YX01+HAtoP+5cLcrx0qHq2OjkbbMFtQzVJTepVMstodZoa7SqrvKtq4uYKfTS4o4r16E
         vdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjMzSWeTCK/CfwMasOtNqKKa11mu7wMZkdYved+KPaE=;
        b=hvl6meUO3T6KoppQAhZlMXKxH6vvSYqfq2TgeOB/yrQbmnMt81pqu24b26IVrnvx7n
         YU1gj+Cj9K5+Cjkgs4QctEHVDe7rqaGOgEZTHudL9OMth7VGDT1HLfysZwOxy9a4LZtc
         H87RvDtdd9jdDP+FoNjVjWvPp+ayob4d7kRP8ihd4TMzxpcC2uMt5707l1BrfTHBuXrh
         9dJdSRm0rf0B3Ah5elsfw0+PipXVHNIMnRPxQ0f0ZAoG08saVRtRYfeI6Z7AQdLtgCfs
         OvU8niMRozG3HK2ajCtN58z3JQDjz++ep7jRFv8HhWXBkw65yetPXgQVYgJcCTrP5y/y
         jjkw==
X-Gm-Message-State: AOAM530wVpYVJqVITuvVTHgKeV3Unu7JyECFuOKhaazWYjdvEHkK8eQM
        VViiaGPtbEjePUqmZ1nJXKMA
X-Google-Smtp-Source: ABdhPJyo2Oyt/pQhdXYuGx/6Ou59dNw1mj9LdaWt5kV83PEc8dvRuMKPzqPPjUc/i7YV1KuyIp4uKA==
X-Received: by 2002:a05:6a00:cc1:b029:32b:8465:9b59 with SMTP id b1-20020a056a000cc1b029032b84659b59mr3345561pfv.66.1626336035174;
        Thu, 15 Jul 2021 01:00:35 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id z8sm5431909pfc.155.2021.07.15.01.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 01:00:34 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] vp_vdpa: Fix return value check for vdpa_alloc_device()
Date:   Thu, 15 Jul 2021 16:00:24 +0800
Message-Id: <20210715080026.242-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715080026.242-1-xieyongji@bytedance.com>
References: <20210715080026.242-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vdpa_alloc_device() returns an error pointer upon
failure, not NULL. To handle the failure correctly, this
replaces NULL check with IS_ERR() check and propagate the
error upwards.

Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 7b4a6396c553..fe0527329857 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -436,9 +436,9 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
 				    dev, &vp_vdpa_ops, NULL);
-	if (vp_vdpa == NULL) {
+	if (IS_ERR(vp_vdpa)) {
 		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
-		return -ENOMEM;
+		return PTR_ERR(vp_vdpa);
 	}
 
 	mdev = &vp_vdpa->mdev;
-- 
2.11.0

