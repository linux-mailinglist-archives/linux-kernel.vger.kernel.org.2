Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537B392535
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhE0DHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:07:18 -0400
Received: from m12-18.163.com ([220.181.12.18]:42233 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233302AbhE0DHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=70Oom
        WJ3zwC7Ux4Cyuscx9W74Lf/fdGM/9aFa7xNXOw=; b=YPjz89JDYUNFXKZ8wozMj
        F2/GjaVmqfeGW15EBVVwd2n/4GGUypet5kP1K2An0CE0ojqLChtvx1glTV2u9Gj3
        HFndIWphdfyF103qWXkrZ/lzwMwGiR/Yb7E4zp0p7x9SRYCXaIIS360LJnMWbu9y
        8l9CcNvgXF7ievQZWhYTQE=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowACHieFPDK9gAU9Clw--.31488S2;
        Thu, 27 May 2021 11:04:50 +0800 (CST)
From:   zuoqilin1@163.com
To:     perex@perex.cz, tiwai@suse.com, joe@perches.com,
        gustavoars@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] sound/oss/dmasound: Remove superfluous "break"
Date:   Thu, 27 May 2021 11:04:45 +0800
Message-Id: <20210527030445.1201-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACHieFPDK9gAU9Clw--.31488S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW8ArWfGF18uFWUXryfXrb_yoWDCrc_X3
        yIgr1xWa4kZrn7A347XasrGrZrK3W7Aw1fW34UKa17Wr48GrWftw1DGrsxWrn5X34Fyw4x
        u3y2k3yIk3yFqjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0mXd5UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiZQ+fiV8ZOwgNGgABsf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Remove superfluous "break", as there is a "return" before them.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 sound/oss/dmasound/dmasound_core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 22cef0c..0c95828 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -1229,31 +1229,22 @@ static char *get_afmt_string(int afmt)
         switch(afmt) {
             case AFMT_MU_LAW:
                 return "mu-law";
-                break;
             case AFMT_A_LAW:
                 return "A-law";
-                break;
             case AFMT_U8:
                 return "unsigned 8 bit";
-                break;
             case AFMT_S8:
                 return "signed 8 bit";
-                break;
             case AFMT_S16_BE:
                 return "signed 16 bit BE";
-                break;
             case AFMT_U16_BE:
                 return "unsigned 16 bit BE";
-                break;
             case AFMT_S16_LE:
                 return "signed 16 bit LE";
-                break;
             case AFMT_U16_LE:
                 return "unsigned 16 bit LE";
-                break;
 	    case 0:
 		return "format not set" ;
-		break ;
             default:
                 break ;
         }
-- 
1.9.1


