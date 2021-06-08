Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497BE3A04BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhFHT5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234625AbhFHT5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htxg7QFhlugIkUjEBRB6MmryeZkakMXu7uhWLDq62MQ=;
        b=fIySp3vH0eSj3hCLDeYg3V5APorNcyGv7OPMKijN9YBj/ZCjr+19w62vtiDi/yxEYJhirb
        RQyqmJxVyeBSm1mFJsEymmbXEzKAMs5ZtzrnDw9l5WVPKkGGli/x6ltdal2gNa5NREBMmF
        NXwIOMaQHB/fqLuvDeGegDGoH9LF8dE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-R6a5BbITN3ap0hLQNm78ZQ-1; Tue, 08 Jun 2021 15:55:18 -0400
X-MC-Unique: R6a5BbITN3ap0hLQNm78ZQ-1
Received: by mail-ot1-f72.google.com with SMTP id w1-20020a0568304101b02902fc17224cf5so14696319ott.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htxg7QFhlugIkUjEBRB6MmryeZkakMXu7uhWLDq62MQ=;
        b=qugGZPSomLSPpuCNw1g1TAk6o4CRh+W5n2AfsvLLrvjU4IX6k0x2h19Ww/cpSVybHH
         IgKbpHWWXkO+0D2ZJdR+PmvFyenEsxk608Q7hIpCADp3KMaSb8T6uxhHGceCtU2U8oTm
         opr+Nr5IBh/Pi8EgjHsyqFDGWkBoFFO8jmCz4g5adXXHdHl4pGNxsUZ2z1/upTRdss4c
         f3M7DlKmiEMMczkyLhHGrkvYcZ1pzGP36x3TusX72DI/1hhMuGsKASmV1ZY0ts948Okp
         /axVd1dC9xrcJJhKXamzcO/HKH2X9KWmVj4AfYRPa0jt/EC5Epek1XHNnXFDbOVjzfxv
         VnLg==
X-Gm-Message-State: AOAM531waZOeAiThh2kT418m5sDPh5hFHyj38N9zPHeuIvb8gEvFi3Pq
        1ag9RUbRQ/SpbEtx9vuoTxP56Ex4ruDS5PVM+CTPBXYsYcFEu7meWE0XyisDA56oUjVXoO5sd2T
        OlMVzYHKPxaTrc1YBsiugSOdV
X-Received: by 2002:aca:4703:: with SMTP id u3mr3955500oia.37.1623182117640;
        Tue, 08 Jun 2021 12:55:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkQnduqFmHXGXncV3/7jvv7BP7nZordQ4ddUIl4lAERn1K6+6xmEGbcvd4LPsWckV0CQEsPA==
X-Received: by 2002:aca:4703:: with SMTP id u3mr3955495oia.37.1623182117532;
        Tue, 08 Jun 2021 12:55:17 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:17 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 4/7] fpga-mgr: wrap the status() op
Date:   Tue,  8 Jun 2021 12:55:03 -0700
Message-Id: <20210608195506.3022550-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608195506.3022550-1-trix@redhat.com>
References: <20210608195506.3022550-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager is not required to provide a status() op.
Add a wrapper consistent with the other op wrappers.
Move the op check to the wrapper.
Default to 0, no errors to report.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c484b4309b2f4..cc531f0537acf 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -426,6 +426,14 @@ static ssize_t state_show(struct device *dev,
 	return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
+static u64 fpga_mgr_status(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->status)
+		return mgr->mops->status(mgr);
+
+	return 0;
+}
+
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
@@ -433,10 +441,7 @@ static ssize_t status_show(struct device *dev,
 	u64 status;
 	int len = 0;
 
-	if (!mgr->mops->status)
-		return -ENOENT;
-
-	status = mgr->mops->status(mgr);
+	status = fpga_mgr_status(mgr);
 
 	if (status & FPGA_MGR_STATUS_OPERATION_ERR)
 		len += sprintf(buf + len, "reconfig operation error\n");
-- 
2.26.3

