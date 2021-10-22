Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26B4437545
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhJVKMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 06:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhJVKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:12:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC2C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:10:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w14so966131edv.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmAB8n7UaBcqYspnUH1iQzfV3fA+SByJ94PZYXKecgY=;
        b=oHt2Wof0ZrH0Db8BpUIlVfNuIA4YEHpx/05WyIgrxZ0IKpYvKPeO8ACqfZ6VwmwbjY
         OV279sUu09r2FU8ECBsJCWfFPjQP8zAN79mE+V459+7wkRrSyU/VhroL9b0wiPcfVGw1
         8NSCjFU7/w05VaGu0PWBoxoIZ9eyDSoiAN2Bu3nUMREUXK47Ny/r7QUqI4IhR/n1sDUM
         5K1QbBNWJrMna0D+Vq3GjdNlmPfPY/Nr5hZqbrqWG7+NvIH3AAYOjWT9ZFqpXEhQ2z//
         Xy2fivTQpEsha23cIFT2S63HrIOFtIl43mtF57PjpLu1uQtmYqdgMvsp6D/wY2VNkS/6
         Qc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmAB8n7UaBcqYspnUH1iQzfV3fA+SByJ94PZYXKecgY=;
        b=VkaOLTEgC7Du/qjMIsFqycGdlEe9HlEBlBC7zpApHuHj/b2AIsagkwKIRKsS/hsZnH
         147yOUU7YEsjkvxv9Vhgl8nGwpYgkdm7gpMsx8UZ20B05SO2dz2MZk1H4JnOw0ipT2At
         OSRSqoi2R8+OideIl18Rd0QSNd6V+oUukpCMmMpqyDCy500+5J0xg3km+gR5BlxRW8vU
         +B79yp5LonA6YNezc17kpmhZFAHRiFW+OBB1R2SchoAWb5sc2oYluFIQhRY561WPrARy
         OUBWVgeRoe7++w3cjNmG+YMy9IOnIOkdlwYGlajfkZ4K0O8CV/BZyQiHSDSLNK5hwRo5
         xdQw==
X-Gm-Message-State: AOAM532UaNZeQeXECCBejjNLJwiSQGlA+b9qeaLgLwCluXrhUD+mIZje
        iNtE6fegsn9nBDv53RVqzqzBYXvnZP4=
X-Google-Smtp-Source: ABdhPJzATlfsnVn2ex6Z2XSOuRakVDLSIMIT1qSn1ffpholYi105ufGMMko+a0QJVqTMzg/Gklndrg==
X-Received: by 2002:a50:d558:: with SMTP id f24mr16112680edj.305.1634897433770;
        Fri, 22 Oct 2021 03:10:33 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.retail.telecomitalia.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id j15sm4243446edl.34.2021.10.22.03.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 03:10:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 2/2] staging: r8188eu: Remove unused semaphore "io_retevt"
Date:   Fri, 22 Oct 2021 12:10:28 +0200
Message-Id: <20211022101028.30367-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022101028.30367-1-fmdefrancesco@gmail.com>
References: <20211022101028.30367-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove semaphore "io_retevt" because it is never used.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/include/osdep_intf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index 90b37655e9e0..0d7009269aab 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -34,7 +34,6 @@ The protection mechanism is through the pending queue.
 	struct urb *piorw_urb;
 	u8 io_irp_cnt;
 	u8 bio_irp_pending;
-	struct semaphore  io_retevt;
 	struct timer_list io_timer;
 	u8 bio_irp_timeout;
 	u8 bio_timer_cancel;
-- 
2.33.1

