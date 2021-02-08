Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704F4312A91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 07:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBHGLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 01:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBHGLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 01:11:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77CCC061786;
        Sun,  7 Feb 2021 22:10:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 7so15782067wrz.0;
        Sun, 07 Feb 2021 22:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IzgnsVIfQ7MUr3Ild4g6lH/jjkDlQ+c5fZz2xq4Qd0M=;
        b=IFdCDqIq3K4sR7qI23+MXf/nE+MnBNzqSkyVuO4r4wN26UzDYoL07WtEvfssn0BIfo
         Mk0lfYh/dKCl/TQo/5T9QAg0rxjsFnThCnuZpRG4BRV3L6wILC9S3y+JgjP8EbL1rOv7
         pHk+NMNjFXwQK3hZzrBvcrIyM0I3vXL9eAy6rM+QacznPveyuyT80126LftBl54p4lMM
         Xh7+4g6zXfld33SAq50bSzurmCwoFo32eEGeUVboYb7FitTrO4AggnL8DEneRmGtdWTn
         HD4dmKhx9vAZcOmoS83LegWJk1KKQIO8YtWx9x28T1A+vcsazdKE3WBXOFII+cIuFard
         NIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IzgnsVIfQ7MUr3Ild4g6lH/jjkDlQ+c5fZz2xq4Qd0M=;
        b=nBibVutnX19HOtzY0D4g/p8kU8Pezkl/ir3ZbeXqyogK3rqqQGUPcKig6qMa93CNEU
         o1+W/j7f5MjPDfIMl33XC5V5LGVNeTc1wJUEaTZl+rYGB2kaCzDEyrfxMn0sqRHXBFG2
         yzsOji7ONKw5JC61hCfuOMEJsDFAlX2TloYd//uz6J488bfyzFYMaCjGY4fK6W1sB6rr
         9a5yy7GI1kjhOMsFEK12okttU3ooaT50dx5XuMmxGzPks5xQnui+f1xNiQObsuUaKdky
         CMU2mwJM5OFzma8ECSQjtTSAyIb3dTi9+v6wV9Nr+09raUyDF1eebWUZsfKTT4FtCwG2
         ZlkA==
X-Gm-Message-State: AOAM532fbSvVYm32kHuJt+AXSOT3KOeSLQ1sMx/jhSFskdIj7k8e+qiK
        QqJ09CuIN2BVrSJiKgGWaYw=
X-Google-Smtp-Source: ABdhPJwAklcz2IhxWhplULsILsyJcC1/7jVHUHOswyE9u52R6xwuOO+plQjS+Yqkm/ETdvCcMKtJXA==
X-Received: by 2002:a5d:414c:: with SMTP id c12mr18487516wrq.251.1612764636586;
        Sun, 07 Feb 2021 22:10:36 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d8e:7300:842e:a74a:35f3:bd06])
        by smtp.gmail.com with ESMTPSA id m2sm18466356wml.34.2021.02.07.22.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 22:10:35 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Yong Wu <yong.wu@mediatek.com>, linux-mediatek@lists.infradead.org,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair file pattern in MEDIATEK IOMMU DRIVER
Date:   Mon,  8 Feb 2021 07:10:25 +0100
Message-Id: <20210208061025.29198-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6af4873852c4 ("MAINTAINERS: Add entry for MediaTek IOMMU") mentions
the pattern 'drivers/iommu/mtk-iommu*', but the files are actually named
with an underscore, not with a hyphen.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches  F:    drivers/iommu/mtk-iommu*

Repair this minor typo in the file pattern.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210205

Yong, please ack.
Will, please pick this minor fixup for your iommu-next tree.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 674f42375acf..6b507e8d7828 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11200,7 +11200,7 @@ L:	iommu@lists.linux-foundation.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/iommu/mediatek*
-F:	drivers/iommu/mtk-iommu*
+F:	drivers/iommu/mtk_iommu*
 F:	include/dt-bindings/memory/mt*-port.h
 
 MEDIATEK JPEG DRIVER
-- 
2.17.1

