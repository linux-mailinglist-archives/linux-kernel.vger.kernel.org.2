Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D2940C0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhIOHwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:52:24 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44934
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231621AbhIOHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:52:23 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0158940257
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631692264;
        bh=ZPPsEFlwBfA1eTgPCoHOeJvzGiA/qDxA8TsO1MrIx1M=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Vwz+q9IKMN4kFjk/Q4+bvGGw/Px279gxdBJpKpf2xeA1vB7qQsZ6YrJRMGFRU336o
         qg9LukGIxiItYRw7gyP2SEkWKj1KsDgLqFluDdBLfGPDltupiXgWYgCke2pTs4/xcX
         deSsLK26ZGa4fSu0PuxG/E2YWJ8eCWwXv468x6kTHy7Xxgk6Ct/DC/i9WLMRMH/RUH
         k9tS09TD7FVS/6+X713m012G54TBFx5hopSkQ2i/mVHxDgw23k3bf9nLcVxH6I+LA/
         00P9jbaZXJfiTP5KfVuW2SchoBBRUzmCovNj9OGqm98xbQEBTnklf++bdF1/K3YGe6
         rfG7/oF+bFIYw==
Received: by mail-ed1-f70.google.com with SMTP id y19-20020a056402441300b003cd8ce2b987so1112013eda.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPPsEFlwBfA1eTgPCoHOeJvzGiA/qDxA8TsO1MrIx1M=;
        b=v5dQH7AeK1l59pFk76CV8yo0cGq83Ls6a7bIt5cBe4z2JK9e5MP/VuqNxxEMPUbjPY
         fdi4b42blSZPVQ+BVKU5z0Zy6EcRBeJxrPXngzL0JqVzOXqdkHibhXOoZo5kUiYWcRMd
         Utw4cq8ire3PPzSXR5yM6Th0JSSV7LqyATcmL7TZk13Hj/78LFA/p5Nmb5Fm3spbPWf/
         8Xqm0gbm6nTKcy6x2O/iZTKpNQzZg62qDPH/TsoCTnKth38nU18nWMsIwTejbQ32B1WM
         qrynqpWPXYtp3/jBgogCxWhIpDYQdTQqqwAxn9rRDYB8UmjWMn4mFwyVZ4ZHpkQbLhzK
         5ehA==
X-Gm-Message-State: AOAM532Hzu0OdY2ZeT5x5uWfe9ITTEPfDjuDrCLeWmE1DD0afyyO82Gu
        0eYgMdWFcCFJlGbTYH81E5lzROqwlBHp+4ioneYg4qwuDH1/S49wvHwP8gCaI3hk2ol1VQQ4jO0
        oQa1CBu6JNJHgl8747LrtP8MJlWhXVJp54bNk6hXq0w==
X-Received: by 2002:aa7:db4d:: with SMTP id n13mr21505138edt.398.1631692263446;
        Wed, 15 Sep 2021 00:51:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+WyCHnD+lfmB0FjoPiCQDeKX4wp21vo3/85j5pwzMA7v8zxcjkjew58uNFvFPYNOOjESEbQ==
X-Received: by 2002:aa7:db4d:: with SMTP id n13mr21505124edt.398.1631692263328;
        Wed, 15 Sep 2021 00:51:03 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n11sm591922edr.51.2021.09.15.00.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 00:51:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: exynos: align operating-points table name with dtschema in Exynos5433
Date:   Wed, 15 Sep 2021 09:50:56 +0200
Message-Id: <163169222223.16372.5421804464819720795.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210820081458.83406-1-krzysztof.kozlowski@canonical.com>
References: <20210820081458.83406-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 10:14:57 +0200, Krzysztof Kozlowski wrote:
> Align the name of operating-points node to dtschema to fix warnings like:
> 
> 

Applied, thanks!

[1/2] arm64: dts: exynos: align operating-points table name with dtschema in Exynos5433
      commit: ee3b1f976c5214b79d939ecaba42f9e83b5efc86
[2/2] arm64: dts: exynos: add proper comaptible FSYS syscon in Exynos5433
      commit: 6de3cc6db06d2b9ba1e614aa58a413c9f8f22712

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
