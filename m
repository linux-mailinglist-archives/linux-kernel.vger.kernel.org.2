Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1EE45A141
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhKWLYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhKWLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:24:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D004EC061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:21:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x7so16395495pjn.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/NUU473gHgJJWAHyz9icycAmdo+qfzcO9MMsTUYLCA=;
        b=Ka+/WtPAVKmsC47ebx/EttMPimSyaFaQsXvSwohDRgg53jo8emMNbvUMSjBffFZJiF
         6mmEV31XO/9nn98pDJV/kWkNmFi5luffIqiHkegaqh/MUKTubaMVlPLwa07SSu/o/XsD
         8ngdYw/RZqDR/Hmx12cSy0gEWVZ3Gd2d3Mktk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/NUU473gHgJJWAHyz9icycAmdo+qfzcO9MMsTUYLCA=;
        b=lP22COOTLRFqc/dfIA9INgijXhUZfZaaRD1eqkeN6+WGWbp5dasIGJZ/AVcd77v2N1
         nDXm904XsyuuvJB3n9vHRaG8P+YyP/aUJONK4JVIgw22X3RAWH2dLvOApTXVGebIOTQq
         ZpT+Sgq9q9epiwbVZ0KEviWHQeQ5AZ4rkEB46LZZ9Fcgl1TiZdSwmwnXzdG0gEhefYcE
         9ivXEgC5yeKMoLljE9tuOyKkLpA10E7deCeiiDAT7g4+oPXgYPrdDVRI9BdFAtXDXxLc
         D+EWrZw5rSFe48UFMntlEp660owovoCNLgsPV7J/Pw5P3ic+sHL6/J2OnJIKEbxtZ5ZH
         yVWQ==
X-Gm-Message-State: AOAM533gVKKDgKzdL7JVPcd/6tjZxF/DvsUk/cb+USL+rLMR3Q9kepzn
        /8se96Y4wOvT82eW1EJCINl+RA==
X-Google-Smtp-Source: ABdhPJzZX7TeNDOF6tm1dgQN6UgDtm8Er0h77Xe7AqW6C2wdt/CMcVsKuhDG9eZ4EtpKo4xugVw3nw==
X-Received: by 2002:a17:902:e5ce:b0:142:780:78db with SMTP id u14-20020a170902e5ce00b00142078078dbmr5853227plf.12.1637666470227;
        Tue, 23 Nov 2021 03:21:10 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:d1ae:c331:ed2a:15e9])
        by smtp.gmail.com with ESMTPSA id 63sm11093914pfz.119.2021.11.23.03.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:21:09 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        - <devicetree-spec@vger.kernel.org>, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, senozhatsky@chromium.org,
        tfiga@chromium.org
Subject: [PATCH 0/3] Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
Date:   Tue, 23 Nov 2021 19:21:01 +0800
Message-Id: <20211123112104.3530135-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default IO_TLB_SEGSIZE (128) slabs may be not enough for some use cases.
This series adds support to customize io_tlb_segsize for each
restricted-dma-pool.

Example use case:

mtk-isp drivers[1] are controlled by mtk-scp[2] and allocate memory through
mtk-scp. In order to use the noncontiguous DMA API[3], we need to use
the swiotlb pool. mtk-scp needs to allocate memory with 2560 slabs.
mtk-isp drivers also needs to allocate memory with 200+ slabs. Both are
larger than the default IO_TLB_SEGSIZE (128) slabs.

[1] (not in upstream) https://patchwork.kernel.org/project/linux-media/cover/20190611035344.29814-1-jungo.lin@mediatek.com/
[2] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/mtk_scp.c
[3] https://patchwork.kernel.org/project/linux-media/cover/20210909112430.61243-1-senozhatsky@chromium.org/

Hsin-Yi Wang (3):
  dma: swiotlb: Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
  dt-bindings: Add io-tlb-segsize property for restricted-dma-pool
  arm64: dts: mt8183: use restricted swiotlb for scp mem

 .../reserved-memory/shared-dma-pool.yaml      |  8 +++++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  4 +--
 include/linux/swiotlb.h                       |  1 +
 kernel/dma/swiotlb.c                          | 34 ++++++++++++++-----
 4 files changed, 37 insertions(+), 10 deletions(-)

-- 
2.34.0.rc2.393.gf8c9666880-goog

