Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C9A30A173
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhBAF2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:28:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49424 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhBAFZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:25:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1115F0Qx086747;
        Mon, 1 Feb 2021 05:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=J3ocIIW+svtR/frilWI593lhmK57A9OV8Lt0oZoHqdM=;
 b=GES0QwrrcMEOcerY376N17zaPYHCdpVsCzTfhOPqqq1Gcd5LqTEQ6Bn2ZLRscCoZXRqu
 ifcjZ/1V0e3nIHNr6HLu8I+3YjkJ5C04Su+xwfjGFakAuyJ589rpfV+CaVVGhcMukgFt
 LYLdLm5LtediTz6ARpIbiRlahDQR4+T2ofqqL5hHKU/Af6lVNDDJ1fvHCNkFLp3MVYyH
 QCPQJ80up34pOwrAUQiL50MB/OEtt2lXAK3ESIgCl1hffurQzdeRP7ojSPefi3Zdw908
 LF05Oq8VUnxUlNb2mpcvL2OW9IlEFVW/Sg5x4d3+Z//IArXBh093W6r/4K4Mru9PI51r vQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36cydkke5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 05:23:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1115GQwA035059;
        Mon, 1 Feb 2021 05:21:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 36dhcuej2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 05:21:55 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1115LsnX016367;
        Mon, 1 Feb 2021 05:21:54 GMT
Received: from localhost.localdomain (/10.159.236.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 Jan 2021 21:21:54 -0800
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        santosh.shilimkar@oracle.com, soc@kernel.org
Subject: [GIT PULL 2/2] ARM: DTS: Keystone update for v5.12
Date:   Sun, 31 Jan 2021 21:21:50 -0800
Message-Id: <1612156910-11159-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010025
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_5.12

for you to fetch changes up to 091584182ba6a298351f1e555c13ceb880c1f397:

  arm: dts: keystone: Harmonize DWC USB3 DT nodes name (2021-01-24 20:50:48 -0800)

----------------------------------------------------------------
ARM: DTS: Keystone update for v5.12

Contains couple updates for DWC USB3 DT nodes

----------------------------------------------------------------
Serge Semin (2):
      arm: dts: keystone: Correct DWC USB3 compatible string
      arm: dts: keystone: Harmonize DWC USB3 DT nodes name

 arch/arm/boot/dts/keystone-k2e.dtsi | 6 +++---
 arch/arm/boot/dts/keystone.dtsi     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)
