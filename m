Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89C2327AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhCAJik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:38:40 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:1996 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234023AbhCAJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:37:51 -0500
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1219M6jj020302;
        Mon, 1 Mar 2021 04:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=smtpout1;
 bh=EM5BrDIMVQChc57nS9FKhnvWtBPZQxuDesoN5FM42HY=;
 b=PZC1SrmUH0uEHUWnDpIHNQABzojXvXcyAsd8LnoEVbBx6k9soD6KaOkPc7ZyrdI145ht
 niSMA1b3iUVEAc5yw6YmwAmHFtqIY9K1NXgpSkBIjScooBEcV0cfgSjUnGGBBpqn5bg9
 lwjFxTWTvtmZR8Aew+/RMntJ9BlbYIM8/nTU6/uiwoT8rdhEEbcSMc/e2Qr2u6wmBEB6
 MG0xGdxlazbACaElrRizs/lbMi5Qnv9tRxv//GWSTqRCzVj1TLaGivs6d9Rd73oFRY1J
 aJsPmjgMkBiPErn6sR7LC+fswx5mhH5whLtGY5EfghhIZNn9HadiscyTxJ56h00dfehY Kg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 36yhhb42gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 04:37:06 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1219K7cC108365;
        Mon, 1 Mar 2021 04:37:05 -0500
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0b-00154901.pphosted.com with ESMTP id 37046jn8c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 04:37:04 -0500
X-LoopCount0: from 10.69.132.19
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,215,1610431200"; 
   d="scan'208";a="1537356588"
From:   Perry Yuan <Perry.Yuan@dell.com>
To:     pobrn@protonmail.com, pierre-louis.bossart@linux.intel.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        Mario.Limonciello@dell.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Perry.Yuan@dell.com
Subject: [PATCH v4 0/2] Dell-hardware-privacy-implementation-for-dell-laptop
Date:   Mon,  1 Mar 2021 17:36:13 +0800
Message-Id: <20210301093614.15888-1-Perry_Yuan@Dell.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_05:2021-02-26,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=944
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010078
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <perry_yuan@dell.com>

Hi All,
This patch set is a new driver for dell mobile platform ,which has the
hardware privacy feature.

For micmute led control, the hotkey is Fn + F4, it is a hardware based
mute state, and new privacy will prevent micphone void input from
hardware layer, any application cannot get voice data when micmute
activated. 

Camera mute use a new hardware design to control the camrea shutter.
When video is muted, no OS application should be functionally able to
capture images of the person/environment in front of the system

Older history:
[1]https://patchwork.kernel.org/project/platform-driver-x86/patch/20201228132855.17544-1-Perry_Yuan@Dell.com/
[2]https://patchwork.kernel.org/project/alsa-devel/patch/20201103125859.8759-1-Perry_Yuan@Dell.com/#23733605
[3]https://www.spinics.net/lists/alsa-devel/msg120537.html
[4]https://github.com/thesofproject/linux/pull/2660


Perry Yuan (2):
  platform/x86: dell-privacy: Add support for Dell hardware privacy
  ASoC: rt715:add micmute led state control supports

 .../testing/sysfs-platform-dell-privacy-wmi   |  32 ++
 drivers/platform/x86/Kconfig                  |  17 +
 drivers/platform/x86/Makefile                 |   4 +-
 drivers/platform/x86/dell-laptop.c            |  26 +-
 drivers/platform/x86/dell-privacy-acpi.c      | 164 +++++++++
 drivers/platform/x86/dell-privacy-wmi.c       | 340 ++++++++++++++++++
 drivers/platform/x86/dell-privacy-wmi.h       |  35 ++
 drivers/platform/x86/dell-wmi.c               |  29 +-
 sound/soc/codecs/rt715-sdca.c                 |  12 +
 sound/soc/codecs/rt715.c                      |  12 +
 10 files changed, 655 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
 create mode 100644 drivers/platform/x86/dell-privacy-acpi.c
 create mode 100644 drivers/platform/x86/dell-privacy-wmi.c
 create mode 100644 drivers/platform/x86/dell-privacy-wmi.h

-- 
2.25.1

