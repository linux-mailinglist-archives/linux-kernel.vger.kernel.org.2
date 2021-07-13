Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2778F3C6C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhGMIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbhGMIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:50:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA9EC061786
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1478470pjx.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdoZ+4EM7JCQgZ86bDT9RbGlh7q+AWgllGjoIYPWL9Q=;
        b=gA1/QgaUqMMGrBGGpEVYK8fMzHiF70tOx013tB9CxkOMsIAz6K9CyWbLukiYsceeeK
         WT3omC6T/UV02GbqJntqFcUEJy/CsH+2v38lltH8hTUVi5bDMirNFM2m8jsgCd53U/1v
         Lc/Oygn7Gsw282JeKIqoiMuvIbDZt/am73WeLkzOY2/CkX4nQAuUu3ul4s5GPTxJkyx3
         dWRyzileES+3pFwFh509M/IKBfUS06G83m9tPJd2yiq3RvUawNvAiQ6SGLm5AoV3JD3Q
         Yf50mdZiBV6HqGDPHp59XIyHUg9RniZUw56YWfFOmyWOXjXu+QsXkJ6TpitVDuk7cFO9
         CT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdoZ+4EM7JCQgZ86bDT9RbGlh7q+AWgllGjoIYPWL9Q=;
        b=O3uCWhBbl8qs17zbWCTYC9ZYWeKf8ruwBd3l3bnB1HZCCVbl/2jsrEFmTNoi7COE66
         dcQuJjway5zMr4OHx1EB98nfAdR/CmxXCV8hgFRT50CzywBiik8ok4uDRrVWXwlHTJEV
         y5VKunnh/kGMKUcqx6HKwPaMP/dRXa/YoI0B9Ell/9iMAyKHc2uh1Xo77mShf/BF6x9p
         poI9uG9tQLhsFZJS0nBR5gZJM5bd3DcBFvlEayo1pWeH3YIniUXwja8JAPbsraGeC6iT
         elZ6z3gCmNUwCs1objZ/prJ3iOwgC1jtKlJbIdw2gUmJ1rLxyjl7xgQjeXEH7zQPUXtr
         I78g==
X-Gm-Message-State: AOAM531wwycZM8mrpPwzsiZJJsPbUQXmI4772ko4LdAdnGKfUo7XY3H8
        JJb/ZohlL7sqouZ20C72CqoM
X-Google-Smtp-Source: ABdhPJy/YXaKCppxOExioeRxTLQv1sj8lcUHDptTXIY/sm3klehqPKR0QkOZNRfSckm4SM+jax8f+w==
X-Received: by 2002:a17:90b:1b4d:: with SMTP id nv13mr1935868pjb.216.1626166061630;
        Tue, 13 Jul 2021 01:47:41 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id w2sm15858457pjq.5.2021.07.13.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:47:41 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 05/17] vhost-vdpa: Fail the vhost_vdpa_set_status() on reset failure
Date:   Tue, 13 Jul 2021 16:46:44 +0800
Message-Id: <20210713084656.232-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-read the device status to ensure it's set to zero during
resetting. Otherwise, fail the vhost_vdpa_set_status() after timeout.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bb374a801bda..62b6d911c57d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -157,7 +157,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	u8 status, status_old;
-	int nvqs = v->nvqs;
+	int timeout = 0, nvqs = v->nvqs;
 	u16 i;
 
 	if (copy_from_user(&status, statusp, sizeof(status)))
@@ -173,6 +173,15 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 		return -EINVAL;
 
 	ops->set_status(vdpa, status);
+	if (status == 0) {
+		while (ops->get_status(vdpa)) {
+			timeout += 20;
+			if (timeout > VDPA_RESET_TIMEOUT_MS)
+				return -EIO;
+
+			msleep(20);
+		}
+	}
 
 	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
 		for (i = 0; i < nvqs; i++)
-- 
2.11.0

