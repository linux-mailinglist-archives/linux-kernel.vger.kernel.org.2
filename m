Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0135FD3B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhDNVXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhDNVXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:23:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6341FC061574;
        Wed, 14 Apr 2021 14:22:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w3so33621928ejc.4;
        Wed, 14 Apr 2021 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8jfAogNeKCWWv1zaa7om4rEu/mAS7YNOdM/85EuRkA=;
        b=Ap2aOflASrspeVeXAvULF6WN1yH4NdL+eDp0qD/X2fuimESfwiAimvQhAwSHbi7szR
         uZCgSMI3repBxlgBe8x8Jf6AGffcXhlpHlR6mGheX/sbBoR0EsPS73u2Z/VDFnyWL4y3
         UMGTi/U+66z2tDq8zv3g492xZguOi1bHkNnpIo9vDZnAxCvcmKADELdal1v/3gphTY8d
         jiD0iq5NGTlTAGpn31IRTyvu1y2+isNH6hcdy3yowH/0+tF/IwdA158xfmygpp2iHiSd
         GLgLltz1DD52TBcaiGVQfsRn14NI0pgX4P+dAJLIsI6rrDCg59rFqJ2obuD01II+X/7z
         syxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8jfAogNeKCWWv1zaa7om4rEu/mAS7YNOdM/85EuRkA=;
        b=EFNL9dlQjQyuwgS3LLPHyFzrMtACYchP7PTgtXgvuDsJspj30lEkWLoRqIXz51TdGD
         fxRSCuzZdhQCZMLNRU5ZLyvMeiCX32+o8XqhX99DngJJprz2ZiZY0BZ24K29AohvgZ22
         G4ykDqpgjil2yUMXSg68MFUOLrcuiHYUJfnlOoNoRm/c1tc3TpuEXK+s+diAWzJ/R9Ik
         Wm+paUOwho7EYeWnu6T467TpyuPGTP9jbI/dsTFmt+dTYyXULMsLCcvvf8QUn7wQXFOn
         6F5F31DFujhCyMtlUByQ6g1vP3PaqOOKXGoOqNWBgjfHAixCIsmK1Ez46xiFh7n2bMfQ
         9vNg==
X-Gm-Message-State: AOAM533ppVUDmdweBq1jmCpkGNvlnSlWokKRoLcjdUzuckHG0iyTJ5ny
        ODcMwJX9BE1BQlxbUQgkLeviTKWdgrsifBIn
X-Google-Smtp-Source: ABdhPJyhnIM/TVGVyeHj2rd2daFjwSwt0tqMcoJ49N04lvb8YO1MbOJ6zdT+H/+POTsRRX2cqVQI1w==
X-Received: by 2002:a17:907:3f08:: with SMTP id hq8mr116060ejc.90.1618435370199;
        Wed, 14 Apr 2021 14:22:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id t7sm586187edq.42.2021.04.14.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 14:22:49 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        adrian.hunter@intel.com, yoshihiro.shimoda.uh@renesas.com
Cc:     beanhuo@micron.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Let sanitize not retry in case of timeout/failure
Date:   Wed, 14 Apr 2021 23:22:34 +0200
Message-Id: <20210414212236.346813-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>


Bean Huo (2):
  mmc: core: Add a retries parameter to __mmc_switch function
  mmc: core: Let sanitize not retry in case of timeout/failure

 drivers/mmc/core/mmc.c     | 22 +++++++++++-----------
 drivers/mmc/core/mmc_ops.c | 11 ++++++-----
 drivers/mmc/core/mmc_ops.h |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

-- 
2.25.1

