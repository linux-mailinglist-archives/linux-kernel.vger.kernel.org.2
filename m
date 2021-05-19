Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868793896DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhESTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhESTlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:41:02 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C03C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:39:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t20so11039643qtx.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=02LE2Ct4623xELUCtUAbj1uXOX9qcsak7FEg/dNML6A=;
        b=dzfDU5azfxRNJBTqHYG8or7QUfom7Bu1BO+LfG2VWEDP7d5C7BLgyjBJpD0anJp0Ng
         3RBjBIuVcTRvCP0rq/fJk/A3IBXQQZml5+Slp74VHkrFyk2p4+sIffz0IxFOu7osZ8wn
         WFd8zC7EK0gZ6+7d5sTjs6X/5GnpheehKVNLjV07k8e7vrI9ZSevlrOqD7B7SOlP6cLS
         bSHX/NVngabjLm5e8Tj+Xqvsgi7KGVnN6gpAtkAmaTfM/HwAB6ijZwHdlZLgepKO/KXU
         vLm6Z4ItCEQee67s6+rfvv3dKAG+DSTFfJc0tAw1ozQ8yd8O8yflZSRefiCuGdAkNyAJ
         8M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=02LE2Ct4623xELUCtUAbj1uXOX9qcsak7FEg/dNML6A=;
        b=IwM6lvoSL3ddbUe6sYkMdq/US3NBbj5h+BUsdAbUt4hX6V+cQtU8svtnlJhE8ERNmD
         By+TkioGSF2ifvcaYEem7267qdRMTWhMXtM+Euw1CfrestFlMO8aTqKPP+szD39dl8Hb
         7G6OXdSqpMDGUwGuFCTD/idyX+RW5Z4ivtdkuxFDIOib343C6FjycX6xTQAkRBfJtiTx
         A4AeqXQ7hM9QTmTNXTxnAlzH4IeX9TlaLr5j8PGJ7c8HNlvB+rx4PR9cgULLSk8L0ihk
         RjUtzCm9NEUub+p94AppnKsXyeR+fHTdUQABLdc0i46j+EQAufwHaj5IG7xlPtLajeXD
         vEgg==
X-Gm-Message-State: AOAM532HvrIFIDB6oraBrtHw46dXyn9am/fRj0MlRgPa9qZT4Ew0NotD
        JynCJF9uEUih+gosToNyqX0c15s/n3ReR3xj
X-Google-Smtp-Source: ABdhPJwN55plgQPAvjtWPUvdAgqqHiW+O3bkKZ8Bz/1z18i4usXndqMUBllGpcoyTFCIeZS9EN18Bw==
X-Received: by 2002:ac8:5205:: with SMTP id r5mr1241881qtn.305.1621453179751;
        Wed, 19 May 2021 12:39:39 -0700 (PDT)
Received: from ubuntu ([191.96.170.47])
        by smtp.gmail.com with ESMTPSA id w14sm279832qts.83.2021.05.19.12.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:39:39 -0700 (PDT)
Date:   Wed, 19 May 2021 12:39:38 -0700
From:   Philippe Dixon <philippesdixon@gmail.com>
To:     vireshk@kernel.org
Cc:     rmfrfs@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: spi: add blank line after variable
 declaration
Message-ID: <20210519193938.GA7131@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning:

WARNING: Missing a blank line after declarations

Signed-off-by: Philippe Dixon <philippesdixon@gmail.com>
---
 drivers/staging/greybus/spilib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
index 30655153df6a..ad0700a0bb81 100644
--- a/drivers/staging/greybus/spilib.c
+++ b/drivers/staging/greybus/spilib.c
@@ -246,6 +246,7 @@ static struct gb_operation *gb_spi_operation_create(struct gb_spilib *spi,
 	xfer = spi->first_xfer;
 	while (msg->state != GB_SPI_STATE_OP_DONE) {
 		int xfer_delay;
+
 		if (xfer == spi->last_xfer)
 			xfer_len = spi->last_xfer_size;
 		else
-- 
2.25.1

