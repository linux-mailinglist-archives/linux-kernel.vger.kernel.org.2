Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8853F3E9611
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhHKQel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:34:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30250 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhHKQej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:34:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628699655; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gvbzXWH0n+NKtqFjoatqc0R0BrprLzQ2Kn6H7/1zuVU=; b=trNEl39/hZtvWURm/PL42TtOPC6BQxKghO1K0nocZ5y3glL5U/KFfiQDRt8EOvFKx3MsaH+w
 k5iAkzluXyECAOc8VxiPNytXsDolhxeCPOQv2UxOtGTIhD0oNPaLAZIP2fSUd4ViUXFqQDbM
 fyTnrVZlET0woIVR3lW7nlNPGOQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6113fb2591487ad5208f7b0e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Aug 2021 16:30:29
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 019AEC43144; Wed, 11 Aug 2021 16:30:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B2A23C4338A;
        Wed, 11 Aug 2021 16:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2A23C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] add fixes to pass DP Link Layer compliance test cases
Date:   Wed, 11 Aug 2021 09:30:01 -0700
Message-Id: <1628699407-28358-1-git-send-email-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm/msm/dp: add fixes to pass DP Link Layer compliance test cases

Kuogee Hsieh (6):
  drm/msm/dp: use dp_ctrl_off_link_stream during PHY compliance test run
  drm/msm/dp: reduce link rate if failed at link training 1
  drm/msm/dp: reset aux controller after dp_aux_cmd_fifo_tx() failed.
  drm/msm/dp: replug event is converted into an unplug followed by an
    plug events
  drm/msm/dp: return correct edid checksum after corrupted edid checksum
    read
  drm/msm/dp: do not end dp link training until video is ready

 drivers/gpu/drm/msm/dp/dp_aux.c     |   3 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 137 +++++++++++++++++++++++-------------
 drivers/gpu/drm/msm/dp/dp_display.c |  14 ++--
 drivers/gpu/drm/msm/dp/dp_panel.c   |   9 ++-
 4 files changed, 102 insertions(+), 61 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

