Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0250457976
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 00:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhKSXWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 18:22:10 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:17126 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhKSXV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 18:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637363934; x=1668899934;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=X8rozlh7XZA6KcsavrAkZ5+YLzbzFayI4fUmiQGnRwA=;
  b=MR4XLjz18o1wtq2T3tUY49HJ/cLS94WbXDtFgIXle+hnlqFHe3YFlmoR
   6EdqJX8gAbP4RYltVZ6CEw5N31VJ0wILDNG0B5fUVNUcxwHETVEj5MQ3f
   iWrOBfH21Z+ollHjAaw5L+o4guo1C7BPxI6ntE4a152wM1O6vadZ57Ut+
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 19 Nov 2021 15:18:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 15:18:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 15:18:53 -0800
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 15:18:53 -0800
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <gregkh@linuxfoundation.org>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <nganji@codeaurora.org>,
        <aravindh@codeaurora.org>, <dmitry.baryshkov@linaro.org>,
        <daniel@ffwll.ch>
Subject: [PATCH] MAINTAINERS: update designated reviewer entry for MSM DRM driver
Date:   Fri, 19 Nov 2021 15:18:36 -0800
Message-ID: <1637363916-18257-1-git-send-email-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
index 5b33791..503112d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5938,6 +5938,7 @@ M:	Sean Paul <sean@poorly.run>
 L:	linux-arm-msm@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	freedreno@lists.freedesktop.org
+R:	Abhinav Kumar <quic_abhinavk@quicinc.com>
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/msm.git
 F:	Documentation/devicetree/bindings/display/msm/
-- 
2.7.4

