Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8102735C269
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbhDLJnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:43:43 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:10334 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242037AbhDLJSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:18:00 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13C9C02f004737;
        Mon, 12 Apr 2021 05:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=smtpout1;
 bh=KFIFE8UJy90Y2MVElNIAftsv7/F8+aOXBzc+KxnEAe0=;
 b=u9JI5YdyNvu3aWdTbk+UkbK6GmZsK6qBTiZXhU0X1CyaG7tFM5HQRyFKEEuRw34yDSbp
 IhdpYtzNxwd41sUIYMTRzgcEUvb2zAqkGphb1jIUzXwC0ZmugoAQGiL64VXqvwldunqp
 vgRIKpGnKdurXRsVB9qAksWAu0To6CLhMaBpB1gIe82qLP9q3qzECZzHBgekz0c297N7
 kK7wd9B3MrTId2wAk/Pqcp0EW4OoiQirK/Tt+NQrWKStme60Rch5uaLnZh0Par/TBSSZ
 uiv/5iOc2hE17HjllVe9lrlYVEVhjH/eLqPdM6JM9QOGArml5Fm+z/xhqRfBMTWHvund TQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 37u7v0mmxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 05:17:41 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13C99owG016440;
        Mon, 12 Apr 2021 05:17:40 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 37uryjw0ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 05:17:40 -0400
X-LoopCount0: from 10.69.132.19
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,216,1610431200"; 
   d="scan'208";a="1076903885"
From:   Perry Yuan <Perry.Yuan@dell.com>
To:     pobrn@protonmail.com, pierre-louis.bossart@linux.intel.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Perry.Yuan@dell.com,
        mario.limonciello@outlook.com, Dell.Client.Kernel@dell.com
Subject: [PATCH v7 0/2] hardware-privacy-implementation-for-dell-laptop
Date:   Mon, 12 Apr 2021 17:17:23 +0800
Message-Id: <20210412091725.7820-1-Perry_Yuan@Dell.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_07:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104120061
X-Proofpoint-GUID: FsjAz0f_QX2unDCXAF6AzZNpanvzwN0U
X-Proofpoint-ORIG-GUID: FsjAz0f_QX2unDCXAF6AzZNpanvzwN0U
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120061
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

 .../testing/sysfs-platform-dell-privacy-wmi   |  55 +++
 drivers/platform/x86/dell/Kconfig             |  14 +
 drivers/platform/x86/dell/Makefile            |   1 +
 drivers/platform/x86/dell/dell-laptop.c       |  23 +-
 drivers/platform/x86/dell/dell-privacy-wmi.c  | 394 ++++++++++++++++++
 drivers/platform/x86/dell/dell-privacy-wmi.h  |  23 +
 drivers/platform/x86/dell/dell-wmi.c          |   8 +-
 sound/soc/codecs/rt715-sdca.c                 |  42 ++
 sound/soc/codecs/rt715.c                      |  43 ++
 9 files changed, 596 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
 create mode 100644 drivers/platform/x86/dell/dell-privacy-wmi.c
 create mode 100644 drivers/platform/x86/dell/dell-privacy-wmi.h

-- 
2.25.1

