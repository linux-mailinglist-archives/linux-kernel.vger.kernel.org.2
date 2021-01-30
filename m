Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD553098B2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 23:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhA3W4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 17:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3W4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 17:56:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74369C061574
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 14:55:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y10so3611459plk.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 14:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Edg7SZe/LYVxNnbqgoVBuhXRLciPrmz39JuMkpRhFiA=;
        b=jtOeDLjXqNR+NBB2WQniFEW0/yIOiVzAwR7rltKGD+fPE41wL2WNKadGm1B+2q2qIO
         CoGQv7UBcY34jlC8792KbsLWCUGpH5Fl9K+5XAOpxiZKPBHzl1ozreywYYwjumKb9V+o
         yGUYQMadNYKoIgB5fRIGvUTQshE513XPXA2xh7a6SWZtklWL4BCVQ8mgj1yLK26X4zmb
         OOGMMmjtsDEGwB4DW+4L8bvHpA7fJvFmlldBNkGSE3ZBS/ctgc2extbBAYU3DXJ7h83w
         sri7VPyE7k2BJU1oZh4eg7+e7LRfDBrSD4tz/q0t/Wa8aMBuLwZDlQFvonfwZjJ83uQQ
         BPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Edg7SZe/LYVxNnbqgoVBuhXRLciPrmz39JuMkpRhFiA=;
        b=kcVoAyjeHeSN19A/UfTaS01dqqModhNoPOgJBc/88Pgv7ypE5yMiKqHGWxx75tVwaZ
         p4Qp19pEW9u0SeVIPwYmw2D0WwbM9urYpOFeIr1U75PW5gVOiY3u0KoTGAJ0S3rXXJfm
         PGd9vwkkLEnL8CEjmMN1aM/SHYuFIwnq4rtDMNW3E95SWHZ+Gclb/ozt+ENway8xTXPl
         hF4Eldp7CEph3rPFJNTinVeMzwHBktgLsZiRRPEvN+tYNRC8LAygu0B2ZjwtvKgGQrwH
         pU/pqexYepkShoh07bBiJEN8kYO+qnCdKm3cqcAOwod0FbgPqXVkcL1MsRcIyCjwjQH0
         s9jw==
X-Gm-Message-State: AOAM530Oo0RJEfiJbmQhxX85vTp/gb/3ZlX23Av1jHm1w93y6PgVYp7n
        yoc21yc8PN7jWYAi7dzOdN0GjO86oO0=
X-Google-Smtp-Source: ABdhPJyxErqd59tSEM3iz4Sx0478rW57srYbnQpr9fq+lnOhrqy3rvjMYzKoZnS7LUbYWBTkx5opxA==
X-Received: by 2002:a17:90a:3988:: with SMTP id z8mr3665888pjb.46.1612047354575;
        Sat, 30 Jan 2021 14:55:54 -0800 (PST)
Received: from 1G5JKC2.Broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 14sm12989104pfy.55.2021.01.30.14.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 14:55:53 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, arndb@kernel.org
Cc:     kbuild-all@lists.01.org, Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>,
        linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC EMBEDDED
        PPC4XX)
Subject: [PATCH 1/2] powerpc/Kconfig: Fix unmet direct dependency on NET
Date:   Sat, 30 Jan 2021 14:55:37 -0800
Message-Id: <20210130225540.1639-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild test robot was able to generate a configuration where
ETHERNET and NETDEVICES was selected by the Akenobo platform but not
NET, which resulted in various build failures and these Kconfig
warnings:

WARNING: unmet direct dependencies detected for NETDEVICES
  Depends on [n]: NET [=n]
  Selected by [y]:
  - AKEBONO [=y] && PPC_47x [=y]

WARNING: unmet direct dependencies detected for ETHERNET
  Depends on [n]: NETDEVICES [=y] && NET [=n]
  Selected by [y]:
  - AKEBONO [=y] && PPC_47x [=y]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/powerpc/platforms/44x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 78ac6d67a935..68bd647c878f 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -206,6 +206,7 @@ config AKEBONO
 	select PPC4xx_HSTA_MSI
 	select I2C
 	select I2C_IBM_IIC
+	select NET
 	select NETDEVICES
 	select ETHERNET
 	select NET_VENDOR_IBM
-- 
2.25.1

