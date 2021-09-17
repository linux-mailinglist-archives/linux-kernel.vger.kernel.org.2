Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D863740F6A4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbhIQLVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:21:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60288 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhIQLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:21:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CB2E71FE19;
        Fri, 17 Sep 2021 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631877618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=LgeOlYiugRlMNxjs+SaKTKk8B90t257FaWpa07ChoH8=;
        b=FE4WLOkVhSxISzRUayD31zvb2tKv6Wd2k/+Cw53YQvvr0UFBhn5xGad1T9JD/GO32FXM+M
        3dtGVSNeYhMo0FXsClN69kOKYLrMw+ktieIJ+tPG1jFzqirpB8m3w79fGCRzRmYyoYg4Vf
        WBZ9Ug0FpSERqyyhLzm2SQN1FJlucOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631877618;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=LgeOlYiugRlMNxjs+SaKTKk8B90t257FaWpa07ChoH8=;
        b=a0fEnhp9EXFls/WK176QMTwnZR24LWWx6/V6H6eUa+JpB7zvErB/l8BV11z+6eOlA4Jou1
        kH8x/UjetER7xdDg==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BF0C1A3B81;
        Fri, 17 Sep 2021 11:20:18 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id A0A81603FA; Fri, 17 Sep 2021 13:20:18 +0200 (CEST)
Message-Id: <694766b15cfa3759e3686145417952d320029390.1631877302.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH] nvmem: nintendo-otp: add dependency on CONFIG_HAS_IOMEM
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri, 17 Sep 2021 13:20:18 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function nintendo_otp_probe() calls devm_ioremap_resource() which is only
available if CONFIG_HAS_IOMEM is enabled. Add a kconfig dependency like
other similar drivers have.

Fixes: 3683b761fe3a ("nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 drivers/nvmem/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 39854d43758b..fb4005df86c0 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -108,6 +108,7 @@ config MTK_EFUSE
 	  will be called efuse-mtk.
 
 config NVMEM_NINTENDO_OTP
+	depends on HAS_IOMEM
 	tristate "Nintendo Wii and Wii U OTP Support"
 	help
 	  This is a driver exposing the OTP of a Nintendo Wii or Wii U console.
-- 
2.33.0

