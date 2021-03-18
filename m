Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43D340148
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhCRIwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhCRIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:51:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28273C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z2so4598497wrl.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7V2C5garI2m71wrt2YhHdPjHtF10QzZ2ukjtzqhJtw=;
        b=pCmBF+FhFFyD4T+PspGlle6dJSS7h31BQHp1wJ9yl/nSGdR0ztPjRS/k/1pA5x7V2o
         j6UMp0FV19vEG2Lfabj851R60ckWCU0v3SQHTm9kQpUtV1TnZu2Ao03TiP1GZmuNKZZu
         a8wq789h6a10FfhIXGrraVpYdNvEeuuKy6UcEmT8OZOAyPh1U37XoGM00XkEmG2xijNx
         i5lWNW+BVQko/sR0Ti/4F9VW/8v2VvJn0p2vopi+tXYIZj5tQ+sp2f6yf1HN/rseqRsG
         EV9wm0OD5QcN8W1rDECwETGPB/JTXnbYCxyIEQ7FkQf1JkOFLzyOjoC/WMbntM/leRn6
         AMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7V2C5garI2m71wrt2YhHdPjHtF10QzZ2ukjtzqhJtw=;
        b=CHY1q57VebgiHb2kBeN+B5v1U2S3OgvmvQ9sT4a8n111LatzY3D1lJOKpjiWhHnaqv
         y5g7FdRqh8b0wL20xGEqJq70Q3OFZRjDaoyhb1N+1v0kIM2qX36DF9VGOx91II4BM9rk
         5JiepbR9NFfInRqkjbRwHE5GECvuOaXKL2UBsIEU+Ws9t4OYgbRjJije5P+CCah0DE1f
         c3rUbQZ8fEEgDkVe13Ewo4g+anjO4C/rCW/RUq8a5yG6ooYEIgzbZPLHYZ/k2P95eecV
         MHPn8yc7va926jL5kxI9QgDBzaj3sCXDRQVnjtDjSg027dp0lyVla23m93IRnzHhVk/a
         4yVQ==
X-Gm-Message-State: AOAM5321SJEfTrMCKBMPiOymhPLwtF+Y2bMOOqrTq7H3kuZ+ULaAXvsB
        ZB2IRkT3pwK+1zmpUVGg4In7QTNCnMs7YQ==
X-Google-Smtp-Source: ABdhPJwW3BgHx4D4LM4CZlczeIQk3nZCyztSvU6zNU6Kr6ikEhPCKrmuiLyifn05MJIDj99gyQ+ATg==
X-Received: by 2002:adf:a703:: with SMTP id c3mr8697373wrd.72.1616057512788;
        Thu, 18 Mar 2021 01:51:52 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>,
        Colten Edwards <pje120@cs.usask.ca>, Hat Inc <alan@redhat.com>,
        Jan Harkes <jaharkes@cwi.nl>, Jaromir Koutek <miri@punknet.cz>,
        Jens Axboe <axboe@kernel.dk>,
        "L.C. Chang" <lcchang@sis.com.tw>,
        Lionel Bouton <Lionel.Bouton@inet6.fr>,
        Mark Lord <mlord@pobox.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Torben Mathiasen <torben.mathiasen@hp.com>,
        Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 00/15] [Set 2] Rid W=1 warnings from ATA
Date:   Thu, 18 Mar 2021 08:51:35 +0000
Message-Id: <20210318085150.3131936-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

This is set 2 out of 2 sets required.

Lee Jones (15):
  ata: pata_pdc202xx_old: Fix some incorrectly named functions
  ata: pata_sil680: Add some missing function parameter docs
  ata: pata_sis: Remove superfluous param description and supply another
  ata: pata_triflex: Repair some misnamed functions and fix some param
    descriptions
  ata: pata_it821x: Fix possible doc-rotted function names
  ata: pata_via: Fix a kernel-doc formatting issue
  ata: pata_piccolo: 'ata_tosh_init()' is misnamed in its header
  ata: pata_sl82c105: Fix potential doc-rot
  ata: pata_opti: Fix spelling issue of 'val' in 'opti_write_reg()'
  ata: ata_generic: Fix misspelling of 'ata_generic_init_one()'
  ata: pata_legacy: Repair a couple kernel-doc problems
  ata: pata_cs5530: Fix misspelling of 'cs5530_init_one()'s 'pdev' param
  ata: sata_mv: Fix misnaming of 'mv_bmdma_stop()'
  ata: libata-acpi: Fix function name and provide description for
    'prev_gtf'
  ata: pata_acpi: Fix some incorrect function param descriptions

 drivers/ata/ata_generic.c       | 2 +-
 drivers/ata/libata-acpi.c       | 3 ++-
 drivers/ata/pata_acpi.c         | 6 +++---
 drivers/ata/pata_cs5530.c       | 2 +-
 drivers/ata/pata_it821x.c       | 4 ++--
 drivers/ata/pata_legacy.c       | 8 ++++----
 drivers/ata/pata_opti.c         | 2 +-
 drivers/ata/pata_pdc202xx_old.c | 4 ++--
 drivers/ata/pata_piccolo.c      | 2 +-
 drivers/ata/pata_sil680.c       | 2 ++
 drivers/ata/pata_sis.c          | 2 +-
 drivers/ata/pata_sl82c105.c     | 2 +-
 drivers/ata/pata_triflex.c      | 7 +++----
 drivers/ata/pata_via.c          | 2 +-
 drivers/ata/sata_mv.c           | 2 +-
 15 files changed, 26 insertions(+), 24 deletions(-)

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Colten Edwards <pje120@cs.usask.ca>
Cc: Hat Inc <alan@redhat.com>
Cc: Jan Harkes <jaharkes@cwi.nl>
Cc: Jaromir Koutek <miri@punknet.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: "L.C. Chang" <lcchang@sis.com.tw>
Cc: linux-ide@vger.kernel.org
Cc: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Mark Lord <mlord@pobox.com>
Cc: Red Hat <alan@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>
-- 
2.27.0

