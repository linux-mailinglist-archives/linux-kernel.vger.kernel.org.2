Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC43943162F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJRKfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhJRKfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:35:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8407C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:33:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t2so40492492wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=moJQ78F9oXsWwcjsOjRc3VK50C8FMLYVsh1+aqFOWVI=;
        b=SGbLdHaCHPafWnkcsKJrt8C7uSJJKjuE1s0WSZxitXueyV10vheKPI1GlKLjamhR/h
         mzJe7a7FXuugyTVhDzqGFD5GuQghM67V3ISQDyrU8nPg/cQiSrXe3J66oFyhkHih/NF0
         BdCrNdo5R+hFb42+dri9MqiCvzR/dhNPv8Q+J4EMAb8qm7RRslzt4ax60VC8rcXsi9ge
         MC/DGjcXXBt3mjSLfYrF2HDt9weYL8Rh2SeZVHeczTZ9PyR4Si7FmCJgZGUwxVUGCVe9
         nyiMg/NnHmrPgQSEx1pL2fXo2x/kqd4BbGTYkSfhDE3Sx5hBcAx/dLpadpjASFYPGjp8
         Ku5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=moJQ78F9oXsWwcjsOjRc3VK50C8FMLYVsh1+aqFOWVI=;
        b=YGqz9JKvkjVdpzvMTgSww/j4eK82UJ8X9MkvrJMoA7GVejovtmQxd/9JFjW8iggAis
         KUuT0QkliILaB0cgf57cVIH18zk+/WlAMG1rutgdK5AqNk4WSO/u2bLJyXncdz9hOrpU
         aD9sjWJOLD6u7jCtBnICHOL4X3iIy5erKl1fl1N/O2U1JsET64YAoC7MEQPTh5vPiakD
         mCNWW5DspDNQhuPg6OyVXJOonPzwRFmNLQUI0Na1NvDPmKv5IjOz0uuiu40STcNO0a0+
         aX3Q5AqbkafliKmK72Rx+Ugdr27z38Zm3h4Q5Hp1T3vzC5gJ8cHAWXMkdPc2mk0/3SP1
         fQmw==
X-Gm-Message-State: AOAM5325NKGXF34CmCHToVgHdnsXne7rYrTDFJ1OLWbZ/h229bqXCu6H
        3fbU4sJ4KP2SmuQLrN0lLeg=
X-Google-Smtp-Source: ABdhPJx+JeHhyFTrMDRiVtMFDM8Kd4upVKRwte0zT1MHPBh7pH9grloOuAgxFRGNtd41Is/2nY1F8g==
X-Received: by 2002:a5d:6888:: with SMTP id h8mr16880082wru.395.1634553212482;
        Mon, 18 Oct 2021 03:33:32 -0700 (PDT)
Received: from localhost.localdomain ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id o8sm19062252wme.38.2021.10.18.03.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 03:33:31 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     soc@kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v3 0/2] arm: ep93xx: CCF conversion
Date:   Mon, 18 Oct 2021 12:31:03 +0200
Message-Id: <20211018103105.146380-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series series of patches converts ep93xx to Common Clock Framework.

It consists of preparation patches to use clk_prepare_enable where it is
needed, instead of clk_enable used in ep93xx drivers prior to CCF and
a patch converting mach-ep93xx/clock.c to CCF.

Link: https://lore.kernel.org/patchwork/cover/1445563/
Link: https://lore.kernel.org/patchwork/patch/1435884/

v2->v3:
Rebased the series onto v5.15-rc5
v1->v2:
- added SoB

Alexander Sverdlin (1):
  ASoC: cirrus: i2s: Prepare clock before using it

Nikita Shubin (1):
  ep93xx: clock: convert in-place to COMMON_CLK

 arch/arm/Kconfig              |   2 +-
 arch/arm/mach-ep93xx/clock.c  | 975 +++++++++++++++++++---------------
 arch/arm/mach-ep93xx/core.c   |   2 +-
 arch/arm/mach-ep93xx/soc.h    |  42 +-
 sound/soc/cirrus/ep93xx-i2s.c |  12 +-
 5 files changed, 587 insertions(+), 446 deletions(-)

-- 
2.33.0

