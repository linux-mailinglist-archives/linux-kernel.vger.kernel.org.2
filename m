Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F13D8E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhG1NIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbhG1NIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:08:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED17EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:08:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z3so1279637plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVck83D0NoOaryAJNBW2Tr6sIFbNz9st83cB9qkZAmE=;
        b=jpxCyVBc75tNPG7TUIVt1G6Yp0dNuCyuSP5giSiEpra3EqyGuLn1ms6d/NkpiFoDeM
         NbCZnk8yUDYpmOuhbzqYgKQwRVWu2846TAyFMqJ0Oms8o80Qg/Afaa34D7q2G5Y0F5bu
         R8JRL/dOjeaz24gxA5bxeKec6rAQymi0unqtl4ykNwOh1yd4ClJLLWRP4ArWTXoPYXRL
         yVJ4WjpVmQrP8dQMyloMqUBfTNgN2Ggn0PcvM5oeUBRaYGFnuUVGJEBvZ1b9iXpGdsVi
         mX3yhNi6P697qVtjIf3TEt0D2lJYhKhd61aFNPBIjFtBpfwhXul5WqPCe0APK+i0C5rw
         eeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVck83D0NoOaryAJNBW2Tr6sIFbNz9st83cB9qkZAmE=;
        b=KYGoKikzZh2XaLHO8p324uq3BUh0FjU8QykSiOVWoqFpaojOOkAbcAw9YS2HmWEwLo
         fNK99/J2k3q9NoV14WuYjSkpLn+mTKYH1IQc3naFyE+FpxgfSKIgbCyYqE6qCa4JM32U
         RKfqp76SLBjdTU1qY/JaUQPaTuJTfUrJIwuSk/vYieVTlKPxpjRcftrcKWN42qn3exi7
         Qe/LrTXIxK23XP5Kqr/cqd4RQa7XF3mDQ7XI0NU0PRFL+PY7V0PiwhU5FIuz/Nkv1Lia
         YB8kIM3pCMADbksAWFkq4XgOjrbw+ElLjxW1OJDzU69LoZeQSu641lThMEFQrXR80ib2
         mf+g==
X-Gm-Message-State: AOAM531xrcSNP3R4B4edjT5WFLOY3yJOfI+wRZ09dqrZ6q+gYrRqmARw
        FvRhCEtCvDo07P4ZDe68Mai3
X-Google-Smtp-Source: ABdhPJwj2LI9vbGMfkXYwFFfuFlaPN1nro+LXWdF//Skckn1NaJpVjkWhyNMGYrEPaeIXqt6PENYPA==
X-Received: by 2002:a17:902:d645:b029:12c:2759:ce2b with SMTP id y5-20020a170902d645b029012c2759ce2bmr12464164plh.58.1627477695330;
        Wed, 28 Jul 2021 06:08:15 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id m6sm8534165pgs.75.2021.07.28.06.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 06:08:14 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] vhost-vdpa: Fix integer overflow in vhost_vdpa_process_iotlb_update()
Date:   Wed, 28 Jul 2021 21:07:55 +0800
Message-Id: <20210728130756.97-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "msg->iova + msg->size" addition can have an integer overflow
if the iotlb message is from a malicious user space application.
So let's fix it.

Fixes: 1b48dc03e575 ("vhost: vdpa: report iova range")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 210ab35a7ebf..9479f7f79217 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -614,7 +614,8 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	long pinned;
 	int ret = 0;
 
-	if (msg->iova < v->range.first ||
+	if (msg->iova < v->range.first || !msg->size ||
+	    msg->iova > U64_MAX - msg->size + 1 ||
 	    msg->iova + msg->size - 1 > v->range.last)
 		return -EINVAL;
 
-- 
2.11.0

