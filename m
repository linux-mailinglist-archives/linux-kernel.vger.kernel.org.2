Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85A238CE60
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhEUTtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhEUTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621626494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dcVKe0qdt5wPmssTiHpynTzWxX54hdMY2B36rci5X+Q=;
        b=gNnGPDYZseyr4RCxpf0N0d9bHydU24C3yjiPemijDikJiynbePlfdipHTDJ1w3I1KRjGik
        s9nK+fcDQy6VhnEdgLdokMvL23rtvywpC3f788Y8hTYbx4DSxBYwvZ4E+zi+ejDF6KqhXG
        pIteG3r10EyyoMSGBJYWI0gJ83xAFgQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-rQXgXu8yOcCl5l9f957S_w-1; Fri, 21 May 2021 15:48:10 -0400
X-MC-Unique: rQXgXu8yOcCl5l9f957S_w-1
Received: by mail-oo1-f69.google.com with SMTP id i11-20020a4a6f4b0000b02901ef8b6e92a6so13947234oof.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dcVKe0qdt5wPmssTiHpynTzWxX54hdMY2B36rci5X+Q=;
        b=YPbHPxUVU8EFj34FHqQN2melqKhIZ9VTZJj06HEip83n12eROJ3weQJgp6rVasfQIs
         HYfZJOlsNRwU11K2wvTSiAf9MN06rD4ZhwOKADxzm+ndDH+kPgqcpuaoxXEQC4mplKQU
         qm9whUjw9D8i2C1eLNXd7wqizruAJTFQU8FCj/4qSeiG2RXfJpZz6Vx/yxn4bxL9/jDF
         ADc2sj2Qglyo/5Xyk8PhbhEzHG3jjztjzdyp/XLQeWIBsxob/D45ynm0UZzQCgVNCy1R
         9gyRcwowzJkNbqHuFrRjvzlbn/3aBkv6ep47+T8z8sQBdg/hrcqv7H9dt5awcOaAT87V
         r/sw==
X-Gm-Message-State: AOAM533WVlNZztp9hGQR4oKxR29rW1Pq7RzomXrQ6iDBIbdcr1DJTd2h
        5pJgnLYNuKk76ZhFK62aTnZ5FeSql3n4qSOQscFph2w6aqUd3/pzoFF7oYe7u2ydLhcnLSlCZIP
        FdKu5apbszSDzousp1Jq0Db55
X-Received: by 2002:a05:6808:6c5:: with SMTP id m5mr3394627oih.128.1621626490083;
        Fri, 21 May 2021 12:48:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYrYQGPQcv+yBq3l/flebYi1hTX+R84vJTx8eoodbyd7DfEsBjcEW5UppYT9L2Rb+H4ngnOw==
X-Received: by 2002:a05:6808:6c5:: with SMTP id m5mr3394619oih.128.1621626489952;
        Fri, 21 May 2021 12:48:09 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w20sm1302157oic.54.2021.05.21.12.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:48:09 -0700 (PDT)
From:   trix@redhat.com
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        drv@mailo.com, martinsdecarvalhobeatriz@gmail.com
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] media: staging: atomisp: improve error handling in gc2235_detect()
Date:   Fri, 21 May 2021 12:48:05 -0700
Message-Id: <20210521194805.2078135-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this representative problem

atomisp-gc2235.c:867:20: warning: The right operand
  of '|' is a garbage value
        id = ((high << 8) | low);
                          ^ ~~~
When gc2235_read_reg() fails, its return val is never written.

For gc2235_detect(), high and low are or-ed and compared
with GC2235_ID, 0x2235.  Initialize both to 0 and skip
checking the read returns, it's errors are not passed up, only
-ENODEV is.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
index 38defa0f81513..3b6e02b1f45d1 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
@@ -849,21 +849,14 @@ static int gc2235_get_fmt(struct v4l2_subdev *sd,
 static int gc2235_detect(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	u16 high, low;
-	int ret;
+	u16 high = 0, low = 0;
 	u16 id;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	ret = gc2235_read_reg(client, GC2235_8BIT,
-			      GC2235_SENSOR_ID_H, &high);
-	if (ret) {
-		dev_err(&client->dev, "sensor_id_high = 0x%x\n", high);
-		return -ENODEV;
-	}
-	ret = gc2235_read_reg(client, GC2235_8BIT,
-			      GC2235_SENSOR_ID_L, &low);
+	gc2235_read_reg(client, GC2235_8BIT, GC2235_SENSOR_ID_H, &high);
+	gc2235_read_reg(client, GC2235_8BIT, GC2235_SENSOR_ID_L, &low);
 	id = ((high << 8) | low);
 
 	if (id != GC2235_ID) {
-- 
2.26.3

