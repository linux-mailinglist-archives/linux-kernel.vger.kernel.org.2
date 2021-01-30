Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77FF3098AA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 23:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhA3Wpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 17:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3Wpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 17:45:31 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41120C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 14:44:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o7so9372890pgl.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 14:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=boqyiloEprNh8Qrr948kOJQFE8uQrpTMdyDEzc69iG4=;
        b=r4vOtqnNHsIJU7+Y8Zb0TCOlVmmLKA8CsyvN1rjmX/BHqcTDRgOZJi0gChMIdZtS1U
         th9R8qljlUH+aBJ5Q5JvR4LTDYHJGKyf7EFHZcVluyDfUWi9B1SGj7aVPNDLuSCxxX2g
         Lb+2fcBpZU/JPhBZZTur7H08/NM3ffLKhWNqGPbfGcgVIoPv+5xRwefgWXUhJ9aAeRm0
         D9V2c9gtp1WVgaSsBsOtW/VqTTBffaBqXeTCmeM94Se4092oiW6Byp3b7Givv7qH6Gfw
         nrXqMXQbZyKyNCChkt3YRnBR54nTKL5dNr70fmCGmb3OvsPFfaujDeGJi0Ii/XR0HFXf
         Se5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=boqyiloEprNh8Qrr948kOJQFE8uQrpTMdyDEzc69iG4=;
        b=jyMOCQw7ukvzcguZtPQQLjM80zL0C5r0m9Ten0TsXZiT9kSur0L69UFYjoP7gfAODb
         Qg+H8CJhxY3ByXplf4Cb4ShdS7UCOhK/CdUvu+m/UzjtLRhZXgtsBM16HICWDRUXfTeu
         JfNh40zni1yLYvIZ0o9NAp05JK5CK054IOcxwVtChVTDt0zHk7eOc6YpOzwPYyDFuo8O
         OFyQYpkk0e/ePzAgiMMlmutkeFnYNgsW6S6ezDPsYab30NMb+ODIzfzBh2iGFs3i0Xek
         rh/m8jjWgPsgpXLZLohQO66jyt+2MMqtdc9onksOzfzTwy3uQFh/7l5rGyxSVrgDPVC8
         99Hg==
X-Gm-Message-State: AOAM531aeS6t+ZHEDeRvrWVan3IPBkYX7H5gBnXrCrO7cOQOlP7mvc9c
        p/dxZA71Dy1F6j/D5yYysZ0dpdSCLr4=
X-Google-Smtp-Source: ABdhPJzHNy7XsIPlrR5wO5jc7E1umqa/1b/UhExqbBel39l1T4l6Q3P46HKbukwW3qKRCldxTtpM1A==
X-Received: by 2002:a63:7748:: with SMTP id s69mr10480105pgc.81.1612046690685;
        Sat, 30 Jan 2021 14:44:50 -0800 (PST)
Received: from localhost (g54.222-224-210.ppp.wakwak.ne.jp. [222.224.210.54])
        by smtp.gmail.com with ESMTPSA id j5sm11023218pjf.47.2021.01.30.14.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 14:44:49 -0800 (PST)
Date:   Sun, 31 Jan 2021 07:44:42 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC fixes for 5.11-rc6
Message-ID: <20210130224442.GB2002709@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull:

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 1bea2a937dadd188de70198b0cf3915e05a506e4:

  soc: litex: Properly depend on HAS_IOMEM (2021-01-30 06:36:10 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.11-rc6

Fixes include:
 * Fix config dependencies for Litex SOC driver causing issues on um

----------------------------------------------------------------
David Gow (1):
      soc: litex: Properly depend on HAS_IOMEM

 drivers/soc/litex/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-Stafford
