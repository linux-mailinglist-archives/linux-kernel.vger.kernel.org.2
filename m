Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1324354140
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhDEKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhDEKta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:30 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34DCC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:49:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c6so8166064qtc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 03:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/xfBkLHIPDesOBkx+QlD07DxWxc0MVnh3m1mC0mSR3Y=;
        b=MKK2XMdH6mWhZHnqKMDfGoohDqBb6Mx97X977lVfVa4fN6XGI73bl7z1G5qDWxLoN9
         yEM8fgGTT/m0PtiLGypnmAOvB9Rl/GInEydZla0QkjwMOA98ef6KbUZ25vKe2rMBZRAc
         OGAl/YvNTvmh4PS4jaD6sddutQDYvCBf91o1bDBkPYUQ9dMlZ8CnNjWv5Psp3IayRc7h
         jfpO7my+FMFKyDNOqBc8S79PsLOHM9sq+Hu9ZgSaUsvfe17CQvEEHjWIqZE0oZwkeAiD
         B5KgHO9QuFt9GGXSKXau/aCuBReMh4PnuEP6HFeBq/CZRtzHx3FrNX36JMf11i9GCHzY
         CK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/xfBkLHIPDesOBkx+QlD07DxWxc0MVnh3m1mC0mSR3Y=;
        b=jAUwviYvPCfy2zwZkKA4LiFAh/GdTkb7JJZyoaB2kCpoGRghxtov3C1B9x+kEBasVL
         iIq92c1Wuwrm3SaHX2G03qMZzrc/taVgPGPuzSCpgtcOwG521IrEmA21jZ8PHaoUnGNq
         IXRCEOmjpN9fjGLBia2gpGVVaCLWatvOy8spCZ5E10yoJ6dfj07qJKuuKnrMpsuG3r7s
         HU2lTY6Wq/ARKIDtH+4Jh+HpbGzHpRQmLlPaJKyFIeEWiHvgr2oUjmRh1DKWS8VsDeEb
         xdVcA+w4otAcIeGm8Ag4ba7ZUYpk7ZCsuwvYiTJiRfK8+qRebNL9oIvgpPUEAnkrkaXj
         rfjQ==
X-Gm-Message-State: AOAM5307VV1cN7O0J4jHtNqFHOkZ5/+/95urnD618FEqNQcqQJOxN7bP
        tZuf3l4ZanDiAYQ52KoNrHk=
X-Google-Smtp-Source: ABdhPJyEVT4M43wiRtKkfLRWtIvLJ4irQddc5LFZ817p2Ge/KaR0wNCSgAiYdRk9GFPIEUPgsz9u2Q==
X-Received: by 2002:ac8:7b8d:: with SMTP id p13mr21872351qtu.94.1617619763927;
        Mon, 05 Apr 2021 03:49:23 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8290:6b95:72bd:5607:9b84:56df])
        by smtp.gmail.com with ESMTPSA id p66sm13349634qka.108.2021.04.05.03.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 03:49:23 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v4 0/9] w1: ds2438: adding support for calibration of current measurements
Date:   Mon,  5 Apr 2021 07:50:00 -0300
Message-Id: <20210405105009.420924-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403044821.390485-1-sampaio.ime@gmail.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches aim to make a user able to calibrate the current measurement of the DS2438. This chip uses a offset register in page1, which is added to the current register to give the user the current measurement. If this value is wrong, the user will get an offset current value, even if the current is zero, for instance. This patch gives support for reading the page1 registers (including the offset register) and for writing to the offset register. The DS2438 datasheet shows a calibration routine, and with this patch, the user can do this quickly by writing the correct value to the offset register. This patch was tested on real hardware using a power supply and an electronic load.
Please help to review this series of patches.

Best regards!
Sampaio
---
Changes in v4:
- Fixing different patches with identical subject lines as requested

Changes in v3:
- I accidentally added a wrong line that would not compile. I'm sorry. Fixed it.

Changes in v2:
- Using git send-email to send the patches
- Adding documentation as requested
- Separating the coding style changes in different patches as requested

Luiz Sampaio (9):
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixing bug that would always get page0
  w1: ds2438: adding support for reading page1
  w1: ds2438: support for writing to offset register

 Documentation/w1/slaves/w1_ds2438.rst |  19 +++-
 drivers/w1/slaves/w1_ds2438.c         | 122 ++++++++++++++++++++++----
 2 files changed, 124 insertions(+), 17 deletions(-)

-- 
2.30.1

