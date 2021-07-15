Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E5E3C9A04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbhGOIDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOIDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:03:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2652BC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id o201so4408592pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iFc+ibtp0UM6wHtuhwz7LidyVAVQrZxCrl5QWAnxgw=;
        b=DAGe6bIqCqf4YJTIc2XVAko7BBiqhBhM+cz7yEw7laxAOt3fKNmA65q9ZVPvQtDJYN
         Y/SALymCNeaXwH6tvE8l+ZJiEC4p8TEw8/pysMaWigP8517Pbqe/uki+P668tpKHfrkH
         21KOsMwnDhnmRc5yksXbcPrxkJk2dZTCJ7JPNE6pwoWLqKfhG00bmSe7g7NuAXJtPaXj
         xx6a5KQXZifdJHg7w74kRz7XCo2h7IDXeulrWSjbuPEfqjVxAv2coBFi5iYhiz3GbaZu
         RqfG/ZQIT30TDXLVM373R8a9B4CJVlwNbwPS1cJljiTkW/cfk5Pm+wmJfcqo80VAzzpW
         GQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8iFc+ibtp0UM6wHtuhwz7LidyVAVQrZxCrl5QWAnxgw=;
        b=cSX8fyz73UdM0pUNRmdpfT5Tb8mc4mP24D+vfIonhwBTOPXmRJ12AA7Qw3Vwngjnx3
         n1aHp9WlCSnZ/fbzmgy5ec2qswrsHp3iu9vkhv6Cw9mWumKf7nHmo+8Wupci4YVotzpL
         bcP08Ae0QP3ZFTK1yiyA/isuhr+uW0mBKk5FlWVQ8l+pH5g6KLbEMs/TqPM8bLe6Hgp8
         udAaClSTgHtKwy7JIfZDN3Kn1aMAx/2T0zDrcdHYFzDaijcJqPn0uP7E4cUgmzBWDYKa
         d5DMvV46XE5J5isCVOHtSFgk1AMifXzfyOkwPVM1suH/2XgqiBsTJLP6xxGMPcivwY3v
         RY5w==
X-Gm-Message-State: AOAM532GI+2mtBtoRgD6/BBRxI8o9TR3ahvDdH6bCMdAVf2ZVHyYgRvL
        Pf8lcUrDT+5U95jMuXWzmtU9
X-Google-Smtp-Source: ABdhPJwrgGCUaL4EYuk05ZGNSyW2jbmd+E7Vf1D07+DF6A2N+Bok4EoNSe06FamCpaKjSVXarVv37Q==
X-Received: by 2002:a63:5156:: with SMTP id r22mr3325981pgl.264.1626336038719;
        Thu, 15 Jul 2021 01:00:38 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id m21sm5801201pfa.99.2021.07.15.01.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 01:00:38 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] vDPA/ifcvf: Fix return value check for vdpa_alloc_device()
Date:   Thu, 15 Jul 2021 16:00:25 +0800
Message-Id: <20210715080026.242-3-xieyongji@bytedance.com>
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

Fixes: 5a2414bc454e ("virtio: Intel IFC VF driver for VDPA")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 21b78f1cd521..351c6cfb24c3 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -493,9 +493,9 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
 				    dev, &ifc_vdpa_ops, NULL);
-	if (adapter == NULL) {
+	if (IS_ERR(adapter)) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
-		return -ENOMEM;
+		return PTR_ERR(adapter);
 	}
 
 	pci_set_master(pdev);
-- 
2.11.0

