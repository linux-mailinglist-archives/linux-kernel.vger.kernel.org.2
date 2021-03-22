Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC70345152
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhCVVCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhCVVBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:01:22 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792DFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:01:21 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s2so13446749qtx.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cyat6zOR7/GgwGxSsJlE3YlCqVzoIHPgkclZ/M3Ujsc=;
        b=OL19KNMZOqZBDibR4JT79gwPRZ3wmr4w9iTZ6STjVyvB5+ZB6ClPd9/z7apeiIO5oh
         H9M62yS/k9jf8NGlfeNYvv38FZc6Zz0rgD2eVPX5mBF3mx55v1gmJG8aOykbgPrKEIJw
         kuuE/2mNM2R/mggFcdMmORN96c6V6xDFOAo6BQ+QPz4ADDIFBJSB+ju7E61D5AeZFiIG
         +lHWC1AfkaZgbjQPlGWArc0OsOTN0Yz/OoLnpiFUu87XPceHiCp497C+XV+RO4tp+W0H
         IwbSAkrKGL5+qiEsj67RGsSAvlLMGYPbTzE5lGsAiy6hWhBwX9D9m1CesUM4HM37eHQB
         Fjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cyat6zOR7/GgwGxSsJlE3YlCqVzoIHPgkclZ/M3Ujsc=;
        b=Y2+aaTHVfTpmSrPWVQs8Of8e7eM+xFua1xM1hBf2/+4TAyPqVBKkjmEiavsQmCjICO
         g7VzNOEPyw8h6NtHKZd8Duk9ELpteaewRLM37rVM1WiYjpR/P7QI+vIt2qqFjCfc1boo
         N3qDZPyU/KMbnw/vI8qygbxw/mBgLUxit5xlxn554uSqVcbimWef7jJisPqOgBNqUIEi
         hL5D4h2rU+nkhbxWGcLfoTayy25EcU7EUJLKflLGA7LAH0ZvA9l9KNfxVI10UvEOYE2+
         nl8AJ2G91d9rHJ5DQbnuRo99eHVmGhB3YmZsr8x5nnpNPL8XNI+TckzC4Z0TErsrOSoi
         V2Vw==
X-Gm-Message-State: AOAM5335OmkGDtJh9+eAZMeUsBfYeUM6PFZ94nxryZwGLU4vF18kwghf
        omAZ4l1btR6pMjMhyR4Fo1c=
X-Google-Smtp-Source: ABdhPJxrahGekLcDm3v9AKtNSRgQl4XgZUwL2ZLmS3/WFkgzkQXCsF4mAcTneGyB9nAo1AMw5SSBAg==
X-Received: by 2002:ac8:688c:: with SMTP id m12mr1775174qtq.74.1616446880803;
        Mon, 22 Mar 2021 14:01:20 -0700 (PDT)
Received: from localhost.localdomain ([138.199.10.68])
        by smtp.gmail.com with ESMTPSA id b21sm11599027qkl.14.2021.03.22.14.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 14:01:20 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        unixbhaskar@gmail.com, gustavoars@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ASoC: Intel: Fix a typo
Date:   Tue, 23 Mar 2021 02:31:05 +0530
Message-Id: <20210322210105.1575758-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/defintions/definitions/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 sound/soc/intel/skylake/skl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 857ea17e3c9f..33ed274fc0cb 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  skl.h - HD Audio skylake defintions.
+ *  skl.h - HD Audio skylake definitions.
  *
  *  Copyright (C) 2015 Intel Corp
  *  Author: Jeeja KP <jeeja.kp@intel.com>
--
2.31.0

