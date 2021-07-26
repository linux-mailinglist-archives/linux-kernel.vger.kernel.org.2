Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132D23D5521
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhGZHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhGZHc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:32:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E10C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:12:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k4so4745024wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZpjgjuUh1n9gqNINTk5X5U12Pvm6cJ3IqcfL4udcP8=;
        b=0YqoY1XuxJBeHq76SOvmVl4M34+V6vmKOYTZaiFZ1LUtCuSLv2DBTHcNDhlcirGVDT
         imeGRw/UCL8jse7nv/NRRhTpJdnLdL9btttorxLzuvMGnyNd9dGVMr82Fb5qn2JmskJM
         vEdTFxTvInmK0fT8VZ0VHmSurzKkgrpjhweincy2paMV87C2Y8EnaQYaVHL6BvSzWHQ/
         Me083lhJaNqeXMWC7ICJr2RYR0d7u6FIsLyM51/0lYTDp41i5czu5iTdQ8eaoJqzyahD
         jXy51AEJZmsfnMVJVdBRk7do1hm8QgAF79Q+pE7JRmRm9AZgLCEyC1llnYOW6e8e3ZXS
         UUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZpjgjuUh1n9gqNINTk5X5U12Pvm6cJ3IqcfL4udcP8=;
        b=MVdkptJBvQWChkolQOPLbbbilWpcC0/x1wD7qKl5L5X375aNkJu/ymgO/p3LugUL2K
         Y9izGXkoJV31e7CoHgaa8/huZV5LIIbrvnP8COe02DqVVnuSx9EzP46lFENNQ0EFdXyZ
         jGaaZRG6KCbuymsHKVxpJU6KEx7tN0DnGtDBv7xWqIew3XSVwJNmjQYL9u07NCzkpVMc
         EGTLHbihVh+zjU5KyLyAGqb30lUYkYA9PlzerqDzVegchuvC8owBI1rJlQOU3TIBmAao
         7oaVB25UvJZQnKPKDPnvZH0G3dLUBwoFy6EvcJnujdZHZbL6XmSuUiFPIeViEaT+rHRq
         i3DQ==
X-Gm-Message-State: AOAM532Dzf4I7VctJq5gaMFsp/KAr3u2GFmZMFVfIOm4nWj1pMJRKK66
        iq8QqXnLciLxOrCtyqxsZCd37Q==
X-Google-Smtp-Source: ABdhPJy5R+KzB21AsAQps1d0yh3y29yIpafJM2bJRYzHecWOTjx/4VnV6mymD+Jk6eIGtfKAwph5Yg==
X-Received: by 2002:a05:600c:1c86:: with SMTP id k6mr16318944wms.147.1627287172233;
        Mon, 26 Jul 2021 01:12:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:32b6:aa71:d2df:4f1d])
        by smtp.gmail.com with ESMTPSA id c15sm646762wrx.70.2021.07.26.01.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:12:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
Subject: Re: [PATCH v2 0/2] Meson8/Meson8b: sound card support
Date:   Mon, 26 Jul 2021 10:12:40 +0200
Message-Id: <162728713307.14205.17687651856471455921.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210717233030.331273-1-martin.blumenstingl@googlemail.com>
References: <20210717233030.331273-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 18 Jul 2021 01:30:28 +0200, Martin Blumenstingl wrote:
> This series adds the AIU audio controller for Meson8 and Meson8b. The
> AIU audio controller has been found to work fine with out-of-tree
> patches for HDMI audio (over I2S). SPDIF output also works (tested with
> a scope).
> Endless Mini (EC-100) has an RT5640 audio codec. The driver for this
> codec can be selected since commit 08c56cab302a05 ("ASoC: rt5640: Make
> codec selectable"), which is part of Linux 5.14-rc1. While support is
> not perfect (due to us lacking proper support for configuring
> GPIO_BSD_EN) audio output still works fine.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (for-next)

[1/2] ARM: dts: meson: Add the AIU audio controller
      https://git.kernel.org/amlogic/c/4f8ca13df1d5ff1c09e06acbd1bc7d4d8510dfc0
[2/2] ARM: dts: meson8b: ec100: wire up the RT5640 audio codec
      https://git.kernel.org/amlogic/c/0bd475db1a5d0cd89b435ff6bfee083aca5d104a

-- 
Neil
