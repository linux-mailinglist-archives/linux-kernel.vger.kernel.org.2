Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC93A05E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhFHV0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhFHV0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sl2hI9DkGhrHAF/gZGC77L8hn5lQAm7T18qsJ8qLvm8=;
        b=LrP5T1HfkeTiKXbPBAY63Labmx2dvQ78fKYVcJxLQZBs+TdxPLsbxNdZL5aOH7MVqXxL4c
        V0RNuNelU22hgSvwq20UWV4/pMZR8I1dqbiiAIsmvAVBvKzPLPDL7HflFEM0ngghHg15dZ
        8YczHybDtjUev8/oh/jq6kF1ry4qPng=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-kvzdOwl_PPe1JUbRGRhxiw-1; Tue, 08 Jun 2021 17:24:22 -0400
X-MC-Unique: kvzdOwl_PPe1JUbRGRhxiw-1
Received: by mail-oo1-f69.google.com with SMTP id i3-20020a4a6f430000b0290248e8fe5cbcso11273550oof.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sl2hI9DkGhrHAF/gZGC77L8hn5lQAm7T18qsJ8qLvm8=;
        b=HDSXX7FCQ26JsOR0R3iXiiPaXq5sTfxbK/utVDEH2R6a99rZ/7X7qLQMvJu3RLiJhg
         pKN+uzKY4praNDpjYD5zBm2WYNjhU6ekScAs47Tx2e7bXQT9/Y7Qj/M7pfS7C4BK9Yp6
         uB94xDZjcEQhUogdDNpjthCPKjyU3pl62IEEsD+RT2iFp3ro+1u+ESDRowYYYpk66fa4
         E+mgwjUB1KYAewyqawsJm298aTElCcvbamPy8HrW9pyKFvYWoOnAvOAR8r+fhy94QmLO
         8jNA6enQzVX7bcEmatJkzZSvBlWGfVC9voLLsy4/z05xs4O7ehqvQD0av2QFasJ3c+Tv
         og3Q==
X-Gm-Message-State: AOAM531CDiYleVjPPJKLY868p9t2FfQUHZbh0kzMmVd2leiOmOakMugV
        m0GXbI6dTy6CfjRRX6UI18PwiOTVthWhcft52ntFSRzkxR3sjURVVOpby8zLmmxMh1WisvOnVGE
        vKZ62tNxKeo4rub7uTi4VHVur
X-Received: by 2002:a9d:6042:: with SMTP id v2mr17663728otj.170.1623187461253;
        Tue, 08 Jun 2021 14:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmxpPWzOyTlGEiV6Av+AuPF28wy57ENACphojjEyHPZwmAPwtDFH5wKuVEl6aUMJEsLLhlTw==
X-Received: by 2002:a9d:6042:: with SMTP id v2mr17663714otj.170.1623187461077;
        Tue, 08 Jun 2021 14:24:21 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:20 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, robh+dt@kernel.org, hao.wu@intel.com,
        corbet@lwn.net, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gregkh@linuxfoundation.org, Sven.Auhagen@voleatech.de,
        grandmaster@al2klimov.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH 08/11] fpga: region: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:47 -0700
Message-Id: <20210608212350.3029742-10-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608212350.3029742-1-trix@redhat.com>
References: <20210608212350.3029742-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Change use of 'a fpga' to 'an fpga'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-region.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index c3134b89c3fe5..c5c55d2f20b92 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -33,14 +33,14 @@ struct fpga_region *fpga_region_class_find(
 EXPORT_SYMBOL_GPL(fpga_region_class_find);
 
 /**
- * fpga_region_get - get an exclusive reference to a fpga region
+ * fpga_region_get - get an exclusive reference to an fpga region
  * @region: FPGA Region struct
  *
  * Caller should call fpga_region_put() when done with region.
  *
  * Return fpga_region struct if successful.
  * Return -EBUSY if someone already has a reference to the region.
- * Return -ENODEV if @np is not a FPGA Region.
+ * Return -ENODEV if @np is not an FPGA Region.
  */
 static struct fpga_region *fpga_region_get(struct fpga_region *region)
 {
@@ -234,7 +234,7 @@ struct fpga_region
 EXPORT_SYMBOL_GPL(fpga_region_create);
 
 /**
- * fpga_region_free - free a FPGA region created by fpga_region_create()
+ * fpga_region_free - free an FPGA region created by fpga_region_create()
  * @region: FPGA region
  */
 void fpga_region_free(struct fpga_region *region)
@@ -257,7 +257,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
  *
- * This function is intended for use in a FPGA region driver's probe function.
+ * This function is intended for use in an FPGA region driver's probe function.
  * After the region driver creates the region struct with
  * devm_fpga_region_create(), it should register it with fpga_region_register().
  * The region driver's remove function should call fpga_region_unregister().
@@ -291,7 +291,7 @@ struct fpga_region
 EXPORT_SYMBOL_GPL(devm_fpga_region_create);
 
 /**
- * fpga_region_register - register a FPGA region
+ * fpga_region_register - register an FPGA region
  * @region: FPGA region
  *
  * Return: 0 or -errno
@@ -303,10 +303,10 @@ int fpga_region_register(struct fpga_region *region)
 EXPORT_SYMBOL_GPL(fpga_region_register);
 
 /**
- * fpga_region_unregister - unregister a FPGA region
+ * fpga_region_unregister - unregister an FPGA region
  * @region: FPGA region
  *
- * This function is intended for use in a FPGA region driver's remove function.
+ * This function is intended for use in an FPGA region driver's remove function.
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
-- 
2.26.3

