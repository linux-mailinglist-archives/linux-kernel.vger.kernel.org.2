Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D049E35B124
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 04:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhDKCDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 22:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhDKCDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 22:03:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA896C06138B;
        Sat, 10 Apr 2021 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MrqRlFnmAr3VO2kikjWYwVGKANP+pM6Y3zXnpk6GwW8=; b=Hdd/T3rDjlbpPkMCZ/ZkI0S6KY
        kkAhdJQDU4zp15e5pt8agS7t9W7+MsgWBMu5/uqMql/8hssQ9cBHWNOmXmunsD2DKpBlj/p1UU0C1
        xZy/88ZaaIpdr2rv74Dcs827yaJvo19qczwUcNKOqLz8Aqkn1do7tY3NgbUEGXgcQW6UdPUaPC52u
        yVVlWhBK0PasYSS0qETwTrsE/GNc2Uxa4Gs25f9u7OBHSieh44YlycpAb62HqxCJ26S/2t/0rDkNs
        8tew6Up9SyItuU/DjKEmKscxCTKoGlDiA1PGVp73y1FfakQhhERJdJvHQNhxu73qQ+D7HoS91NB0c
        xyMr6oyg==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVPRE-003mQP-M6; Sun, 11 Apr 2021 02:03:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH RESENDbis] ia64: remove duplicate entries in generic_defconfig
Date:   Sat, 10 Apr 2021 19:02:55 -0700
Message-Id: <20210411020255.18052-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ia64 generic_defconfig duplicate entries, as warned by:

  + arch/ia64/configs/generic_defconfig: warning: override: reassigning to symbol ATA:  => 58
  + arch/ia64/configs/generic_defconfig: warning: override: reassigning to symbol ATA_PIIX:  => 59

These 2 symbols still have the same value as in the removed lines.

Fixes: c331649e6371 ("ia64: Use libata instead of the legacy ide driver in defconfigs")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
#Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/ia64/configs/generic_defconfig |    2 --
 1 file changed, 2 deletions(-)

--- lnx-511-rc1.orig/arch/ia64/configs/generic_defconfig
+++ lnx-511-rc1/arch/ia64/configs/generic_defconfig
@@ -55,8 +55,6 @@ CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_SYM53C8XX_2=y
 CONFIG_SCSI_QLOGIC_1280=y
-CONFIG_ATA=y
-CONFIG_ATA_PIIX=y
 CONFIG_SATA_VITESSE=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=m
