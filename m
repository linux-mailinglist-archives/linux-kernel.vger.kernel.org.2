Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D50311889
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhBFCkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhBFCca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:32:30 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C002C061B3F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:11:14 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d6so7242635ilo.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktpO/jSmoOx5RVisI52DM6PeD/6jBsQ5/HisJypSEHU=;
        b=ozvSvOes+inyPBHz80LRvVrFcsrJMzQcACU5LKGFx08VpOGwelVCRaOGmPRhfUgQCf
         N5rqnPRhUMvCvkCVIkkyaPXJ6xaVQ/AoMuGpi6zk8CwVLjaQ8KbMscdkjSWapEY8O8EQ
         vTLjdqs+t2mXJMIP4Npaiv16vWRmN36xVdMJ4i2sw+Z7elNhC6x42O+YvahqLGUDv4MG
         ZgH5Tvs3PWP03HWf/1e1H5C2npvac6I6W8e3OFf/HvHaDiP5UVgRq7nf46JLwL0C9bA2
         DmaKbWBsP/apTInIRbWEwjExMmiDJ7MFjsv85P9AJ/Z2bNfoC3UqxoxSbfNrFgd34dD4
         uExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktpO/jSmoOx5RVisI52DM6PeD/6jBsQ5/HisJypSEHU=;
        b=YKk4/Ibt6jBqMFyvvb1zaBRJjyd7qyT4ZU0tzn3OvTdps848n/+b9bfQFBcIo0Kpuq
         fiyYTxZAUbXFriGHwRaBJHootEXGnjlUZClWH/71/xLw86t1OqKqVdrqeFhJDNqn/Z64
         8Di5h8HNgLYVB34CU4MPUoBzrLgC/66aSOdO4w/JzlZpW76aAAOmCL8oxJ1MGPcHn/o2
         Go8AupRmTIec5M9YEqsEhOrvgf11oqdlpQM2CAhAsHNBFvdgehmkPwcC3rglyc/J99Ki
         odWzjl880ipmN2wmntCO2/ej/V5OjJwZBkIwS3KyOh0qKHbOvJBii+bAPyBjv/kH8koa
         Qyzw==
X-Gm-Message-State: AOAM5305YLFk778deHvffBSQkGLGUEB6V7z34+6xLlFC3XZ6c+ZP2AOB
        FIDpzyTXjGKpVbtJxCRFsNF2eQ==
X-Google-Smtp-Source: ABdhPJxC0bJgCkwEtZG6d2RJ3paGFc9aTLxSS6YQQ28hdw4p7jc/JS4xelRiLwvAYsVfxkek60BtmA==
X-Received: by 2002:a92:2e05:: with SMTP id v5mr6146744ile.241.1612563073683;
        Fri, 05 Feb 2021 14:11:13 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m15sm4647171ilh.6.2021.02.05.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:11:13 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/7] net: ipa: get rid of status size constraint
Date:   Fri,  5 Feb 2021 16:10:59 -0600
Message-Id: <20210205221100.1738-7-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210205221100.1738-1-elder@linaro.org>
References: <20210205221100.1738-1-elder@linaro.org>
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

