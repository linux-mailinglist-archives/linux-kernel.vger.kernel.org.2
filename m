Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5245091C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhKOQFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 11:05:16 -0500
Received: from li1434-30.members.linode.com ([45.33.107.30]:46208 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231562AbhKOQE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 11:04:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 9719B5DE02F;
        Mon, 15 Nov 2021 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1636992121; bh=9HCm74kmLej6uZvnc+Jiw+vlQTg3fDIin0BTbXZI4JE=;
        h=From:To:Cc:Subject:Date;
        b=UrsM7o0LNweHYdsuci+94sY6mmLbd4D1j+oxptcPAKDJC09Flz8NBsEPwegN1jie7
         C1zvmsF5Is2zwZdDJFdKBn/djRwUGYt8qQAD0+fAG1/SDnh8jsbKqJEd26nCiTnUKk
         zcts+xprIiV+a0Zeg5R1UTpsAynKOzwm+fk3C5w4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Si97c3LbDJVX; Mon, 15 Nov 2021 16:02:00 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 7F8385DE01D;
        Mon, 15 Nov 2021 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1636992120; bh=9HCm74kmLej6uZvnc+Jiw+vlQTg3fDIin0BTbXZI4JE=;
        h=From:To:Cc:Subject:Date;
        b=GtXvJDtgW7fqQ9ZaIQ7Xljs23Hs8Yvops0NMI7kZuwTFwKV/rwlenobDPBygAaJa/
         /0YG1AEseqfuOuf3InjmRKNCus1RouuLv4l0/FXfiKc/xCQDdNXWp6QxUzlQtyxj8B
         u7jNfpfpRFIFHX+b9NSwsITUwIODDeC5VbnF2Ie4=
From:   Angus Ainslie <angus@akkea.ca>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH] drm: drm_probe_helper: add modes upto 1920x1080
Date:   Mon, 15 Nov 2021 08:01:35 -0800
Message-Id: <20211115160135.25451-1-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of monitors nowdays support more than 1024x768 so if the EDID is
unknown then add resolutions upto 1920x1080.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
---
 drivers/gpu/drm/drm_probe_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index e7e1ee2aa352..5ad66ae9916e 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -517,7 +517,7 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 
 	if (count == 0 && (connector->status == connector_status_connected ||
 			   connector->status == connector_status_unknown))
-		count = drm_add_modes_noedid(connector, 1024, 768);
+		count = drm_add_modes_noedid(connector, 1920, 1080);
 	count += drm_helper_probe_add_cmdline_mode(connector);
 	if (count == 0)
 		goto prune;
-- 
2.25.1

