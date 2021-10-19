Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA24331AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhJSJAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:00:38 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37068
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234519AbhJSJAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:00:36 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7A1733FFF6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634633903;
        bh=E3RamXCXwP7jsVW/jJ6Nnag1iblPhlMlnb88dq3fIKI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=kXhhU3v5oCpvB7USzPLpfTOfL4Z6IXCXivWKFa5hR/qzSIn5uzP/T1VQVRcmGIbog
         JdOmN1RTe19J9hzXEFR6M+WN2ynVDBjydZpTytdKHbYE7CDDbWVugN7R8tCXFJkYcp
         4eYe0EHp34+731qGXTihnYDz4PGh4x1EfsCFkBeq7vieNJiSbWyRkM70ARkNl0rUef
         WlTiMUlh/JRw6D5nEa2KuoPoZ/trAcaSaAn1y8eYbFH5TUnlCQBuvpvK6AC/g8DPKl
         NXdmShb6H0Y5JT/kIzJIUDKRAl+S+7Zjd3eKnOd0ohHzaNPePlEmSL1DYxOjeyKA4s
         eNnHL5cncNgxA==
Received: by mail-lj1-f199.google.com with SMTP id t7-20020a2e7807000000b00210dad8b167so619772ljc.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3RamXCXwP7jsVW/jJ6Nnag1iblPhlMlnb88dq3fIKI=;
        b=38OcOIMyPEOsBMtN0PG7K7QylE+VFxoafe23bPrrX4WzfuwxlKPzEXbEoHhUxblz0C
         T7jVXIWVB3eaxu5JD8iYfuLeigAC97J8bbuMIm9DDy1YJyCiGoBlGUQ9zbkfJe3RyLYU
         RdGscnrrZmEVHvL89Y1hsLz/07c8RE9GrpKjueb9T3oAliNQLVaqr8U9lOLfkQ/28b87
         4FbR3b/11kaYDRKEP7uIn9VUXE/XU6FFEohqlo1mtkVoFjeXl+TeMUxPecd30RVM4Dph
         UERh5fekHrq8xTEP5VsoRFA/A6/hGERAfW5/obrkqCSEXOoj6L1HaApY3c29YEICzDMB
         VVoQ==
X-Gm-Message-State: AOAM532pj7OneiShy9YMvvmNXuEVHkq0X6mBcCebz2ahJ9BOs5EvWGYZ
        egvemfGLh2vvh/norWGXdxY7vwpde5lBGUwvWa6YdPdQiR+BY6cmEtwzFamTwmhkOf/1MMl3Wy1
        9brDg/6UUbzTvIIIeOd6uBOVZ8hsC79BpsDaHE+HkCg==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr5465920ljg.158.1634633902909;
        Tue, 19 Oct 2021 01:58:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXkL9Oa/Mq5OcoNVFI8nJnyskwDrVCPs4JuPvw1CYnDmFE4T+a5DtFLuErnaFfLL3hKEIdaw==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr5465904ljg.158.1634633902777;
        Tue, 19 Oct 2021 01:58:22 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id 195sm1869142ljf.13.2021.10.19.01.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 01:58:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/3] arm64: dts: exynos: add 'chassis-type' property
Date:   Tue, 19 Oct 2021 10:58:20 +0200
Message-Id: <163463389698.22504.735636032751029230.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211017101228.19478-1-krzysztof.kozlowski@canonical.com>
References: <20211017101228.19478-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021 12:12:26 +0200, Krzysztof Kozlowski wrote:
> A new 'chassis-type' root node property has recently been approved for
> the device-tree specification.
> 
> Add this property for end-user devices (such as laptops,
> smartphones and tablets) based on Samsung Exynos ARM64 SoCs.
> 
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: exynos: add 'chassis-type' property
      commit: 4b1a78330df4742aa862468911b38c36d3edba30
[2/3] ARM: dts: exynos: add 'chassis-type' property
      commit: 2b91bd8d2bce958f75c97a9bb808a1844d2f5a53
[3/3] ARM: dts: s5pv210: add 'chassis-type' property
      commit: 7b06c1ad884ee80e43604ba2a0bbc5f8ef3524e1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
