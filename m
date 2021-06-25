Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44283B43A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFYM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:58:07 -0400
Received: from m12-13.163.com ([220.181.12.13]:36992 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhFYM6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5K5m1
        i7AFffYHG6+5V141txZ9n2mjZOi15x1fOS+yIg=; b=aPXsUZX7qxjO6/HjJZ8vh
        MYm9L4R+umydvdD+GjE4+duF9hqdk+ZQs/v/HE5zKcH7efy5Omb4q2pthYeBRQfF
        owudltj+iV/ePI8M1jiGPhheXtbU3ln0r/nA0FYvkvjIESgx7mawcH+lAVIN9X6E
        GiIPPMvU8L+PVwvbKPcxLY=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowAAnXwMWztVg_jd2IA--.30557S2;
        Fri, 25 Jun 2021 20:37:43 +0800 (CST)
From:   13145886936@163.com
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: fsl_xcvr: remove an unneeded semicolon
Date:   Fri, 25 Jun 2021 05:37:40 -0700
Message-Id: <20210625123740.508640-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAnXwMWztVg_jd2IA--.30557S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrJF43JFWUCw4DJFWrCr4DJwb_yoWxWrb_Cw
        1kKwnYg3yrGrWIya4kGw4fXr4j93y7uFWUXF4Fk3W8G34Yyw4Fq3W5GFW5uFs8Wr18CryS
        g3WUtrZ8Ar17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5l2NtUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBzhu8g1QHNBNbOQAAs8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Remove an unneeded semicolon.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 sound/soc/fsl/fsl_xcvr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index e34d57ad66fb..75fa8f1b5576 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -736,7 +736,7 @@ static int fsl_xcvr_load_firmware(struct fsl_xcvr *xcvr)
 			/* clean current page, including data memory */
 			memset_io(xcvr->ram_addr, 0, size);
 		}
-	};
+	}
 
 err_firmware:
 	release_firmware(fw);
-- 
2.25.1


