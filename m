Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFBC3F5670
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 05:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhHXDHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 23:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbhHXDBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 23:01:17 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA57C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 20:00:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 22so21627162qkg.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 20:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgCyH+gJ9RXo5Eggw+y253SR+mBguM7vqFNUFDvY1Pw=;
        b=c5X594Q+Cc494R/qbqWEZ2pGSYL/SCeR0j795SIsoU/2fePpPAy4rzYYLXwLU32hf5
         l6Cf7ZMCl1WOu/falJjHaewc8k48gGxiMJT9eIpk26pxs4l0lJTob80uNA0FycEvuETr
         GZbK1/jGWqLJteqlSDjCNz+rw88A41i3ZLwOAWU1TQE1jkuSblnLkS4jXqujowUjBLpA
         u6zrcZMT8dE2ajJ2YZeHaT/WZRvGHMHUETdbNtATV7Y4J5cEq/b8PeQwGH1L5irGjXH6
         otAv5AClBVpLqoY1oFYYNw+V3Hh8NLJOPOrNzEboN3Zb/qYJ40eeh3/zZuJuaQznlSV+
         VAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgCyH+gJ9RXo5Eggw+y253SR+mBguM7vqFNUFDvY1Pw=;
        b=cf9w1xt2pY/y5SJa4d82MCwJM/rHoKUfX8xqqfChCHadWyBQ9drG15welJuhD0rCKe
         I5NNsdF/KTY8yqosTLrT6wyvwhzDtWzl2jOIf0bJcDJ3bOtbZUUy13U5B8sauHwvYFsH
         EOZb8Zad3+CFhyGN0IxHy4loZ/qd+45h3SWmgqsSGwuqqVvdVtadfznx6uk/lBo7vufY
         ZloE4niK8Euf935xA8sQIJYcIHEzk1P9OPa1NXL1YPNn/rCRx/obAvnu95bz0b2CqnlZ
         0LFHB/SE1zYxudmYVRGNULCqDuDfFzdkJiamg0KqCDAgcsDBsacNGXrqIpmSpczg2qQ4
         tvbA==
X-Gm-Message-State: AOAM531CqlewygIgih44TPp5YGA2w8dkQLiJ9vuYaCiGXjwZXdaZ8LyZ
        VYTrh1HXchh85B6xz2zgKSY=
X-Google-Smtp-Source: ABdhPJxDkRdqMNWpFkyuC+eJOdt2zLovNXHNNe/fb4Kn7yt8NpMZ+7H++qiW7zqlRauVQ+0edHLexw==
X-Received: by 2002:a05:620a:648:: with SMTP id a8mr2324414qka.272.1629774030591;
        Mon, 23 Aug 2021 20:00:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d20sm7459876qtw.53.2021.08.23.20.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 20:00:30 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bard Liao <bard.liao@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: SOF: intel: remove duplicate include
Date:   Mon, 23 Aug 2021 20:00:15 -0700
Message-Id: <20210824030015.57267-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Clean up the following includecheck warning:

./sound/soc/sof/intel/pci-tng.c: shim.h is included more than once.

No functional change.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
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
1.8.3.1


