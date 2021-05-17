Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32F6382885
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhEQJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhEQJiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:38:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B13C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so5229500pjp.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yD5HyGp3c5S++JQipHfU8Xx8Nzfr4K0wxo9vwzLPL4k=;
        b=HpXfO8jmOooeDGDsueFEjTzmU1KGGFTTnmHKnW4ML1nFkWcTV1J/VUFu+1qcVGT2g5
         mmBP0Pd/3/Z7GrbovL8xxVMn9UMVdEcUdxof/LYLtbpGYX1szJr/sJjsvibrju3viYGe
         bnq0NVcUTKKoHAU8QBluGUrku+Lq9DGg0Ke+2ZXlGkoH2ltM0ajS5B1Mt5L8kMOVC0h4
         IGwh+fDtmtZczxznn0ENbNISIjYB82MjH3GzMsSCEWRqVXZcpTFXS3bfi7Mb169nWF1D
         mvG6JWxfqrJ9/vgGnxBt1i2DXsuVbNDWNvRnxCvJqbPaXYxXy9cUC6W6fwA11eEj5qd8
         +RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yD5HyGp3c5S++JQipHfU8Xx8Nzfr4K0wxo9vwzLPL4k=;
        b=fldjlFqjZ/WyORusrSX43ORhwabZcP5SRxNvgsyV7F8HvCoGGdXyMwtHWHJaP1RASl
         NcAoBjSApqbGsqipdahIAOUYJ/vCuNyOEK/2aKGF8aP43bPP+nYUpHF0orrGmbK+fpZw
         imhXzdYhYrzQIWhSFUlOiQboUoednwCrkiv3dlAh7wba68qLisgVp8VBRpXmiBJ8O9HV
         E0JXA/Q1cyq0yFcGEK3nlKr4PUtUHDcm/1y+ZVaAGd0Z1isTTp5y50YkOWv5800wARlh
         /3WCW/Sp8czhZPS6Eokb26xVmARSOLzCeo8SDjjeGoy1S20cVp9c83IW3cWVSGSFVt67
         pu5Q==
X-Gm-Message-State: AOAM531p4yyNKfk6bNjnvzbKE2gqqmS2CBhQJUdTZfXtJczbYPUO/UNK
        Eg3O5MkVJ8yng2Rn81jzAu20
X-Google-Smtp-Source: ABdhPJwNrSg76mEZzUpIvS+Pegv8ZTqiJmc/m/PgB9pv2NZoiaIVjiMburSR0DQ7WknjI17VRF2QYQ==
X-Received: by 2002:a17:90a:6285:: with SMTP id d5mr44237420pjj.3.1621244152762;
        Mon, 17 May 2021 02:35:52 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a16sm9665241pfa.95.2021.05.17.02.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:52 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/15] 9p/trans_virtio: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:28 +0800
Message-Id: <20210517093428.670-16-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now virtio_device_ready() will return error if we get
invalid status. Let's handle this case on probe.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 net/9p/trans_virtio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 0960ed1ad7ac..6013d3761b76 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -617,7 +617,9 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 	/* Ceiling limit to avoid denial of service attacks */
 	chan->p9_max_pages = nr_free_buffer_pages()/4;
 
-	virtio_device_ready(vdev);
+	err = virtio_device_ready(vdev);
+	if (err)
+		goto out_free_vc_wq;
 
 	mutex_lock(&virtio_9p_lock);
 	list_add_tail(&chan->chan_list, &virtio_chan_list);
@@ -628,6 +630,8 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 
 	return 0;
 
+out_free_vc_wq:
+	kfree(chan->vc_wq);
 out_remove_file:
 	sysfs_remove_file(&(vdev->dev.kobj), &dev_attr_mount_tag.attr);
 out_free_tag:
-- 
2.11.0

