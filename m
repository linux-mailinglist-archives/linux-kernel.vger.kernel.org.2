Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D17E4222C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhJEJz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:55:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54580 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233455AbhJEJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:55:24 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19583IiQ026071;
        Tue, 5 Oct 2021 11:53:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=ZrZrA9Wav/JVHvmVRKZpvmWqQKz8oNhEPjgdKgmf6pM=;
 b=mB7gJzaHdA4kEwz0Wq0XsO+B3OPD+VdKEWyfezdIVUEoI5HZSXNGLFqOgLRtvmO5MWzD
 7XeCLOL5ROfrxshq3Zp6fIK/PeXuFGZuG0bQYwW41Fpl7w8hEqvuN7njwv/th/0zcmI6
 pmozkV34GU0LfNOigvrETORY653RZ10LoYT/eLkmYiPFHvZsb7Aqs5rn5f9NNsw6azIP
 z2AdVaiPFbnhjUCjvcSGcCbOKNyzEDu3dOwicjs6tHciORsGOg2Edw1FK8lpTTgJcVm1
 NjAI4v0S8pB1EqYYnETze4/dPzOdACWxuVO3G7e7ztqygo4uRVosDshgl8ZLFr+w1yG+ Vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bgjv10pd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 11:53:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 17E4A10002A;
        Tue,  5 Oct 2021 11:53:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0DB11226FAA;
        Tue,  5 Oct 2021 11:53:25 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct 2021 11:53:24
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 0/3] usb: dwc2: drd: fix some issues
Date:   Tue, 5 Oct 2021 11:53:02 +0200
Message-ID: <20211005095305.66397-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes initialization issues seen while dr_mode != "otg"
and resets previous session before setting the new one. 

Amelie Delaunay (3):
  usb: dwc2: drd: fix dwc2_force_mode call in dwc2_ovr_init
  usb: dwc2: drd: fix dwc2_drd_role_sw_set when clock could be disabled
  usb: dwc2: drd: reset current session before setting the new one

 drivers/usb/dwc2/drd.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

-- 
2.25.1

