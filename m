Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1653A319364
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBKTvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:51:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229965AbhBKTtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:49:49 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BJawCo060001;
        Thu, 11 Feb 2021 14:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3ECbkre0tIcEPaZw5FdcXHPPdJMMxgI5dRte7jJoTFs=;
 b=Yqw6Jm5UYS7WelFOgRvm92UU+lTng5/5XqFpp3Gjf6nsNd7fIfO56BwnqnQeL5TR3JYk
 HaUNrlTPH9vNn4OHtv3t9FM9dMe5XzgcI/bVPKCutOec0J3zZ854lH0gggYgCFEMyjaj
 2lkbujoA2BdFRp83GJufGoOGVe79AuxBjcYSZO60uzIu2n6QY6zGb8X3Gp/ke015eE3d
 uKpiTP0DHHfjn1KmHnu2XNX7R7gH5OsKWsd9Fe1ve+kpdGi3z7WUZDQon+cv5waaxKJF
 g1r9T4mivJSsUShf5XvmSrib8FmTG0y/C/63GhgMdKsSecJBxcZVkrdzQLe/dGphp32z 8g== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36n9dybk5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:48:50 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BJkuYH024284;
        Thu, 11 Feb 2021 19:48:49 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 36hjr9t3h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 19:48:49 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BJmmvC15401316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:48:48 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B81BE112066;
        Thu, 11 Feb 2021 19:48:48 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1E28112061;
        Thu, 11 Feb 2021 19:48:47 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.11.199])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 19:48:47 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        andrew@aj.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: Aspeed: Reduce poll timeout
Date:   Thu, 11 Feb 2021 13:48:46 -0600
Message-Id: <20210211194846.35475-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxlogscore=993 mlxscore=0 clxscore=1011
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lengthy timeout previously used sometimes resulted in
scheduling problems, detailed below. Therefore reduce the timeout
to 500us. This timeout selection is supported by the benchmarks
collected below with various clock dividers. This is purely the time
spent polling (reported by ktime_get()).

div  1: max:150us avg:  2us
div  2: max:155us avg:  3us
div  4: max:149us avg:  7us
div  8: max:153us avg: 13us
div 16: max:197us avg: 21us
div 32: max:181us avg: 50us
div 64: max:262us avg:100us

Jan 22 01:27:21 rain27bmc kernel: rcu: INFO: rcu_sched self-detected stall on CPU
Jan 22 01:27:21 rain27bmc kernel: rcu:         0-....: (2099 ticks this GP) idle=0ca/1/0x40000002 softirq=349573/349573 fqs=1048
Jan 22 01:27:21 rain27bmc kernel:         (t=2100 jiffies g=841149 q=7163)
Jan 22 01:27:21 rain27bmc kernel: NMI backtrace for cpu 0
Jan 22 01:27:21 rain27bmc kernel: CPU: 0 PID: 5959 Comm: ibm-read-vpd Not tainted 5.8.17-a9b4ea8 #1
Jan 22 01:27:21 rain27bmc kernel: Hardware name: Generic DT based system
Jan 22 01:27:21 rain27bmc kernel: Backtrace:
Jan 22 01:27:25 rain27bmc kernel: [<8010d92c>] (dump_backtrace) from [<8010db80>] (show_stack+0x20/0x24)
...
Jan 22 01:27:25 rain27bmc kernel: [<8010130c>] (gic_handle_irq) from [<80100b0c>] (__irq_svc+0x6c/0x90)
Jan 22 01:27:25 rain27bmc kernel: Exception stack(0xb79159b0 to 0xb79159f8)
Jan 22 01:27:25 rain27bmc kernel: 59a0:                                     9e88e5d5 00000559 00000559 00000018
Jan 22 01:27:25 rain27bmc kernel: 59c0: 00000000 9f217c55 00000003 00000559 a0201c00 bfa4d048 bfa4d000 b7915a44
Jan 22 01:27:25 rain27bmc kernel: 59e0: 40e88f8a b7915a00 3254e553 80734924 80030113 ffffffff
Jan 22 01:27:25 rain27bmc kernel:  r9:b7914000 r8:a0201c00 r7:b79159e4 r6:ffffffff r5:80030113 r4:80734924
Jan 22 01:27:25 rain27bmc kernel: [<807348b4>] (__opb_read) from [<80734d98>] (aspeed_master_read+0xbc/0xcc)
Jan 22 01:27:25 rain27bmc kernel:  r10:00000004 r9:00000002 r8:80734cdc r7:bd33fa40 r6:00000004 r5:bd33f840
Jan 22 01:27:25 rain27bmc kernel:  r4:00201c00
Jan 22 01:27:25 rain27bmc kernel: [<80734cdc>] (aspeed_master_read) from [<807320f0>] (fsi_master_read+0x6c/0x1bc)
...

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 90dbe58ca1ed..03c61e50b299 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -92,7 +92,7 @@ static const u32 fsi_base = 0xa0000000;
 static u16 aspeed_fsi_divisor = FSI_DIVISOR_DEFAULT;
 module_param_named(bus_div,aspeed_fsi_divisor, ushort, 0);
 
-#define OPB_POLL_TIMEOUT		10000
+#define OPB_POLL_TIMEOUT		500
 
 static int __opb_write(struct fsi_master_aspeed *aspeed, u32 addr,
 		       u32 val, u32 transfer_size)
-- 
2.27.0

