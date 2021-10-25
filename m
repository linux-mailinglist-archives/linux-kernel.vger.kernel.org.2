Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FAE43A83B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbhJYXiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:38:00 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:11307 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhJYXhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635204926; x=1666740926;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=sCHp0cFXQiqQ+Mjl8y2cZ/GODXHWgVMPKsSlaf7whdE=;
  b=Asynbqw4t8eqPLbIaUJ+ki7F5vgfPXpkaVtR0PhlaNyqwZ5t+/iYrlac
   GhFLAy40XbHy5wQqZN6K5MMtGQb2VsQJgss4KHX/gVdK5g1glnZWa02wh
   3fY//DZ1a2SfWFt/rsvsSRi1ikrjxZUDsWiJ5luPfwWOQSjlXXNDlnvmJ
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 16:35:24 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 16:35:24 -0700
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 16:35:23 -0700
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <gregkh@linuxfoundation.org>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <nganji@codeaurora.org>,
        <aravindh@codeaurora.org>, <dmitry.baryshkov@linaro.org>
Subject: MAINTAINERS: update designated reviewer entry for MSM DRM driver
Date:   Mon, 25 Oct 2021 16:35:07 -0700
Message-ID: <1635204907-412-1-git-send-email-quic_abhinavk@quicinc.com>
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

