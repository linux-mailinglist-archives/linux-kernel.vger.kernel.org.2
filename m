Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55BE311452
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhBEWDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhBEO5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:57:55 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30CC06178A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:25:00 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id d6so6316012ilo.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktpO/jSmoOx5RVisI52DM6PeD/6jBsQ5/HisJypSEHU=;
        b=bdgOwBy2EdlM8UU2CbP0LQUUrUdWj9ErOn2Pypwrr2YlwgXfTIy49IdBEeE/C4Gti8
         pWfKw8O2Txoje8FGF+dNElEqJdDUvkOzRflX/T5ZZJB6fVLkOaoLtZw/mVgjhPMnBAeE
         BPh1fVoyM6VGVVWmkMmRpTrWUSCQMLDzIPU2fnBgWKfrRuGRQje75F7s3vwo6mcqAMe0
         qxQ7o8SWtPtOQ5elX/qC05vTjHAbcg43BKrkk217z6x3pygbQzE0G9QXZ4nCzgQHqjbX
         UxOTqboS0NX4U7sWXbv5WOIPnLMIqqVI9hbHNMhYJHxd1wWF1V9h8rFFPVDaRxW+7+JY
         bN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktpO/jSmoOx5RVisI52DM6PeD/6jBsQ5/HisJypSEHU=;
        b=LBGvqg+qUCIx0dULzTQ4JpCVJb1fuMy28A+53xKcIEGNsHOWFAM23q+ftycqTrPKl/
         eUIh0PDhr1i9lPTXVvfdPdbWEI+W55wsV+pMT7dH2hyBocL4oKquMGLZMsXKJ9MoXiYj
         yi/0+9+i9ax4bhoUN2izIewFQzuVkWX+O+3ZL+b2ec0eDUOikwMItpcXoUppJ/caPuIn
         H1rmWSiuSro/iibhqHrUrCAj1L03Msyu0clJlIA9VX6U13GkZ7RNXbvZFc6291L2oX+8
         LyxKgKJfWjrG+PWezGMTm+QtZcRM+zUP6ST9+vwxMVHU5KdR4IGJgE2+hDsSlrXmk4RE
         veKA==
X-Gm-Message-State: AOAM531/gOorPED60nUUVPPfUBoPGUeLYImoFaksNa73SBJzOKnxDUif
        UcRn3hFyviT4tPKQ96+pgK/9BS+ITNH6AQ==
X-Google-Smtp-Source: ABdhPJwiRGWecuiPuMFn8Z+xj2JpfGLpEDk9gLnBWUrlLf5hOstCF5U+3C2HcWcQqh7UrCSbndbi/g==
X-Received: by 2002:a05:6602:2c4e:: with SMTP id x14mr4376864iov.58.1612535919991;
        Fri, 05 Feb 2021 06:38:39 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h9sm4136882ili.43.2021.02.05.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:38:39 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/7] net: ipa: get rid of status size constraint
Date:   Fri,  5 Feb 2021 08:38:28 -0600
Message-Id: <20210205143829.16271-7-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210205143829.16271-1-elder@linaro.org>
References: <20210205143829.16271-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a build-time check that the packet status structure is a
multiple of 4 bytes in size.  It's not clear where that constraint
comes from, but the structure defines what hardware provides so its
definition won't change.  Get rid of the check; it adds no value.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index bff5d6ffd1186..7209ee3c31244 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -174,9 +174,6 @@ static bool ipa_endpoint_data_valid(struct ipa *ipa, u32 count,
 	enum ipa_endpoint_name name;
 	u32 limit;
 
-	/* Not sure where this constraint come from... */
-	BUILD_BUG_ON(sizeof(struct ipa_status) % 4);
-
 	if (count > IPA_ENDPOINT_COUNT) {
 		dev_err(dev, "too many endpoints specified (%u > %u)\n",
 			count, IPA_ENDPOINT_COUNT);
-- 
2.20.1

