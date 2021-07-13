Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9723C6C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhGMIvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhGMIut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:50:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90197C0613AD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p22so5974793pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79+lwfgqPqTMCDJYOtelsxZhwWsCxwv7dGGvPGe+0Sw=;
        b=XPYV6AqgUbZp6+vdppARBpAYCPqTsziLqNwvNsrjLuNKQsh6GS3q19GuTFueLqfI3W
         2mpioxtWWYo5lHGzcp+Jutobs4GmHGUTQiIvyRJOrhRaSYEd2g13fYjJdx8IqQbpVtg+
         U5M3F2NmfDR26UxFi92Yzg5HX/fYV6AYnZdE6d7ugOH+Y9vAV4e5UbOMWrmsG3AqiEzX
         NUPQt8B7lzQDca2Wt8iUkhnTLPaw8kJJmv71Rv4l+iNrRzjIvV51afp0ikEMovNJIa3w
         l3GoRQ485RyPX6RthpBauL0J2/vlNzokMcWZNI71JmewCwtjndkIJDGd4VS80mquizHp
         zreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79+lwfgqPqTMCDJYOtelsxZhwWsCxwv7dGGvPGe+0Sw=;
        b=gEJaHYM4QxkAP03llYwWamnpF43SpmDhzunwG5fP8QZmvs3BMFsFTnMPKEAUNbtw7P
         6KM9vQbd0G2BYGGbHk4anakY2WAvr2FK6smHNg8c6FFltl83IxkujYzCG4Tcb7zD4151
         AWMeh5rNkXtiJt3rQAf4c5fFL6+5bzgWPB3Wm+4yJforluNd7/1xr4zrcVni1a2RBWAW
         3AEMuZpm8ECfS8CpHzeI39yeI/SSbM1kyhAVBlPvY3beDCOx2Yew3R8MH+ybfLOmn1+9
         i6zh+z35R3Z6L7ez4abCOPLHZhi2Qx9CEGgOQmYUYNBSNruM+UEAg3VcIIxg5OYtcvrP
         7CbQ==
X-Gm-Message-State: AOAM533Ud/0IParwh3TUlzMJGKkocXFQ3ThNZYpqi4fvBCoKrI6hzXJh
        RgI89z5c8pfD0AxfpzyHn1GN
X-Google-Smtp-Source: ABdhPJya/3d83k8xmEEz7mxN/KfDFTYEWfRDpJqmURKX4t0jIlbAdO7JalzXWyaKhiHPR7hvAQh/zQ==
X-Received: by 2002:aa7:808b:0:b029:2ef:cdd4:8297 with SMTP id v11-20020aa7808b0000b02902efcdd48297mr3574498pff.27.1626166076154;
        Tue, 13 Jul 2021 01:47:56 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id q21sm11607775pff.55.2021.07.13.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:47:55 -0700 (PDT)
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
Subject: [PATCH v9 09/17] virtio-vdpa: Handle the failure of vdpa_reset()
Date:   Tue, 13 Jul 2021 16:46:48 +0800
Message-Id: <20210713084656.232-10-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vpda_reset() may fail now. This adds check to its return
value and fail the virtio_vdpa_reset().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_vdpa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 3e666f70e829..ebbd8471bbee 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -101,9 +101,7 @@ static int virtio_vdpa_reset(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 
-	vdpa_reset(vdpa);
-
-	return 0;
+	return vdpa_reset(vdpa);
 }
 
 static bool virtio_vdpa_notify(struct virtqueue *vq)
-- 
2.11.0

