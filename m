Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA503A56B9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 08:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFMGED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 02:04:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48784 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhFMGEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 02:04:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15D61q4H055186;
        Sun, 13 Jun 2021 06:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=QrRNt7cFTy927GgLiaf/L5hOfMtw3J/e2HUHy/eTuFc=;
 b=YuUWVA+sahTgWr9PaEX8RyVFoxhT2NPBOlCfRw9zK0Wfh9RW88r8pLPoCFdyAWcNflQr
 q92vW2NpT978Ks6WfMdhY63QT9uCIs2rq/LyvZ5VlvUMTCmAysCr8Qk1itllF0juqG+q
 Zk8PedGoDIZhmwA4bwCqtW6CGbHtYLMNtirOnN5HqDMeC2W9CMVEOeYPCkZEUKBa6aQz
 ZNqBjtpMOYya1MCEOQXu80GFU/4fHDBiiq2NjG9jTaGOcIF7kxIUlo4xA36AXu+g5Y4D
 jVyGx+PvubEmjcBuhMKXscF/gBT17es0W7esDlXE4RggUKUfenAnWWqnko612sMxDu81 Sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 394mbs9es3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Jun 2021 06:01:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15D5tUpp015537;
        Sun, 13 Jun 2021 06:01:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3956pp6kvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Jun 2021 06:01:52 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15D61p4M030529;
        Sun, 13 Jun 2021 06:01:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3956pp6kva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Jun 2021 06:01:51 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15D61oRA009961;
        Sun, 13 Jun 2021 06:01:50 GMT
Received: from localhost.localdomain (/10.159.245.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 12 Jun 2021 23:01:50 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL 2/2] SOC: Keystone driver update for v5.13
Date:   Sat, 12 Jun 2021 23:01:45 -0700
Message-Id: <1623564105-10273-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-ORIG-GUID: Zv9n8edbUr0aFEynaxHRSPgv2lBLeMga
X-Proofpoint-GUID: Zv9n8edbUr0aFEynaxHRSPgv2lBLeMga
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10013 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106130045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.13

for you to fetch changes up to 536e23c607edf0e13092887b92e0d5c7d29462b4:

  soc: ti: wkup_m3_ipc: Remove redundant error printing in wkup_m3_ipc_probe() (2021-06-04 13:04:13 -0700)

----------------------------------------------------------------
SOC: Keystone driver update for v5.13

Couple of cleanup fixes in PM AVS and WKUP M3 drivers

----------------------------------------------------------------
Qiheng Lin (1):
      PM: AVS: remove redundant dev_err call in omap_sr_probe()

Zhen Lei (1):
      soc: ti: wkup_m3_ipc: Remove redundant error printing in wkup_m3_ipc_probe()

 drivers/soc/ti/smartreflex.c | 4 +---
 drivers/soc/ti/wkup_m3_ipc.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)
