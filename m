Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057C4330470
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 21:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhCGUId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 15:08:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56961 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhCGUIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 15:08:22 -0500
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lIzhN-0002l6-EI
        for linux-kernel@vger.kernel.org; Sun, 07 Mar 2021 20:08:21 +0000
Received: by mail-wm1-f69.google.com with SMTP id a3so1152889wmm.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 12:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSQieJ8nQE58ekoGafigYdMDYrreYYyCtjGaEuN2LQo=;
        b=OFsWAoDFJKny0FRlak/2FVQzn2wPyzeNDtRuqNQUooMzaUqRNZG1OMHXVIQopBlYXQ
         Cx+D5r5vslCLaxmfdCgRzY9eJrofGac64VYYnM5AIBzQ6N6xR55fxO5oWW/vVXSgqZcT
         1dzVOkErXS9AGxIx3tLh+Wu9IyKqHcBBLVeOFvJ48rXbm0sclKJuR/exWt6AjXU8yH/z
         2OcQb+gdAreaU8i6+KSVpPXyL0GRZy+smdiLjt9fzL8GgUJgTUNzhURwjsQUzBbkHkHl
         oJzoRBtp17QQPhTzBfne1leAs0RlqsjB/hDHRwabBg7k0D32ItVqAJf/SX6DEG6b7JCr
         WlMA==
X-Gm-Message-State: AOAM533NiqS9v4uz5If3d5lSsg3Ce0KRr5k7eb0gXlhxG3EVouMBoKha
        X6oi1G1+cwcMvyS5HFRX7UnqnzfC9FI/JE9DMXFODUcKtnOu1jMPXV7A0934ThrX3THJyCTQ8Hs
        oDFqjzfCQrSE48wIBVWk26Y2fYKR36x8m4E1XwR3IBQ==
X-Received: by 2002:adf:e791:: with SMTP id n17mr19437523wrm.322.1615147701211;
        Sun, 07 Mar 2021 12:08:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSvNTOZIGgHUkrKnFIH0hoAo/Z5A03xBXmm0JmPTuNu4ee6LFgLxcRQ35yz+mgjO+3yTg71Q==
X-Received: by 2002:adf:e791:: with SMTP id n17mr19437513wrm.322.1615147701044;
        Sun, 07 Mar 2021 12:08:21 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id r2sm14225087wrt.8.2021.03.07.12.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 12:08:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org, Olof Johansson <olof@lixom.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: (subset) [PATCH] MAINTAINERS: use Krzysztof Kozlowski's Canonical address
Date:   Sun,  7 Mar 2021 21:08:18 +0100
Message-Id: <161514768474.92984.2303716384239569013.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210304075751.9201-1-krzysztof.kozlowski@canonical.com>
References: <20210304075751.9201-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 08:57:51 +0100, Krzysztof Kozlowski wrote:
> Since I plan to use my Canonical address for reviews and other
> maintenance activities, reflect this in MAINTAINERS to avoid any
> confusion.

Applied, thanks!

[1/1] MAINTAINERS: use Krzysztof Kozlowski's Canonical address
      commit: ca881b97dbe1ce3ed94e20ae185b246435d86ead

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
