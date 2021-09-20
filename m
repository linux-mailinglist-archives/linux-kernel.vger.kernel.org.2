Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17E412309
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351813AbhITSUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344224AbhITSMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:12:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34C1161245;
        Mon, 20 Sep 2021 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632158427;
        bh=j3KnQedw5EvhmvfAXTvgNcftKEVZJ9z77zCDEAAO7VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=noXG7RICwV5v52f171OCLtuWRqKN9dWMUc1N0FKrIKFqLr5DhiK4UTV9CadiPlcYk
         sCenTqprfE/yNM/1Pp8ksDjt0yc1EXrWbsJcbO91glhSGMLSZGrXlYk1a40+tqcNB/
         EDTOWxuQLgqbTRNF/z0mZpNOt6an1/Pbw6JSBt/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Lukasz Majczak <lma@semihalf.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 150/260] ASoC: Intel: Skylake: Fix passing loadable flag for module
Date:   Mon, 20 Sep 2021 18:42:48 +0200
Message-Id: <20210920163936.210641483@linuxfoundation.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920163931.123590023@linuxfoundation.org>
References: <20210920163931.123590023@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>

[ Upstream commit c5ed9c547cba1dc1238c6e8a0c290fd62ee6e127 ]

skl_get_module_info() tries to set mconfig->module->loadable before
mconfig->module has been assigned thus flag was always set to false
and driver did not try to load module binaries.

Signed-off-by: Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Tested-by: Lukasz Majczak <lma@semihalf.com>
Link: https://lore.kernel.org/r/20210818075742.1515155-7-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 7f287424af9b..439dd4ba690c 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1333,21 +1333,6 @@ static int skl_get_module_info(struct skl_dev *skl,
 		return -EIO;
 	}
 
-	list_for_each_entry(module, &skl->uuid_list, list) {
-		if (guid_equal(uuid_mod, &module->uuid)) {
-			mconfig->id.module_id = module->id;
-			if (mconfig->module)
-				mconfig->module->loadable = module->is_loadable;
-			ret = 0;
-			break;
-		}
-	}
-
-	if (ret)
-		return ret;
-
-	uuid_mod = &module->uuid;
-	ret = -EIO;
 	for (i = 0; i < skl->nr_modules; i++) {
 		skl_module = skl->modules[i];
 		uuid_tplg = &skl_module->uuid;
@@ -1357,10 +1342,18 @@ static int skl_get_module_info(struct skl_dev *skl,
 			break;
 		}
 	}
+
 	if (skl->nr_modules && ret)
 		return ret;
 
+	ret = -EIO;
 	list_for_each_entry(module, &skl->uuid_list, list) {
+		if (guid_equal(uuid_mod, &module->uuid)) {
+			mconfig->id.module_id = module->id;
+			mconfig->module->loadable = module->is_loadable;
+			ret = 0;
+		}
+
 		for (i = 0; i < MAX_IN_QUEUE; i++) {
 			pin_id = &mconfig->m_in_pin[i].id;
 			if (guid_equal(&pin_id->mod_uuid, &module->uuid))
@@ -1374,7 +1367,7 @@ static int skl_get_module_info(struct skl_dev *skl,
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int skl_populate_modules(struct skl_dev *skl)
-- 
2.30.2



