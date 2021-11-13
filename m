Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9543C44F5A0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 23:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhKMWP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 17:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231129AbhKMWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 17:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636841585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yVoMOfDwy8Q0m/39gh0gDNPU0gOTI/GsdwFXBbgGHLc=;
        b=JQPCefiBs3gqQc+yirk0ZeoQa6lC9Y2i446RVrDtT28nO5Gbif8LdJnvVVpan5zEwtec4D
        GFGO4yGcw6MXWHbv9RDH9R21Ann7XygDufplYdl/9Bs/UCHTpq2QLOP7nAXqxzgPQn91Cz
        jHTNFs818OVuyZ+57BSP3va8OIiYuYo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-INELyM9yOWmQexlwFsXoZQ-1; Sat, 13 Nov 2021 17:13:03 -0500
X-MC-Unique: INELyM9yOWmQexlwFsXoZQ-1
Received: by mail-pj1-f70.google.com with SMTP id a16-20020a17090aa51000b001a78699acceso6450085pjq.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 14:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVoMOfDwy8Q0m/39gh0gDNPU0gOTI/GsdwFXBbgGHLc=;
        b=KGAdo/uLkQelNtcwMDum5KFaZ5Up2zZFXJtG1+rhBwb2MidAFYjI6z8uaeifJNjeYC
         EU3p2VNNImT8OrZVFtfXUFvmuEkDjevLfKVihumtCPTP/pVBUmzGWyG2YJbwik0bkH9v
         etkuYsfUt+y78ww8BZdIkgTqFFQ4pnhtfWTJeDGY3ToC8qo1G2fZBPBkZB0FSwBZSW+f
         MyyWW92ZMhu02+tboE+vWJ6ZLv8+iaJlIrrDvX24yJ36Usy4YX27gqYuCbj9ueNFOXrN
         x3/ejWCPsKDgU/lhy5UexuwhNc4C3+qRFQbguZlMHDFsoLCbTRfr71AoCnwC7iXgydH8
         w+gA==
X-Gm-Message-State: AOAM5307v1uY7wN8LkQ7ni0nNoB7fdH6A8okPRZ7vuvaMs2JiVfQmn+A
        JaP3hziadxHc5uhDnMcUhKMm038w42FIygwlpL4wD/t9W9R73IHEOBlEAloy1qTo2cjjOdrPYRm
        isc0h7PGUXrEDXAEYdrC8clCH
X-Received: by 2002:a05:6a00:ac1:b0:44c:4dc6:b897 with SMTP id c1-20020a056a000ac100b0044c4dc6b897mr23381716pfl.25.1636841582788;
        Sat, 13 Nov 2021 14:13:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZMYhHkvNs9tAiwjcm5+NqPix2hrqBvesc82Cx/xOQI7yWfXLU6nEamlLc+J8xq/t8pAiAoQ==
X-Received: by 2002:a05:6a00:ac1:b0:44c:4dc6:b897 with SMTP id c1-20020a056a000ac100b0044c4dc6b897mr23381699pfl.25.1636841582534;
        Sat, 13 Nov 2021 14:13:02 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j6sm7908688pgf.60.2021.11.13.14.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 14:13:02 -0800 (PST)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, yilun.xu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fpga: dfl: pci: generalize find_dfls_by_vsec()
Date:   Sat, 13 Nov 2021 14:12:52 -0800
Message-Id: <20211113221252.4062704-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

find_dfls_by_vsec() is a general dfl function.
Although dfl has multiple vendors, only Intel is supported.
Move vsec and vendor id to an array variable.
Other vendors can append the array to enable their support.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-pci.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 4d68719e608f..9dc0815c8274 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -136,19 +136,36 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
 	return table;
 }
 
-static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
+struct dfl_vsec {
+	u16 vendor;
+	u16 id;
+};
+
+static struct dfl_vsec vsecs[] = {
+	{ PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS },
+};
+
+static int find_dfls_by_vsec(struct pci_dev *pcidev,
+			     struct dfl_fpga_enum_info *info)
 {
 	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
 	int dfl_res_off, i, bars, voff = 0;
 	resource_size_t start, len;
 
-	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
-		vndr_hdr = 0;
-		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
+	for (i = 0; i < ARRAY_SIZE(vsecs); i++) {
+		if (pcidev->vendor != vsecs[i].vendor)
+			continue;
+
+		while ((voff =
+			pci_find_next_ext_capability(pcidev, voff,
+						     PCI_EXT_CAP_ID_VNDR))) {
+			vndr_hdr = 0;
+			pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER,
+					      &vndr_hdr);
 
-		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
-		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
-			break;
+			if (PCI_VNDR_HEADER_ID(vndr_hdr) == vsecs[i].id)
+				break;
+		}
 	}
 
 	if (!voff) {
-- 
2.26.3

