Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A658411832
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhITPb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241436AbhITPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:31:56 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98D3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:30:29 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x9so3347153qtv.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQ99H87nx71zTeZnm1PBaqgtUrgnKGZgxB0njW1Zu98=;
        b=qIlxa1d1fM85RtMxf1hyFljZ/Ht4E0RjTSVdscTBBXzFq5D8OQugMpk++T8QIx71Ix
         n9VrYAhnxJbnmo2/RaTW4XUeya7hORyQHYF7e/rmwy/+gDpz7zgHr7mLSn75ysmZVKgR
         tTjUuax7VyLsO3nkE46T5cjyUa/OySGIeyS6zqh+n/2T+cJmQ9l9G9dMiM07HE/h70L4
         oOy4mfosauZUth0NpnZCHFo6whv3JkbEdgOW9zWC3IoQ5DX6p2stN0oIM6T6RvudOTUW
         hudWaJU3gnJFEceDkTBEKK5blm/aayJlwwQ2GBwdhPZX+fANYWS20DSvTFLtHRB16COP
         CoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQ99H87nx71zTeZnm1PBaqgtUrgnKGZgxB0njW1Zu98=;
        b=hyTdyfSV3Eylz5zN/ELXKU0jq95JuglE3y7nmdsvI3qLow5q3o/RFtZjS9id+bk0Ez
         rENvLofuwR13WJBrJfjYBYIF91t2hTfG5VWDmRf0Ls5EjokE6SjmlaXOX/kYIX2jj8OA
         f5pg6uHaI8gXTqGq+n0P4X0sjURkD5EKtu2H1uU8DFKWqrzqd/EfoA8cijJ1xGXOyafT
         9mVPrK61bmhdSInYcYDKIweHxnEtrUO/e0gVwlfGHnWGASApMSK1idriqn3LkXvCaVsl
         8WYwEq9OYBbmXW7oUkzEABtUeeouxS6qjxu6iapcinqKptjFF7g3k256rLWY3I6rFXa3
         FDDA==
X-Gm-Message-State: AOAM531NrWpGEMIVKMNl0ArrhQt8D5ZewTXcfRuMDIWNT7+E+Zz5DQ/K
        2KkFetLPZi4vdIQb7wQqBoVwAta5l+ffIQe/
X-Google-Smtp-Source: ABdhPJyqhK1V1TSoxa5piMCubgiZqrVbP9IuW+Qr/Hw1ALcUG/YAFw6MNFTYOHdrFlq6ng/x7saQ0Q==
X-Received: by 2002:ac8:5c4c:: with SMTP id j12mr24140831qtj.127.1632151828458;
        Mon, 20 Sep 2021 08:30:28 -0700 (PDT)
Received: from Zachary-Arch ([128.211.185.212])
        by smtp.gmail.com with ESMTPSA id y12sm8962055qtj.3.2021.09.20.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:30:27 -0700 (PDT)
From:   Zachary Mayhew <zacklukem.kernel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Zachary Mayhew <zacklukem.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@lists.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: add docs for fbtft_write_spi()
Date:   Mon, 20 Sep 2021 08:26:03 -0700
Message-Id: <20210920152601.170453-1-zacklukem.kernel@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] staging: fbtft: add docs for fbtft_write_spi()

This patch adds documentation for fbtft_write_spi() to make its
calling context clear and explain what it does.

Signed-off-by: Zachary Mayhew <zacklukem.kernel@gmail.com>
---
 drivers/staging/fbtft/fbtft-io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
index de1904a443c2..985d7cf8c774 100644
--- a/drivers/staging/fbtft/fbtft-io.c
+++ b/drivers/staging/fbtft/fbtft-io.c
@@ -5,6 +5,19 @@
 #include <linux/spi/spi.h>
 #include "fbtft.h"
 
+/**
+ * fbtft_write_spi() - write data to current spi
+ * @par: Driver data including driver &struct spi_device
+ * @buf: Buffer to write to spi
+ * @len: Length of the buffer
+ * Context: can sleep
+ *
+ * Builds an &struct spi_transfer and &struct spi_message object based on the
+ * given @buf and @len.  These are then used in a call to spi_sync() which will
+ * write to the spi.
+ *
+ * Return: zero on success or else a negative error code
+ */
 int fbtft_write_spi(struct fbtft_par *par, void *buf, size_t len)
 {
 	struct spi_transfer t = {
-- 
2.33.0

