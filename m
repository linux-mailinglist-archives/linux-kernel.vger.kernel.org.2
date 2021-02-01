Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE2D30A760
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhBAMPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhBAMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:14:59 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E87C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 04:14:18 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q7so16291432wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 04:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZqqSEikuKoZ7t9f3u+RFTxn353pYpN9LldSfi3Rr3M=;
        b=Yw/EY5THxQYott8yUhDX9m0QAA4mX1UaLLa8cq8HCrgwIHknjmi0839RWs5hojWvfA
         ZiKXGollAHVxbrsrQDo922lKgEjEfOgNx5EnN6VW+j+jClNQfLxrsm9zIpNUlYobVJQR
         GwKhkRZpId3tVXDQJnWb3AYYU3ZMqGglq2K0fK4m1pusRffzFLte4SX/poLoTbV5xkDG
         jbTRX6pEpqBo0IpCGR9JoHS0kZ3hwRZNT7BoQODWUTwfbMoG6UKYOdYVji/DMXC0Hx9P
         gVAx/DWULDNdvshc/2FxWMtuEBUCCnJZbXb8G51Ye+/wC4+KPHXGJwKn+4E6iUfZKWb+
         SHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZqqSEikuKoZ7t9f3u+RFTxn353pYpN9LldSfi3Rr3M=;
        b=IAXnhxvrW+RFbummR7bwGekdoIFqLFQkjfbKkKbjQ8S+KsJoEkqBHOZUeF3Nf4PYBG
         vrUcSdDfUL9oUd14xiSzsyhzlOu/gN0jSB2XJdgO9hGwTzYNe0QIQIFaCzVMcVF2ECua
         L9d/uL/7VuRy00PLd88zOXxDDs/Maf/YhGIRCSpy+fbxA8mHDVmmkuEC79jdtV8czoqG
         7BEQdVObIHMVmazffNyBNGp1WbBpXchQv7lOjr/CtdRT3IazL7eeJ9oF1Fy+2vc451Rq
         kibDJb2vczByUEagdz2ek3AN4NP02YB56XwCJ8SO3emleDr9IFD++5NqrgVtHyT14xns
         E0bg==
X-Gm-Message-State: AOAM533fIoi50jE3nONccnP8SNBzYFsnYvVdkMq42sEtT1t1RdH7GDvV
        oYy+d2QJ81eYeFDkV4NODc8=
X-Google-Smtp-Source: ABdhPJzCm8JqwFovXlYiyJrS9Y8DqOHhf8sUnkwsefp/4vulBLEBvyjuiQd8jg7dMnspNvPLQVMm0g==
X-Received: by 2002:adf:8464:: with SMTP id 91mr17345253wrf.188.1612181657697;
        Mon, 01 Feb 2021 04:14:17 -0800 (PST)
Received: from localhost.localdomain (cpc141888-watf13-2-0-cust663.15-2.cable.virginm.net. [86.14.42.152])
        by smtp.googlemail.com with ESMTPSA id j13sm20698332wmi.24.2021.02.01.04.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:14:17 -0800 (PST)
From:   Bilal Wasim <bilalwasim676@gmail.com>
X-Google-Original-From: Bilal Wasim <Bilal.Wasim@imgtec.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, enric.balletbo@collabora.com,
        hsinyi@chromium.org, weiyi.lu@mediatek.com
Subject: [PATCH v2 0/3] Misc bug fixes in mtk power domain driver
Date:   Mon,  1 Feb 2021 17:14:13 +0500
Message-Id: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorrect mask for the "bus_prot_clr" field meant that imgtec
gpu power domain (mfg_async) was not powered up correctly, causing
failure in driver booting. Fixing this and also adding "domain_suuply"
capability to "mfg_async" power domain (for mt8173) as imgtec gpu
needs da9211 regulator to be enabled before enabling this subdomain.

Tested with mt8173 elm chromebook.

Bilal Wasim (3):
  soc: mediatek: pm-domains: Use correct mask for bus_prot_clr
  soc: mediatek: pm-domains: Add domain_supply cap for mfg_async PD
  arm64: dts: mediatek: mt8173: Add domain supply for mfg_async

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts  | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi     | 2 +-
 drivers/soc/mediatek/mt8173-pm-domains.h     | 1 +
 drivers/soc/mediatek/mtk-pm-domains.h        | 2 +-
 5 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.25.1

