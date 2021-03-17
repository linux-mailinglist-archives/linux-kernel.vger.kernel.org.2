Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2395A33F05D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCQMa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:30:29 -0400
Received: from m12-13.163.com ([220.181.12.13]:35658 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhCQMaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HhDgB
        qjBcvhk9CXs4aaWu4TwFYv97w8AoJIatOGi19I=; b=US64WvfuweYjELoxrxu9I
        LVTMj2SXNE59ryxPTwN0aoWvBnVLYVTwPmTexdAptIzmkPCey1DWlMEP1OSWt2zM
        4FLKSQoPcnBm+/6UfZDZXB70qIEOAH5v2c9Jwj6yuDfyae35IQ9Tl2APb7Uc2GIx
        gLI+B7CIzTTGe5hboyM3l0=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp9 (Coremail) with SMTP id DcCowAC3IwHaslFgA0SmBg--.14447S2;
        Wed, 17 Mar 2021 15:42:22 +0800 (CST)
From:   zuoqilin1@163.com
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] display: Fix typo issue
Date:   Wed, 17 Mar 2021 15:42:28 +0800
Message-Id: <20210317074228.1147-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAC3IwHaslFgA0SmBg--.14447S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyrGF43Ary7XF4fGr48JFb_yoWftrb_C3
        WfZrs8uayUZ3Z0vr1akrn8ZrWSv3WYvrW8X3y0q34Fyw12yr1UGrsrWryxXw15XF1UtFWD
        Xa18XFn5ZFsrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0UEf5UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiZR5YiV8ZNQXaRgAAsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'befor' to 'before'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/gpu/drm/i915/display/vlv_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index f94025e..45187ff 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -846,7 +846,7 @@ static void intel_dsi_pre_enable(struct intel_atomic_state *state,
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_INIT_OTP);
 
 	/* Enable port in pre-enable phase itself because as per hw team
-	 * recommendation, port should be enabled befor plane & pipe */
+	 * recommendation, port should be enabled before plane & pipe */
 	if (is_cmd_mode(intel_dsi)) {
 		for_each_dsi_port(port, intel_dsi->ports)
 			intel_de_write(dev_priv,
-- 
1.9.1


