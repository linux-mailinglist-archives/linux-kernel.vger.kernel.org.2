Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAE3A836A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhFOO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:57:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62259 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhFOO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623768935; x=1655304935;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CAScRMwXGy/5WJwei+wqJXkunlKO14sj2Xx4DA6Q4YI=;
  b=O49m8F3PETyZF9xetc5u4/7mYoecZprobzur1AEawBtjdeVxeKfS9/3d
   g1uW8KkASfAdxSIdPomWJYm2Ogg5tA3O0CF5oqzjVn2lai6SACVMb18f7
   xFa0H+cPJMB01rpHiCa6xzQeKJfETocsuSspDojMVMU18enPSzyHKBfi7
   jic8yr4DqiDt19rDOC0fFCY4T8wR8ekIh0+IS7GHRJsockvj3YvE+/tlA
   lNsVEqFhcwOhKZ57b4+Lw2pcvjdhpMHftlXGbg284p5f/Djjzuc/k/53h
   Q2bZf21q30R5dT11cPaBhEKkpSZ54xCoGT6AHwctSUMB9FodOSwsTd/Kg
   w==;
IronPort-SDR: LdMMSRUKT6AsN98wSF/VR5crrtdqFiTw3YEbI4xZqKbW2R1ev19xjVDu8zVTCqYzd+rZPe3qZI
 vPbsB4ad+OKizFjx93psBGxijgKxi9Wg4nzBXqTAK9R0saSjYVnw4XhyhqXQ+uihUs1alzTDss
 Sikuj3dUAulEcW5zBICWq796MFrXnab0nzy9XKvkvkHvVBgC3SANHZbeWwDzkVn1fLVSO6MMm7
 941mq5G5OLMBvHVMaw1qCA4JqJIiFw/37/E52wbaGbQt6A7I+l7vL/2krngkssqC9LaCUaI3tD
 xdI=
X-IronPort-AV: E=Sophos;i="5.83,275,1616428800"; 
   d="scan'208";a="171974924"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 22:55:34 +0800
IronPort-SDR: gDN/qpYnI6on7duatOTmgVrbK/ywhoAzrPt1kVJpE9c370YjPNmLu4kDyGjSZJfNzHZZLI5MZp
 VQ/rdKshcZhF0hpF/hq44aCjWV3thOkmEpQ9YzaISKB/r5+YAM59Ldk7jx16SabQp0WeCw3JsO
 ENnTw69Q/oJvQX+kRJ1QeDQudFmBY16Hnao/IcAwSt+TiCHIyDn91pQ50S0laGOpweU4Jrj9jF
 RC+3sDVZEHGD1wNRkiX47brV5RFbQkEi0Kkge7DBG/w/WL84tSIuHWMbp6PTfbMLAmde9qgbRC
 pHqcihfoqPAieRPZlQABXxFY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 07:33:05 -0700
IronPort-SDR: MEP1if1cYyXjFTD/Dhbttg2NWDaGnYmPA2Pm3tX0YHy/y3Oop5pEWacWiFoPEHjwTa3DespzA/
 6z4WDqnjahyZePKqHcVXjcLUHyeOJqk3yzYe6AoXCObp/ae3M7bKv20BHeEpvTvJMkjH477Dgw
 ZqU7UeeKRmTZKZw8OvmaKXsljchGF4KeK6/ZW5otijQEmwKfLGz9s8GZPkv4Dn3JWXpmGRCHLz
 qcdgnexmi6wdxzgWTGhxgcwFNqvBROFV+woqW9WFQX7Q3z/XB8ABWMgwBRYVbsnBWqE96qnjiY
 GMs=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2021 07:55:35 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/3] mcb changes for 5.14
Date:   Tue, 15 Jun 2021 23:55:27 +0900
Message-Id: <cover.1623768541.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are the collected patches for mcb for 5.14.

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git mcb-for-5.14

for you to fetch changes up to fe520620eeddaa2ed8c669125f9b673c89d6b5a5:

  mcb: Remove trailing semicolon in macros (2021-06-15 23:43:47 +0900)

----------------------------------------------------------------

Alternatively the broken out patches are in this thread.

Dan Carpenter (1):
  mcb: fix error handling in mcb_alloc_bus()

Huilong Deng (1):
  mcb: Remove trailing semicolon in macros

Zhen Lei (1):
  mcb: Use DEFINE_RES_MEM() to simplify code

 drivers/mcb/mcb-core.c | 12 ++++++------
 drivers/mcb/mcb-lpc.c  | 13 ++-----------
 include/linux/mcb.h    |  2 +-
 3 files changed, 9 insertions(+), 18 deletions(-)

-- 
2.31.1

