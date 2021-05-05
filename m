Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9237358A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhEEH1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhEEH1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:27:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0131C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 00:26:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d11so635486wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sSGB223I3PeBh3TG2RAuibwn3vbLRJONtkpynCow05g=;
        b=tNBsreuCJZemMha64jCuI97TnHZ0gwzRwx0zYrIb/M9JCEXaMBrNLQ7RxmV/PmWrbY
         HJoT2YoPVdEKNxcpCrk1VeJ0q5XVpBaRl0oNSqrmPy9aJajrmXRwxzcptYXNLBL22kg4
         kCI9rkOnmAKzVCFy0DAPO33h3iH53CX7AB+litwzli2VPeHS5m1OcNMogGiPj6w022RA
         E25OcZd9zZ4KiGk25bLrmRDXKvKPpwNFRI86GPn4Ff70sJHM29lmSjg7EFFDr/Ig830k
         tsKRqgMl3nZz5hbO9EZE4zKIvHL7NXpVXpMHGPUE/vvVs2FNzPMtmZmn3ndH27pIZCXU
         81RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sSGB223I3PeBh3TG2RAuibwn3vbLRJONtkpynCow05g=;
        b=KsPuFQLKeSpy99K9UTFCYMzHMcU42DZIc+6TPdjs3CRLpuliHdaEIBDvTTJjrfiz9e
         dhTV4wP2KUqyMbpvvPZ7skaLKJwdRG64RzuxPvknmIECplT6KiyZVtyvFrVyAhu+bUlC
         lYYv9pviS3DCH6Saw4YX7sdD7B3Cczsw9vpgz7s1aSr+6EbZtsbpcMTAXYSdxRoxa7M8
         gf9nyAtKFMKwqSMuEI2rIOkjgtYB+LN8WsbpRx9UEH2FyPuUxPcRfFsDv3ZJy2PtT658
         Hcoypiccxn43Vn1ZzMVEyb2qINrXOfMNIWKwj9SFkhp5rPYMf1Ir7pMOqEbh/IhTJvjw
         t6Pg==
X-Gm-Message-State: AOAM530SoqWANqmNH9ksC3YOlSiKacNTQlrn6Y0XE6eNi7/a8wi1tHvn
        aSNqUAatZZe8uM8ujty1hQILhQ==
X-Google-Smtp-Source: ABdhPJyABkwemPMKwQp9GLUEV/VZsbakg+LdwJTV16+JOgDc0yiICSRNDSpsAxOBJf+N1wu1PvwxEA==
X-Received: by 2002:a05:6000:508:: with SMTP id a8mr18035799wrf.315.1620199572246;
        Wed, 05 May 2021 00:26:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:6eb3:66ab:cb1e:ef0])
        by smtp.gmail.com with ESMTPSA id f25sm19008991wrd.67.2021.05.05.00.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 00:26:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/2] ASoC: meson: g12a-toacodec: add support for SM1
Date:   Wed,  5 May 2021 09:26:04 +0200
Message-Id: <20210505072607.3815442-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds Amlogic SM1 support on the TOACODEC driver, first by switching
to regmap fields for some bit fields to avoid code duplication, and then by adding
the corresponding bits & struct for the SM1 changed bits.

Changes since v1 at [1]:
- switch to regmap field

[1] https://lore.kernel.org/r/20210429170147.3615883-1-narmstrong@baylibre.com

Neil Armstrong (2):
  ASoC: meson: g12a-toacodec: use regmap fields to prepare SM1 support
  ASoC: meson: g12a-toacodec: add support for SM1 TOACODEC

 sound/soc/meson/g12a-toacodec.c | 144 +++++++++++++++++++++++++++-----
 1 file changed, 125 insertions(+), 19 deletions(-)

-- 
2.25.1

