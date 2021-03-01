Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70032775C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhCAGG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:06:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:53887 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhCAGGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:06:09 -0500
IronPort-SDR: Af3SgznUmU29xCzDKJ9jawgkQfdcZpvyMKZYvcWTmi3hgmMfVgn8+FrX+HxN1VqhlTM0IRHcRg
 xlN4zoab0+VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="165599688"
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="165599688"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 22:04:38 -0800
IronPort-SDR: OGhuND2aYShAQ5sHbP1pBNqpWmtlzinZKCHld2XJ0FO4Rrq4Es5ppsa/hvOSFFzi44gCWbDLO/
 UCUZgLQ0p2wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="397574180"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2021 22:04:36 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v3 0/4] Some improvement for Intel MAX 10 MFD drivers
Date:   Mon,  1 Mar 2021 13:59:41 +0800
Message-Id: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is some improvements for intel-m10-bmc and its subdevs.

Main changes from v1:
- Add a patch (#2) to simplify the definition of the legacy version reg.
- Add a patch (#4), add entry in MAINTAINERS for intel-m10-bmc mfd driver
  and the subdev drivers.

Main changes from v2:
- Add Tom Rix as the reviewer for intel-m10-bmc mfd driver and the subdev
  drivers.
- Rebased to 5.12-rc1


Matthew Gerlach (1):
  mfd: intel-m10-bmc: Add access table configuration to the regmap

Xu Yilun (3):
  mfd: intel-m10-bmc: Fix the register access range
  mfd: intel-m10-bmc: Simplify the legacy version reg definition
  MAINTAINERS: Add entry for Intel MAX 10 mfd driver

 MAINTAINERS                       | 10 ++++++++++
 drivers/mfd/intel-m10-bmc.c       | 25 ++++++++++++++++++-------
 include/linux/mfd/intel-m10-bmc.h |  7 +++++--
 3 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.7.4

