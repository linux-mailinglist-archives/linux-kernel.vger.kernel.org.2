Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413C2458450
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 16:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhKUPJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 10:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbhKUPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 10:09:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 07:05:59 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s13so27785890wrb.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 07:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhMbJUwa3m/sRiL1gTb1ydr+MolnUwJkremam+jJja4=;
        b=ky9HhfB4zPRUT2MnXbKup+kEwCKXxsvGrrygGL4zkh5UidAS7NSi0OJY8yc/fVZsWW
         Zk1UjB2WGE/Sfuvt/Cte2OD3KqKhaUnUGrMU+zRfMGK++0FlWdN1FIdsYMEhW4N45qe7
         6nELj29FMrBwYQ0k8NmWh2WNL5lcKkGtm+sYxwGr9IMvwN5ou8sbmbGBcXZB6hpwlyFA
         AugIqDuEJSlUGEsT+rS5Ds4qaLScsWuSLc/WtuCCc9KKeQ+87W9tWmsVWlqIm7rmug/D
         /DcgZrhA/Sg70KaS7KxzAqc1HdIN0Vsyy4bGl5djCtmJ+agJR5xHxuxhM1Z2IFetzh/F
         mOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhMbJUwa3m/sRiL1gTb1ydr+MolnUwJkremam+jJja4=;
        b=pm5iWSxWIFH9xStm3dt/bgvpSZ2XquP+EvgYec2YWYfMsmT+QaWhRL4Za6CbOvHXTe
         WeZxhh8k3nfE4Z49FvJHKJhXhTcPPKZutRUunnbMXRJqX24LMTsutk+6c7A/IfsVc0uV
         lGdLnH1r4bXP87V25ZQw21fQFTE0rlHQdnXyJEQakIy8PvykkODBliAygSGpahnefgI+
         f6KTDidq57x+OoEBSc2uCQ7CjbrrBq/dOy71U74TYcDC3cF1vmxfL760RquKIm/59uGQ
         /SEmJPdUY9e/SYLI3W9rdo+wtyvQ0CGaFbCb3WIN0nUF87uc97iyGEv3lPxh5uc8+Ldb
         iJJw==
X-Gm-Message-State: AOAM532BWWW5mbFoWukk6YohvzM3Vnuve52UtDomQhYptwuOjw9osyNQ
        jJn2H374QRoyzb7wBg3w0Uc=
X-Google-Smtp-Source: ABdhPJxsC+4TTcof9z/OHJG/6NWbE6UbhfEGg7Yh4W72/NKnNh67brFJFmEc0qg3V4uOuLuyJqjZdw==
X-Received: by 2002:a5d:648f:: with SMTP id o15mr27742341wri.381.1637507157762;
        Sun, 21 Nov 2021 07:05:57 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id j19sm6037448wra.5.2021.11.21.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 07:05:57 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] ASoC: rk817: Add module alias for rk817-codec
Date:   Sun, 21 Nov 2021 16:05:20 +0100
Message-Id: <20211121150521.159543-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without a module alias, autoloading the driver does not occurr
when it is built as a module.

By adding a module alias, the driver now probes fine automatically
and therefore analog audio output works as it should.

Fixes: 0d6a04da9b25 ("ASoC: Add Rockchip rk817 audio CODEC support")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 sound/soc/codecs/rk817_codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rk817_codec.c b/sound/soc/codecs/rk817_codec.c
index 943d7d933e81..03f24edfe4f6 100644
--- a/sound/soc/codecs/rk817_codec.c
+++ b/sound/soc/codecs/rk817_codec.c
@@ -539,3 +539,4 @@ module_platform_driver(rk817_codec_driver);
 MODULE_DESCRIPTION("ASoC RK817 codec driver");
 MODULE_AUTHOR("binyuan <kevan.lan@rock-chips.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:rk817-codec");
-- 
2.34.0

