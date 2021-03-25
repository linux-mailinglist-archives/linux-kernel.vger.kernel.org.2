Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227C6349328
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCYNfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhCYNfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:35:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC68EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 06:35:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z2so2311715wrl.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sgVSDNtewl13Faq2L7m0VtnnssegF5rNrygJnFP8kVQ=;
        b=V87PaBpvHuLPd8si+rBOURH9tvykrSdIEVgRyxYNGleHug7Pet20eoPwfqrKedmoIO
         xNyOiDnaGrRpgOWGqZIt7Ra3rkDGcRPc35bca/HZIO+b2B9oxyKF73LPvbC2MY+aG+3z
         gDJYeUMjH9jjxGofh5eJsQbE8bH+8z1EHCOQsmxALu+OE6nxImZWEkWVliEazofNk/M5
         iLO/jTivjtWTGjH5oUq9vEDwcOmF1mQNSjBQjzgWUkZiCfXymAjksiSwb7zhAzRPT7Nz
         xfuzouQfGNxeKnTgbFj4YROOe5NSYCUdP7NoF+jDDAFpV02rgPuqXQT+MX6PAdVvZy3U
         mjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sgVSDNtewl13Faq2L7m0VtnnssegF5rNrygJnFP8kVQ=;
        b=WLP15c+mVCCQ+zWSqhKvh3QEjlaR3atme3uzitVTZEoc1t+IdHho+O0VTtJ/F7NPjt
         NEF7gZP7/9vHhew97n6R/p6WWghfCWEkzc89JwCWUORQGCRYopyY9RKKXEF4R5xMEd5F
         YRp9yF3KpWRPvLvvbjcSlD+M7V0PxseCpFPcqd5vMxLzzjipSLR5PftsqPP8EEOW43pw
         BHW5H1XN1o3Py391jvUrqV1nha4+hVTSczSooVgcnKUTFQeVrx5/eJ1h3ekjdoklLXvV
         8D9VG00pL8uHihBaMMRpqBHsK2ktF7IdDbpFzp3LYh4EVvBQCL+dff5UYVEK23hckAiM
         HMKg==
X-Gm-Message-State: AOAM533vMd+TQjeqNjbiXKolnYr9KanqFjwnEo+p3vqdfOqvZKB+XXFT
        xwS5eFP/lxCPS6+c6iW+Bvg=
X-Google-Smtp-Source: ABdhPJwd7KMb+NBqOikfxgscq6R+fEgzdyHZZgsSGwNvgD1/Fl9xQHJKrszuzrDkcxvQ6aeWoBxONQ==
X-Received: by 2002:adf:f0c1:: with SMTP id x1mr8952882wro.7.1616679322564;
        Thu, 25 Mar 2021 06:35:22 -0700 (PDT)
Received: from m17r3en ([46.11.141.4])
        by smtp.gmail.com with ESMTPSA id o2sm6491758wmc.23.2021.03.25.06.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 06:35:21 -0700 (PDT)
Date:   Thu, 25 Mar 2021 14:35:20 +0100
From:   Swen Kalski <kalski.swen@gmail.com>
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] Staging: comedi: remove unnecessary else statement
Message-ID: <20210325133520.GA594125@m17r3en>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removal of an unnecessary else in statging/comedi/comedi_buf.c
Add an early Return and removed the unleashed the else condition
for better readability int staging/comedi drivers.

Signed-off-by: Swen Kalski <kalski.swen@gmail.com>
---
 drivers/staging/comedi/comedi_buf.c | 52 ++++++++++++++---------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/comedi/comedi_buf.c b/drivers/staging/comedi/comedi_buf.c
index 3ef3ddabf139..06bfc859ab31 100644
--- a/drivers/staging/comedi/comedi_buf.c
+++ b/drivers/staging/comedi/comedi_buf.c
@@ -371,35 +371,35 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
 
 	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA)) {
 		async->munge_count += num_bytes;
-		count = num_bytes;
-	} else {
-		/* don't munge partial samples */
-		num_bytes -= num_bytes % num_sample_bytes;
-		while (count < num_bytes) {
-			int block_size = num_bytes - count;
-			unsigned int buf_end;
+		return num_bytes;
+	}
 
-			buf_end = async->prealloc_bufsz - async->munge_ptr;
-			if (block_size > buf_end)
-				block_size = buf_end;
+	/* don't munge partial samples */
+	num_bytes -= num_bytes % num_sample_bytes;
+	while (count < num_bytes) {
+		int block_size = num_bytes - count;
+		unsigned int buf_end;
 
-			s->munge(s->device, s,
-				 async->prealloc_buf + async->munge_ptr,
-				 block_size, async->munge_chan);
+		buf_end = async->prealloc_bufsz - async->munge_ptr;
+		if (block_size > buf_end)
+			block_size = buf_end;
 
-			/*
-			 * ensure data is munged in buffer before the
-			 * async buffer munge_count is incremented
-			 */
-			smp_wmb();
-
-			async->munge_chan += block_size / num_sample_bytes;
-			async->munge_chan %= async->cmd.chanlist_len;
-			async->munge_count += block_size;
-			async->munge_ptr += block_size;
-			async->munge_ptr %= async->prealloc_bufsz;
-			count += block_size;
-		}
+		s->munge(s->device, s,
+			 async->prealloc_buf + async->munge_ptr,
+			 block_size, async->munge_chan);
+
+		/*
+		 * ensure data is munged in buffer before the
+		 * async buffer munge_count is incremented
+		 */
+		smp_wmb();
+
+		async->munge_chan += block_size / num_sample_bytes;
+		async->munge_chan %= async->cmd.chanlist_len;
+		async->munge_count += block_size;
+		async->munge_ptr += block_size;
+		async->munge_ptr %= async->prealloc_bufsz;
+		count += block_size;
 	}
 
 	return count;
-- 
2.25.1

