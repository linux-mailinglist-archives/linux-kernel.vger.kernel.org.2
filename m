Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88328343CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCVJik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:38:40 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:46402 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229760AbhCVJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:38:09 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12M9Gjbl023992;
        Mon, 22 Mar 2021 05:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=smtpout1;
 bh=NAC2lMtRM8NWthEFOAc3VP8TaqtZBRju9fMmGpRg3d0=;
 b=lMO1Tv85AcAtrc0I43HtnJx3Bn62CYaqv9u4AbenAyXuUNjjDY/jMmI4lNZwfOLUs0T4
 jUHvHzoy/bWXY2phd+ILWMD1Da66GTdWeaFcfjFl7iDOeeNvmA4jGTfyx5zy630JW2DW
 2pa+xcfHDgTwNKUZyopI02obXFGiOeeBPl2Sb19vqWTINKDYnF+HSe1taoFFnwXSTCj9
 +Di0IXXJkbjmYTbEZWivOrLKVWIItZMSbVYTpz1dWWvFHRg1GWvGY4CT41T2D+4ChNYg
 f2fdXOsMAP8yiJnY7Brv3NLkr4KwOHaYxjOTlwmn+tuQPamoVWvwDa0tzvSx9jy7fIZy LQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 37dc6wm8t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 05:38:09 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12M9GWW7156748;
        Mon, 22 Mar 2021 05:38:09 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0a-00154901.pphosted.com with ESMTP id 37dx2w4256-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 05:38:09 -0400
X-LoopCount0: from 10.69.132.19
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.75,453,1589259600"; 
   d="scan'208";a="580340369"
From:   Perry Yuan <Perry.Yuan@dell.com>
To:     pobrn@protonmail.com, pierre-louis.bossart@linux.intel.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        Mario.Limonciello@dell.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Perry.Yuan@dell.com
Subject: [PATCH v5 0/2] hardware-privacy-implementation-for-dell-laptop
Date:   Mon, 22 Mar 2021 17:37:42 +0800
Message-Id: <20210322093743.13452-1-Perry_Yuan@Dell.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_04:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=967 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220072
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <perry_yuan@dell.com>

Hi All,
This patch set is a new driver for Dell mobile platform that has the
hardware privacy feature including micmute,camera mute.

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
[5]https://github.com/thesofproject/linux/issues/2496

Perry Yuan (2):
  platform/x86: dell-privacy: Add support for Dell hardware privacy
  ASoC: rt715:add micmute led state control supports

 .../testing/sysfs-platform-dell-privacy-wmi   |  32 ++
 drivers/platform/x86/dell/Kconfig             |  16 +
 drivers/platform/x86/dell/Makefile            |   3 +
 drivers/platform/x86/dell/dell-laptop.c       |  23 +-
 drivers/platform/x86/dell/dell-privacy-acpi.c | 164 +++++++++
 drivers/platform/x86/dell/dell-privacy-wmi.c  | 340 ++++++++++++++++++
 drivers/platform/x86/dell/dell-privacy-wmi.h  |  35 ++
 drivers/platform/x86/dell/dell-wmi.c          |  27 +-
 sound/soc/codecs/rt715-sdca.c                 |  11 +
 sound/soc/codecs/rt715.c                      |  12 +
 10 files changed, 650 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
 create mode 100644 drivers/platform/x86/dell/dell-privacy-acpi.c
 create mode 100644 drivers/platform/x86/dell/dell-privacy-wmi.c
 create mode 100644 drivers/platform/x86/dell/dell-privacy-wmi.h

-- 
2.25.1

