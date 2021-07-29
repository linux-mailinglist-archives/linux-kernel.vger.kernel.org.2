Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF83D9EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhG2Hgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbhG2Hgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:36:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F86C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so14251576pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvd20FCyGBljiGWMWOaikLGhtJL5n9pTt07FT1J+Aso=;
        b=fAKGRkP44Owwu4WMhbWuGxtEfRuOu4Cliti37qy1QkYokdFasOrHiHEwVppycUJDa3
         xeF9kkZtMqWVQcXx7XKdtgFjWeO1NCyZDLh3+kz3ApKsTKIU6gaqywKHV7mpMcUCrFV3
         zT4da+pmxdaGZe9kwFsedZAB26Rx93mb10YQroc3l8UwUi3VDv4fFVk6HznSiU7KP12l
         QvFB2dhPB1pvedlwjBrG+DbUl0EvD8waTHUa//y24vFctO0KTfe/zUc5erne7P/i6vAi
         PVBkdkxGHNypwS6VxgwTCHPCV7C/7vCsjPYfvADjwRWrvD7pN6kCS8dvfPAuJ1QD2QfH
         GWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvd20FCyGBljiGWMWOaikLGhtJL5n9pTt07FT1J+Aso=;
        b=KPfizT8FMzvNh28MX2ZbMWe5MoucdqwyDdq1bRmjnTyH4ORfrDE8tN4hJuSWDJmfyt
         7EH4Zghp6prNF+lRJaDGU5kTNPbQYFCgD5B2PlbY5ezgXcl2E7geSC+MFHExY0pdsjep
         afB+gTiIndSUsIK2Y04gIZpWpG0cEiD8IpDhDmJWBU+hll7mhEamKwHbwNeCaSMdNDiq
         tKE+Qj9q8AptIwu4IE+8YyKQUcI/mQyPUSVJbV3TyXEsSkcKfF9YP+mjAmuQ36HzteLI
         QslMc2/JmOX64O/46yqeulxqhk8So0SawvhHWUVwDsOxG87hoi8ifdtkNY+bZJ7pT1I0
         8hlg==
X-Gm-Message-State: AOAM531U/IWxZd7Kmu/VhLhA5tVTz6fwzyBBnQlZPqcdCKwgtOw2OglW
        C3u2aadD/t16yfhJly6YDvvu
X-Google-Smtp-Source: ABdhPJyVF72gj48BOfkqvU/dMdWjVFFjQBW8Tk1dwBDWNR4fUvBJh4VyPTlJiE+Mwgcny9FP/ET49Q==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr3901952pjj.233.1627544189208;
        Thu, 29 Jul 2021 00:36:29 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id i24sm2382500pfr.207.2021.07.29.00.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:36:28 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 06/17] vhost-vdpa: Handle the failure of vdpa_reset()
Date:   Thu, 29 Jul 2021 15:34:52 +0800
Message-Id: <20210729073503.187-7-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729073503.187-1-xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vdpa_reset() may fail now. This adds check to its return
value and fail the vhost_vdpa_open().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index dd05c1e1133c..9a00b560abad 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -116,12 +116,13 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
 	irq_bypass_unregister_producer(&vq->call_ctx.producer);
 }
 
-static void vhost_vdpa_reset(struct vhost_vdpa *v)
+static int vhost_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
 
-	vdpa_reset(vdpa);
 	v->in_batch = 0;
+
+	return vdpa_reset(vdpa);
 }
 
 static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
@@ -872,7 +873,9 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 		return -EBUSY;
 
 	nvqs = v->nvqs;
-	vhost_vdpa_reset(v);
+	r = vhost_vdpa_reset(v);
+	if (r)
+		goto err;
 
 	vqs = kmalloc_array(nvqs, sizeof(*vqs), GFP_KERNEL);
 	if (!vqs) {
-- 
2.11.0

