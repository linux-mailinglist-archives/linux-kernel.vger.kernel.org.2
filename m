Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EF631EF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhBRS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:57:42 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:5028 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233067AbhBRRKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:10:39 -0500
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IH1WsH029049
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=iOzx0OYK+UNNO4YieKhBdXb+NeFDdGB4h/IMLZWKEDE=;
 b=bJ8byuD+IfzNsafnTuT5ksNz78g8uFrPi9pvcA84CumsUrxShNo4S8ODQfS2/gvNMziI
 +SjpqhcllOu7hIQ1PJjVEA9Pf+sebVPztePov2p451mBZ8l1w63XRu8Z/vVnl/dbA8EO
 fOriPTB+Psa9fEeQr8Cf52+N/0+GYcs6avI1vBunEEwA4EcshZSmLz72wBzbyNQz7aEB
 jnN7bYyuDp/C3yGqVmxW3NIgw2AKldnBPX3YOCAlCU1j7sikqK2ZPbuj05aT4HjlD4hd
 h4XgJncKyjtDi75bo4NmO3JmzWmVjhyCDAnwi4zGv448Km9VqG9QZR5NDnDXrdWBuHG5 jA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 36q6tj70sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:53 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IGxh2C024487
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:52 -0500
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 36pw7qbfw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:09:52 -0500
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,187,1610431200"; 
   d="scan'208";a="1047578350"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>, jorgelo@chromium.org,
        campello@google.com, Mario Limonciello <mario.limonciello@dell.com>
Subject: [RFC 0/2] Split out firmware upgrade from CAP_SYS_ADMIN
Date:   Thu, 18 Feb 2021 11:09:45 -0600
Message-Id: <20210218170947.15727-1-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_08:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=513 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180144
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=639
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently NVME (and probably other drivers) require CAP_SYS_ADMIN to
send all commands to the device.  This means that software running
in userspace needs the stronger CAP_SYS_ADMIN permission when realistically
a more limited subset of functionality is actually needed.

To allow software that performs firmware upgrades to run without CAP_SYS_ADMIN,
create a new capability CAP_FIRMWARE_UPGRADE that software can run with.

For the RFC, only include NVME.  Other drivers can be added if suggested.

Mario Limonciello (2):
  capability: Introduce CAP_FIRMWARE_UPGRADE
  nvme: Use CAP_FIRMWARE_UPGRADE to check user commands

 drivers/nvme/host/core.c            | 28 ++++++++++++++++++++++++----
 include/linux/capability.h          |  5 +++++
 include/uapi/linux/capability.h     |  7 ++++++-
 security/selinux/include/classmap.h |  4 ++--
 4 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.25.1

