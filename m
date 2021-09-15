Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25F40C108
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbhIOH4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:56:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58266 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231591AbhIOH4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:56:08 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F4Znfl030341;
        Wed, 15 Sep 2021 09:54:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=sMaBAxlvyiQCJ60a+vAyfTRUZu4RuizXruZcAcstzRo=;
 b=0YVzvZIlJg1T5x3yZ8uRA1UpZsH+m1UE9ExqueP02XfnBVE+o84aGn7rIvDl1WUBMU20
 uhajihpJflqIGJjQHtLWbP+1XP4DiprVq4iptM2bVcy6clYlqkMJUuJDxRrX6biMpZ1Y
 cq7L07NNzNbWv8XEmbuQkdVydMUZUGpuJclqfGhgz+bgr2evzOjkE6RDE2rXsRqdIi7i
 eUMawKLp0aaH7L5hVRv7aWwF+yOLh975tXkN78GVBSjHiZ9UGYHE86iWHqVOv4WByXGI
 SKZB3dez08rUHqaPxUyufQSXElg7ItrzPME6Y7SkYH/lmsW5STY0037hiD5KhxrOk2/K ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b39xps1q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 09:54:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66CD310002A;
        Wed, 15 Sep 2021 09:54:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5277A21C7BD;
        Wed, 15 Sep 2021 09:54:40 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep 2021 09:54:40
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <alexandre.torgue@foss.st.com>
CC:     <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/3] usb: dwc2: fill in gadget caps, configure it for stm32mp15
Date:   Wed, 15 Sep 2021 09:54:30 +0200
Message-ID: <1631692473-8732-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_01,2021-09-14_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fills in 'otg_caps' of the usb_gadget structure, and configures it
on stm32mp15.

When dwc2 is configured as dual role (OTG), the USB gadget descriptors (device mode)
are configured via configfs. This lead in calling usb_otg_descriptor_init().
In usb_otg_descriptor_init() (drivers/usb/gadget/config.c):
- If otg caps structure is provided -> use it
- If otg caps structure isn't provided -> HNP and SRP are enabled by default

This could lead to a configuration mismatch beetween:
- OTG controller: HNP and SRP aren't enabled
- gadget descriptors: HNP and SRP are advertised

Fabrice Gasnier (3):
  usb: dwc2: add otg_rev and otg_caps information for gadget driver
  usb: dwc2: stm32mp15: set otg_rev
  ARM: dts: stm32: set otg-rev on stm32mp151

 arch/arm/boot/dts/stm32mp151.dtsi |  1 +
 drivers/usb/dwc2/core.h           |  7 +++++++
 drivers/usb/dwc2/gadget.c         |  1 +
 drivers/usb/dwc2/params.c         | 16 ++++++++++++++++
 4 files changed, 25 insertions(+)

-- 
2.7.4

