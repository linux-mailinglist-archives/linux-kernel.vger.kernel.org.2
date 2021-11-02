Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718E8443826
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhKBWEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:04:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:53370 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhKBWEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:04:50 -0400
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id E51B35EBE;
        Tue,  2 Nov 2021 22:02:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E51B35EBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890535; bh=QYCx8iyB5QbzPzCDV274eB6oB6pXbjKZaGgcnZWvu98=;
        h=From:To:Cc:Subject:Date:From;
        b=pUTpxEG3/+BLWHeWRKdDVgPZk2Bz0s8rn03j1z3EgymRXWlAkw77VKWStkjjeK9+U
         isUdWisTBAsXW15vY3VjbUMYDDzXKwja3YxDC3J/ogqkcwl45rHiupqpKS7Zl++VWg
         dV2uWAq9Z8mNRnXnYaRGUtRzzQGD18LeEWc2jpaNy3km2CFrVfLCuS0NhIVhkEcjIM
         59FCy1g44t8L8mavFlBAHVaxZehv6CLusqa1MrSOkvAUYI8jQznMI7M/lOzhuv+MVP
         c7Pi+P50KAxgy2T5rUJgG+hAmkTEDfr4Qkf8uHAI5dIWJQg3Ihq7ukEBMYlFeSK1TM
         maM4/STnynGTw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/9] Remove some unused header files
Date:   Tue,  2 Nov 2021 16:01:54 -0600
Message-Id: <20211102220203.940290-1-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on something totally different, it occurred to me to wonder
which header files in the kernel are not used anywhere.  Writing a little
program to figure that out in Rust was the perfect distriction from the
work I really needed to be doing...  It turns out there aren't many under
include/linux; this gets rid of the ones I found.

Jonathan Corbet (9):
  Remove unused headers <linux/jz4740-adc.h> and
    <linux/power/jz4740-battery.h>
  nfs: remove unused header <linux/pnfs_osd_xdr.h>
  Remove unused header <linux/cnt32_to_63.h>
  Remove unused header <linux/sdb.h>
  Input: remove unused header <linux/input/cy8ctmg110_pdata.h>
  mtd: remove unused header file <linux/mtd/latch-addr-flash.h>
  ARM: ixp4xx: remove unused header file pata_ixp4xx_cf.h
  spi: remove unused header file <linux/platform_data/spi-clps711x.h>
  net: remove unused header file <linux/ks8851_mll.h>

 include/linux/cnt32_to_63.h                  | 104 ------
 include/linux/input/cy8ctmg110_pdata.h       |  10 -
 include/linux/jz4740-adc.h                   |  33 --
 include/linux/ks8851_mll.h                   |  21 --
 include/linux/mtd/latch-addr-flash.h         |  29 --
 include/linux/platform_data/pata_ixp4xx_cf.h |  21 --
 include/linux/platform_data/spi-clps711x.h   |  17 -
 include/linux/pnfs_osd_xdr.h                 | 317 -------------------
 include/linux/power/jz4740-battery.h         |  15 -
 include/linux/sdb.h                          | 160 ----------
 10 files changed, 727 deletions(-)
 delete mode 100644 include/linux/cnt32_to_63.h
 delete mode 100644 include/linux/input/cy8ctmg110_pdata.h
 delete mode 100644 include/linux/jz4740-adc.h
 delete mode 100644 include/linux/ks8851_mll.h
 delete mode 100644 include/linux/mtd/latch-addr-flash.h
 delete mode 100644 include/linux/platform_data/pata_ixp4xx_cf.h
 delete mode 100644 include/linux/platform_data/spi-clps711x.h
 delete mode 100644 include/linux/pnfs_osd_xdr.h
 delete mode 100644 include/linux/power/jz4740-battery.h
 delete mode 100644 include/linux/sdb.h

-- 
2.31.1

