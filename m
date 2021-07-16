Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639E83CB724
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhGPMLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:11:01 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60104 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232085AbhGPMKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:10:37 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GC6IFa024404;
        Fri, 16 Jul 2021 14:07:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=4mUHlddVYh/kpJLGPpqQhmK3WdL2j9N2VX8um0wKavY=;
 b=vf4aFPs2RQfwa60pBt3Chzc5rSnTcfkSNkjGFn8ZGmO12wcPfnxE56Ve1UNkR/4C4fcL
 NLHBnGfzsV8mZPvnmsz+5t4wmDmjjJrzTrXmFEzQ9uLnigVm3Ah6c5pIoPSXUtM6QIt5
 BLDXMnBOucZgR1/ZZqbf1VLYuvqCpAdz9bJZiGiU1BD9vih3SjNTiNSUHkjnYQc5RkvA
 CbM7AjqYE7e0JnIRj63yRBbICTjMzZr/YB7g6/yJxPTqCCAmYcu9G/cKQlKqfGLviUyu
 yN/F8HeXFTkHD25rNooA46crGyErESkWmxozMJZmN1JC9SkuBNqmBCyw8lJwcDC7QP/e Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39tw1gup9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 14:07:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55338100038;
        Fri, 16 Jul 2021 14:07:33 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 48B65226FCD;
        Fri, 16 Jul 2021 14:07:33 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Jul 2021 14:07:32
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 1/2] usb: typec: stusb160x: register role switch before interrupt registration
Date:   Fri, 16 Jul 2021 14:07:17 +0200
Message-ID: <20210716120718.20398-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716120718.20398-1-amelie.delaunay@foss.st.com>
References: <20210716120718.20398-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_04:2021-07-16,2021-07-16 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During interrupt registration, attach state is checked. If attached, then
the Type-C state is updated with typec_set_xxx functions and role switch is
set with usb_role_switch_set_role().
If the usb_role_switch parameter is error or null, the function simply
returns 0.
So, to update usb_role_switch role if a device is attached before the irq
is registered, usb_role_switch must be registered before irq registration.

Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/usb/typec/stusb160x.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
index 6eaeba9b096e..3d3848e7c2c2 100644
--- a/drivers/usb/typec/stusb160x.c
+++ b/drivers/usb/typec/stusb160x.c
@@ -739,10 +739,6 @@ static int stusb160x_probe(struct i2c_client *client)
 	typec_set_pwr_opmode(chip->port, chip->pwr_opmode);
 
 	if (client->irq) {
-		ret = stusb160x_irq_init(chip, client->irq);
-		if (ret)
-			goto port_unregister;
-
 		chip->role_sw = fwnode_usb_role_switch_get(fwnode);
 		if (IS_ERR(chip->role_sw)) {
 			ret = PTR_ERR(chip->role_sw);
@@ -752,6 +748,10 @@ static int stusb160x_probe(struct i2c_client *client)
 					ret);
 			goto port_unregister;
 		}
+
+		ret = stusb160x_irq_init(chip, client->irq);
+		if (ret)
+			goto role_sw_put;
 	} else {
 		/*
 		 * If Source or Dual power role, need to enable VDD supply
@@ -775,6 +775,9 @@ static int stusb160x_probe(struct i2c_client *client)
 
 	return 0;
 
+role_sw_put:
+	if (chip->role_sw)
+		usb_role_switch_put(chip->role_sw);
 port_unregister:
 	typec_unregister_port(chip->port);
 all_reg_disable:
-- 
2.25.1

