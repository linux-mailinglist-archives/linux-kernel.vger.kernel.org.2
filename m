Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99ED42405C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbhJFOte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhJFOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:49:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B172C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:47:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t8so9726220wri.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FpGN9kOnJDi4bp4uH5MAgsQolt/ldvbDekvSmaP94dE=;
        b=Mi9A2NZ+LuU3hc+WHO+nWwbCCMoGn1iqQHKKrj615QeInC+RXI4+W6Pice+k/YYiyb
         hF6qn5Bj7NotIfpnSETqi2f1AHO44FkLkIzbXbr6Lvg76eAYzh2RRJw9LiZzzmYvtXJ9
         XOFCuStM50CbWYUh2fuazIwZYJWy3lF+1X504Y2PPwLebgiNhZaprEpDONay7ctCr+WE
         pl1VaUYcUbe1Uy44i5gDaLI/hm9RznkwtqUe0+bCam5SCx4qIuPzbrpKeltBncGpLSKX
         Ci+Iv3ZKzvvKEFbt7YLVqt/kv+cl8mp10J0A1i2HNDh8PDKS5OxUrWhTN2EsVoFhoy4Y
         Umwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FpGN9kOnJDi4bp4uH5MAgsQolt/ldvbDekvSmaP94dE=;
        b=6r03+JjJFYtPl3IVJwm2ZJkqpQpMIUBKgCfiXdFAyTNrerifhtFXC13nGf4/bGUqrY
         d+Ew6RoPrCXAWP+nTXSBOzU2YA1By7JpFhNLHU1nWHuzqsUjyG5epsN0mc9gkzdsk7/B
         exq93JR9PCFilKRUXQo7If7PVblX+S1JfBbAzsmFCvwSSxt95hheKInZ54gSrx8PPUZM
         IAY8d75YY+bK4+gTaaT3rOMa7d/3L2ra2ckLsz3KLv65QE1k0WdIzazchqS0hCRPwMMY
         qLYGA0mqrgRVxsZkIAuHHnuhWPhU9GWefvcOWo+mWTl42LnZXv3Ozy/k+5fdhAx9/wyz
         AjAQ==
X-Gm-Message-State: AOAM530geTUloZl9yJsdFmjiLypWkF3awvyeKxi7kgz+XUqaPrlntdho
        5JbtUzlFxaOm04acyuVq76zPTg==
X-Google-Smtp-Source: ABdhPJyeHrDDQgenzhAuHAUV4nS23JYHsmGLVxw16NOxvPwq3/eVmNYWzgaxbld5EY9q4lvhI3BSIw==
X-Received: by 2002:a05:600c:489a:: with SMTP id j26mr10376642wmp.111.1633531659746;
        Wed, 06 Oct 2021 07:47:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z18sm14589340wro.25.2021.10.06.07.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:47:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, qiangqing.zhang@nxp.com,
        linux-imx@nxp.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] nvmem: Add cell post processing support
Date:   Wed,  6 Oct 2021 15:47:26 +0100
Message-Id: <20211006144729.15268-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set aims at providing nvmem cell post processing support.
cell post processing is required on some provider drivers as the data
is stored in encoded format that is not what consumer drivers are expecting, 
example mac-address is stored in ascii or with delimiter or in reverse order.

This is much specific to vendor, this patchset would allow nvmem provider
drivers to post-process this before consumers sees the data.

First patch is to rework nvmem cell instance creation, which will help in
creating nvmem cell instances dynamically and associate a name with it.

Next to patches are adding post-processing callback and using it in imx driver.

thanks,
srini

Srinivas Kandagatla (3):
  nvmem: core: rework nvmem cell instance creation
  nvmem: core: add nvmem cell post processing callback
  nvmem: imx-ocotp: add support for post processing

 drivers/nvmem/core.c           | 149 ++++++++++++++++++++++-----------
 drivers/nvmem/imx-ocotp.c      |  25 ++++++
 include/linux/nvmem-provider.h |   5 ++
 3 files changed, 132 insertions(+), 47 deletions(-)

-- 
2.21.0

