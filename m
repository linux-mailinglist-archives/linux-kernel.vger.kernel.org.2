Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B503EA052
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhHLILH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:11:07 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37508
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234995AbhHLILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:11:04 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B51E740658;
        Thu, 12 Aug 2021 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628755839;
        bh=LbYBvz/IK4bQV1YLy48n6bzetxCj5Y5EuS3PD38la+g=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=q4DzlCk4kT0xgT7rT104hSP5qcdnzcs7TtyjZbD6GNzIjkpayA3BtK2hcTzzCGNeJ
         GN/iZ8nMrvKEsWN0xMsRbXxgj5m4tp59ccUBbQp/xlAs90+kp6A9XOl1d0Lg6Z1dXm
         I8QOJ9KK3oVQ9uAHMPhLDIDHpVJx/lHOx0XsIQYDSC87TBfLqc3340Um98aQJ6xHE7
         hB1SuAX7yIosccRyqtWikYCM75zOmv7HrvZIRKiy3uIJ7BenLejpjpMI+lyoMtqQ7o
         gcqk9nm3HCxH49Dqshibbc56ehgwGCGR5B1DAJwACoAuVTN7seknQ3ym5o1fq3H0L3
         PGeoOXkCh+blw==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] riscv: defconfig: enable NLS_CODEPAGE_437, NLS_ISO8859_1
Date:   Thu, 12 Aug 2021 10:10:27 +0200
Message-Id: <20210812081027.9242-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812081027.9242-1-heinrich.schuchardt@canonical.com>
References: <20210812081027.9242-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EFI system partition uses the FAT file system. Many distributions add
an entry in /etc/fstab for the ESP. We must ensure that mounting does not
fail.

The default code page for FAT is 437 (cf. CONFIG_FAT_DEFAULT_CODEPAGE).
The default IO character set is "iso8859-1" (cf. CONFIG_NLS_ISO8859_1).

So let's enable NLS_CODEPAGE_437 and NLS_ISO8859_1 in defconfig.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
resent on Palmer's request due to non-matching e-mail addresses
cf. https://lore.kernel.org/linux-riscv/20210726112647.78561-1-xypron.glpk@gmx.de/
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 393bf3843e5c..1a3170d5f203 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -110,6 +110,8 @@ CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_9P_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
-- 
2.30.2

