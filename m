Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110853148CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBIG0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBIGXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:23:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FE2C0617AB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 22:22:19 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g3so9183457plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SQyVkSYwcHNPQBFHoCQtFFFjCENqy21v8WbruxTyIQ=;
        b=S8b7bks4s14Aq0h3NWBRKYyM5rNroqOh0mjkOQqRPPLHlWF1b/82tP2JW6Ak+XahaS
         vuqFZkcLranydMu7pllFHxd5nuNgxoGZIBPnWrP05Of2B7XaG8dtqQLOaoHbIZQ1OzXK
         3qWvUM55PHjPtT5jCfFBuHsTloYPqv037Cmok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SQyVkSYwcHNPQBFHoCQtFFFjCENqy21v8WbruxTyIQ=;
        b=kvVXtOQVuWN2DARWY8F4lpSuZe5fcSdAPE1qES1kR41gldCuJtVQi+chQpyVxPmWJU
         Sn3aGGwej0ZbptMa4ld9DFlokY3pIK0zLmRcB07xGElWpUbbC2QGq5zPPwoJDuufAbbL
         Suo7CWv8szTJ0mUyj6+eo7FlD01wVl8j7HHczcRkGgnVTU2VtCHdFt94Ud+0Cq0DPJZn
         5faa2Bg67bQKhxeDSVVFeWzWEW7/PsIFsR/8DtmHtTaA+eInmYTg1NNZAJHZGRGl5UfS
         INPeOxilMFL0TQh/ZZkMzlsVXOvkAl6a1HA5TNIhB8Vt0VASmZsctypOa/EZuHiL1ysY
         ariA==
X-Gm-Message-State: AOAM533tgp19W9m0uMoY9my9wYfAV0y+65fw3IY1g1Ii3xz5T7fR7Ymp
        kODzPnCS2IVt1v6rSsgs7J+ikw==
X-Google-Smtp-Source: ABdhPJxcpi2bQzo5Ag59ySIm3BqsShiYpJbthB3TKnbwDYfpDCilPQMTJU6vCjKSHchn3Ia3PqrJPA==
X-Received: by 2002:a17:90a:654a:: with SMTP id f10mr2534268pjs.202.1612851739435;
        Mon, 08 Feb 2021 22:22:19 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
        by smtp.gmail.com with UTF8SMTPSA id g17sm21205826pfq.135.2021.02.08.22.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 22:22:18 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v4 05/14] swiotlb: Add DMA_RESTRICTED_POOL
Date:   Tue,  9 Feb 2021 14:21:22 +0800
Message-Id: <20210209062131.2300005-6-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new kconfig symbol, DMA_RESTRICTED_POOL, for restricted DMA pool.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 479fc145acfc..97ff9f8dd3c8 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -83,6 +83,20 @@ config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
 
+config DMA_RESTRICTED_POOL
+	bool "DMA Restricted Pool"
+	depends on OF && OF_RESERVED_MEM
+	select SWIOTLB
+	help
+	  This enables support for restricted DMA pools which provide a level of
+	  DMA memory protection on systems with limited hardware protection
+	  capabilities, such as those lacking an IOMMU.
+
+	  For more information see
+	  <Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt>
+	  and <kernel/dma/swiotlb.c>.
+	  If unsure, say "n".
+
 #
 # Should be selected if we can mmap non-coherent mappings to userspace.
 # The only thing that is really required is a way to set an uncached bit
-- 
2.30.0.478.g8a0d178c01-goog

