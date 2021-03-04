Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57DF32D876
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbhCDRPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:15:01 -0500
Received: from mx4.veeam.com ([104.41.138.86]:54418 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239044AbhCDROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:14:30 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 9ABA6114A8F;
        Thu,  4 Mar 2021 20:13:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1614878027; bh=LH+nxslTQcrSx/rBsBPlCNstmi56jt6xI2HDC7GWY1A=;
        h=From:To:CC:Subject:Date:From;
        b=AFPQIMF+g2f0h+ZmZU097geUiQrYHMPct5DBt/NudWOu67CYsjfCSFz3jKpIV0UJx
         M22hjVoW3Pl+tATPUrFrEluSbgzxriD0km7B/1OAcuS/LLBrfr79JOzrngi+ygQtut
         xEk4vaB2n85uYZd+CJzFVDfvj8U3HfKSX45f+pt0=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 4 Mar 2021 18:13:46 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <snitzer@redhat.com>, <agk@redhat.com>, <hare@suse.de>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH 0/1] device filter
Date:   Thu, 4 Mar 2021 20:13:37 +0300
Message-ID: <1614878018-23278-1-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58637265
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I would like to discuss the idea of further extending the functionality
of device mapper and suggest the concept of device filters (DF).

The DM creates new block devices based on existing ones.
DF will not create new devices. Using blk_interposer, DF will intercept
bio requests, perform additional processing, and then pass (or skip)
the original request.

By analogy with the way DM implements various mapping algorithms through
additional modules, so DF will be the basis for the work of modules that
implement their own filtering algorithm.

Based on DF, it will be possible to create solutions for live migration,
continius data protection, and implement the backup on write algorithm.
For security systems, it will be possible to implement algorithms for
checking accesses to a block device.

Installing and removing such filters does not require changing
the configuration of the user's infrastructure or rebooting.
Connecting and disconnecting is possible "on the fly" using
blk-interposer.

In this patch, I propose to consider additional IOCTL for the dm-mod
module. The new IOCTL looks like a good starting point for developing
device filters.

It is technically possible to create a DF independently of the DM.
However, I think that DF can use a significant part of the code already
existing in the DM without creating duplication.

I look forward to your feedback on device filter.

Sergei Shtepa (1):
  dm: adds an IOCTL to work with device-filters

 drivers/md/Makefile           |  2 +-
 drivers/md/dm-ioctl.c         | 22 ++++++++++++++++++++++
 drivers/md/flt-ctl.c          | 25 +++++++++++++++++++++++++
 drivers/md/flt-ctl.h          | 10 ++++++++++
 include/uapi/linux/dm-ioctl.h | 18 ++++++++++++++++--
 5 files changed, 74 insertions(+), 3 deletions(-)
 create mode 100644 drivers/md/flt-ctl.c
 create mode 100644 drivers/md/flt-ctl.h

-- 
2.20.1

