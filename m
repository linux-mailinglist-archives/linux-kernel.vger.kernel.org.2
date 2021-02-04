Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848D830F1B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhBDLLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbhBDLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:10:46 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EC3C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q7so2941243wre.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1Hcpu/GsWIJa0ISm8bZ6HXe5H9dtQ9e34hCFzoGJVs=;
        b=GqGjTH3exPZnUvuas4XWPGoETlhvPot3+TvjkOlDnxXoe1coZAt2hy/jT3XKnkw6fh
         LGklIUq3zBgQ9jgyWRbi/e2qTa+QBTpniwrYo+NSlKVCjg/KQXXeNmb8n13P0g8F8yY1
         n3drLix+WlfPPYGTgkDxPcesnJ9vYZm/dLFPMd7drEiwSFEBeRSD0Iz8LbUhQ3IOQyK5
         2bLD5kx6MQnR72F7ZbfJeM6Oy6gvgo5De/X1RNQ83wcQ368guKzegRsbSnin3uejNjhn
         F13499ZOFCdtjxeGUrJ420lTbM4Mrem03vUVRJM0wFzInoE1iCVzRjouEFhNKsTKt3NY
         WEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1Hcpu/GsWIJa0ISm8bZ6HXe5H9dtQ9e34hCFzoGJVs=;
        b=H2oDrI4H9lwTZotOpeotY3cuBeWS4Kd/IivkLgnJ/2CYGy8YuYpdMRVIE+6a7k6BMa
         1xOGj28HIutqibo83ZBdmKK9uMU/FVdfwtpbv6FkGeSgCh4KKxJWNhZLrut/HlbRL5XD
         UEvtm0TEW6PoabRdZg2BlLkq43/pOHki2hR0WWFcE4UAmW3fBouI7cnfzPivd9m+0ZoA
         iwnpu1LpNiRTGpFJNpX8VinsRNtLRifDZcDSiYVk7ZEGuzlLnKhvgYt4SMwVuEJECvl7
         3/UqLAhTprdHZWuLshBaDhdjAyfa/T7zhWeZ0WiqaKA5aYnHDNNTzpLCzyTX1VErqTue
         8Utw==
X-Gm-Message-State: AOAM530pr9QSwBAGDAsnHJ6tuH09579ztMzEdTO+AlFnbRSbo08KFkmc
        Sme5XqIfu5rELr6uP4zET0PVkV/cCrJ3GA==
X-Google-Smtp-Source: ABdhPJwjdkC95lnOwPsXjE3KbW1ymbODYl/4EWoKmla9E92T0UEh0s4HJSxjepfmFWLxqqxeWowLog==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr8797431wrq.359.1612437005106;
        Thu, 04 Feb 2021 03:10:05 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 01/20] crypto: hisilicon: sec_drv: Supply missing description for 'sec_queue_empty()'s 'queue' param
Date:   Thu,  4 Feb 2021 11:09:41 +0000
Message-Id: <20210204111000.2800436-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
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
2.25.1

