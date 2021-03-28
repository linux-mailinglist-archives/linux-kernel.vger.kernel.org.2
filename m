Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E370034BE30
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhC1SLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 14:11:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38671 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhC1SLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 14:11:22 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lQZsf-0005wN-5S
        for linux-kernel@vger.kernel.org; Sun, 28 Mar 2021 18:11:21 +0000
Received: by mail-ed1-f71.google.com with SMTP id r19so7541198edv.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 11:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rey3AlF6bNMfZTTg+jkx/LiRPjc90KdJa4L+s9E+65I=;
        b=QDxph0gjQ5lYnUs0u1c3srNY4lQnD2PFQzgbCvohGcFehSqNMJFRyLPad4ezqBcyhh
         bzgm1eoh+ipWcIs6llY8Z8ID0QWoQcKDC0sV0NOC1ENzkroelpquqNE1fqNdg21L+Zqv
         pi+bWg8n03fvRQUf6shjuGWmDeivJ1P4zvYJzccLsAMdRThnL6qT92yK2HfObO3JaN3L
         pGYrfNVQRJg1Sfc0ZD/Vqc//3/pYvNmmZGljEZij2tczpXYyb1OSh0tx3HGy0hW0dvdg
         6sHMx5/e1atopkk3/64u/6j+MJnuz7X06g0M+9m5f4Ad1o/1RmK+ph6e/Zs0ry1qZfGT
         2xGQ==
X-Gm-Message-State: AOAM533uFOQg+jbVi3QVlXA3vIA9h7J3utrkc3jqjsAeUJXc1jbXxQRf
        A8NKN+WSdvVTeBGh/RTwVBfQuRK9haGaD62UfADrNo/8RBIeN1Lk43QaEqoIyfrO7aTtq4mfVkQ
        7cSxFEc1exH90pkwyzsv/X5VkFA2iFDbKhiVo5M3cRg==
X-Received: by 2002:a17:906:5495:: with SMTP id r21mr25458708ejo.471.1616955080888;
        Sun, 28 Mar 2021 11:11:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMqzeyTcGYaM/gLqBM9Eh62h3335SF++m0WO+Z/UFRWGHlTnAkUvRVICLPJ2uKs+ueEa0cVg==
X-Received: by 2002:a17:906:5495:: with SMTP id r21mr25458700ejo.471.1616955080791;
        Sun, 28 Mar 2021 11:11:20 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id bt14sm7670364edb.92.2021.03.28.11.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 11:11:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Timon Baetz <timon.baetz@protonmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2] ARM: dts: exynos: Add front camera support to I9100
Date:   Sun, 28 Mar 2021 20:11:16 +0200
Message-Id: <161695507016.4212.18409865650409500354.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210327200851.777327-1-timon.baetz@protonmail.com>
References: <20210327200851.777327-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Mar 2021 20:09:01 +0000, Timon Baetz wrote:
> Add node for Samsung S5K5BAF CMOS image sensor and
> enable the associated MIPI CSI-2 receiver node.

Applied, thanks!

[1/1] ARM: dts: exynos: Add front camera support to I9100
      commit: 7f4ebf3e4ce10a1ed8ff2aee5d75568dc3522b2f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
