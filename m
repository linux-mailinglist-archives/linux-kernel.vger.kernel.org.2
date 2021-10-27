Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7308943C046
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhJ0CxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:53:01 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33520 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbhJ0CxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635303036; x=1666839036;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wiKUdiIYul5fWqpJX+M9AXgQpzBUewouZtkI/Kf7vRc=;
  b=ivbAMBVSPy23PnNvxOXbXu08DzcAtedVReHBo2D9wsTSGfqj1plp2NOO
   nNqE5x3ArLeKYTE4pWvmSbV/yT+ZJgZhaMtc/HYKHnm2YwRwCikxLxqbv
   KtlOdom4N8zqWzsQAIlDOfP3CVM7+zhg3P+AU4GcVPsdEywpgPLEn+V7m
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 19:50:35 -0700
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 19:50:35 -0700
Received: from wcheng-linux1.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 19:50:34 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jackp@codeaurora.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v2 0/2] Disable mass storage endpoints during disconnect
Date:   Tue, 26 Oct 2021 19:50:23 -0700
Message-ID: <1635303025-772-1-git-send-email-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Revised comments for usb_ep_disable() as it should be safe to be
   executed in atomic contexts as well.  Other FDs are currently
   calling ep disable during the disconnect event as well.

This series calls the usb_ep_disable() API directly from fsg_disable()
as there is a possibility that UDCs that support runtime PM may
already be in a suspended state, leading to HW access while resources
are disabled.

Wesley Cheng (2):
  usb: gadget: udc: core: Revise comments for usb_ep_disable()
  usb: gadget: f_mass_storage: Disable eps during disconnect

 drivers/usb/gadget/function/f_mass_storage.c | 10 ++++++++++
 drivers/usb/gadget/udc/core.c                |  2 --
 2 files changed, 10 insertions(+), 2 deletions(-)

