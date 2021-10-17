Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCCD430A12
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbhJQPdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbhJQPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:33:30 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70658C061768
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:20 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id e63so20910404oif.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xNI/fqSmWltjImZA+3I0T0IoPCdlprAOazFOStLyFNQ=;
        b=eIn3KPrwMzRcAEhVrvpaCX1sK1rURrMUuzGw6u8KDZb5pOCqybeVIJ42eNZB16MjyW
         IxZyo3C8K90IlNMJOvlGDMAcNpMLT3h3RJNxQob9SBC0ltatbxZQ1E0wTXYfwhQzs+xS
         GXEILVFfC0jkbU1LqQc2StSicMpc2G61bgO2IymliMOs/rTTI1nnMcfmnqKjK0NP699A
         /8eNlf1lg/Bqev+nMmKar8bOC+JdloqAIDTfYQDF+LNCeCOzayh9O/n4GOc2Pths/9My
         762onKZvrtqjXDETlJHmOYt/JIJnx//tE+IizCVPwvSAzYXy0ikDlTXWsehIKk1hOgQm
         YLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xNI/fqSmWltjImZA+3I0T0IoPCdlprAOazFOStLyFNQ=;
        b=vn4kLoPqsqKBM0JWwGgFDpAKUP+pvZUY5ByXtAUf4JI+CI2QBtAc3ZKxK+qwd1Gy/S
         OeFmYWBX8OJwKEfe8g360fm3AYkI8y2wM1j9VCvDLDzG3Jr0ljQxu/mV8pHhwFXKX4+B
         qZ+yzMvU7wKkwxR0FCnjedw5wqwgutCBKm0VN5nT292yeXclOf9jUU4GhfpTZRba8jMH
         r9iYHj7cwwN479Ug5n45tk7WhHbCRbaYvBwwQlSbXNJy/6imqpUwfWTXoc2QLfxY/aES
         zuaVS23uMrSJCSak+Su2Le+9WgotXVveN8IKC/axTRUQyUSdt3NO0TVaOoD5loY2jIDj
         Es3A==
X-Gm-Message-State: AOAM530NUS368IyH3umESHZk1zQppCKSqwktruIIZDZwtSWkOqnqZ7Lc
        fS4QsR4wpR1b5E89R3+teWK9AIRCVi4SXA==
X-Google-Smtp-Source: ABdhPJwVxS/MjPNX0T0Nx9Mr6ypflotXnob3w24BwfCxT2HW++E7bsXZHzZF9vRr299QYpi1mB+1oQ==
X-Received: by 2002:a54:4f8f:: with SMTP id g15mr15986476oiy.169.1634484679542;
        Sun, 17 Oct 2021 08:31:19 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x6sm2565698otp.49.2021.10.17.08.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:31:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Shunqian Zheng <zhengsq@rock-chips.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Guido Gunther <agx@sigxcpu.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Dan Johansen <strit@manjaro.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-rockchip@lists.infradead.org, Lucas Stach <dev@lynxeye.de>,
        Simon South <simon@simonsouth.net>,
        Fabio Estevam <festevam@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Brian Norris <briannorris@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Angus Ainslie <angus@akkea.ca>,
        Rob Herring <robh+dt@kernel.org>,
        Eddie Cai <eddie.cai.linux@gmail.com>
Subject: Re: (subset) [PATCH 3/4] arm64: dts: qcom: add 'chassis-type' property
Date:   Sun, 17 Oct 2021 10:31:04 -0500
Message-Id: <163448466184.410927.10597282951257964258.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211016102025.23346-4-arnaud.ferraris@collabora.com>
References: <20211016102025.23346-1-arnaud.ferraris@collabora.com> <20211016102025.23346-4-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2021 12:20:24 +0200, Arnaud Ferraris wrote:
> A new 'chassis-type' root node property has recently been approved for
> the device-tree specification, in order to provide a simple way for
> userspace to detect the device form factor and adjust their behavior
> accordingly.
> 
> This patch fills in this property for end-user devices (such as laptops,
> smartphones and tablets) based on Qualcomm ARM64 processors.
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: add 'chassis-type' property
      commit: eaa744b1c101a33fba5978866defc8a7e87f8d79

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
