Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2FF309677
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhA3P55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 10:57:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232246AbhA3Pzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 10:55:37 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10UFVvPd086826;
        Sat, 30 Jan 2021 10:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=iXLTdo0C74vOzG+j6or/m9JYFZbVE/5zreKtvpJwZmg=;
 b=QpzzlNDRQEU3q7Hh38fCUUeXNmXCT+UoDK75U34yhznvbORcAsCby1zdP68epCFbd2J+
 sffsVQPqZGLL5gNkt8bwugwt7PPddgVCjWLGcpPaMLX0Lbzm3PJrp56mJ8tTrHkBUu14
 cnahLeaV0qurYqeBIrNHBjt3zEIPjkQYefli0UTWa3MibDpzvOUZoGkUhKZmkFG4H3Cr
 we7Nk0oMBHe89Xh6RhOi+uo6YzTfrOlliKvn+Na9sO+4p/BVOSFetKKUd3tEwwPkUJUW
 CfWgMpVx0Jc2Osr7cRPXPTO8PZBhMz9HtLxLRfiBzXKtRsWqO7Rd27oGCS8n9PS0Ugmd 4Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36da3703x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 30 Jan 2021 10:32:46 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10UFWQrX014999;
        Sat, 30 Jan 2021 15:32:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 36cxqh8cxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 30 Jan 2021 15:32:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10UFWeBT40698152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 15:32:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D933AE053;
        Sat, 30 Jan 2021 15:32:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AF20AE04D;
        Sat, 30 Jan 2021 15:32:40 +0000 (GMT)
Received: from localhost (unknown [9.171.87.176])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 30 Jan 2021 15:32:40 +0000 (GMT)
Date:   Sat, 30 Jan 2021 16:32:38 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.11-rc6
Message-ID: <your-ad-here.call-01612020758-ext-9054@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-30_11:2021-01-29,2021-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101300084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 fixes for 5.11-rc6.

Thank you,
Vasily

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-4

for you to fetch changes up to e82080e1f456467cc185fe65ee69fe9f9bd0b576:

  s390: uv: Fix sysfs max number of VCPUs reporting (2021-01-27 13:00:04 +0100)

----------------------------------------------------------------
- Fix max number of VCPUs reported via ultravisor information sysfs interface.

- Fix memory leaks during vfio-ap resources clean up on KVM pointer
  invalidation notification.

- Fix potential specification exception by avoiding unnecessary interrupts
  disable after queue reset in vfio-ap.

----------------------------------------------------------------
Janosch Frank (1):
      s390: uv: Fix sysfs max number of VCPUs reporting

Tony Krowiak (2):
      s390/vfio-ap: clean up vfio_ap resources when KVM pointer invalidated
      s390/vfio-ap: No need to disable IRQ after queue reset

 arch/s390/boot/uv.c                   |   2 +-
 arch/s390/include/asm/uv.h            |   4 +-
 arch/s390/kernel/uv.c                 |   2 +-
 drivers/s390/crypto/vfio_ap_drv.c     |   6 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 149 ++++++++++++++++++++--------------
 drivers/s390/crypto/vfio_ap_private.h |  12 +--
 6 files changed, 101 insertions(+), 74 deletions(-)
