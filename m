Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880283716D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhECOow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhECOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:44:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157FEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 07:43:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id zg3so8234919ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+sSoI8mYAtclTc9ch+HKJwJxzZIGx+EMq0xg4jwGJY=;
        b=lcMg1GRQK96CSLu9muYJ/38tJfNVTje46sVXV9uLDLW+WcllEPA0D1aj/1UEnTPqgt
         KGRWoSR4BisAYbjYErXdN2bIuPbIia5aCZd8hjcURs32Nj/WqjA4bu/oZo4PY0n+trn/
         yusgEeJqq3BKieXfp/qHxFoA1MmTiRRo3dij9wudixzpfghDJHhiI7gEkR2aYn4gspLC
         Ho0+eKxdqoUXlpMRQbGR6e8jMUyOsecJWsgeHYLGGaDggzDCiEjT2z4atmpfdJilboJP
         MA9DHMtRfyOnf96sskvuMcdkeBE9LX+YavPYfBVTWQRIs/HpFOH0dj3S06wvS0FMY6Fz
         2yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+sSoI8mYAtclTc9ch+HKJwJxzZIGx+EMq0xg4jwGJY=;
        b=ONwKEXPa6nOSw4B/lwur0u2DMUxzJe/Bi0oZWFvnQcPHYasr1d8UlDAh3YxXET6MTg
         qiHev711Rgw2yrLeA9TYqJbkTx6nli3BktnYW03xkA7Ip777qtCy73ddKC/Nnf0ageBH
         /ELWZuLUzWe7xDozUnsR5jBEEKA+UjwieVxYtjjfcTtJXJKvaC5OrabowiNH4gXO8RAz
         9yLbvhcBilBHU+2Dt6ZiugRHFFO/a4d0DaRTnfpKeUaagZWEfAa5OJvxsS5tYOUx9J+T
         iRAI6NSlO4UDSUwAZcMyQuRaWnY5Z+YNB2PdU7kNMu3MibdboOVXlrzhVeDHc/w4byFp
         kjvQ==
X-Gm-Message-State: AOAM533wPIkDSu+ZA+cnvjK4sCfYL98dtfNx1q4s/n6vWcD0Q8yb8U42
        wQNfZqzCLS/sYNo+u5yo49+VL9VwfzpXKw==
X-Google-Smtp-Source: ABdhPJzz8YSG1ci1mdLP9jB4YLfscuJhMz3kr/0Wr1oKGOdWmN24W8jyr6/Hcqis9MIkLZIU6GdSDw==
X-Received: by 2002:a17:906:a10e:: with SMTP id t14mr16892149ejy.103.1620053035841;
        Mon, 03 May 2021 07:43:55 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id e19sm2005867edv.10.2021.05.03.07.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:43:55 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH] iio: core: return ENODEV if ioctl is unknown
Date:   Mon,  3 May 2021 17:43:50 +0300
Message-Id: <20210503144350.7496-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ioctl() mechanism was introduced in IIO core to centralize the
registration of all ioctls in one place via commit 8dedcc3eee3ac ("iio:
core: centralize ioctl() calls to the main chardev"), the return code was
changed from ENODEV to EINVAL, when the ioctl code isn't known.

This was done by accident.

This change reverts back to the old behavior, where if the ioctl() code
isn't known, ENODEV is returned (vs EINVAL).

This was brought into perspective by this patch:
  https://lore.kernel.org/linux-iio/20210428150815.136150-1-paul@crapouillou.net/

Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/industrialio-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index efb4cf91c9e4..9a3a83211a90 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1803,7 +1803,6 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (!indio_dev->info)
 		goto out_unlock;
 
-	ret = -EINVAL;
 	list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers, entry) {
 		ret = h->ioctl(indio_dev, filp, cmd, arg);
 		if (ret != IIO_IOCTL_UNHANDLED)
@@ -1811,7 +1810,7 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 
 	if (ret == IIO_IOCTL_UNHANDLED)
-		ret = -EINVAL;
+		ret = -ENODEV;
 
 out_unlock:
 	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-- 
2.31.1

