Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8907E44D1ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 07:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKKG1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 01:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhKKG1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 01:27:47 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF7DC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 22:24:59 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s136so4331322pgs.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 22:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOtyQShi56C0T8mRr8HuBiN05m8/pKEj4hk5IHegoRo=;
        b=XaneTcGxsPRnH0siZPlArroEhYD0zqaMZP/Ua5qxLd5IViCdujxVQwpsPy1PEYrNgG
         T/fhvs7Mpp3SlY1a/IZZZAMoVtywbIFD7UYFWFUjv8PUoBme+EZOOUEghYyqII3BFaBq
         n77itdrasVEhPX1LoWQup1p37ZyDmzokS1nvZivO7DF7mOB31UBzG5S8TcDGZiNNijP6
         sZ7xd6KagOz1aw1MyBXTEDM0l+rlF1CssO5+2Sg9dgkb/lmVET/KC6Hdy3xcQa+HvhQE
         cu0I3ftXTPSSPfSzBXg2aB2cEYFyaoYNlenbubyNuh9dFzClfpnBrzBFDqILF6vtQMfz
         pf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOtyQShi56C0T8mRr8HuBiN05m8/pKEj4hk5IHegoRo=;
        b=MmA031v3ShUV2o21mfubz3Hlp3EuGi5AZ9LfLGEnynAcwxQDPMg9Xvh07ai4DPIb19
         ilecsykiRVn6RIt6bMHOt18ltHgkxzeo1yFuT0bHNpvGOmXWQysLdAsUJE98qfRHdOLR
         Z5jSsU7MhX5EkN7v5vf3HCPHobBVEx1Ri5zUrMVX+kH+nMjMiDv2ekyt8jv10ynJfccp
         4TUlPXs4Mm5FaC5aHuk7yJChFLCDbe2Um3sclbL2hH2JW1evdFnslhbVjU/Rtk3MlQPw
         ADwrZVtVeSjp2tDGrJGRnMIV9K0vsVa5dJuLSUGORL2VvQZib5lbf2It218nEUVqXsFo
         7TWA==
X-Gm-Message-State: AOAM530JqvnEy/4pBam27CAlzj3XLYXQSI8Yh0Icto0tTC3iMTz2aLAp
        L3QkEWXxbefinWWXrESkXhtvGA==
X-Google-Smtp-Source: ABdhPJwd7ZktiBQYocQLrTGcaazgeISZEF6ZGRazpqerc6hLzT05lXW69Z/NaDuhJH5FDcJjxyhGcg==
X-Received: by 2002:a05:6a00:807:b0:49f:d6ab:590c with SMTP id m7-20020a056a00080700b0049fd6ab590cmr4758435pfk.32.1636611898624;
        Wed, 10 Nov 2021 22:24:58 -0800 (PST)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id f11sm1246652pga.11.2021.11.10.22.24.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 22:24:58 -0800 (PST)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] vmscan: make drop_slab_node static
Date:   Thu, 11 Nov 2021 14:24:44 +0800
Message-Id: <20211111062445.5236-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drop_slab_node is only used in drop_slab. So remove it's declaration from
header file and add keyword static for it's definition.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/linux/mm.h | 1 -
 mm/vmscan.c        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..08b36283a57a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3167,7 +3167,6 @@ int drop_caches_sysctl_handler(struct ctl_table *, int, void *, size_t *,
 #endif
 
 void drop_slab(void);
-void drop_slab_node(int nid);
 
 #ifndef CONFIG_MMU
 #define randomize_va_space 0
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..b02548a32a1d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -951,7 +951,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	return freed;
 }
 
-void drop_slab_node(int nid)
+static void drop_slab_node(int nid)
 {
 	unsigned long freed;
 	int shift = 0;
-- 
2.20.1

