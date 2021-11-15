Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF662450520
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhKONQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:16:10 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47442
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231715AbhKONOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:14:35 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 74BED3F1AF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 13:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636981899;
        bh=Ek/Fldzw6HQOPZj1XYTC44c+sdFSqm7+VnT8VkD8Rfw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=drAtQ3p+a8aqyMf0Bb1S9H0Fxbf/UDGo7qxusuX8Iwjzmk3Aut48tOe6Aty2e2N6Z
         gYBNSJr47ZEhiS+V2cfb3sjU6Sl1Ab7CLztVkhzUkII7mP1m58WXA3wzUp/nwTmLGA
         FhfavO12MeAAfFub1PBmtGb2roJ8oa9X5tJTE3YMfOdn0zDfVxxF+Kn33CIo4JGKhn
         WvVJhaxDFJXHJ3k9ra5vZ9qCddVSi14tqBSmxBYN1/KP0/qOpLdhOus3NAaUCsgAQa
         x+qmuhaCxcl6REge/haKJhVxHcLx9y63MXvPC+XXGt0TF8Q2nADXgQ8oKjJXWh0eEn
         +vjXkRlmzCsNw==
Received: by mail-lj1-f197.google.com with SMTP id p21-20020a2e9ad5000000b00219ee503efeso4121760ljj.14
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ek/Fldzw6HQOPZj1XYTC44c+sdFSqm7+VnT8VkD8Rfw=;
        b=kn3Vhn+jAyBk5bjEgleWmOXZRM/ttCtBw05t8526JvJSx7LF3QsJS1C5GHMoRbCqPe
         kO2dw0hojfiZCfmEMQd2c7mgcLSWF8R1/wcBJh+nockvguzwLN5jI0qqc/p6XKSspkqH
         MsbKmarBaa/NlLExvfsTpr6AsunsD1yrmLSqz641Zp+kxVHYtvCUQtrkqV2pUzk7beok
         TlGp75h3SlAUlV7/4XastCftyLfcXy5fqzH2ng+Fvwwn8uh+RdS7dTU7QB/UYSRKISj5
         J9HBdNrXxTXsc4+bZFJ3OwqWy0f86CBFFgzsfwc85cKVewQ641soWh/FQHQaVlextH1V
         PQ0g==
X-Gm-Message-State: AOAM532t8WZNY2HPa2RwF3NjQFXWMLeivN+DA5x0jm/79piaZcNXrBV1
        rRJb5vW3GUu7W2wJ67+qNovGGq8u4jaXWYEXgfz5GkhYslrgZagpOtzOk8QMvVqsNAOxKWpO0to
        MV7nHHjpPSbcAeTvDDj3adMlmGQkAnd2PWe8BSbAjaA==
X-Received: by 2002:a2e:8143:: with SMTP id t3mr38123508ljg.18.1636981898877;
        Mon, 15 Nov 2021 05:11:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEgeHAM0nYXXWQdsOhrhSNd86XLgS1t7Bl6YTvfQwwvZk1C4SUKQ+X8kW2UH5L8O81hyXlNA==
X-Received: by 2002:a2e:8143:: with SMTP id t3mr38123497ljg.18.1636981898738;
        Mon, 15 Nov 2021 05:11:38 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p21sm1411254lfa.289.2021.11.15.05.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 05:11:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: exynos/i9100: Fix BCM4330 Bluetooth reset polarity
Date:   Mon, 15 Nov 2021 14:11:33 +0100
Message-Id: <163698188786.128367.17376497674811914207.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211031234137.87070-1-paul@crapouillou.net>
References: <20211031234137.87070-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2021 23:41:36 +0000, Paul Cercueil wrote:
> The reset GPIO was marked active-high, which is against what's specified
> in the documentation. Mark the reset GPIO as active-low. With this
> change, Bluetooth can now be used on the i9100.
> 
> 

Applied, thanks!

[1/2] ARM: dts: exynos/i9100: Fix BCM4330 Bluetooth reset polarity
      commit: 9cb6de45a006a9799ec399bce60d64b6d4fcc4af
[2/2] ARM: dts: exynos/i9100: Use interrupt for BCM4330 host wakeup
      commit: 8e14b530f8c90346eab43c7b59b03ff9fec7d171

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
