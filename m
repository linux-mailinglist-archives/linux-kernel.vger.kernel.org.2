Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523164139F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhIUSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhIUSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5959DC061766
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id dj4so21716720edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+O516dRas0PleKnQD2Ngp8BTWaQ5AdYStSXmf67/51c=;
        b=oqsmYy/6SUD3hUAmrcTAMSupwoqpojay5ajo36ihbT/fIUKNVLCf/kPp8jC/ndbA+w
         9h4IP6PF4UQWqvZN6U8nxEK8gRXqxRBaQiAlOH1dYHcT8MragPGZ+RImcT8jOWECRT78
         UTjnoAcQIPDdhflM2+RWMixNQMyHYGFY4pv1LBV+xA+sEyRCEHYjjZ4sRfNzcGIR9+s5
         6z7c1lSCXZfqFTu77Dm9yRrSgZypDNq+dCvWPDwoBevIYrbYX3jUp2ui19ECiMZ+Dj2t
         0eG4hNty/3Vw0nGZc9NjW8uxNIvDw0Awnn6CEaxo80RoSROACkZIcCxuKH3UKpWMA9wh
         G+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+O516dRas0PleKnQD2Ngp8BTWaQ5AdYStSXmf67/51c=;
        b=FOWAJCIlLzuL2XHDBB1U7ui1Snmuhj3SbQAllAVnl7Frs//ZEA3F5xK8o7a+1lV0H1
         R6bhUqInjvYGVIa30D+Ge4VYzS3+Fak7ZVRKpao5WZX0T0e4wtGmP8H7zw33W+1EuYd/
         5rFwED6SCHVtlWkqnJ0JokZO8I2qfm/YTThGoWyb2GWtdtZgj97EwyCktOT3iFtlq+LY
         h9NmtJEo0+wTFrThEk4Zg98Ro8K7/Fna7w+rZpCycn+n7DcFYXpDqKDIgHM8Ivcf9mFs
         dZLVFNTFVKRQlV+P09YOboKX3CGGqYOYiNzBH457WBnLDbMNUtlsdHGAGG6HL/74+BuM
         myiA==
X-Gm-Message-State: AOAM530PtfRJ7Fg8gfSKzwAD3vJGnpKxwdFOAwDIV4cR8HWKSrzkF1U+
        cYxwsEwsJUF0w4HxBDGl/as=
X-Google-Smtp-Source: ABdhPJy9nwmv9h7+IIW2qIR4nN7Ie8v5Tsn95/dh2n7QCJiwTlFtt4JFkbIrI5aPXQHuypr2B+++qg==
X-Received: by 2002:a50:d88a:: with SMTP id p10mr32857947edj.274.1632248348706;
        Tue, 21 Sep 2021 11:19:08 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:19:08 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 12/16] staging: r8188eu: Remove a test from usbctrl_vendorreq()
Date:   Tue, 21 Sep 2021 20:18:30 +0200
Message-Id: <20210921181834.29677-13-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary 'if' test from usbctrl_vendorreq() because
"length" is never greater than MAX_VENDOR_REQ_CMD_SIZE.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 04a878c1a87d..b3f8a76b5db2 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -23,12 +23,6 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 		goto exit;
 	}
 
-	if (len > MAX_VENDOR_REQ_CMD_SIZE) {
-		DBG_88E("[%s] Buffer len error ,vendor request failed\n", __func__);
-		status = -EINVAL;
-		goto exit;
-	}
-
 	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
 	/*  Acquire IO memory for vendorreq */
-- 
2.33.0

