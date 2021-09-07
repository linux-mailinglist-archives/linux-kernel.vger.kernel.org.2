Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DF240221A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 04:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbhIGBs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 21:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhIGBs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 21:48:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6435C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 18:47:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s29so6866291pfw.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mc027pv6u15MDfXa8/3uliAGB1haKo3X34nc3V5v00=;
        b=oC0DtrPvwGiND0GVCJXzXX+dI34T4Zqz0WDJq566WiviOsRcoCp10XRByr4+cjaegm
         Mz4YmBM2xfPwYdcc8pL7u6265hJfeL8l5wVMS2lthiuR+gOihgA5sYWpjxMGbSxCy/eY
         xgZAKIx3setTGWmKAiD4FzZo+dksYXs9e3yMhTRteSmu5D0SgwEUrM86yYzSkE1x1Ny8
         +CSLi6GoRIUNdcdUsKhUEN31ciH0rSqnIZcFtgJtJOGX6aoeF1I35Ea+QMrPftKVUZAG
         nvlr9rkU84SzeChGIDD1xlTQmn/7j7CEWx8PHH/wj0vavyzZEmNN8JqwU2+w8b8ZVpgG
         h3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mc027pv6u15MDfXa8/3uliAGB1haKo3X34nc3V5v00=;
        b=WXCoEXoqDhKFWAKdMgvjL8XYXFEzPzLMO6mWR/XzBdMxlD1kpuaVInevQ9YarLs1+A
         3N6dLM+RyOSH2j26pHIasy4w2KV2Sp/8d3wb++Ui9EkFcb4SOXlLAROvQHfzoE49/EkH
         xiDdKyweZWaDugGh1mpw6/mNOo8vmfRJ7SqgUDF0yfahy3E/5ru2R/ji5QszxagFF5vP
         +btdYkMYN/9RofAGPlkXMmdukEEZLp+s29gXz3I/cKZdf2iBSUAy4tvV4P0QU6qhxLcC
         bIwtVaCtNPHDyrnV/NAI/hxsrk30cVpLFxVhjzWXkHBYZFa/zQjOzyimCLfEmnYG2HLR
         KKXQ==
X-Gm-Message-State: AOAM5320TTgdvpoiLlL0WtOlKaawvTzsxx3H0Qq9y7H9lbxXT1DeFBWn
        4yp7a9dcIQOZ6P/UYPChXGAc93tIGep8WQ==
X-Google-Smtp-Source: ABdhPJxUQ+t24jfciNyfQu1gi3O+qJsmIQ4TWAwZD7uUI8KaPuNkV7ME7C8E94lysZjNFushXSkUuQ==
X-Received: by 2002:a62:36c3:0:b0:3fd:52ea:bd70 with SMTP id d186-20020a6236c3000000b003fd52eabd70mr14379411pfa.38.1630979272172;
        Mon, 06 Sep 2021 18:47:52 -0700 (PDT)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id p16sm545172pjz.44.2021.09.06.18.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 18:47:51 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Leon Romanovsky <leon@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ALSA: vx222: fix null-ptr-deref
Date:   Mon,  6 Sep 2021 18:47:45 -0700
Message-Id: <20210907014746.1445278-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a recent refactor created a null pointer vx in snd_vx222_probe().
The vx pointer should have been populated in snd_vx222_create() as
suggested in earlier version, otherwise vx->core.ibl.size will throw an
error.

[    1.298398] BUG: kernel NULL pointer dereference, address: 00000000000001d8
[    1.316799] RIP: 0010:snd_vx222_probe+0x155/0x290 [snd_vx222]

Fixes: 3bde3359aa16 ("ALSA: vx222: Allocate resources with device-managed APIs")
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 sound/pci/vx222/vx222.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index f48cc20b9e8a..468a6a20dc1e 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -137,6 +137,7 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 	}
 	chip->irq = pci->irq;
 	card->sync_irq = chip->irq;
+	*rchip = vx;
 
 	return 0;
 }
-- 
2.25.1

