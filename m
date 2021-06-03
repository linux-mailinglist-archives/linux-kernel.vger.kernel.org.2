Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4325F399856
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 05:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFCDCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 23:02:06 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:24146 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhFCDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 23:02:05 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.229])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 7AB3FAC038E;
        Thu,  3 Jun 2021 11:00:19 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Intel: Remove duplicate include of shim.h
Date:   Thu,  3 Jun 2021 10:59:50 +0800
Message-Id: <1622689193-29884-1-git-send-email-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUhPSlZDHU5JTx0dTUhLSExVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhg6Dgw4FD8SDRUyNTkvTh0z
        Cx4aFCpVSlVKTUlJTUNCSUlLT0JLVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTktVSkxNVUlJQllXWQgBWUFJSUlDNwY+
X-HM-Tid: 0a79cfd0859eb039kuuu7ab3fac038e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shim.h is included twice.
As shim.h is not related to later header file,
keep one which has comment and remove the former one.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 sound/soc/sof/intel/pci-tng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/intel/pci-tng.c b/sound/soc/sof/intel/pci-tng.c
index 4ee1da3..4bded66 100644
--- a/sound/soc/sof/intel/pci-tng.c
+++ b/sound/soc/sof/intel/pci-tng.c
@@ -15,7 +15,6 @@
 #include <sound/sof.h>
 #include "../ops.h"
 #include "atom.h"
-#include "shim.h"
 #include "../sof-pci-dev.h"
 #include "../sof-audio.h"
 
-- 
2.7.4

