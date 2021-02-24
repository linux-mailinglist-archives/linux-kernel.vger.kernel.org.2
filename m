Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB493245AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 22:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhBXVUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 16:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhBXVUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 16:20:05 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:19:25 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id h4so3922155ljl.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wS6FEYlpa8V4SEOFzYNw75kR4rI+of4Jli7dMikAW/s=;
        b=vSNWtu+hdZAgtGKmRpzoRNIgHdtE+qvx53E31I0OX56mL6IjztTv7/ajsYk4wdhrSk
         IKi9gnrqOcBV+kmvtzjxCz0Duso+Jr1r/ntqEvM/8GT0530QS9J8WGRcJ4IjI1uso5IV
         mw/Ree6XVGE5leCEI4WLeb0VivamUWvMj8O6o9hypzKRMdn6sSd7hZF4mEWFvQ9KEwCc
         CBmBSbGPpH5BPYqpNL552wH3yyj2kwPEH1DSSmCkFrxJQgi2RxmmUgp/Rq6O8D6dYRRt
         wuymtqGgsIbfW5aCyMN+KP6YeHndtmMdfLhbjE29laTRGBDX2zTVnL/IvAO9mfcwsHDw
         ZyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wS6FEYlpa8V4SEOFzYNw75kR4rI+of4Jli7dMikAW/s=;
        b=Hq+k+rWGCdTcjqFj+RQaPHomdknNWr4v2+0aGByGnYof4zQzW9gjf2SCq8P25UqE9r
         JpqcudzdzG4cxy1bsyW3//z3DbvY2KSDjS96jwy63zd0WfPCEiQI1/FfBbSKQkaLOZFi
         y6E+REptTaQaac5qaAWNaBlbEeft3hsefzo4mDGp9n/WX9/dAZrSiGT53ThLbMVCyaD5
         65uL8gNY/Zj+bw/5x8esvzNkZvTwqL8JLh1V5DGzoXvHHvZwcVfwAXH+csy/Yh+X4ci2
         X+HlsOx1RWl7pZ55zeEHCR6AoF5kTtDaxDppyONrLCzOsScaMk1mFFKEDnkCs3JNVfaH
         TrTA==
X-Gm-Message-State: AOAM530u4rsFVNkPdWJQNEs0CUzR2TkdCmgHJiSzMlHIsueKI6MRgDMD
        9LoiLq26/JW1zpWjNFK/3l4=
X-Google-Smtp-Source: ABdhPJzTH6jZIK2lpsxudYsQmD0/OWsjX2ws8hrKG2PLJX/OCQVQ9kR/mAXtyt8MnrFOQ0b2CQ5Ktg==
X-Received: by 2002:a2e:2f16:: with SMTP id v22mr20734452ljv.105.1614201563059;
        Wed, 24 Feb 2021 13:19:23 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id w26sm717116lfr.186.2021.02.24.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 13:19:22 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/4] ASoC: rt*: Constify static structs
Date:   Wed, 24 Feb 2021 22:19:14 +0100
Message-Id: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a number of static structs that are never modified in RealTek
codecs. The most important patches are the first two, which constifies
snd_soc_dai_ops and sdw_slave_ops, both which contain function pointers.
The other two patches are for good measure, since I was already touching
the code there.

When doing this, I discovered sound/soc/codecs/rt1016.c is not in a
Makefile, so there is not really any way to build it (I added locally to
the Makefile to compile-test my changes). Is this expected or an oversight?

Rikard Falkeborn (4):
  ASoC: rt*: Constify static struct sdw_slave_ops
  ASoC: rt*: Constify static struct snd_soc_dai_ops
  ASoC: rt*: Constify static struct acpi_device_id
  ASoc: rt5631: Constify static struct coeff_clk_div

 sound/soc/codecs/rt1011.c     | 2 +-
 sound/soc/codecs/rt1015.c     | 4 ++--
 sound/soc/codecs/rt1016.c     | 4 ++--
 sound/soc/codecs/rt1305.c     | 2 +-
 sound/soc/codecs/rt1308-sdw.c | 2 +-
 sound/soc/codecs/rt1308.c     | 2 +-
 sound/soc/codecs/rt5631.c     | 2 +-
 sound/soc/codecs/rt5682-sdw.c | 4 ++--
 sound/soc/codecs/rt700-sdw.c  | 2 +-
 sound/soc/codecs/rt700.c      | 2 +-
 sound/soc/codecs/rt711-sdw.c  | 2 +-
 sound/soc/codecs/rt711.c      | 2 +-
 sound/soc/codecs/rt715-sdw.c  | 2 +-
 sound/soc/codecs/rt715.c      | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.30.1

