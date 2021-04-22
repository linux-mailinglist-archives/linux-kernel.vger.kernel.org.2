Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5D2367D20
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhDVJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:03:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57848 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhDVJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:03:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13M8evtu061731;
        Thu, 22 Apr 2021 09:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=luKBrUqgQXuE6ecf9zdzvMeJVaBMF+rgQS18TT6YaPA=;
 b=rj5IDy98a1ehCtAM80zC/x0IcJiL/RU5XYtd39WlRaw4mq638nti628pFWfEZ2reVLa8
 TFf62VNjYkXNYjtwqvohr+SM3kxRfapDYyXbRdveDyNrWLrOb2okwKKtRdDVabvwJFqM
 mk3yhSiy5cdL+T07A8iMA1ni5GZmb4mhvkR+uZpQ0QV0mU1lNRZKOwK02df5MkwzxWs8
 1akpvtqRId4zjOlvIWpfvk86yHfsFiybynPegOPAx4T/YbzdXEdC1o6RQq3TwAQRvsVK
 wHU31F+/K+BwDC6mNmxJ+j7lccu1jemHF/P1v9AJ4YO0oX68qDEnQYSR4AgpKkYzBOGu cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37yveamdgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:02:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13M9038W156046;
        Thu, 22 Apr 2021 09:02:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3809evjx53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:02:37 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13M92bRp170135;
        Thu, 22 Apr 2021 09:02:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3809evjx4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:02:37 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13M92Zp4019604;
        Thu, 22 Apr 2021 09:02:35 GMT
Received: from mwanda (/10.175.205.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Apr 2021 09:02:35 +0000
Date:   Thu, 22 Apr 2021 12:02:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        "Jon Medhurst (Tixy)" <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] firmware: arm_scpi: prevent ternary sign expansion bug
Message-ID: <YIE7pdqV/h10tEAK@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: 6Sb26I_pnSMvX2LJsvaeWNeSbcTLo0wR
X-Proofpoint-ORIG-GUID: 6Sb26I_pnSMvX2LJsvaeWNeSbcTLo0wR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How type promotion works in ternary expressions is a bit tricky.
The problem is that scpi_clk_get_val() returns longs, "ret" is a int
which holds a negative error code, and le32_to_cpu() is an unsigned int.
We want the negative error code to be cast to a negative long.  But
because le32_to_cpu() is an u32 then "ret" is type promoted to u32 and
becomes a high positive and then it is promoted to long and it is still
a high positive value.

Fix this by getting rid of the ternary.

Fixes: 8cb7cf56c9fe ("firmware: add support for ARM System Control and Power Interface(SCPI) protocol")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/firmware/arm_scpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index d0dee37ad522..3bf61854121d 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -552,8 +552,10 @@ static unsigned long scpi_clk_get_val(u16 clk_id)
 
 	ret = scpi_send_message(CMD_GET_CLOCK_VALUE, &le_clk_id,
 				sizeof(le_clk_id), &rate, sizeof(rate));
+	if (ret)
+		return ret;
 
-	return ret ? ret : le32_to_cpu(rate);
+	return le32_to_cpu(rate);
 }
 
 static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
-- 
2.30.2

