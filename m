Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF5352E9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhDBRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhDBRmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:42:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BA0C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:42:33 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h13so6128566eds.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScmcEaVFBSOKM3zbhWaVisr6S40D1F1cKzKJmwlPJfo=;
        b=C0J9vA79mBFuZpfOe+6Jlc0UkD+uSD8LGQqq1NfRtQTSSwAvXSxPoq3d12+wchrr50
         Hvk7MchZ6HGAHFZpzMhT5RCIBsyxEAXDFd8ZriqCCkT9SpXHpSRH+c8yV0aq9ILqgZWW
         QGKrBeyOMBYH4iAcsp2ZW4W9UIdzQOX00CPc6yfyI4GvQ8uru3iHUJn2QLFoTVqBwZm8
         SZXyFIbdaoawI2YgQ3acyzJ4UQoWpJxDRByo9leo3/bfSVq6ONoSpCg5FLGA9L8GPwlH
         3dHW4oVG4hf3RFW//ZlfnRW9xyIUL4bO7SokOzNE9/obl2p8wmFHptTK8S/JaCLB7ttn
         HUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScmcEaVFBSOKM3zbhWaVisr6S40D1F1cKzKJmwlPJfo=;
        b=R40W1voDSzU7+lQPs+/HZ5MFHo3pHx6xlBJpE1+xXbEJE9T51cntUEtm+P+7TOVtoN
         ndOwP9mCc+fZKtAA4P0GnLzuFZZfkHpqFx70k1wIRIXKQkPjCpm6ak0yNzuI1RaWIXxd
         NZ39bjjr8L0imRn5dBSSWrze4URVAprSIS/gsyLd7N3G6tO5rkLIWN3sb59xO64R5XS9
         /0oo3foW9mbXwSenK59yIFBWxIDGnXqfU1+RKRLKzzHP29Y7rOedwGaZ4997R80O5YzI
         igSLEvNbyqVR6iOTN9N/zqtCCs9AwnN+axFSgaWq9PFNlx1GNNGM6v/h5BsDfPX0A/7z
         63/w==
X-Gm-Message-State: AOAM533B9Lo0nCIqBapqT+8NbjN/rNohSVJCeIqQHh1K0BrbxdqpkNAS
        Jv7jnrLAnb+/YMpRLyGW9eq6N+J+dIbiUroJ
X-Google-Smtp-Source: ABdhPJwH6c+HW0wWntSrWcOHFKbjpQGsMQ9Z78MAjIgut1i9LuxyhhVNG8UCCvXh82LRCy7qiVoC8g==
X-Received: by 2002:aa7:cd64:: with SMTP id ca4mr16357828edb.334.1617385351814;
        Fri, 02 Apr 2021 10:42:31 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.90])
        by smtp.gmail.com with ESMTPSA id m9sm4475270ejo.65.2021.04.02.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:42:31 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] iio: buffer: use sysfs_attr_init() on allocated attrs
Date:   Fri,  2 Apr 2021 20:42:26 +0300
Message-Id: <20210402174226.630346-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dynamically allocating sysfs attributes, it's a good idea to call
sysfs_attr_init() on them to initialize lock_class_keys.
This change does that.

The lock_class_keys are set when the CONFIG_DEBUG_LOCK_ALLOC symbol is
enabled. Which is [likely] one reason why I did not see this during
development.

I also am not able to see this even with CONFIG_DEBUG_LOCK_ALLOC enabled,
so this may [likely] be reproduce-able on some system configurations.

This was reported via:
  https://lore.kernel.org/linux-iio/CA+U=DsrsvGgXEF30-vXuXS_k=-mjSjiBwEEzwKb1hJVn1P98OA@mail.gmail.com/T/#u

Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com> 
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---

@Marek: could you maybe test this on your setup?

I haven't been able to reproduce this on mine.

Thanks
Alex

 drivers/iio/industrialio-buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index ee5aab9d4a23..06b2ea087408 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1309,6 +1309,7 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
 	iio_attr->buffer = buffer;
 	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
 	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
+	sysfs_attr_init(&iio_attr->dev_attr.attr);
 
 	list_add(&iio_attr->l, &buffer->buffer_attr_list);
 
-- 
2.30.2

