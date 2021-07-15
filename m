Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5DC3C9A05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbhGOIDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:03:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF3FC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so3460259pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xi2yq/oMuht15dQIa5OENDEEfXt6Sk6oNQhem5EgmIc=;
        b=PD6osDaKmEg4991ZAy7bkZFu0PRrUtSiVdhfZY6EAVyI8436cndwKMiIp77h1uwPWj
         W3Mxz9tiPKEcvzhaNOtIEZyOI1C1MSiMKtzsu6PPfwoBmZbqwzcJu7SPXmHHAkGjyW0L
         RKD19HiqF46FsgMqZN9QTaTCBMVCJazHhCfOZuTd5OcAFD7wevzF6pBaZ52yCbbT1KHw
         Rc317/ds6GaDXPIEI2WQpWFDqUgn75ZZYXOpuvgbNMeUDO9exToD03PBAsj6RNF9x+WM
         e7VqGDff9dpPhcst9VhqZsXAkKT8Lc5mzuzHKTzjGtD4Y6kQ2JAhrP9Dp1NhgkRE9suU
         NdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xi2yq/oMuht15dQIa5OENDEEfXt6Sk6oNQhem5EgmIc=;
        b=WR2xur777kgAl9FL0tT2F8nXLzdNgIltEmdcdUdLKqTzj8cpCn3RnD1fY3ONmiTKmI
         lyc9DN1GjfyyHpc/pVc7OtnNx5H+KcEExmXnBrsEqRyH9MSi6P3NKXTQ/Z9o/Xe7yoJd
         RytYFxJFf/xA4ddcFT1kH4arxGDKil05s+KI6rFys5zxYcx6t0sWI9YYdLdwU0RGnOtO
         xQyKnP8EmOBuyzrP+LqRtgdXSlTxl14gn1hdKnXV+jfFHVSY9XwEFptdn5UqgdUmwXG/
         uhddZIUkH3+EheD6vzKROheD9kii/JkZCJGcErq1NSti19nIk3HFkoOLhRqyFMmJ4728
         8I6g==
X-Gm-Message-State: AOAM533qjm6MyKWp2SkbwgYaS8+Il+SukLLnMhdvgWOtBjSE/RXFDG6P
        6pd8Nszr2MSBjER+VHyFEsHM
X-Google-Smtp-Source: ABdhPJypXMnOzmRXkKaTTCEoi7Bsu3KB3exdQ8Ve5VxjEIJK6cYa4P7fQ+vHiI4ZykxKzwHGgakANw==
X-Received: by 2002:a17:902:e052:b029:12b:491f:4eb6 with SMTP id x18-20020a170902e052b029012b491f4eb6mr2476076plx.81.1626336042178;
        Thu, 15 Jul 2021 01:00:42 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id b13sm5968589pgk.66.2021.07.15.01.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 01:00:41 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] vdpa: Add documentation for vdpa_alloc_device() macro
Date:   Thu, 15 Jul 2021 16:00:26 +0800
Message-Id: <20210715080026.242-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715080026.242-1-xieyongji@bytedance.com>
References: <20210715080026.242-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of vdpa_alloc_device() macro is not very
clear, so that most of callers did the wrong check. Let's
add some comments to better document it.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 include/linux/vdpa.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 3357ac98878d..8cfe49d201dd 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -277,6 +277,17 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
 					size_t size, const char *name);
 
+/**
+ * vdpa_alloc_device - allocate and initilaize a vDPA device
+ *
+ * @dev_struct: the type of the parent structure
+ * @member: the name of struct vdpa_device within the @dev_struct
+ * @parent: the parent device
+ * @config: the bus operations that is supported by this device
+ * @name: name of the vdpa device
+ *
+ * Return allocated data structure or ERR_PTR upon error
+ */
 #define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
 			  container_of(__vdpa_alloc_device( \
 				       parent, config, \
-- 
2.11.0

