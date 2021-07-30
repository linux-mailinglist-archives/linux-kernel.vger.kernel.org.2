Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF8E3DB722
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbhG3K0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:26:48 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52228 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238274AbhG3K0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:26:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UhR-l2X_1627640797;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UhR-l2X_1627640797)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Jul 2021 18:26:40 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     emma@anholt.net
Cc:     mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        p.zabel@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/vc4: hdmi: make vc4_hdmi_codec_pdata static
Date:   Fri, 30 Jul 2021 18:26:34 +0800
Message-Id: <1627640794-15718-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of vc4_hdmi.c, so marks it static.

Fix the following sparse warning:

drivers/gpu/drm/vc4/vc4_hdmi.c:1479:25: warning: symbol
'vc4_hdmi_codec_pdata' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index b20530c..ca08b64 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1476,7 +1476,7 @@ static int vc4_hdmi_audio_get_eld(struct device *dev, void *data,
 	.audio_startup = vc4_hdmi_audio_startup,
 };
 
-struct hdmi_codec_pdata vc4_hdmi_codec_pdata = {
+static struct hdmi_codec_pdata vc4_hdmi_codec_pdata = {
 	.ops = &vc4_hdmi_codec_ops,
 	.max_i2s_channels = 8,
 	.i2s = 1,
-- 
1.8.3.1

