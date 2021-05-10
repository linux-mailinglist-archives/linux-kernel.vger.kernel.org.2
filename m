Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65079378E30
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351464AbhEJNG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351167AbhEJNDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:03:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1FC061361
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:56:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l13so16497720wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjOlhmCbAbyUbUH7pil1I907GgA6nAM7F2t7vQHJi14=;
        b=f9lveGxFe9Pw8WYVlGxIEgVuO1mnm7e2GgPSpQGuhH/T2sjSEST44fTvFD+tp/lIzi
         l12Qf+xSoCOYm/RxYEcaz6XwDoOsuAG+UUBpPK8nX+aGhC2BBawQOU2ZDUT3RnRJUzDh
         uucUDHJuS5NOdIvek5tQEBO3Z5BbpLO/m/QQ4PLJieBfwdpZJom4VnQDZHpQ59S1Y3Jn
         AuZJEIRF5iOmaDEyonyDmEcSSEBEnoIWLsnndskhAS9exaxVyKIIYgmJddbQEdFejIFu
         8iDI+MQVHXyShSpy0aVLKNwf47BfbRU6I+p02s9D9aYLqW+kikf+eAmxiWUR3dfIkzWr
         f6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjOlhmCbAbyUbUH7pil1I907GgA6nAM7F2t7vQHJi14=;
        b=DFFG7r0VBdUbeWKD1Uy9Egjk4sqmQK+e1ckcXoWIdPpBzgTY34ILi+M9/XayDeJmhp
         esGFzm4hUXTu7mUqIY/4RhTvBAQgj/7hByA7Q+3cJ+um3Sx0OAF9lXfINC4pM+tag5ng
         Bohay5LpIP9JJDXIf0koUXx8wZcLdDlRW6TYcwvxG3FYzO4NTtDZdG5vOIzdDgN+Rxqk
         Il6aD4MC04/+u7hntn5lLVXDbCVfv0rl6ISapCsPwSniPKpDKTYpG83T1WgR8oQwAJq2
         lugx2YqVh+yaXqBluxWK3ugGEM7G0xgcmzMgahytaFBZzj63CWhEjDEEbPgZVQe7Hvnv
         EK0w==
X-Gm-Message-State: AOAM530Z6OfXeT84H1TuwZRMd1OX10l+csMHMsSsfK/o4/jALP0NHx7V
        zC7HxqFNM+JKEA7IAgXHF9T67ikNQ18Sgw==
X-Google-Smtp-Source: ABdhPJyAXSIWebWDF2S3D1eLFeO0OlxyJoRD3nHZbVLU9Hc5ZKi7lZjH0aZy9cWQknjoFHOmhKU0TQ==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr31894907wrk.244.1620651359564;
        Mon, 10 May 2021 05:55:59 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:59 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH 09/11] iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers
Date:   Mon, 10 May 2021 15:55:21 +0300
Message-Id: <20210510125523.1271237-10-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Channel numbering must start at 0 and then not have any holes, or
it is possible to overflow the available storage.  Note this bug was
introduced as part of a fix to ensure we didn't rely on the ordering
of child nodes.  So we need to support arbitrary ordering but they all
need to be there somewhere.

Note I hit this when using qemu to test the rest of this series.
Arguably this isn't the best fix, but it is probably the most minimal
option for backporting etc.

Fixes: d7857e4ee1ba6 ("iio: adc: ad7124: Fix DT channel configuration")
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7124.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 437116a07cf1..a27db78ea13e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -771,6 +771,13 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			goto err;
 
+		if (channel >= indio_dev->num_channels) {
+			dev_err(indio_dev->dev.parent,
+				"Channel index >= number of channels\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
 		ret = of_property_read_u32_array(child, "diff-channels",
 						 ain, 2);
 		if (ret)
-- 
2.31.1

