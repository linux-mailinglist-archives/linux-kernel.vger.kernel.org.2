Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6362E43D230
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbhJ0UMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:12:45 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40705 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243830AbhJ0UMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635365418; x=1666901418;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=4sZ8+PsZnpALtmEwUku1TEagKL1r7jaVqsFdyy1aw4Y=;
  b=SGS5dtQQlWu11AYrT7dIBsjPi6oPtqFHLRQ2nVfT0n0mqSh1PBF7s+5t
   EUIPjB+4pGiY+QDldi1TNSrmmI8EYuxpHpR1DddLszxU7eWmDlUvowTKf
   Y1tkqNYk2iDQTcv07EdsrxJC8WwRcRoUtD4vkaVgKG5cquoMUV/NUKjLY
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Oct 2021 13:10:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 13:10:17 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 27 Oct 2021 13:10:17 -0700
Received: from wcheng-linux1.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 27 Oct 2021 13:10:16 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jackp@codeaurora.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 0/2] Disable mass storage endpoints during disconnect
Date:   Wed, 27 Oct 2021 13:10:05 -0700
Message-ID: <1635365407-31337-1-git-send-email-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - Modify statement for usb_ep_enable().
 - Add explicit statement mentioning that APIs can be called in atomic context.

Changes in v2:
 - Revised comments for usb_ep_disable() as it should be safe to be
   executed in atomic contexts as well.  Other FDs are currently
   calling ep disable during the disconnect event as well.

This series calls the usb_ep_disable() API directly from fsg_disable()
as there is a possibility that UDCs that support runtime PM may
already be in a suspended state, leading to HW access while resources
are disabled.

Wesley Cheng (2):
  usb: gadget: udc: core: Revise comments for USB ep enable/disable
  usb: gadget: f_mass_storage: Disable eps during disconnect

 drivers/usb/gadget/function/f_mass_storage.c | 10 ++++++++++
 drivers/usb/gadget/udc/core.c                |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

