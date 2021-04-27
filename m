Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8353D36CA93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhD0RsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0RsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:48:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A136C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:47:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a4so60359329wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=4YNKwrbSH5Rvo37rqzZa8T4Lub6eWYDT8GYlkyyDYk0=;
        b=C8dHAVl38Pf5OiBKnYeqR4yQrqD3SxvRYXRFscwQp+Y91UOh/+OhBTX/3SrTyoPY1y
         ZSPDZv6w2LW6rRRKMGC0huKX+E3+8hXOM76CD01PuQsRXoN7/meuUpr8kqnVv9wXuBx/
         okw/ifFFZfN/609mLVtLB6gUlUkfE2Ogw5VyJ7nrZQGEAoNV3dWPtCmFMPB/znpan7oa
         sXxgRB1+t7zd8fZ+asmw+JmuXszcAWTWG7IPftOHLlCiWBkBJtkLFUPBOh5rVkp1J9aq
         9Ywtk99SKMA3ImR2uQSNhQXtL+OpKLodxC+tlJd1V8IowrfL2LlRUgdfval3sxqnhKmp
         obmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=4YNKwrbSH5Rvo37rqzZa8T4Lub6eWYDT8GYlkyyDYk0=;
        b=pY/yreyuQZBwsK9q3CziTWEM1K2FZ7s2hNLDZ5ApOYtVGStTVlKFwacS/UZFM9ET14
         BENW8L05DCzhRWHQVSC5wjbZjfNrYbvCU3A+WKymbuIQOb+/0fADA1PHvbnonWBdfhCd
         R1BzeK992FzDelQDRzHngHFgx2sW4NDAVe1vmytKmKGUdODBLiANkC6OILZJyfn+ithA
         4vPaCQhrl2ycgsrOV1R54pNXB0Agb1Jqj3U0VhCrhh9sxo9QxdIkfUMLh2xe0FJqBCkq
         gb7wdRo4FLkI55vfiuYbHNoS3w5a2ghMaV7VXDezyRyZo7RP2cItw9adVEFnzm01vw1d
         xa6Q==
X-Gm-Message-State: AOAM533WAvHK21a8f4fXozjSymEsjTbFhdhn3GWU6Lnp8hGPNIqkxLdR
        22Wh6s84XAjhKkqlTFKjFO0r1OZ3gznIkpfD
X-Google-Smtp-Source: ABdhPJyQWagRbNKnvuALypImjKzksqcPDteX3KMtMJwu1zocATBGwcgBG9ry/MFwPzFudi0zE5RVxg==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr16769606wrq.267.1619545641745;
        Tue, 27 Apr 2021 10:47:21 -0700 (PDT)
Received: from ubuntu (host86-178-35-221.range86-178.btcentralplus.com. [86.178.35.221])
        by smtp.gmail.com with ESMTPSA id i2sm2335534wro.0.2021.04.27.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:47:21 -0700 (PDT)
Date:   Tue, 27 Apr 2021 10:47:19 -0700
From:   Iain Craig <coldcity@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pci: fix a multiple assignment code style
 issue
Message-ID: <20210427174719.GA14124@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

avoid multiple assignments while setting pcie->io members to NULL.

Signed-off-by: Iain Craig <coldcity@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 115250115f10..f3b5b8ac03b5 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -306,7 +306,9 @@ static int mt7621_pci_parse_request_of_pci_ranges(struct pci_host_bridge *host)
 	 * resource manually instead.
 	 */
 	pcie->io.name = node->full_name;
-	pcie->io.parent = pcie->io.child = pcie->io.sibling = NULL;
+	pcie->io.parent = NULL;
+	pcie->io.child = NULL;
+	pcie->io.sibling = NULL;
 	for_each_of_pci_range(&parser, &range) {
 		switch (range.flags & IORESOURCE_TYPE_BITS) {
 		case IORESOURCE_IO:
-- 
2.25.1

