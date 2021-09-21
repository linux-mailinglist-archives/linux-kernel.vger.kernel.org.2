Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C95F412F58
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhIUH0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhIUH0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:26:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100EEC061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:24:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d6so36127912wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFVNYM+8ZfBcQi6We1JLgvzVyTGB859WPsLGFEWujhc=;
        b=jYDszma0h/FXRO3om+lag8wn0XZPmRIsfwEhryXv7H/Haj1FaIRANAg/Hp0Z+3xzDQ
         YOLS9eatkHylygVxrY7zlmHZz3cEabPOzh7eGxLOGYMb+DIcEZhpbr/k5w8F03CpTo2p
         hAzc2gBlWuuIvg+/uR3kjc0YYnsIgqP62FteqZRQK72Tev9lqX+Ffda1cQY2xwySLLf8
         oND5XBT1AE8Oh2av5sc8tG9OqCN6ycXMNNUYSxjo/Lh+VN6dpnOksHH5CxGj7MgXZfBq
         1BsgBtHkahLvMJtdY9cGBkWuftposvfbpfWhwYiBy0YA2977T2Vtolu1SyqTxDoFhpAk
         w4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFVNYM+8ZfBcQi6We1JLgvzVyTGB859WPsLGFEWujhc=;
        b=KZjtHEIT4XSmvrKtzEegiV7IdyMsXEWYv8Hd+/ZQ9idlgL9VSX59VqbWQZQPUdZMn/
         NBVW3p0o3WHkg7xo9Bg+lTS9/6B9aBA39rlYXFU64NNkzuIk+Qj4QuL+D1iM6pz83/jA
         xRbXzsG4HtMzDtLY8WnTj+kTgs+xyGmb+gn9AtqJGUxIU1tVK1qOox/uPHq4kW7g1Lza
         cULkH37iZeJ0crYIwVStjM1xM9vdubwcmRH9/36twIMP1YWBUa3+QW/08UdVzCK7Kr6d
         YmC2iz8FU3u1fD3ZwCZUfTf8fHbVCq0y4+eSCi84njmwW8js1uzirpLpQhJjTWO0c0+H
         pS9A==
X-Gm-Message-State: AOAM533z4iLylI10GKu4aynAcOxBMsZCGtW7tOGy3HZSUWd9aMdCmGE6
        COTQEseWtbTc0U5M/nXCa13obwNvGv278Qhj
X-Google-Smtp-Source: ABdhPJxE8aa5yw5kwtoTkIsHabvAITZpO/4otjBhwLWa7UZ7fgQmgf44/eHeAOMVdJugB44yVqeEmA==
X-Received: by 2002:a05:600c:d3:: with SMTP id u19mr2954065wmm.142.1632209089293;
        Tue, 21 Sep 2021 00:24:49 -0700 (PDT)
Received: from localhost.localdomain (i16-les01-ntr-213-44-230-108.sfr.lns.abo.bbox.fr. [213.44.230.108])
        by smtp.gmail.com with ESMTPSA id b188sm1878316wmd.39.2021.09.21.00.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:24:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anand Moon <linux.amoon@gmail.com>,
        linux-amlogic@lists.infradead.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [Patchv2] arm64: dts: meson-g12b-odroid-n2: add 5v regulator gpio
Date:   Tue, 21 Sep 2021 09:24:47 +0200
Message-Id: <163220908180.41173.4926821171736077752.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920204739.950-1-linux.amoon@gmail.com>
References: <20210920204739.950-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Sep 2021 20:47:37 +0000, Anand Moon wrote:
> As described in the Odroid-n2 & Odroid-n2-plus schematics,
> the 5V regulator is controlled by GPIOH_8 and in Open Drain
> since this GPIO doesn't support Push-Pull.
> 
> Fixes: c35f6dc5c377 ("arm64: dts: meson: Add minimal support for Odroid-N2")
> Fixes: ef599f5f3e10 ("arm64: dts: meson: convert ODROID-N2 to dtsi")

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.16/dt64)

[1/1] arm64: dts: meson-g12b-odroid-n2: add 5v regulator gpio
      https://git.kernel.org/amlogic/c/ecff7bab5c9c2e2b6f5739b328347e08415879ec

-- 
Neil
