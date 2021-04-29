Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F93736E580
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbhD2HE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:04:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16168 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbhD2HEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:04:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FW5x86xk9zpcPr;
        Thu, 29 Apr 2021 15:00:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 29 Apr 2021 15:03:28 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
        <song.bao.hua@hisilicon.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH 0/2] clarify and cleanup CPU and NUMA topology ABIs
Date:   Thu, 29 Apr 2021 15:03:37 +0800
Message-ID: <1619679819-45256-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1: clarify the overflow issue of sysfs pagebuf, and Move the
presence of BUILD_BUG_ON to more sensible place.

patch #2: move the interface that exists under
/sys/devices/system/cpu/cpuX/topology/ to the more logical
Documentation/ABI/ file that can be properly parsed and
displayed to the user space.

these two patches are a follow-up to Greg's comments in the below threads:
https://lore.kernel.org/lkml/YFRGIedW1fUlnmi+@kroah.com/
https://lore.kernel.org/lkml/YFR2kwakbcGiI37w@kroah.com/

Tian Tao (2):
  CPU, NUMA topology ABIs: clarify the overflow issue of sysfs pagebuf
  Documentation/ABI: Move the topology-related sysfs interface to the
    right place

 Documentation/ABI/stable/sysfs-devices-node       |   5 +-
 Documentation/ABI/stable/sysfs-devices-system-cpu | 142 ++++++++++++++++++++++
 Documentation/admin-guide/cputopology.rst         |  83 +------------
 drivers/base/node.c                               |   3 -
 include/linux/cpumask.h                           |   6 +
 5 files changed, 154 insertions(+), 85 deletions(-)

-- 
2.7.4

