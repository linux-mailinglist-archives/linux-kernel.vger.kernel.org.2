Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DB531EF19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhBRS7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbhBRRR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:17:56 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78336C061786
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:17:03 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id o16so1772932ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=X79/FL7O601ZV52yVZ6z02kzQq2OSMITFkO3ohwlxz0=;
        b=B3uIqaD28vR4iHEhLwxCN3xwylIe+uY6SaHqX0Xdf8ay4gUV0Q+4H/RYxHe+zkVTRs
         bZGMD0afv+Hw8bnFjOMBVYwmPKZqAEoQLP2bx9VA0bYA7hbaO5jZ+Gjupt/6GIOV7ZTD
         LHWbKey4NLZu3qI2vFvUOUVa9oRrcPfFQmmfybgE5anEWhygFtOcPWTkM5haWTR3IavM
         /dQnMD9Z7YeJDMB0M7c1TilPx7AOOJlh3QPRetB69WvT6VpTs/76CgsHuzuDNimKVguk
         4SfaiSDk27mvwW0RK7gicuEm6Br5LKlBeUn7u+v4CSk7KA97CDOmZHP2Cxgq3SnYsQy4
         sEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X79/FL7O601ZV52yVZ6z02kzQq2OSMITFkO3ohwlxz0=;
        b=ConW+7x9gOxAspeul4rk51GQmluCBLYuRAKrcZvZ/N3WV7djljUS6QVQCTut5dF2l4
         S0u/i9XMRjQhKyLQn1hFWdKh9lL2Gwb2LErObuYsmDA+VdhWHQhgCL1odronleqLcBBc
         yBc/Sb3kXHFSnSbb84jAooajBdsDWrQm7nUl1oMZ4W/VrtSSAEOuCfHCeeFh4QNn9Sra
         9cRh/BjIdgB5Ak37zTKnMRORahoR4hgEERyqMLJrQNTkYKqFzYE6R+nzf8VygLzbQe+D
         ORsNB6wCDuI+wSCRSrl80HfBDTfKAESRPvgrZ7fjrkGitsPaFLaytD/71tU/mCmq00LR
         GF1g==
X-Gm-Message-State: AOAM530lDivrmRiblsglvpcs6zyPuHcyOrw4v9gYEpumxcLAcCWDKUjV
        51QaKF29ghMMv3g/hW3MaKHfUQ==
X-Google-Smtp-Source: ABdhPJwwSKqtxOOm03g09zExbpXmFZUpBTGn9nHJ44JFeuSpejew5EJQS/AiMMEqBzNiEtDm5WSocw==
X-Received: by 2002:a05:6512:3607:: with SMTP id f7mr2813954lfs.245.1613668621899;
        Thu, 18 Feb 2021 09:17:01 -0800 (PST)
Received: from localhost.localdomain ([85.249.43.69])
        by smtp.googlemail.com with ESMTPSA id l19sm650670ljj.107.2021.02.18.09.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 09:17:01 -0800 (PST)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     junak.pub@gmail.com, robert.foss@linaro.org,
        sakari.ailus@linux.intel.com
Cc:     todor.too@gmail.com, agross@kernel.org, bjorn.andersson@linaro.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        jacopo@jmondi.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v2.1 1/3] v4l: common: v4l2_get_link_freq: add printing a warning
Date:   Thu, 18 Feb 2021 20:16:40 +0300
Message-Id: <20210218171640.18764-1-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print a warning if V4L2_CID_LINK_FREQ control is not implemented.

Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/v4l2-core/v4l2-common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 133d20e40f82..04af03285a20 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -469,6 +469,11 @@ s64 v4l2_get_link_freq(struct v4l2_ctrl_handler *handler, unsigned int mul,
 			return -ENOENT;
 
 		freq = div_u64(v4l2_ctrl_g_ctrl_int64(ctrl) * mul, div);
+
+		pr_warn("%s: Link frequency estimated using pixel rate: result might be inaccurate\n",
+			__func__);
+		pr_warn("%s: Consider implementing support for V4L2_CID_LINK_FREQ in the transmitter driver\n",
+			__func__);
 	}
 
 	return freq > 0 ? freq : -EINVAL;
-- 
2.17.1

