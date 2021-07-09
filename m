Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7583C2A34
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhGIURl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 16:17:41 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:19605 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIURk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 16:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1625861696; x=1657397696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yW/7fqj2WCsH+l2yF5p9bJWIk/9AWTlniLPQPpQwG+Q=;
  b=pWpWfGpU/RRoSJAce5DZYU1QB8bEOwVtT7lqX9nrdPT6NhV44OoHRnRc
   dCxFa6E2C0dLqFRKW3HE8982OT7GI3yGRS9OtfOc9CGkgxzvK9Id2ROLl
   Ad5ZE9/rbL3xydOqP0Mf26JOMZYqoM8hX7AM9Pk9kXktvXKk3SW3VGNcM
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Jul 2021 13:14:56 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Jul 2021 13:14:55 -0700
Received: from vamslank1-linux.qualcomm.com (10.80.80.8) by
 nalasexr03e.na.qualcomm.com (10.49.195.114) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 9 Jul 2021 13:14:54 -0700
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <alexandre.belloni@bootlin.com>, <viresh.kumar@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <mani@kernel.org>, Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
Subject: [PATCH 0/2] SDX65 defconfig updates
Date:   Fri, 9 Jul 2021 13:14:39 -0700
Message-ID: <20210709201441.21078-1-quic_vamslank@quicinc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03e.na.qualcomm.com (10.85.0.48) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>

Hello,

This patch series enables support for inclusion of different modules in the SDX65 defconfig file.

Thanks,
Vamsi 

Vamsi krishna Lanka (2):
  ARM: configs: qcom_defconfig: Enable SDX65 GCC driver
  ARM: configs: qcom_defconfig: Enable SDX65 pinctrl driver

 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.32.0

