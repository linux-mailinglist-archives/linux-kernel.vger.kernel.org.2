Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE06423941
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbhJFH72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbhJFH71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:59:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69BC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:57:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r18so6043613wrg.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JVAazJqY2j6C23SRiyIl8fkjFsAEhY/Ou+qUctANy2w=;
        b=jPh9+P7rJ5mGCB/GLaHRVguknuxQAuj7/a31xAtXBQRhwtxM25YxgWLe1ekglP5mDO
         xmtEbYTE+KF44o1BOd8e5fBIQVGEP5KKRm2nElCWnFnv/uwlX2ztbicAd4CER5l1sTYj
         RGtVoPTme/s2Wg9HsYHCPtigA1bzrlAL8vMEZRGYs1+JTXIerwOHhyKQbfW54JRS8XfI
         MDEXx09vJGP5S7wdLqI2mtqofl08OO2+MaUoVr9YbBJXrbpk++GxYadL3jU+FbXG52Fw
         AqHPyEIlZVotUUqJe6GMpVC8JiTUuTBlNtymQ+k+UR+n4p816zfWI0f01NgNj0k1/znF
         ycIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JVAazJqY2j6C23SRiyIl8fkjFsAEhY/Ou+qUctANy2w=;
        b=gsLNbTzI57KH5tHKh3EJ+PnpC4W2OEnO9mJ4PanHoAeCtQnl/Z8KG65ZU4rUkAVMhA
         Xe8KEtJan6ZRP8tGNyO0Ij2oBcVZ95QD9dWBzLZnb9K1O6qB64dOCStA/owWt37DGpAS
         +kjmBj0Ku2y72MZTb+asftd3jfpO+I9PRCM6bLdZ3vBhIHNH+MYeNA1jan4kRdCFwV/J
         Cq5CwiTZBOMRW7g0dse0rf4cVKJqDZPk3CONJXgkJD4Yyk1wyC+6q88tgL/hKTwMNq9d
         2gIi6lqxS91Qm+vE974dtbTilpaRvb0RaD1Fy9E8TArWPDh6TXwTS7Djh/g4LME5otg7
         lS5Q==
X-Gm-Message-State: AOAM531wBPu9cacpasFYfpuALilQDiNh3lheIl2uyruBOH34PKJ7lJJf
        x05vcUiolzk6VOwsmW3NPkYZww==
X-Google-Smtp-Source: ABdhPJzVintMhbOjOX4vU9u706e6ERsN98uwBH4sqtuveE2LV3oM9iqndrWwYO10XpgMTfh8hM3e3A==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr8392075wmq.122.1633507053777;
        Wed, 06 Oct 2021 00:57:33 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id i3sm4337099wrn.34.2021.10.06.00.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 00:57:33 -0700 (PDT)
Date:   Wed, 6 Oct 2021 08:57:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, Misc and Regulator due for
 the v5.16 merge window
Message-ID: <YV1W6z2U6VKYckgY@google.com>
References: <b6102d6db357ebb5c937f460a564c6f26281e403.1631709890.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6102d6db357ebb5c937f460a564c6f26281e403.1631709890.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-misc-regulator-v5.16

for you to fetch changes up to e68ce0faf29c7c268666e11e95bf27dca97d28b0:

  mfd: hi6421-spmi-pmic: Cleanup drvdata to only include regmap (2021-10-05 08:56:08 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Misc and Regulator due for the v5.16 merge window

----------------------------------------------------------------
Mauro Carvalho Chehab (1):
      mfd: hi6421-spmi-pmic: Cleanup drvdata to only include regmap

 drivers/mfd/hi6421-spmi-pmic.c           | 16 +++++-----------
 drivers/misc/hi6421v600-irq.c            |  9 ++++-----
 drivers/regulator/hi6421v600-regulator.c | 10 +++++-----
 include/linux/mfd/hi6421-spmi-pmic.h     | 25 -------------------------
 4 files changed, 14 insertions(+), 46 deletions(-)
 delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
