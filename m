Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3053CB725
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhGPMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:11:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8610 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232647AbhGPMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:10:41 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GBwFLa010195;
        Fri, 16 Jul 2021 14:07:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=/19kFGOX0gCiMy+N9zU3xMPZEdJW0d18XcCxTFhSctU=;
 b=4bMwuuyuRChSFcKXgeqESyDi44cTrPmfz/0/CEIzQE6E8rrqS7XYFHpSSbfSfWvoxoX3
 sZV9255LHyygmmioKTRjMiWUELti6L0OlTmglGeYuUVC1C9yJ2kNTNVv/kC16OEswadD
 Xo7ZEZqVTX4s3E2SFEKlcbXZN2eevJHin0MQN8nXRcy/MHhCO9oz4uq1RCLJQ5WfayDu
 lpmP00+y5eh/e07fi55KNDUd6qDv1zufYTItjuSa9WtFjrmWBVWTVDosb+804TEmISWS
 egr8nSqRBJlDpB6WQ4u710x/iIekNt/ioFQMt1IXNPkj/Mezc2jQkbKBBxgRkgGzIlCF bA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39tw1kc06m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 14:07:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4899010002A;
        Fri, 16 Jul 2021 14:07:32 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3423F226FCD;
        Fri, 16 Jul 2021 14:07:32 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Jul 2021 14:07:31
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/2] usb: typec: couple of fixes for stusb160x
Date:   Fri, 16 Jul 2021 14:07:16 +0200
Message-ID: <20210716120718.20398-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_04:2021-07-16,2021-07-16 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch fixes role switch when attached before probe.
Second patch follows Martin's patch [1] as it is also applicable for
stusb160x typec driver, in order to avoid the WARNING seen on
stm32mp15xx-dkx boot:
[    8.598414] typec port0: Fixing up cyclic dependency with 49000000.usb-otg
[    8.604493] dwc2 49000000.usb-otg: supply vusb_d not found, using dummy regulator
[    8.630642] ------------[ cut here ]------------
[    8.649193] WARNING: CPU: 0 PID: 157 at drivers/base/core.c:1532 device_del+0x328/0x3ec

[1] https://lkml.org/lkml/2021/7/14/47

Amelie Delaunay (2):
  usb: typec: stusb160x: register role switch before interrupt
    registration
  usb: typec: stusb160x: Don't block probing of consumer of "connector"
    nodes

 drivers/usb/typec/stusb160x.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
2.25.1

