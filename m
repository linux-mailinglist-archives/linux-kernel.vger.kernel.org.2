Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03186351F61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhDATNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:13:14 -0400
Received: from m12-16.163.com ([220.181.12.16]:37211 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233817AbhDATMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=bbLsjxUWqWIkerb7Uh
        lE40+J1NmZ+tI75bAMTfi7e7s=; b=jRDrzHuNRJ6PC8C+W/CpngVlOquWUlSNvQ
        xFRsosKMS39twnd1TE3fEzViMe7ZdXWoFPHkOEIwRurpDcLUcEqzJp/D59HTLS+i
        xWahJfQonZwpDGvaDI8QWVTBjnYaBF6pmCq4C/vvkoqvJmtbnQLBeD1tPgLdUrnT
        8YswcrSA0=
Received: from wengjianfeng.ccdomain.com (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowACXnhowrWVgeWQpjg--.43479S2;
        Thu, 01 Apr 2021 19:23:30 +0800 (CST)
From:   samirweng1979 <samirweng1979@163.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
Subject: [PATCH] ASoC: topology: fix typo error about asoc.h
Date:   Thu,  1 Apr 2021 19:23:19 +0800
Message-Id: <20210401112319.28084-1-samirweng1979@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: EMCowACXnhowrWVgeWQpjg--.43479S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW7Cw45Ww47Aryxur45ZFb_yoWDGFg_Cw
        naqr4xZry8Gw1I9w1UJrs5JFZ8Zwn7Ca1kKFnaqr1Yq34DCa1fCw18GryxZryrG3Wvq3sI
        9F1fu340k3sIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5k73DUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: pvdpx25zhqwiqzxzqiywtou0bp/xtbBERJnsVaEDiqtHgAAsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wengjianfeng <wengjianfeng@yulong.com>

change 'freqency' to 'frequecy'

Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
---
 include/uapi/sound/asoc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index da61398..0066eee 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -346,8 +346,8 @@ struct snd_soc_tplg_hw_config {
 	__u8 fsync_provider;	/* SND_SOC_TPLG_FSYNC_ value */
 	__u8 mclk_direction;    /* SND_SOC_TPLG_MCLK_ value */
 	__le16 reserved;	/* for 32bit alignment */
-	__le32 mclk_rate;	/* MCLK or SYSCLK freqency in Hz */
-	__le32 bclk_rate;	/* BCLK freqency in Hz */
+	__le32 mclk_rate;	/* MCLK or SYSCLK frequency in Hz */
+	__le32 bclk_rate;	/* BCLK frequency in Hz */
 	__le32 fsync_rate;	/* frame clock in Hz */
 	__le32 tdm_slots;	/* number of TDM slots in use */
 	__le32 tdm_slot_width;	/* width in bits for each slot */
-- 
1.9.1


