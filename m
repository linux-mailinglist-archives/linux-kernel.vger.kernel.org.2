Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569E539E9E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFGXFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:05:38 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37430 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhFGXFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:05:37 -0400
Received: by mail-pf1-f169.google.com with SMTP id y15so14233460pfl.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jPM6iDc84ozMhah8UQSSD8eMgX6HXfVm3Mo9DHBVHtc=;
        b=NDXRPS6z30Ak+vyOEPN58hwmXysTST1Ja4Mr/YJaUO/tAE/pD4KkBXh/tKICpypxZt
         tbNky2c6lxnPuSab7JH/w7H/5NskAahzucd2ioJ22F0jgwA223UboG4JTw+rlQ6WLx33
         bVSe/sRad9axCRrVjxrgQauLIUyquet3ON7es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jPM6iDc84ozMhah8UQSSD8eMgX6HXfVm3Mo9DHBVHtc=;
        b=fnPpLxFk3Y5uTeFq2Om5wUmf9lf+7qq/TCXwx8IhSdW36W6imEupWHt9TCjqiNVJYH
         aH1cUf67bDxH4Pl5TgcXWUbkq5w7N2ye7KUDZ5b1ZFvOisRBM1v0HSkcDlY2jWyslLOU
         K1d9fy1wJ9+ua7ARu2wPiSNHzmS1XI9aVc8uCA3JJHOcUzOU/mDOPzFNEn0JRsMLnND2
         rYiH4fa9Pur5gCgveV71r435ZaN2bp7nZRo24CiMffC59bRb46uGV2FeZYlA2lNHdwXe
         aIQGOPWe0oFJDBeTzJYRR4emuV/aDUu0CoRYoGkDTnPDJ1QWj+83UGw1ovlv74aWNXyG
         YJTg==
X-Gm-Message-State: AOAM530w5wLbjrx4e1VkE4Jq/dTv6E8QZpA373MWhEzJSzKKjVfxlb5E
        lWZHkQvRgCg/ubCLVaurrMvX8Q==
X-Google-Smtp-Source: ABdhPJz0SeebdWkvvXBLH4fII0e17tO8zg5gXuDsxWy9oXco3JORl59Lbrm0vFKGmWq+mlibLtKvbg==
X-Received: by 2002:a63:8c5c:: with SMTP id q28mr12604815pgn.442.1623106965538;
        Mon, 07 Jun 2021 16:02:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s123sm8907376pfb.78.2021.06.07.16.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 16:02:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH] pgo: Clean up prf_open() error paths
Date:   Mon,  7 Jun 2021 16:02:41 -0700
Message-Id: <20210607230241.3797373-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=a1ab192e75f5e174777b97b45774cbf320075d88; i=kbTASCeMqCM8sUncqpkIJ334IjzMsbFIrlnmwZl9s0M=; m=7xelWwDysTUfBHv7E5dEuCRyzI+PXkhcJ0W5hQOySa4=; p=rp9lMf5mwmgB1rWUhzC3chVXbburHSZuTTQ+ad9t/es=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC+pZEACgkQiXL039xtwCYUcg/7BFv ZlFB/Jsziuinfy48HKwcqI9Jfb3wx8MWWHB9w+3WLoYvNJFaiPMy+vqo4naqX7ei4x8drEzWb/TPz oXS7IZ4Zbul1CbkDm64f07XS+mqMMDNUpAqOuNSqJfpQ3IuBMAvnhtmOnAzEJz9V/rp2Gk+P8yUa9 OdbcfqCyEXx1B31FK3ED4lA95tY3j6JE/cGa66IlTPG2M3QKyGV8fxMMNwW4vJad+w2YNm7lyiwX3 NrjV0iR1RklUtPl0wetbEyow5dAPO6jB2AeDHKQdWpppKnlVKRB9fIW435cBa8tRK3ha71+UoxeKb y35+yaZ5ROpIymb191jPrGGEoXQa/Nbgv+m10kCQDf5v5eEuNMnrnbpG7smMq16iPt2XI9xTGbIFF fNQpO+WXQg9QNRKIgibcq98LSZXsCYqc4YJty4CHwKDaLtHlRaHKMUkWSbINqFXwrjmPJKgnlJtr6 TqW8XOSCsLWT+CvNauj1wAykcWkXbWCRAdHsEbKm0VCPX2Ad5zmzYwhgKibOAza12sQbG4NBUhSq1 ELkctEaupkHT8RqVcMBGRGyxD6F6cV4ff4/OG/pVGzAaYT9ZFZukgC3GtCjwOaFSPQlyQ2B6hwhaZ uQb+AXkt2DzkfAoTQz5m4R+OqvatBeAqx2beraJ/CPKSxDutveiwWVfVDQR8teic=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change coding style for prf_open() error handling paths. Additionally
fix up comments to be complete sentences with punctuation.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is on top of Jarmo's recent fixes.
---
 kernel/pgo/fs.c | 49 ++++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index 0ce0dc9caf7a..3c5aa7c2a4ce 100644
--- a/kernel/pgo/fs.c
+++ b/kernel/pgo/fs.c
@@ -234,17 +234,14 @@ static unsigned long prf_buffer_size(void)
  */
 static int prf_serialize(struct prf_private_data *p, size_t buf_size)
 {
-	int err = 0;
 	void *buffer;
 
 	/* get buffer size, again. */
 	p->size = prf_buffer_size();
 
 	/* check for unlikely overflow. */
-	if (p->size > buf_size) {
-		err = -EAGAIN;
-		goto out;
-	}
+	if (p->size > buf_size)
+		return -EAGAIN;
 
 	buffer = p->buffer;
 
@@ -256,8 +253,7 @@ static int prf_serialize(struct prf_private_data *p, size_t buf_size)
 
 	prf_serialize_values(&buffer);
 
-out:
-	return err;
+	return 0;
 }
 
 /* open() implementation for PGO. Creates a copy of the profiling data set. */
@@ -266,52 +262,47 @@ static int prf_open(struct inode *inode, struct file *file)
 	struct prf_private_data *data;
 	unsigned long flags;
 	size_t buf_size;
-	int err = 0;
+	int err = -EINVAL;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto out_free;
-	}
+	if (!data)
+		return -ENOMEM;
 
-	/* get initial buffer size */
+	/* Get initial buffer size. */
 	flags = prf_lock();
 	data->size = prf_buffer_size();
 	prf_unlock(flags);
 
 	do {
-		if (data->buffer)
-			vfree(data->buffer);
+		vfree(data->buffer);
 
-		/* allocate, round up to page size. */
+		/* Allocate, round up to page size. */
 		buf_size = PAGE_ALIGN(data->size);
 		data->buffer = vzalloc(buf_size);
 
 		if (!data->buffer) {
 			err = -ENOMEM;
-			goto out_free;
+			break;
 		}
 
 		/*
-		 * try serialize and get actual
-		 * data length in data->size
+		 * Try serialize and get actual
+		 * data length in data->size.
 		 */
 		flags = prf_lock();
 		err = prf_serialize(data, buf_size);
 		prf_unlock(flags);
-		/* in unlikely case, try again. */
+		/* In unlikely case, try again. */
 	} while (err == -EAGAIN);
 
-	if (err)
-		goto out_free;
-
-	file->private_data = data;
-	return 0;
+	if (err < 0) {
+		if (data)
+			vfree(data->buffer);
+		kfree(data);
+	} else {
+		file->private_data = data;
+	}
 
-out_free:
-	if (data)
-		vfree(data->buffer);
-	kfree(data);
 	return err;
 }
 
-- 
2.25.1

