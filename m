Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AD7421CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJECkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhJECkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:40:33 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F534C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 19:38:44 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so24111322ota.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 19:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1As026ACI4z9YD96O++wp62zq89tC9v8WEwP6uOHA3Q=;
        b=vXpRyMqPwXNb72D57hhI4NHgKmlXiUnei9EP464AoeWz5vTjuptZaLgYvvVDnvabQG
         9mhIICTWBcimd/3joOUhskzfcpKUTBSy0hRffkSuCsmviPBN/+5LEs7igLNLctCwA4Bw
         GcwOhqq+r44YpCscCoKvd1bV+JVnRA+1DTJBboHBrwHKMbVKGglQsM3IBeBBG20c9zBy
         GMwt3DtkbbQVhWDy+KU1MhvtsZOH0yzl9eKjhrQo6B3wxUNtwsEWPSGntw2DHaLa+6i/
         DNzqgb3IZIH0xMM3OUQSe7YsXwNCgVyDjL6KnwzZuyBw4llaj1C5wPr0vZFrwXCngTjD
         +iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1As026ACI4z9YD96O++wp62zq89tC9v8WEwP6uOHA3Q=;
        b=kb21mnrjuIuJsoLWHBSI3OyK1X7XiZG/sju/t0C/9UBuOwIwCVNeoWohV3GT1uEHRV
         j8ZiFAZVxsXdLsTQTp/Pmzo1DYTHpi0Qj0ZQxpcAn4h2mcViXpqX3W0aDpuecUfyNfAv
         MbFJSPvHmD2ZqDVo5d62pSw0dY0lE9m4Jb6Qk1FvvBZXjO8Hn9/2zJY5GtwMVWvVQ0ZS
         rQD/ItBzWkchD+1l6eqMQlZc8Zq/CCN2Rob3AjhG4459u8yHqGQTkaj9Ft2oUnW24OOq
         lsukUdxTiyApUgURziLuRgUrp1CBFG6YJ6aN+Bu20c/M7p+u0k1lJG3xrFb+POjZGxwE
         IYeA==
X-Gm-Message-State: AOAM533g8vXhMG6WSFDvPiaEQFylbuS6MQoWlD0Sg41WY/ejfMFsOMvT
        tVm+HhAaiv+DGu/PuRyl8TQ2iAXyhegMZQ==
X-Google-Smtp-Source: ABdhPJyOTKZ8Z3/YTyNFYGmOm2qLjJWfeVpUzOYTbCxJHeNc4SvCriowzyofTnld/IBQEVUsMyut5g==
X-Received: by 2002:a05:6830:359:: with SMTP id h25mr12206875ote.48.1633401523430;
        Mon, 04 Oct 2021 19:38:43 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id d7sm3238711otl.19.2021.10.04.19.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 19:38:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: socinfo: Add PM8150C and SMB2351 models
Date:   Mon,  4 Oct 2021 19:40:25 -0700
Message-Id: <20211005024025.2037810-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PM8150C and SMB2351 to the list of known PMIC models.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 47e9ed03882a..bd80db3181df 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -102,6 +102,8 @@ static const char *const pmic_models[] = {
 	[32] = "PM8150B",
 	[33] = "PMK8002",
 	[36] = "PM8009",
+	[38] = "PM8150C",
+	[41] = "SMB2351",
 };
 #endif /* CONFIG_DEBUG_FS */
 
-- 
2.29.2

