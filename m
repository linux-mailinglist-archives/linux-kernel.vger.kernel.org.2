Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C144222C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhJEJza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:55:30 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39186 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233732AbhJEJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:55:24 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1957xael021102;
        Tue, 5 Oct 2021 11:53:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=7nkq9Cd7+hUC5IwyYPLXKTMFto9yyfAa5eT4GDX4NBk=;
 b=1xwQgWl5Jt3gSPwGYCzo233OdKETwfymB3j44VUit1nMVCaXx0KkSOmZtIS8tIzN7uZW
 W7oYWIMfDeZWRGUw7b1da5H1fwex9deA1nZl1gtilDotte/hl/HIxAKc314yPLufEz/W
 C2IKsS1S/TXUThBAOn2+oxRvGuz9VkQQ2DUeigZAWPzxFqmwhCsQ/KpOAYET5PqE/k2j
 oPYJR+5p3c3jd94HEVHcpYW1cPbdWU8tvyyAKVxFNf4nF1X5K5cq5RHBVWbPwppK+EH1
 MuBpp/ROeH+UQJoMmA2KLWHr1WKgRo4GHLhOm0ngZyHziqOFd14LfjdUtFIDGLYjSLGX 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bgjt8rq5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 11:53:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 508CC10002A;
        Tue,  5 Oct 2021 11:53:28 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4959B226FA7;
        Tue,  5 Oct 2021 11:53:28 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct 2021 11:53:27
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 3/3] usb: dwc2: drd: reset current session before setting the new one
Date:   Tue, 5 Oct 2021 11:53:05 +0200
Message-ID: <20211005095305.66397-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005095305.66397-1-amelie.delaunay@foss.st.com>
References: <20211005095305.66397-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If role is changed without the "none" step, A- and B- valid session could
be set at the same time. It is an issue.
This patch resets A-session if role switch sets B-session, and resets
B-session if role switch sets A-session.
Then, it is possible to change the role without the "none" step.

Fixes: 17f934024e84 ("usb: dwc2: override PHY input signals with usb role switch support")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/usb/dwc2/drd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
index 99672360f34b..aa6eb76f64dd 100644
--- a/drivers/usb/dwc2/drd.c
+++ b/drivers/usb/dwc2/drd.c
@@ -40,6 +40,7 @@ static int dwc2_ovr_avalid(struct dwc2_hsotg *hsotg, bool valid)
 	    (!valid && !(gotgctl & GOTGCTL_ASESVLD)))
 		return -EALREADY;
 
+	gotgctl &= ~GOTGCTL_BVALOVAL;
 	if (valid)
 		gotgctl |= GOTGCTL_AVALOVAL | GOTGCTL_VBVALOVAL;
 	else
@@ -58,6 +59,7 @@ static int dwc2_ovr_bvalid(struct dwc2_hsotg *hsotg, bool valid)
 	    (!valid && !(gotgctl & GOTGCTL_BSESVLD)))
 		return -EALREADY;
 
+	gotgctl &= ~GOTGCTL_AVALOVAL;
 	if (valid)
 		gotgctl |= GOTGCTL_BVALOVAL | GOTGCTL_VBVALOVAL;
 	else
-- 
2.25.1

