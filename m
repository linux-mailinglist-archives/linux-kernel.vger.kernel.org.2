Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A49451C39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbhKPAOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344817AbhKOWpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:45:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78739C03AA0F;
        Mon, 15 Nov 2021 13:58:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d24so33545033wra.0;
        Mon, 15 Nov 2021 13:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dYX6q8WGWQ5Z8sNGXILWcWBIch3nmvzkBGJ63urSjus=;
        b=QP9fE2mo85wjW8zUgZba8PC4YUCPqVLKxxYnYRao9WzeACaVkLoBYmttcByPVNNZcG
         cwOxMl4eQjI7MCgbtGGmkSsR41mQUUA1BKQE7PgTcwjutdk2jjyHPdoIl9521ZOpu/sX
         I93u/lM8T4WBajzx82+GbvCmrY6RRD8VZw/paK4fMIVPocASSdp7G451Nm5Ut7R/qPOn
         O88Wt7mxkLLnf4WgUWTbBnlRVbCSHWSF/c8+JiPqKvRLqjV3K14A0PD2g+9JJoxR4PRU
         Al0Lwnjid+T2p0IJYyr8LwbIHnfKPZW8fQs7DZAnDA+yrI0uZwlvSSfOxE0Y4cUwidAP
         xj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dYX6q8WGWQ5Z8sNGXILWcWBIch3nmvzkBGJ63urSjus=;
        b=StZiTjhuV3NQBqCNBR7khfkzNGN1JKuq9xuBYtvVESuywuE7uiQu9IV5DSZIG2aZWT
         d5nNCkQs3Mbp3LjDratb2N2A9jzgPR3jmr892bgpMq4zq4sUfi1B8ti3Bi+UCqkCNilR
         3br5/KgcUdEEz0Q7Dbt423COTiPhgy8sS1bfEOAku5Ydhx3gfHqyJINOYQnzOXlfeTZs
         9gwkTnUVMQ1fmEhnBYCHWlZIMa5S8/DWem3+A0jTGKsPkv8SficfKq+VZk0p2drhTqYU
         jMviF1rXCh0ZbudMrjNuF/nZUtGb9dhGwjd+YZcVbE37rSWAWbcEGl3LjQHPiZiSTuCV
         DrrA==
X-Gm-Message-State: AOAM5328M4U+qhoiZhLsWXjNg2anPwEFjsqJr9acqZP3JY/WocitCF5d
        MXsA4lxldF/2KRIsVsdZQcI=
X-Google-Smtp-Source: ABdhPJxmsYflobj+yzoBiZm9T5tiRgsymSvm77aI7YxcmlRy0u5S0gDf28tiBULM0Rh0q+kQrAgxvQ==
X-Received: by 2002:a5d:48cf:: with SMTP id p15mr2935973wrs.277.1637013507151;
        Mon, 15 Nov 2021 13:58:27 -0800 (PST)
Received: from ubuntu-laptop.speedport.ip (p200300e94719c9c4ec5385e631fb47d9.dip0.t-ipconnect.de. [2003:e9:4719:c9c4:ec53:85e6:31fb:47d9])
        by smtp.gmail.com with ESMTPSA id y142sm463258wmc.40.2021.11.15.13.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:58:26 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bean Huo <beanhuo@micron.com>
Subject: [PATCH] block: Use REQ_OP_WRITE instead of its integer constant 1 in op_is_write()
Date:   Mon, 15 Nov 2021 22:58:19 +0100
Message-Id: <20211115215819.28787-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Use the enums REQ_OP_WRITE in op_is_write() to make it less maintenance
requirement and more readable

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index fe065c394fff..5b5924a7e754 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -463,7 +463,7 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
 
 static inline bool op_is_write(unsigned int op)
 {
-	return (op & 1);
+	return (op & REQ_OP_WRITE);
 }
 
 /*
-- 
2.25.1

