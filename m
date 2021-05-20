Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA738AF20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbhETMvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbhETMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B97C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:13:58 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b7so8452437wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXo5ZWdvVByk2PtNyKq/qS0x9C5PSN9mjM/JaOANNGE=;
        b=lVPRh1VxoFJQoPZhsMJ9EOObH0jR6RpPrxwHfgrqecVselG1egvu304VdaTpsf8GtW
         Ij1rmpvkA2GM7ym6Wky8R3p0KtA2iDNNI6TmyJgV3Ik6HKHgZNWPhMM4V4HiNey9PpVt
         7crLz9QXuFgSGXtlGqUbs+h/etcXRC73qW4Q7o8rhgQSMRqVm7W1zUOB1lXwoOFKczWi
         uANBcRb5QDhLaBPAUlyZDyLms4AuqyETpYWu82pCFPeXd+xuymo2C9XT20Xkr7sKW3oZ
         qSdYd735qB3S7I1CJ7tuq8AbF+G9D8DDRYCWIw8LQvSnTy4k+vWV+qklDDB5u+kq097Y
         ELDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXo5ZWdvVByk2PtNyKq/qS0x9C5PSN9mjM/JaOANNGE=;
        b=dj7XCRhk0w7XMmeTH8agZQ7S4QrsI/vA5q/gOO7w5c18ioOvrhl2y7lhCJXjspwjuF
         R7cxYSfXyV9AcK2WcVQ/6cylz3cA33ZlCbsEWub1DLb9eP1X8LB3fYjixuNwFonH6gdu
         ejHdQyWHm/oyq6fPyPezYDwUMhtp7Ix/VC9IB7gWxTqT/isnwSoJW3zdyrIeOzph0jxi
         UsNCiFKEKTqCr/0QKK0Ng/Q/FKN6WPh1cyTegOQ3FCPQIVCYdzuIKe2wC4n0S6RXMUlN
         dI+lSiA/Ja2KA+RQdM7WPtyz+czBMnFwk5bHEgfQETnY38WZJshtCodlUbl8sgh+3DSc
         nXFQ==
X-Gm-Message-State: AOAM532ib4RkLVEN4dvGfSSm8qlRFZ32jxgPBtnWzAULspG+1IWhAYHY
        hHm/BSnmTlADy4owzvidYIjcqw==
X-Google-Smtp-Source: ABdhPJzu0jd8U9YueDg5gdY6XO6+XnzJRtszfFO+Ue0QSqcUyXoEPks5ozbjzPLbdqNnx3QOLTS6qQ==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr3855680wmq.46.1621512837452;
        Thu, 20 May 2021 05:13:57 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:13:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/16] char: pcmcia: cm4040_cs: Remove unused variable 'uc'
Date:   Thu, 20 May 2021 13:13:33 +0100
Message-Id: <20210520121347.3467794-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/pcmcia/cm4040_cs.c: In function ‘cm4040_read’:
 drivers/char/pcmcia/cm4040_cs.c:224:16: warning: variable ‘uc’ set but not used [-Wunused-but-set-variable]

Cc: Harald Welte <laforge@gnumonks.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/pcmcia/cm4040_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index d5e43606339c3..827711911da41 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -221,7 +221,6 @@ static ssize_t cm4040_read(struct file *filp, char __user *buf,
 	unsigned long i;
 	size_t min_bytes_to_read;
 	int rc;
-	unsigned char uc;
 
 	DEBUGP(2, dev, "-> cm4040_read(%s,%d)\n", current->comm, current->pid);
 
@@ -308,7 +307,7 @@ static ssize_t cm4040_read(struct file *filp, char __user *buf,
 			return -EIO;
 	}
 
-	uc = xinb(iobase + REG_OFFSET_BULK_IN);
+	xinb(iobase + REG_OFFSET_BULK_IN);
 
 	DEBUGP(2, dev, "<- cm4040_read (successfully)\n");
 	return min_bytes_to_read;
-- 
2.31.1

