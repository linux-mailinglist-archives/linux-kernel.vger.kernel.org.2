Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563EB3C2520
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhGINpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231880AbhGINph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625838173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjO7PzMYDwKqWrTVmLCQJSFoOel7Kb6tJJsCfZrgkBA=;
        b=HozXq1XpWK0ajA2no/hoU0Eh+u1mLa4EW/gvxSjg8WmN7LmgEzgoEIDD0eVtpa7Vy3KEpL
        0o8n/lwiuY3KNvm3uuWuecPMDtLGgim7su/+vqkPFyWwqKm1QGNePLZpDMjeAbYG8xQ47x
        ZzWvmKuVYcCZIAGgaBpWjBRIrDU4T74=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-6_oaY1hlNziMpmeYotefzw-1; Fri, 09 Jul 2021 09:42:52 -0400
X-MC-Unique: 6_oaY1hlNziMpmeYotefzw-1
Received: by mail-ot1-f70.google.com with SMTP id 39-20020a9d092a0000b02904b4e396a9a3so2680671otp.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 06:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UjO7PzMYDwKqWrTVmLCQJSFoOel7Kb6tJJsCfZrgkBA=;
        b=NFdBKnsR+pnLDspW0MdM1c0/5OzeinO1RxMzfZJsD02eAn5lZFILCs9uqXSIlU81U9
         YRcDamAfjDrK6fjeGZkVbQk6gzCb4HZX+GKJrpv7UTTj/VyV1pWu2tm+XW4gzKqgFlc1
         Jv+NYWhHYQi4mH7hB1d04z7bW7iLshrf2FKGRGhP4hTr9WML4usV8mGGDOwVxgIhgqKf
         rRi1zs7gKDFXNGiJUmTbY8RWpRP710/PdN58/y0LAqLJf9NJlYSvJ+g/IPqAvcragt2k
         /PgVZKDxp6sc0bWbfIlGXYrlO5g+XHCQdoC60/WhwRvMOZ4dl/Rz5XG2lTQxOK1tdK9s
         XAFw==
X-Gm-Message-State: AOAM53011M9BVZvr7yDMG/tGrqLMhlGbiP7gGiSltkFFmeb8S8BvI7Qx
        dBbsxLXhHnxY9e/jGHnZoSKXlYqLqLxbF71OKeP3k6gAIc9WRv25cA7fuR4OoNeH33swxmzcdc8
        IODCL5uY6UwwDXsWmuNWlgGGS
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr27753473ots.246.1625838171650;
        Fri, 09 Jul 2021 06:42:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoYUu5i8N6kNaYl0+QLRwq8xSRtvtf+Xpkl+ciyEx190t+NOwxARHU2zfR4lvNfosXtdwtGQ==
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr27753455ots.246.1625838171426;
        Fri, 09 Jul 2021 06:42:51 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j23sm1215948oie.9.2021.07.09.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:42:51 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 2/4] fpga: region: introduce compat_id_show op
Date:   Fri,  9 Jul 2021 06:42:27 -0700
Message-Id: <20210709134229.2510349-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210709134229.2510349-1-trix@redhat.com>
References: <20210709134229.2510349-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The sysfs reported value for compat_id is implementation
dependent.  So add an optional op to fpga_region_ops to allow
an implementation to override the default.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-region.c       | 3 +++
 include/linux/fpga/fpga-region.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index dfa35c2dc2720..864dd4f290e3b 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -169,6 +169,9 @@ static ssize_t compat_id_show(struct device *dev,
 {
 	struct fpga_region *region = to_fpga_region(dev);
 
+	if (region->rops && region->rops->compat_id_show)
+		return region->rops->compat_id_show(region, buf);
+
 	if (!region->compat_id)
 		return -ENOENT;
 
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index d712344fd00a7..236d3819f1c13 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -12,6 +12,7 @@ struct fpga_region;
 /**
  * struct fpga_region_ops - ops for low level fpga region drivers
  * @get_bridges: optional function to get bridges to a list
+ * @compat_id_show: optional function emit to sysfs a compatible id
  *
  * fpga_region_ops are the low level functions implemented by a specific
  * fpga region driver.  The optional ones are tested for NULL before being
@@ -19,6 +20,7 @@ struct fpga_region;
  */
 struct fpga_region_ops {
 	int (*get_bridges)(struct fpga_region *region);
+	ssize_t (*compat_id_show)(struct fpga_region *region, char *buf);
 };
 
 /**
-- 
2.26.3

