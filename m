Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84130DD01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhBCOjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhBCOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:38:07 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B835C061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:37:27 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e133so14587167iof.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XsFAitZq+M4tO2JmgFSy4L0QDeaBFSgSKoOpXPki0CA=;
        b=MqGiJDs0nR5mYzkyjKBPRmovzjcjk/nQU/ZwSGNMFfmcgDts0xs7NZ0A0xW4MxeElW
         6pymBnBN4xmUHYWS8L86gailn/M8sBnAt0z0iu8OP0SSynYvCCTw8oze9TTy/X0ZAwAJ
         ZUdouE/ph4LhEyNlE1qIkx2Mv/WjfZoZ98mTEF09hpWEVjxFva3F1OoEwopMoDtlyIzn
         TKnpvfDWgveVynlVyZpxmtqqLvXSS/l1jqLncFKNpFfAmTaArzdBhjeyY2KTwwb6AlVC
         5vKjIwNusRnFmFJS3fNzN5nxEiPkNJkITQuk1FsQOpye5Rdb3SqXa6ksrZkbbjX1v9hO
         xLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XsFAitZq+M4tO2JmgFSy4L0QDeaBFSgSKoOpXPki0CA=;
        b=qnd75YL4ZslUw4S34I/gSuKkCV8WLzuJGFYy//dRZVu5wW1qHmeVrSlLxCsDG+EsaT
         KZqPTQKZGmiNOYM0gHdckxxfZwxrM9ucshpqhrv4hlxXnAZumn60dVSnObZ9bm3JtRZG
         vMc6CKZ5TX+0WQspl/KppwE6Csl3wWQxcOTS8aFPD6h1bIjUCR0zacmqOlyWXF7j1p+X
         MInvft46DhvI/wARIWeCV1uzRD8cWMPfcB8DuLpfdBkhsgNfr8p1NkVkxACUi3n2yOu3
         ZoHIlLNGwPEKwXkFz5gHO4trw8eN5Doha356aCgmrxz4FmCc7tbyu7e5oVc49Jijm8xB
         NX7A==
X-Gm-Message-State: AOAM5329ydNM+KSTNd6tfATII33ezgj84WhAgLHWL17CzTxh474czn2X
        7hBfsCM0Kn6bwrV9zQT5pXedxdQfJSUGLg==
X-Google-Smtp-Source: ABdhPJwU8ubI17iZsjvvNKW9SYlf1uU4FAX2aVEdple7r5WCBSm57xxbJ2XHmuvYP2n4JzZZQPrw7Q==
X-Received: by 2002:a6b:5505:: with SMTP id j5mr2635815iob.148.1612363046927;
        Wed, 03 Feb 2021 06:37:26 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id i78sm487816ild.50.2021.02.03.06.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:37:26 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     dan.carpenter@oracle.com, elder@kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ipa: set error code in gsi_channel_setup()
Date:   Wed,  3 Feb 2021 08:37:23 -0600
Message-Id: <20210203143723.17881-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gsi_channel_setup(), we check to see if the configuration data
contains any information about channels that are not supported by
the hardware.  If one is found, we abort the setup process, but
the error code (ret) is not set in this case.  Fix this bug.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 34e5f2155d620..b77f5fef7aeca 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1710,6 +1710,7 @@ static int gsi_channel_setup(struct gsi *gsi)
 		if (!channel->gsi)
 			continue;	/* Ignore uninitialized channels */
 
+		ret = -EINVAL;
 		dev_err(gsi->dev, "channel %u not supported by hardware\n",
 			channel_id - 1);
 		channel_id = gsi->channel_count;
-- 
2.20.1

