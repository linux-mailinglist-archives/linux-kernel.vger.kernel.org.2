Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1FB412F54
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhIUHY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhIUHY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:24:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C364C061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:23:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u18so34537053wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E97PWu1QJ5hdQHmoBSfMiWuxBrgHJJjYxk0uU7J2ovA=;
        b=yQR5s4TC77kehL4CL25xRK6A5CmqCDmqjYv5vKcOB6OmYAKyKxI1JRGNxNbphDZT1F
         GrORsk46jhreY6HXTXONjFtFKTsgzfDqCMKb+5NW5sW7oX5sqk+X5d177JPd815kS/Oe
         OZXawrXYiXvOYwWTen/fQfO1oJYkzQTFeOi0vsMSFnOrBG9UXARTnK/O13B7S9EOuW78
         IoxSFnl1G1aeo5DkxIJ+e/WuVTqrfKolzZpvpB+Sbgsr3xof3VXLHVTy0QkOU8mXlnW7
         79r9/VZDuh089EymDcemhjWMISOLg94M1OnJiC0krmTBm5XNPoBNsMJaDrMh51FiXWAb
         VP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E97PWu1QJ5hdQHmoBSfMiWuxBrgHJJjYxk0uU7J2ovA=;
        b=I9LEbufIU+aF8NvINx/EYbha5+y4FmvsEuDrrEDs7Z1YvbzH7NQ6dS4jPYoNLl3/au
         Z17pRWHnpQY6amrkWVW9FKVJpvrILLkdxn9CK3EJjOYbEz1KHS26mkSLdL35lSWlhKVT
         04c3/jLjosnZl9/5QHzuDeWjRZHAGuvnXauzqXFpIX88jlWe0ZV9B7bXEh0RrF6asecQ
         NYNSTgToznpIegexpG5BvjyZNswZ7p3xqUgSjGlgS7zoRapARunFvEl22opfsG9lA+lv
         PJOHyDClM+lk84wdqdpm8SFc2gfMwdJB95VtlnKPTiGvs0HnlXQ8XS8Fhsw7ob1xiQgg
         eoIg==
X-Gm-Message-State: AOAM532xQNNjr/XVJWX1n4a9J+cmYixZ4hJ7lyhQBgnR582B1WRPtDil
        ij0ekyz+87XR0/dwhCOg+CwdxQ==
X-Google-Smtp-Source: ABdhPJyPP4WobqDOrLMj2ZP+kjgLUqYmCqgy43N+dLV6Id1U1Y3D+Xugng5+ZIAd4qHZ8jUxjMgx4g==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr33269067wrq.61.1632209008019;
        Tue, 21 Sep 2021 00:23:28 -0700 (PDT)
Received: from localhost.localdomain (i16-les01-ntr-213-44-230-108.sfr.lns.abo.bbox.fr. [213.44.230.108])
        by smtp.gmail.com with ESMTPSA id o19sm9725878wrg.60.2021.09.21.00.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:23:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCHv2 0/3] Fix the pwm regulator supply properties
Date:   Tue, 21 Sep 2021 09:23:26 +0200
Message-Id: <163220899063.36285.13600700816269701023.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210919202918.3556-1-linux.amoon@gmail.com>
References: <20210919202918.3556-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 19 Sep 2021 20:29:08 +0000, Anand Moon wrote:
> Changes PWM supply properties help fix internal link of PWM to
> main 12V supply as per the shematics.
> 
> V1: https://lkml.org/lkml/2021/6/29/288
> 
> Thanks
> -Anand
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.16/dt64)

[1/3] arm64: dts: meson-g12a: Fix the pwm regulator supply properties
      https://git.kernel.org/amlogic/c/085675117ecf5e02c4220698fd549024ec64ad2c
[2/3] arm64: dts: meson-g12b: Fix the pwm regulator supply properties
      https://git.kernel.org/amlogic/c/62183863f708c2464769e0d477c8ce9f3d326feb
[3/3] arm64: dts: meson-sm1: Fix the pwm regulator supply properties
      https://git.kernel.org/amlogic/c/0b26fa8a02c2834f1fa8a206a285b9f84c4ad764

-- 
Neil
