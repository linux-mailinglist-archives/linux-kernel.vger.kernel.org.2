Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBFC31972D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhBKXwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhBKXuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:50:06 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43317C0698C5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:44 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id j5so5050098pgb.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mp+mWSDpsQpj9MF3x3T5H2fS4e1Av4X97/izXSyp1vI=;
        b=IuMH+Xl3+C4gUMMxtAllS7ZPSyGIoYf2rMe0IufQxwt52j9zVpYi7Q3JUk8+OxWzM3
         PvpHM5+brzjn0zNVXbpwOTW6Fr/Sphi34Y+Rvf4XaNv4qvbVCuVST2bvyBMNbXSy8a2O
         cefrrkXqEPkTtXSPRfrSIYYPiFexWCuzTM7gVdqpFmeWvFgI7gDGsq2XFJ3t5jph5Pt9
         xjrSqVy1afVFI63asEptOugavONzuOBGj2UtNCaJqtu6Kjw4P04eiojQ+/1Txmthy8PW
         PLREL70UwzlmOeiYrHjsXjEoQKJQxrAe6rZoEkPScppHQGdzJu74eD8haECB6A9poH/Q
         N/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mp+mWSDpsQpj9MF3x3T5H2fS4e1Av4X97/izXSyp1vI=;
        b=nSm566duNVM+ONwt2Hql23ixGAK4mS23AdpXEaM+tz+qqOeamPEPs2zG0GnnbR2rqO
         W39ufytZYn1nnufD0u0oTtDwpkq493xufV6WQP/20q1ddkQSaCAbBuauWzjZzBSlvjDr
         wMUES7+l95xkoKR/mqdblNUIdPlBE++d8w4AySKkmyHW+QeMGRa9xG1ok8aoAmtS74hN
         NUTi8wnjLPh95dWMHrRS0mZjOIQrWMGHQtGcOLHtbZntYmJ8skvNU4HJVOppO6/NQMZG
         Vdr7EqNm6Lyb10bMn+0Qsj0pqf4y9Wq8fP8/LnQtG19FHlId/KRBSiLlAgiaKzrkANt/
         +wqw==
X-Gm-Message-State: AOAM531ZK8nd0pRU28P7OC3539v0p9N88DjLzg0CAA6a+Nh0nXMI9IRa
        Iugko1oSUHo1fZeqaFkvIcK4vQ==
X-Google-Smtp-Source: ABdhPJy8Mb/RaDN4E9yiyhX9HRl5bhPkreXY/KdCrERlX6WBjqpAKbwRDF5yZPdwFRMoauRSVPM6Xg==
X-Received: by 2002:aa7:92d9:0:b029:1bb:b6de:c872 with SMTP id k25-20020aa792d90000b02901bbb6dec872mr427305pfa.68.1613087203698;
        Thu, 11 Feb 2021 15:46:43 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id iq6sm5932740pjb.6.2021.02.11.15.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:46:43 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 15/19] remoteproc: Properly deal with a kernel panic when attached
Date:   Thu, 11 Feb 2021 16:46:23 -0700
Message-Id: <20210211234627.2669674-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
References: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panic handler operation of registered remote processors
should also be called when remote processors have been
attached to.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 62f708662052..0dd9f02f52b6 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2693,7 +2693,11 @@ static int rproc_panic_handler(struct notifier_block *nb, unsigned long event,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(rproc, &rproc_list, node) {
-		if (!rproc->ops->panic || rproc->state != RPROC_RUNNING)
+		if (!rproc->ops->panic)
+			continue;
+
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			continue;
 
 		d = rproc->ops->panic(rproc);
-- 
2.25.1

