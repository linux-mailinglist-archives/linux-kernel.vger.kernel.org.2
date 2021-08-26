Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272653F8846
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbhHZNEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhHZNEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:04:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A3C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:03:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id e21so6054824ejz.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWlNAP4uAjjXML5Q2n9AQSabtDy+TUTfzJ5X6D2qTQc=;
        b=nmLJwMIYb4+Bxqi41+nhIFsTT8OfKCjsrxsuKBPjVvE0r28f8wmaDuF/H1cWJpSUxD
         KPqkwQShQ0qb4sWeOkWCvgdLrspjL1Q3iJKAd9tFn9RYF8TZ+quNwn9z9K5ixuK8H5nR
         kphe5xc9zrD5/RgOOiOcpV4wgmfEjGfrHgQN0PWwkpNc4MM5uNyhktKPZFfkNTYqfVJA
         zuIoOujUlxKin8PPHycwP6eYunPmF17/l/OHJJOTNgEKd5jppzFFzj9UTFgvqlxV6NP0
         X+HizFIB5i1tCp26TZkZiMAMmDZv4gEJyEOkgZ9iH1yTYMKsRepouujmrKetwrvc6TPw
         tr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWlNAP4uAjjXML5Q2n9AQSabtDy+TUTfzJ5X6D2qTQc=;
        b=RA3EfMftgSpgdMHl956MtALNfXFTUe8MlOOmy4bZW3SiRrTOZM52kQbdUMi6iOT27/
         qkjnddVNcSmH2Rh5ZMjKwHsaHCLry9qlClWErn1rpCbqW2Z1LuR7f9j24othWO4mlM8q
         FHAY8ZTCEhwgMdPd41ZGK/93wpXVvVki3MaGZZFgltOXTwMt7OtYTMSzU+bdWi8665KG
         pRhUof0f0rDLpz7ZmtcK8vX20zFJ5Tu2Q8TbpLBmiC4ae50gaoFaNWBzprWGUXlimAXS
         sl/IPXSnjiPX5L54un30V09bu78YVcrAB2OAe6AwB7GB3XDgNoe41dfd6xOFI7xG1Pbk
         uG+g==
X-Gm-Message-State: AOAM533hvXzsJz6Myw20Hqb9HAQVzfJu7La1qvGwQxIpzCnd0GwSR3J3
        iPphLMWwa87Ov2DV+E1PILs=
X-Google-Smtp-Source: ABdhPJzN1S9CVoUuQAghjzLVbmPpJgODWnrSK+IyXEQsd/Gxq5BfSF2lcGux3i8vomMNAUfn2egR6g==
X-Received: by 2002:a17:906:3497:: with SMTP id g23mr4217118ejb.85.1629983026651;
        Thu, 26 Aug 2021 06:03:46 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id o26sm1399916eje.24.2021.08.26.06.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:03:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: r8188eu: Provide a TODO file for this driver
Date:   Thu, 26 Aug 2021 15:03:42 +0200
Message-Id: <20210826130342.9552-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a TODO file that lists the tasks that should be carried out in
order to move this driver off drivers/staging.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: According to reviews by Fabio Aiuto <fabioaiuto83@gmail.com> and Greg K-H
	<gregkh@linuxfoundation.org>, remove "[] is currently in development...",
	indent and properly wrap the lines, remove the unnecessary last paragraph.

Thanks to Phillip Potter <phil@philpotter.co.uk> for for providing the first draft.

 drivers/staging/r8188eu/TODO | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 drivers/staging/r8188eu/TODO

diff --git a/drivers/staging/r8188eu/TODO b/drivers/staging/r8188eu/TODO
new file mode 100644
index 000000000000..d2f21b35fbcb
--- /dev/null
+++ b/drivers/staging/r8188eu/TODO
@@ -0,0 +1,12 @@
+To-do list:
+
+* Correct the coding style according to Linux guidelines; please read the document
+  at https://www.kernel.org/doc/html/latest/process/coding-style.html.
+* Remove unnecessary debugging/printing macros; for those that are still needed
+  use the proper kernel API (pr_debug(), dev_dbg(), netdev_dbg()).
+* Remove dead code such as unusued functions, variables, fields, etc..
+* Use in-kernel API and remove unnecessary wrappers where possible.
+* Remove the HAL layer and migrate its functionality into the relevant parts of
+  the driver.
+* Switch to use LIB80211.
+* Switch to use MAC80211.
-- 
2.32.0

