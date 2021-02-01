Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19AF30A21D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 07:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhBAGnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 01:43:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60076 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhBAFWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:22:20 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1115DZ0W179837;
        Mon, 1 Feb 2021 05:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=NGNMP8cFJbPPBvx3gcdqk3xsHqfUkWSZAztQLufqfb0=;
 b=F3OdNfR4u0UdmokB+ZUNPeVf8xyoTdVp+HhEQmo9ZnF/kuU2mx7W/LLcPQZA2wNexjKX
 PqrsijZtEJE3qOQ8QdyZ0UW9La7cxWGalgxZiHocLIxkOSqibjLvsCSGr8g8ld7X4FpU
 551cdWLtcgidRXsCaMNyIHjvDhlPYwu/zJBiJP3xW/mpMYhojbuFFztBgvZ7sBSXaKsI
 CPOGqUe9exVrVymX+ajfsiwW1vwogZjfBKWojwtl5KyQEblUV0VR4rVzxPNcprwB5pQt
 fKfyF1rVxPbt+fOVeQxamyzWUBpYJ5zicjoA8xA/uC4EUQjPtn6uzIUTeCCe0wVec4B+ HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36cvyakmf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 05:21:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1115G4R8179597;
        Mon, 1 Feb 2021 05:21:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 36dh7p6x4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 05:21:10 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1115KxLL015567;
        Mon, 1 Feb 2021 05:20:59 GMT
Received: from localhost.localdomain (/10.159.236.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 Jan 2021 21:20:59 -0800
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL 1/2] drivers: soc: Keystone update for v5.12
Date:   Sun, 31 Jan 2021 21:20:54 -0800
Message-Id: <1612156854-10929-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010025
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.12

for you to fetch changes up to a8fc8e5b8e42c4401d009143a5fd822ef3d0c9df:

  soc: ti: k3-ringacc: Use of_device_get_match_data() (2021-01-31 20:58:49 -0800)

----------------------------------------------------------------
drivers: soc: Keystone update for v5.12

Updates include:
	- Navigator refcount correction
	- probe fix in pm driver
	- fix clock init for PRUSS
	- PRUSS binding doc update
	- of_device_get_match_data() use in ringacc

----------------------------------------------------------------
Christophe JAILLET (1):
      soc: ti: pm33xx: Fix some resource leak in the error handling paths of the probe function

Grzegorz Jaszczyk (1):
      dt-bindings: soc: ti: Update TI PRUSS bindings about schemas to include

Suman Anna (3):
      soc: ti: pruss: Correct the pruss_clk_init error trace text
      soc: ti: pruss: Refactor the CFG sub-module init
      soc: ti: k3-ringacc: Use of_device_get_match_data()

Vasyl Gomonovych (1):
      soc: ti: knav_qmss: Put refcount for dev node in failure case

 .../devicetree/bindings/soc/ti/ti,pruss.yaml       | 76 ++++++++++++++++++
 drivers/soc/ti/k3-ringacc.c                        |  7 +-
 drivers/soc/ti/knav_dma.c                          |  1 +
 drivers/soc/ti/knav_qmss_queue.c                   |  3 +
 drivers/soc/ti/pm33xx.c                            |  5 +-
 drivers/soc/ti/pruss.c                             | 91 ++++++++++++----------
 6 files changed, 137 insertions(+), 46 deletions(-)
