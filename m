Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F156331154
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCHOzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhCHOzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:55:31 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF418C0613D8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:55:30 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jt13so21008569ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBNx3+l+qHDe6EkshwxnUvUhVuyIuR48vB6z54Joki8=;
        b=nTF2zXvbxcoUnMTJKJRh5lxphx5JfP3FHvUk0L/VCv3nENNwU6DC1sJEgloDXOxZzR
         z9IijKI0al0C46RH4OsSkFLgSvK/ye8p2SA9rzL5ixNbTTIAkFEFxEZV5WZxPiI5TIZx
         mSDXSPQMKsd4wJ5h2YlaSivmWjWh9u0lFAx0yRoY69NTm4XZ2RysV2VyecXjRkYn0jIL
         3MbtP2sywizYzOWLDex0+U0aOiwaz2xMwM6F1fhyTfi12JIGuYGCYWm/1pvckKJAKi9z
         EzUqPXhpOXaaa1jIaWXzRXaNYIzDrUWq7U9bgEHLBG8PZUdB2dkKaUPX17QBHHlVR4Be
         u+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBNx3+l+qHDe6EkshwxnUvUhVuyIuR48vB6z54Joki8=;
        b=XnQ9nJK2njg1rMefOVRCs30obJbaeHiLoEjiR+tKwb1FTav/pmqNMaOwXoTs5DybW8
         tbXetj/OGHcVwv4P1Mqa5FjEtO2/Ol54pl3RTLarsDgyNtodGRD2B8u1Y6+H+mcwIC+V
         YLSfhc4bLk0iEpeE7u7Q61T5JoqS38dROKSlb6+gAg7LJGqL2fd784QBl9t5eSobiIdg
         A3TbTXoT2FvXoh8VG/FqxPg6MvmT74FdesVmwHJpoaZLFImPgn7Wqum55BKkdv8VRHpy
         GMngzUhMsRUb8PtpcTfpMrnnqCDCWeM6Rqs177tss3zbSZ72H6QG95mtbhDmkWDbUYNn
         BUMw==
X-Gm-Message-State: AOAM531TuzPgf9ny65GPHuLH5a7ZePtwQ/cNwdjA6OBB/uEF6CSWcxEx
        e5tYo3eW232X1LLe+dTAEHaqYg==
X-Google-Smtp-Source: ABdhPJy3dzNItArKPc94hDqlK8aS8fNX1eICojTsHibEp0xBvophfesscwVwUCVlgWvMxvrYa/+PPw==
X-Received: by 2002:a17:906:7102:: with SMTP id x2mr15619326ejj.355.1615215329786;
        Mon, 08 Mar 2021 06:55:29 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:29 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 03/10] spi: spi-bcm-qspi: replace 'delay_usecs' with 'delay.value' check
Date:   Mon,  8 Mar 2021 16:54:55 +0200
Message-Id: <20210308145502.1075689-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'delay_usecs' field is going away. The replacement for it is the
'delay' field. So, we should check for 'delay.value' being non-zero.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/spi/spi-bcm-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 707fe3a5d8ef..a78e56f566dd 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -671,7 +671,7 @@ static int update_qspi_trans_byte_count(struct bcm_qspi *qspi,
 	if (qt->byte >= qt->trans->len) {
 		/* we're at the end of the spi_transfer */
 		/* in TX mode, need to pause for a delay or CS change */
-		if (qt->trans->delay_usecs &&
+		if (qt->trans->delay.value &&
 		    (flags & TRANS_STATUS_BREAK_DELAY))
 			ret |= TRANS_STATUS_BREAK_DELAY;
 		if (qt->trans->cs_change &&
-- 
2.29.2

