Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4571D3405E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCRMpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhCRMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:44:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB24DC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b9so5386968wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqK2Pp2ViTz0xdgYhapttz8LcH4etuWNmG0+y0P94Tk=;
        b=OA9EIYsInkm8+sbKDz65mq57blKnFk/VyB2KwDk4y5vDgz6vnx4e19aC7mQ4UamzvD
         8axwr/dUv/8a30fI7OPHVI6nG5Hpj237RPlR9w/4Me0kWU4D65vEKauzTCHvM4TXlXqt
         Ye7le7bu5vxmYtgQ29JW01tPCw2+eLDnmKkReOUOeOlRJm3h00gybG0Sn/tofbARn+4v
         Nk5YEyh5SBRVM0kgOl5TGaU9YS4XgQ5LCG97a7VD6aXvKM0TL921nV8IgWxH1wHDN7KQ
         WXx50dqy7LYZI2p5efB/j3TTR1hXGzQgwh9pxXBQSeD7rVwlAxlcvUqX9+LFOEy3NaNA
         gkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqK2Pp2ViTz0xdgYhapttz8LcH4etuWNmG0+y0P94Tk=;
        b=nf6OqjCDFH2ZxgrOa+M1f+ruhLGzjH+Z3qzfubVLfXoQ5lrlH2MdlA8nL78Oy1FnQb
         p8zU619mHhnp9VA1oy0FpvI5PlPdvLNgKrC2cZ1F7d8K/E8a4dSvyeGPCCHpH0hgkZ0T
         hNvt+6QtVXUtCNkV38AepX4GmWIP5pHWf2OTPuLmZ3lG4Hod8gp/G3PojjA75jrKcIs0
         AURD8yCGAiWnpe5fqZUhK1ADhnAXkUl+U8OpuHAtgijmeHfEkVtC50ZIFZuUXbfY9YIU
         VAAod5ZNKx6O9FkJRvTv4NAu1ekKnAA8cZx1y+yl1mf2za0xjiOuFbA1ty8Nb42t1SZZ
         ZH1g==
X-Gm-Message-State: AOAM531x4BskXFcpQXC623lgVnm8g0dPnpXg4x1mxjYSvCvCNnDF2Ezm
        Mmpfn4TQnhWEBYteYkGnUqzbCKndPWiHww==
X-Google-Smtp-Source: ABdhPJwV0CtMRkwCaOXy/5vvgsMtNuWjcOi3sZABwA4HMtXR7vy5o/de4/orKnRynrT1wJ3qUCKnpw==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr9585919wrm.32.1616071471400;
        Thu, 18 Mar 2021 05:44:31 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id q15sm2813900wrx.56.2021.03.18.05.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:44:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 01/10] crypto: hisilicon: sec_drv: Supply missing description for 'sec_queue_empty()'s 'queue' param
Date:   Thu, 18 Mar 2021 12:44:13 +0000
Message-Id: <20210318124422.3200180-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318124422.3200180-1-lee.jones@linaro.org>
References: <20210318124422.3200180-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/hisilicon/sec/sec_drv.c:843: warning: Function parameter or member 'queue' not described in 'sec_queue_empty'

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Zaibo Xu <xuzaibo@huawei.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/hisilicon/sec/sec_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/sec/sec_drv.c b/drivers/crypto/hisilicon/sec/sec_drv.c
index 91ee2bb575df2..3c26871db12f3 100644
--- a/drivers/crypto/hisilicon/sec/sec_drv.c
+++ b/drivers/crypto/hisilicon/sec/sec_drv.c
@@ -834,6 +834,7 @@ int sec_queue_stop_release(struct sec_queue *queue)
 
 /**
  * sec_queue_empty() - Is this hardware queue currently empty.
+ * @queue: The queue to test
  *
  * We need to know if we have an empty queue for some of the chaining modes
  * as if it is not empty we may need to hold the message in a software queue
-- 
2.27.0

