Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499C538E14B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhEXHDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:03:42 -0400
Received: from m12-13.163.com ([220.181.12.13]:44921 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232345AbhEXHDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zoJst
        1Zn1evVluRhJUjkEU/5yb3SCPyxYCn2nqhpOLQ=; b=f0kUHlbWu5oj31uTdnjuG
        kwHW1hC1S2vQTMwlubg7kbsZLytVyzX2UXz8IpcZgM0ySBdTAWTSGvVQJYqeZFuP
        D3iAZ4Vq8tS2C0BaD6H4HrPgE28JVTQNPj8UVkcBl5tYiFCG5Oe5uzmuKzOHThdx
        EN95ix5PWVkGIEgVcRL94c=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp9 (Coremail) with SMTP id DcCowABXDAEPT6tgNa6LCQ--.40309S2;
        Mon, 24 May 2021 15:00:35 +0800 (CST)
From:   zuoqilin1@163.com
To:     perex@perex.cz, tiwai@suse.com, joe@perches.com,
        gustavoars@kernel.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] sound/oss/dmasound: Remove superfluous "break"
Date:   Mon, 24 May 2021 15:00:28 +0800
Message-Id: <20210524070028.45-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABXDAEPT6tgNa6LCQ--.40309S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1furWktF4ktF47Cw1kAFb_yoW8AF4rp3
        95WrWUGrW5KryqkFyq9wnFvF4Ska1jvFy7uFyfX397Aay8W34kuw1DtrW8ZF1jg3s7Kr18
        J3yYy3s5uFn5XwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5cTQUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiThOciVUDJrYSHwAAsD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Remove superfluous "break", as there is a "return" before them.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 sound/oss/dmasound/dmasound_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 49679aa..22cef0c 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -999,11 +999,9 @@ static int sq_ioctl(struct file *file, u_int cmd, u_long arg)
 	case SNDCTL_DSP_RESET:
 		sq_reset();
 		return 0;
-		break ;
 	case SNDCTL_DSP_GETFMTS:
 		fmt = dmasound.mach.hardware_afmts ; /* this is what OSS says.. */
 		return IOCTL_OUT(arg, fmt);
-		break ;
 	case SNDCTL_DSP_GETBLKSIZE:
 		/* this should tell the caller about bytes that the app can
 		   read/write - the app doesn't care about our internal buffers.
@@ -1020,7 +1018,6 @@ static int sq_ioctl(struct file *file, u_int cmd, u_long arg)
 			size = write_sq.user_frag_size ;
 		}
 		return IOCTL_OUT(arg, size);
-		break ;
 	case SNDCTL_DSP_POST:
 		/* all we are going to do is to tell the LL that any
 		   partial frags can be queued for output.
@@ -1044,7 +1041,6 @@ static int sq_ioctl(struct file *file, u_int cmd, u_long arg)
 		if (file->f_mode & shared_resource_owner)
 			shared_resources_initialised = 0 ;
 		return result ;
-		break ;
 	case SOUND_PCM_READ_RATE:
 		return IOCTL_OUT(arg, dmasound.soft.speed);
 	case SNDCTL_DSP_SPEED:
@@ -1123,7 +1119,6 @@ static int sq_ioctl(struct file *file, u_int cmd, u_long arg)
 		   the value is 'random' and that the user _must_ check the actual
 		   frags values using SNDCTL_DSP_GETBLKSIZE or similar */
 		return IOCTL_OUT(arg, data);
-		break ;
 	case SNDCTL_DSP_GETOSPACE:
 		/*
 		*/
-- 
1.9.1


