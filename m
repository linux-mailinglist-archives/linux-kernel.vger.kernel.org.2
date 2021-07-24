Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042C13D471D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 12:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhGXJxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 05:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbhGXJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 05:53:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE93C061575;
        Sat, 24 Jul 2021 03:34:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r23so1659496lji.3;
        Sat, 24 Jul 2021 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6qKlfQqH4Pff1qY3yh2+h4mSC4bChkJmId4p4BeXQU=;
        b=O6hvyvnQIiTssakclxodabsh84VNdDn9LRuunsV2DlxcfjfrE5a0C4XDVFjIOUQ2CV
         eaB1icO6o4OMnXoQ8j8f+EQIFM2T8vf4S/f/0Sj966XKDC+fv8D315AcsWcblWaZbOwi
         ZIRKKJJePG3/B/vSvOA1q2+idYwZxjqwxo1xfa4a/LPCERHcEg3jGQdIjTg7LNiSY1D3
         a6xahXn2u6LTYwKzP3/2Luq5a69Osd1FojrSm01WqlWWxPkXrYlDYFxICAzdFkUApcUJ
         N1S0WVoHxzx38vFAWUfFoFOsuCeHzEo8B/HnyyAIBvC7UuKWr7bwZSoW5XKd04dOm9ZT
         O+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6qKlfQqH4Pff1qY3yh2+h4mSC4bChkJmId4p4BeXQU=;
        b=o9LhecUhxtAyVlnIfzcpIEg7lcXBWo3laZBFURvyCi8cP09oC2+jJJ1WwRGN5cLI8M
         /RJRTqHCD7wR+gvfSHna6K7rDtAVKyy0ORXYJ/EkH6O73AfjeXTQZ98f9CXoHjgYy+d3
         EVHfHxmg92kkEfLVAaRFlV2B6jr3UDOaDY/chqxeoNi7M1qv0u4G1AnQ1vDPTFyWco8/
         TfsBdlYhokSO15O9A7QkI+HOjlGXIKvmguF7EdCzDr7TIKjTrXMMxhhmIiqHgNoenWbm
         J335VyRvXU4x4xr98XZLPGk+UkznbmYmZ5wZRK2+PpnjgYNlcwSWzh9JsjX41I6Vzvka
         OlKw==
X-Gm-Message-State: AOAM531ZPMjGrM2Vxx5ovW5lIPBFnQOkpv0Rp8dpQnzEarwVyULQ9f1R
        /dAYoSiiwHI/wExmFRnGOHc=
X-Google-Smtp-Source: ABdhPJw1DpZY1EfJig8d3cXTa8Tc9M+VIOgYNm4+S2hFK0uPqhzIBTOFv32HnDYsxMsZfB/QZql0TQ==
X-Received: by 2002:a2e:8743:: with SMTP id q3mr1517461ljj.397.1627122850546;
        Sat, 24 Jul 2021 03:34:10 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id v22sm2158938lfi.270.2021.07.24.03.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 03:34:10 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH v2 0/3] add Gopher 2b LCD panel
Date:   Sat, 24 Jul 2021 13:33:55 +0300
Message-Id: <20210724103358.1632020-1-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gopher 2b LCD panel is used in Gopher 2b handhelds.
It's simple panel with NewVision NV3047 driver,
but SPI lines are not connected.
It has no specific name, since it's unique to that handhelds.
lot name at AliExpress: 4.3 inch 40PIN TFT LCD Screen COG
NV3047 Drive IC 480(RGB)*272 No Touch 24Bit RGB Interface

In v2 removed .num_modes as noticed by Paul.

Artjom Vejsel (3):
  dt-bindings: Add QiShenglong vendor prefix
  dt-bindings: Add DT bindings for QiShenglong Gopher 2b panel
  drm/panel-simple: add Gopher 2b LCD panel

 .../bindings/display/panel/panel-simple.yaml  |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/gpu/drm/panel/panel-simple.c          | 43 +++++++++++++++++++
 3 files changed, 47 insertions(+)

--
2.32.0
