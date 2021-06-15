Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB23A7D73
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFOLrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:47:23 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:45186 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOLrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:47:23 -0400
DKIM-Signature: a=rsa-sha256;
        b=ZAO2bcFNMtQU/YuKzEFCBUJLBEZWCWvWxwPeox2Dqn+RMJOOMXQKhZQO97rfOShPgN6EdQ9NWvNDlGPfYIWuMgzGVSxedB8vhK7knKoq5KkAS8mdO3omoBDF3trFE3n7kghZoSIMPl84Dti+AamdPsN0Py1hwb28MrDasAHmtB0=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=j3jt4fUPgIREfp+PJY4vqwyrcfj6j4PCiNXLHMJ+77c=;
        h=date:mime-version:subject:message-id:from;
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 50D5BAC03F3;
        Tue, 15 Jun 2021 19:45:05 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Zhan Liu <zhan.liu@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Roman Li <roman.li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drm: display: Fix duplicate field initialization in dcn31
Date:   Tue, 15 Jun 2021 19:44:01 +0800
Message-Id: <20210615114410.7708-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQhkaT1ZJSEkdSk8fS00dQk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NS46Ejo*FT8NI0gJC086NUoZ
        MlZPCS9VSlVKTUlITE5MTktNTktIVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJTUNDNwY+
X-HM-Tid: 0a7a0f7d464cb039kuuu50d5bac03f3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c:917:56-57:
pstate_enabled: first occurrence line 935, second occurrence line 937

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 0d6cb6caad81..c67bc9544f5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -934,7 +934,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dmub_command_table = true,
 	.pstate_enabled = true,
 	.use_max_lb = true,
-	.pstate_enabled = true,
 	.enable_mem_low_power = {
 		.bits = {
 			.vga = false,
-- 
2.20.1

