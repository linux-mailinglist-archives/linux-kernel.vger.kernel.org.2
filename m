Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867CE3D8E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhG1NIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbhG1NIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:08:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9589EC061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:08:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so9908523pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XX70o1X1Cgw4fNpu8tzLJbjLTB/dJBQIRbJuCgl7gAQ=;
        b=qjJyVPD23XAfvIMFBK0k3lyIPRo9qGbjwyUTtkfxUEQQduxjqJNo1w3+PU5CfpsMmn
         waiUcOznQY7k7MkpnHIzRDkQ8WCOyVySkwmoWt3E2YVUmR1Oc+Ia/TuihSWljmPrwNkP
         YLdTeervyYOsboUmbGXkh8awIeQJeR4eKFDHzB/ItLEkL2FLeYEG7vG8zrffMZr4qoIR
         38tzc3iwVD5lsmYgMSVpahKHc7Tdd4oJR+tuXwa/GODFxCy7bg3slQdCio5v5xl239k5
         AZau68DzYxvhjXBVylam9VNmDAHsmH4DJ+vERsePgfh044NfG8Z+BJZrha2i12Sx6pCA
         Abzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XX70o1X1Cgw4fNpu8tzLJbjLTB/dJBQIRbJuCgl7gAQ=;
        b=X3z7zxaV1eYzXXEJuFBIXPwrrsjzBtF27TF7d6rw1JkhWxGQO9dau68SS5daNGZsc+
         La2Of+0pDLolRCWKeXtj+v/ZNn4QVF8r2tP9Y3HDkv3anjf9iPegOmIMrPSjbshXjB30
         IO6fjlvkuVSz1O6q0Txh/LPQjhTzITNXN2VCyz7AE6sx1iXbL0K0VOeknb56R+1hHIVs
         EYn3yWOwk29iBpdAhDuIAEgXeZOvRK2FHo9uLYG9TARXYpm568i49VpLpK9uhoYX5BWo
         +qF/MmnqYwm6ov50L4g8J1CKyNVQBGVLfoWGy8sb1Gyziy4/o/gdMZ2KFhWK/v9E76ZA
         1LEg==
X-Gm-Message-State: AOAM530scFI8AMR6iOE0S0kn5hy37Fqx4Lc1KihBGJPv6NHus6w5pgQU
        DPpiQutPbOmJ/7rnfBG11C6o
X-Google-Smtp-Source: ABdhPJz3HJJEY5ok/VLZC6bllUI2mC3K2btVzbWJ0mXyY5ky7iNv19XOgPjBOh4gziWaD4gfyYcEVw==
X-Received: by 2002:a17:902:db0f:b029:12b:880b:ef38 with SMTP id m15-20020a170902db0fb029012b880bef38mr22513206plx.5.1627477703192;
        Wed, 28 Jul 2021 06:08:23 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id j128sm7789048pfd.38.2021.07.28.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 06:08:22 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] vhost: Fix the calculation in vhost_overflow()
Date:   Wed, 28 Jul 2021 21:07:56 +0800
Message-Id: <20210728130756.97-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728130756.97-1-xieyongji@bytedance.com>
References: <20210728130756.97-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the incorrect calculation for integer overflow
when the last address of iova range is 0xffffffff.

Fixes: ec33d031a14b ("vhost: detect 32 bit integer wrap around“)
Reported-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b9e853e6094d..59edb5a1ffe2 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -735,10 +735,16 @@ static bool log_access_ok(void __user *log_base, u64 addr, unsigned long sz)
 			 (sz + VHOST_PAGE_SIZE * 8 - 1) / VHOST_PAGE_SIZE / 8);
 }
 
+/* Make sure 64 bit math will not overflow. */
 static bool vhost_overflow(u64 uaddr, u64 size)
 {
-	/* Make sure 64 bit math will not overflow. */
-	return uaddr > ULONG_MAX || size > ULONG_MAX || uaddr > ULONG_MAX - size;
+	if (uaddr > ULONG_MAX || size > ULONG_MAX)
+		return true;
+
+	if (!size)
+		return false;
+
+	return uaddr > ULONG_MAX - size + 1;
 }
 
 /* Caller should have vq mutex and device mutex. */
-- 
2.11.0

