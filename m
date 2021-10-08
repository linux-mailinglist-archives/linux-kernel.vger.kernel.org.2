Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71FA426580
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhJHH7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:59:04 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39670 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbhJHH7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:59:03 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1984ZWrU017379;
        Fri, 8 Oct 2021 09:57:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=HCSz4SNu5MuHsUcJwomXutSa1lHfngigp26ZIbAcKkc=;
 b=zZF80sY5ngi+aGvGqYi0gzslTP4PDZZAM8oljD20v9TbXEQ82YM3cX0iEmZxfecnAdBl
 HHn3MTdMLE+hAcdvMwa6av8CI9xGseew91UuWa8Rf9UszUBrPf7tyk7GrD4dBOPrmBfO
 dKB2BpSOjPqRJq8PsmIdooeAwloklhmmJYptAq4kWaKsQ2aeanU2fK51Gpt4UeRtlg7G
 hEjbFx2NUdwOCKJ6T4T7cqETe4hENuYwbjsFmQraK0td0BGrcrauBWSH7/QsFT3tFfQy
 NpERDWjrMPw7bKpjmf0qPNd2cN5uaJN3Y0P/aUnAaCSxIVuntxfWVTrP8DRiIHlE7mMG /Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bjdun9fxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 09:57:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 25181100034;
        Fri,  8 Oct 2021 09:57:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 17012218110;
        Fri,  8 Oct 2021 09:57:03 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 8 Oct 2021 09:57:02
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 0/2] usb: dwc2: fill in gadget caps, configure it for stm32mp15
Date:   Fri, 8 Oct 2021 09:53:07 +0200
Message-ID: <1633679589-16021-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_02,2021-10-07_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fills in 'otg_caps' of the usb_gadget structure, and
configures it on stm32mp15.

When dwc2 is configured as dual role (OTG), the USB gadget descriptors
(device mode) are configured via configfs. This lead in calling
usb_otg_descriptor_init().
In usb_otg_descriptor_init() (drivers/usb/gadget/config.c):
- If otg caps structure is provided -> use it
- If otg caps structure isn't provided -> HNP and SRP are enabled by default

This could lead to a configuration mismatch beetween:
- OTG controller: HNP and SRP aren't enabled
- gadget descriptors: HNP and SRP are advertised

---
Changes in v2:
- replace otg_cap bit field by otg_caps structure.
- Fix build issue when HOST only mode is selected [1]
- DT patch for stm32mp151 merged in v1, so not resent

[1] https://syzkaller.appspot.com/bug?extid=7af597ce2b38596c16ea

Fabrice Gasnier (2):
  usb: dwc2: add otg_rev and otg_caps information for gadget driver
  usb: dwc2: stm32mp15: set otg_rev

 drivers/usb/dwc2/core.h    | 19 ++++++------
 drivers/usb/dwc2/debugfs.c |  4 ++-
 drivers/usb/dwc2/gadget.c  |  1 +
 drivers/usb/dwc2/hcd.c     | 12 +++-----
 drivers/usb/dwc2/params.c  | 75 ++++++++++++++++++++++++++--------------------
 5 files changed, 59 insertions(+), 52 deletions(-)

-- 
2.7.4

