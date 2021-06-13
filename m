Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB683A56B8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 08:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFMGDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 02:03:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51220 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFMGDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 02:03:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15D5tdDB145614;
        Sun, 13 Jun 2021 06:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=lrDHu/B7kRhqXFBy0o1juB+Fx+ejQRdmlkOp47EaafU=;
 b=lwTtw9Q5e0OOKQxMhoYnqr1+XHjMJ7uAhn0ZGnlWw+OdQsq+FIvXS9wh2KOCmEG4KkVH
 1zVNqHaMA8aLbUPQcDpFtOIzGa8vjEpjB1RzlVAhIPltSOVL91vyz/ybLxSGeGJddJWi
 sCmuzSQ4wGitqqS78Eb7m8ILPMBwjtJAXhSe5kkAUP4VbsLR0MqDC8utgh8lRD5S/IPN
 HaMxb7HRJNZTzQrAFeIKMz44vdiIlGp3Kle6UTDU+CQr8OOgFNGCsra4jWnrgwPQnOH5
 9f19MlWj+o25gLuLOEaGzmyXrTUqx/E9TcIqaRH0/FBSwgY4t7Yzp2k5zNkBpI++ehOw aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 394mvn9dt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Jun 2021 06:00:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15D5snRB177468;
        Sun, 13 Jun 2021 06:00:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 394mr3y2r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Jun 2021 06:00:57 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15D60u06007204;
        Sun, 13 Jun 2021 06:00:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 394mr3y2pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Jun 2021 06:00:56 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15D60jqG009234;
        Sun, 13 Jun 2021 06:00:45 GMT
Received: from localhost.localdomain (/10.159.245.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 13 Jun 2021 06:00:44 +0000
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        santosh.shilimkar@oracle.com, soc@kernel.org
Subject: [GIT PULL 1/2] ARM: DTS: Keystone K2G cleanup for v5.13
Date:   Sat, 12 Jun 2021 23:00:20 -0700
Message-Id: <1623564020-9958-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-ORIG-GUID: qnOH2JPI7zgfoKjMI5Lv8xD6DffMrukR
X-Proofpoint-GUID: qnOH2JPI7zgfoKjMI5Lv8xD6DffMrukR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10013 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=904 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106130045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_5.13

for you to fetch changes up to 0b5194dec85b9f3971900129f9a3584a6cb5918d:

  ARM: dts: keystone: k2g-evm: Move audio oscillator assigned clock to mcasp (2021-06-04 13:32:47 -0700)

----------------------------------------------------------------
ARM: DTS: Keystone K2G cleanup for v5.13

  - Rename message manager node
  - Rename the TI-SCI node and clock
  - assign clock to McAsp

----------------------------------------------------------------
Nishanth Menon (4):
      ARM: dts: keystone: k2g: Rename message-manager node
      ARM: dts: keystone: k2g: Rename the TI-SCI node
      ARM: dts: keystone: k2g: Rename the TI-SCI clocks node name
      ARM: dts: keystone: k2g-evm: Move audio oscillator assigned clock to mcasp

 arch/arm/boot/dts/keystone-k2g-evm.dts | 11 +++--------
 arch/arm/boot/dts/keystone-k2g.dtsi    |  6 +++---
 2 files changed, 6 insertions(+), 11 deletions(-)
