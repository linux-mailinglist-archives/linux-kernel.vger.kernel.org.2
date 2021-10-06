Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AF44248FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 23:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhJFVg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 17:36:57 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:37792 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJFVg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 17:36:56 -0400
Received: by mail-oi1-f177.google.com with SMTP id w206so6037287oiw.4;
        Wed, 06 Oct 2021 14:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jlaMBb+PXzLm9v2gfdRM6nmNdN1Ikyp2veWkLLyMHFA=;
        b=qdte5e0sfw+3ILNtzz7ziTz+N9IyeqDrfsPZnMp7cxcWvAik6oABZ6Sh6w7Fk4dbR+
         2CILh+WxN4jo4dpqyzuAh1Ixb1l+dDNNYHmREfQCbk/NdAAopCOpSLTVw6Cl66D4vlDL
         h2Py/o7fecCbkEqU3uukdYMpUqGe0MRynTKgnS7d8bAjEZeJ/TIn7SltDf5kbDzGnQaE
         STEQPaeQ2FxR3ZMie9TmyQQNq6O5+EVW8WiBt4v+ZxdsMO++/6AcrG7nyPcCLLfnpH3Q
         bEpYkTaRQUSkxIQIa+1a3b/mkxLgEFowk7W/iHu+suugmSlnQZvji2ZdRsTyObvI3DOa
         Y59w==
X-Gm-Message-State: AOAM530neW/TcJZePK4Odu19TcijltjrWngMzonTZ87+Ao1ZlKE8yoc4
        69neMWc8emlNivYprZms/zvgLWvBUg==
X-Google-Smtp-Source: ABdhPJyJ113+jKX1dZCRWhNWr4t5PaazrGDt9LDPqVMQsBlmlHlcpVTm5Uj/fVJwTSgh7C0bxVia9Q==
X-Received: by 2002:aca:4b09:: with SMTP id y9mr3045460oia.80.1633556103835;
        Wed, 06 Oct 2021 14:35:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x34sm4377324ott.52.2021.10.06.14.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:35:03 -0700 (PDT)
Received: (nullmailer pid 2921399 invoked by uid 1000);
        Wed, 06 Oct 2021 21:35:02 -0000
Date:   Wed, 6 Oct 2021 16:35:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.15, take 3
Message-ID: <YV4WhkB4PQVMCCvu@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple more DT fixes.

Rob


The following changes since commit 55c21d57eafb7b379bb7b3e93baf9ca2695895b0:

  dt-bindings: arm: Fix Toradex compatible typo (2021-09-17 16:02:41 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.15-3

for you to fetch changes up to b2d70c0dbf2731a37d1c7bcc86ab2387954d5f56:

  dt-bindings: drm/bridge: ti-sn65dsi86: Fix reg value (2021-10-04 12:01:59 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.15, take 3:

- Add another allowed address for TI sn65dsi86

- Drop more redundant minItems/maxItems

- Fix more graph 'unevaluatedProperties' warnings in media bindings

----------------------------------------------------------------
Geert Uytterhoeven (1):
      dt-bindings: drm/bridge: ti-sn65dsi86: Fix reg value

Rob Herring (2):
      dt-bindings: media: Fix more graph 'unevaluatedProperties' related warnings
      dt-bindings: Drop more redundant 'maxItems/minItems'

 Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml | 2 --
 Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml | 2 +-
 Documentation/devicetree/bindings/media/i2c/ovti,ov5647.yaml       | 2 +-
 Documentation/devicetree/bindings/media/i2c/ovti,ov9282.yaml       | 2 +-
 Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml       | 2 +-
 Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml       | 2 +-
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml      | 4 +---
 Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml           | 1 -
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml          | 1 -
 9 files changed, 6 insertions(+), 12 deletions(-)
