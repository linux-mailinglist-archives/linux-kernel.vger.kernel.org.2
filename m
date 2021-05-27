Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D786A393415
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhE0Qhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:37:31 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33193 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbhE0Qh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:37:28 -0400
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis)
 id 1MxDgs-1lWi1Y41ay-00xb4U; Thu, 27 May 2021 18:35:05 +0200
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl-asoc-card: Set .owner attribute when registering card.
Date:   Thu, 27 May 2021 18:34:09 +0200
Message-Id: <20210527163409.22049-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2Xcz2Picz7QfmT/3RZBi3M8YNs4IfW4bK0TwJV+1zVrQF9+vlSl
 SpyEYVbT+4phkVcPD0ZG9bn4CAhEsIknv5lWwzPzDyXjwUVbUyGnIcI/zSyao3qv97Uyo4i
 8I+4g8168s60kXemjwIW7S501zxCz+aUwNwwO7y+Pb2ZprPbNdy7M8pHZeG2EZATaEWW/9y
 6O8qBSxcDQtKbzu8xhHQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bzReOWb16ek=:V0+42pMgaYxIojg4mvWBbg
 pEcUglREpACdHscuIlYtm7rEF3ODNcM1E0WQzBzhTFSs7DhVRluMSngL55mjhF42QxYVfR6yN
 Y65WkxbZGGMseBbZaK3721OpVPaZT3j2d3whJBH8Ep+YS3iBF2L2spCuH5Auajt641GTL42GW
 kZof8yQyY9aoOgnyJac80gSxutgWZfgb4Ak7fxwPfzQESJbWM+oeXTICXrW5GCrCKvCz3bhat
 2o9CPY6I3ZwHe5auyuKNq9RcQ7TdfEFm5KMHsn8mAXeUdPiGv68RVfSTL1M6WJG/6oHGiYyQR
 HaZkmeFqcTTe7HE2p0nVlYu5a/pBdX/bhesH0c8R/h8aIokRObk+EJDP8PICJNXBQOjZtpZXJ
 YjmDi/YZ3cxgRpEEEJOP/vNHx5P6984xxPB7G6loLa7hFlOWvrT7mggU/pHi2T2HMSGaaZ9LX
 I5+TKzR4hj5c+LinK2iGQJA6VuoWGUcp2B9Xhhb5O2b1stq40h5gqLrsyKkryYU2ZogkQFvtD
 kkykOYd/i9PhIrXzooyIfBz6g9K+osu7eGuFTYF6CFTnYg9QWm7CUZ6cn3PK6CoMw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, when compiled as module, a WARN_ON is triggered:

WARNING: CPU: 0 PID: 5 at sound/core/init.c:208 snd_card_new+0x310/0x39c [snd]
[...]
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.10.39 #1
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Workqueue: events deferred_probe_work_func
[<c0111988>] (unwind_backtrace) from [<c010c8ac>] (show_stack+0x10/0x14)
[<c010c8ac>] (show_stack) from [<c092784c>] (dump_stack+0xdc/0x104)
[<c092784c>] (dump_stack) from [<c0129710>] (__warn+0xd8/0x114)
[<c0129710>] (__warn) from [<c0922a48>] (warn_slowpath_fmt+0x5c/0xc4)
[<c0922a48>] (warn_slowpath_fmt) from [<bf0496f8>] (snd_card_new+0x310/0x39c [snd])
[<bf0496f8>] (snd_card_new [snd]) from [<bf1d7df8>] (snd_soc_bind_card+0x334/0x9c4 [snd_soc_core])
[<bf1d7df8>] (snd_soc_bind_card [snd_soc_core]) from [<bf1e9cd8>] (devm_snd_soc_register_card+0x30/0x6c [snd_soc_core])
[<bf1e9cd8>] (devm_snd_soc_register_card [snd_soc_core]) from [<bf22d964>] (fsl_asoc_card_probe+0x550/0xcc8 [snd_soc_fsl_asoc_card])
[<bf22d964>] (fsl_asoc_card_probe [snd_soc_fsl_asoc_card]) from [<c060c930>] (platform_drv_probe+0x48/0x98)
[...]

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index c62bfd1c3ac7..4f55b316cf0f 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -744,6 +744,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	/* Initialize sound card */
 	priv->pdev = pdev;
 	priv->card.dev = &pdev->dev;
+	priv->card.owner = THIS_MODULE;
 	ret = snd_soc_of_parse_card_name(&priv->card, "model");
 	if (ret) {
 		snprintf(priv->name, sizeof(priv->name), "%s-audio",
-- 
2.32.0.rc0

