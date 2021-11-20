Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0EA457C41
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 08:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhKTHta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 02:49:30 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:55262 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKTHt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 02:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637394386; x=1668930386;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Pp6EhLw7VumofBo6dP+3b3t1m3ZOohSUF4/UlgDqC0w=;
  b=WfuoTRZ/hrfVVzfAWcwDSv7ZH0W5NnFkeHgxtzmE3CDubykA/4mm/ijL
   u5EAUaLs2IV4iu+AIaPcdMuGsP1HsHA/vH6emS+znrU6u3TXwEfirxsdA
   BxKa6+qCGbqmz8cj3FZJIZlFiCGH4KyHTbAKyd52ITOfWVm66N2XQyTzt
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 19 Nov 2021 23:46:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 23:46:25 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 23:46:24 -0800
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 23:46:24 -0800
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <gregkh@linuxfoundation.org>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <nganji@codeaurora.org>,
        <aravindh@codeaurora.org>, <dmitry.baryshkov@linaro.org>,
        <daniel@ffwll.ch>, <joe@perches.com>
Subject: [PATCH v2] MAINTAINERS: update designated reviewer entry for MSM DRM driver
Date:   Fri, 19 Nov 2021 23:46:11 -0800
Message-ID: <1637394371-16783-1-git-send-email-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself as a designated reviewer to assist with the
code reviews for the changes coming into MSM DRM.

Acked-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b33791..c27d8f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5935,6 +5935,7 @@ F:	drivers/gpu/drm/tiny/mi0283qt.c
 DRM DRIVER FOR MSM ADRENO GPU
 M:	Rob Clark <robdclark@gmail.com>
 M:	Sean Paul <sean@poorly.run>
+R:	Abhinav Kumar <quic_abhinavk@quicinc.com>
 L:	linux-arm-msm@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	freedreno@lists.freedesktop.org
-- 
2.7.4

