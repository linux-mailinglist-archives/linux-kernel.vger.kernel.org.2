Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A0C42991F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 23:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhJKVuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 17:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhJKVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:50:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F6C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:48:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e12so60408309wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=w+0Wu3dI7YPT16UswJ5OR0p3TmTEyKkuKUSvBshjyLg=;
        b=mvZ8ux77RQcyz+njYb6YnApGlh7sPl+4RoU+lS2Pe/1R9WfF2ZefGV+XFzaefErqi2
         jlqthwAFpi4Gg1sQSY11k/LPDNFarCNj4hxoeJmud2ohm3+3FbgdmOaSckJpolr59nRx
         /253mj3xXR8vNxQn+4lQB0dyZLKl4mTm6G2KPVCyk9vB7CDXy9HnyW060q+c5hde2nY/
         BDLqtxN61RerAAfx9rWJYfDQnz8/OCdxjXKsnT1my9CyAd5z2FKkVfw39pM8GFh+j5/F
         8iG7OQuYImWrrRY4enrel6PMBnsXw444TSw+UYvpIZBWS8QeHL3g/V29xECnGcUBVabE
         2vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=w+0Wu3dI7YPT16UswJ5OR0p3TmTEyKkuKUSvBshjyLg=;
        b=0ogu4ZBLREN2r/iT7caDhjkG+RtjRiWpI4xQUGPiUolxgWGd1a5ylXfM7T4T6t/Hnt
         Zhr0fDMZ5dXsU889+Wsi9UcSg8MarGMY6Ub2ZaLHK0cs9x6vM2KuhVWbvouor7UAL+GB
         1lpfVMWAyk0Bld/SKguBIUmczndgOXrX62hmGvxPG298nQFEpq54cLX7gzqblxT0iPIZ
         9cuF2GVNqshz1AdFvcJkGfyNvRVqTw8p+iKE13u3kN6MgTOlgRJTQCTazrYDIBoyqjSr
         TbCq+IkCXGJdWE1zAorWs4/4A073/GQ1qy1tB6Se/ABzr9lZe6oo46v4R6+2U2vOXa9Y
         8lSw==
X-Gm-Message-State: AOAM530NPs35eJd2Vz2IPeFAXROL85RKbVPzacbZlEN7BSs2gvvYzGM6
        5lFbGGWQZTorBf2LLjwETHDczG4d5AutwG1h
X-Google-Smtp-Source: ABdhPJxXzJtujECeK1eJJ4zh6ymKlBpPmRXtz9p1M/G4DaXwoSKT6z0PzlwU2LwzPBjfJGKOK1xUdw==
X-Received: by 2002:a05:600c:378a:: with SMTP id o10mr1535647wmr.77.1633988885648;
        Mon, 11 Oct 2021 14:48:05 -0700 (PDT)
Received: from hallblazzar-Precision-5510 ([2a02:8084:20c7:8d80:41b2:6091:e6eb:9c88])
        by smtp.gmail.com with ESMTPSA id o19sm9112305wrg.60.2021.10.11.14.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 14:48:05 -0700 (PDT)
Date:   Mon, 11 Oct 2021 22:48:03 +0100
From:   "Siou-Jhih, Guo" <hallblazzar@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: r8188eu: Fix misspelling in comment
Message-ID: <20211011214803.GA239300@hallblazzar-Precision-5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As format check raised by scripts/checkpatch.pl, comment in the rtw_ap.c
looks misspelled by accident. Help fix it.

The original error is as below shows:

CHECK: 'followign' may be misspelled - perhaps 'following'?
+Set to 0 (HT pure) under the followign conditions

Signed-off-by: Siou-Jhih, Guo <hallblazzar@gmail.com>
---
Changes in v4:
  - Refer to the latest commit, 98f668b3.
  - Mail client, thunderbird, seems wrap the text. Use mutt instead.

Changes in v3:
  - Fix wrong signed name in "From" field in email header(mismatch with
    sign-off).
  - Refer to the latest commit, ecd667f5f.
  - Add missing change log between each patch version.

Changes in v2:
  - Remove redundant "Subject:" from Subject
  - Fix missing public mail list in cc list
---
 drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index eea1307768a0..c78feeb9c862 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -744,7 +744,7 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 
 /*
 op_mode
-Set to 0 (HT pure) under the followign conditions
+Set to 0 (HT pure) under the following conditions
 	- all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
 	- all STAs in the BSS are 20 MHz HT in 20 MHz BSS
 Set to 1 (HT non-member protection) if there may be non-HT STAs
-- 
2.25.1

