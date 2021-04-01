Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F12351B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbhDASEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:04:38 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:34602 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236410AbhDARom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:44:42 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131GMG3x012816;
        Thu, 1 Apr 2021 12:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=amhyBFWYg660b275fb3PiPThRjnmySpyVBJZ9j3pYgI=;
 b=rPceU7gQMhSedF8nSFORfW9yO+FEpyxwXVr3CC3wrgeYSpyE0ScphWfD+EUyLvGGbg53
 +EcgnuvByXJLp8KOzLGSj23pxGR9INEYsV2NBIz2ygzOJgSE6CQH3qMYdIDDBXz4LFGw
 YwpqZ3saH5SI9wfH6vSpJ+fj0uhbc1psO3Ux9wWXIZDELfaW6BD7WzVA0hwTsRNryxxy
 AKasHDpqCoXh6BrIORn+w1tFycIifmZWGn22X3tbVyjB0l1zQqMyZA/6pPN2fa1WvwAl
 qbgu8tkqjaGbm6RkoFe4NL2vDKmA1Wu0l+5/rT306ZC9V5ieBdPwDOhsvggESA2cHvCJ rA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 37n299b49p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 12:22:25 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131EJwVO141020;
        Thu, 1 Apr 2021 12:22:25 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 37n6cem6k0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 12:22:24 -0400
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,296,1610431200"; 
   d="scan'208";a="618976136"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@outlook.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 0/3] Adjust contacts for Dell drivers
Date:   Thu,  1 Apr 2021 11:22:03 -0500
Message-Id: <20210401162206.26901-1-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_03:2021-03-26,2021-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=662 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010093
X-Proofpoint-GUID: Sp87cyChh7nNDuNxhD8JEk2sSVzTFB4k
X-Proofpoint-ORIG-GUID: Sp87cyChh7nNDuNxhD8JEk2sSVzTFB4k
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=805 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Dell drivers I'm involved with all have me as an author and/or
maintainer.  In the future these will be maintained as a team effort.
Adjust the contact addresses accordingly.

Mario Limonciello (3):
  MAINTAINERS: Adjust Dell drivers to email alias
  MAINTAINERS: Add missing section for alienware-wmi driver
  platform/x86: Adjust Dell drivers to a personal email address

 MAINTAINERS                                     | 17 +++++++++++------
 drivers/platform/x86/dell/alienware-wmi.c       |  4 ++--
 drivers/platform/x86/dell/dell-smbios-base.c    |  2 +-
 drivers/platform/x86/dell/dell-wmi-descriptor.c |  2 +-
 .../platform/x86/dell/dell-wmi-sysman/sysman.c  |  2 +-
 5 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.25.1

