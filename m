Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E89F3BB6D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGEFgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhGEFgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:36:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC0C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 22:33:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f5so7922633pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WS/CNP/N9EeU5nSTjU5yi9ozS4pjpkLNaRuavopgyWI=;
        b=SmZWr9iSjTdz4g+PwZXKFVYp5kPkSfCiaYIngd088Q/vE76nX5afKnx1U9SIoJ9vGl
         E/1ED+sKEe3ENq2dfijfaoe/mUY7F9AA6ALukTFl+Y/1Q+srJlHH79iPXPv7Szo/dfit
         K7DBcN9lcs7HjT10spqq24ZtoESp/Ym0GZ89g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WS/CNP/N9EeU5nSTjU5yi9ozS4pjpkLNaRuavopgyWI=;
        b=rKa52gJC74vSCHzpajxUqNRABQA4T1rnGCxeB79UK9iSdOzNAin3d0ctBJgce92604
         9fi1zvaann8TK3kduZf+ONGaYFSOISUtsQVdNp0f0G2Pm16vQl0EN7eqHuB8gmIe7mfC
         fi0/t8T3dYFPpbOSlP6QILm4d7GfeaqqCwUndnTy9CXsJxPD0UXtKS+85PLoflXwJcwF
         +LPlIucwNVIUwcyEmPYuGVfGRG6tiDuR3SwimMAisrZJdoEyxPJQzPiyiGeFmkJltKjN
         IaSXPycXq5UPkKbfHA7FoMnuTVVxSr0TcGRALymRfL3bYQyCoIDZy70PuFcJyLWrXJxl
         E6GA==
X-Gm-Message-State: AOAM5306+DJww9vroM7QQN8voQ4Rj1XfN6UZ+qBEa2V++N3d5VHy8Oq9
        UZkeH3IRRhNYQ9zj0lFEeQNvEA==
X-Google-Smtp-Source: ABdhPJwuL5YE4n+oyQ5y6zzGaRklfZ1IvcRIuzn32RygafdBFFhnP2zufiEevYJeO9uqbsmBx0kYCw==
X-Received: by 2002:a63:5d5c:: with SMTP id o28mr13943804pgm.22.1625463206343;
        Sun, 04 Jul 2021 22:33:26 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:3fed:7130:60f:265a])
        by smtp.gmail.com with ESMTPSA id x19sm6805245pfp.115.2021.07.04.22.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 22:33:26 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH v6 02/14] media: mtk-vcodec: vdec: use helpers in VIDIOC_(TRY_)DECODER_CMD
Date:   Mon,  5 Jul 2021 14:32:46 +0900
Message-Id: <20210705053258.1614177-3-acourbot@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210705053258.1614177-1-acourbot@chromium.org>
References: <20210705053258.1614177-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the dedicated helpers to make sure we get the expected
behavior and remove redundant code.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 8df8bcfe5e9c..1a633b485a69 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -484,18 +484,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 static int vidioc_try_decoder_cmd(struct file *file, void *priv,
 				struct v4l2_decoder_cmd *cmd)
 {
-	switch (cmd->cmd) {
-	case V4L2_DEC_CMD_STOP:
-	case V4L2_DEC_CMD_START:
-		if (cmd->flags != 0) {
-			mtk_v4l2_err("cmd->flags=%u", cmd->flags);
-			return -EINVAL;
-		}
-		break;
-	default:
-		return -EINVAL;
-	}
-	return 0;
+	return v4l2_m2m_ioctl_try_decoder_cmd(file, priv, cmd);
 }
 
 
-- 
2.32.0.93.g670b81a890-goog

