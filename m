Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819723A5E02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhFNIBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhFNIBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:01:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0563CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 00:59:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m3so6314007wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5tuJ1U1oQdCxdR2Ogc8v5z1mBF2S7N+I6jU2dYfmsAs=;
        b=SFODf6ZXNO7NVTz9A/PT4aQ8DER+BqnRCMFHsjd4EcESRIwT2uBLqmree0Ng3Sa+Mn
         A6P9gtvu+DIKXWOCT4IBtl+14Eh1hli0TWsW/3qogSj661gg9Zn+GNevOeZNMfGlJGOa
         loxQflUlnoQMwnZr7DAw1gkClDh8ofpZxczDBaymOvpEt5Q0D4hDD8Ghl5Q3J9OSeVD7
         Wiej2JAvn73KytGDg3ZLDt5c75aGdAUOFu7OLo82NFhjn6nzkGpQOzBBqL5KbeeLH7Xr
         9nvCAL+0wlt9TUmF/FJMUA3LM7ie/FLZwxZYGqOrKzAKAou5SMEa7gP4oboj0LKs9EN7
         yBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tuJ1U1oQdCxdR2Ogc8v5z1mBF2S7N+I6jU2dYfmsAs=;
        b=ufJtQotxHm1f52vB9XNKGvgdYaFMF2gw1p5VWOrrKXSe4NXrPVRqZZ4K8XQmFmEW70
         5ylJwBMmERYGWMhZB7bVR/Ay6Bfex6UmcEFiJWvmKOsMz9qnubxDeygdg5oOgH9u3FWU
         30Bt7C1uDn4tHMagCkMupieS0fx2wjFov+6JdftfNM/EQ83yL39U7fqL69CYhLJKP9DQ
         jO20ks4sTrUYyKMIO5XrtV28Yo8OdjXSdWK4k1Am/UOfYVfoXksXvZrCFTRrrkUKekzS
         EOpflY3gq9yZOD7b8fwDqJNa4PdoWm7vP5A10LwjD6yLzmJWOs+hGyebAl75D5EE46a/
         jsfw==
X-Gm-Message-State: AOAM532Py54z5cn38hElqqahp95VFcOFu2YEs2hxtCezPkEz0cOBxk7D
        oDJ1aHFeEri4T9PBBZpVu4u9ig==
X-Google-Smtp-Source: ABdhPJxKRlOiE2KNA9Lj3LnL/AwzcvgTcnLne2X4hj3ipqSMjinzGRafcG66LKKN8dmGKCPQrzoxEg==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr30142407wmq.131.1623657564356;
        Mon, 14 Jun 2021 00:59:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:71f0:4862:1742:37fd])
        by smtp.gmail.com with ESMTPSA id b8sm19968466wmd.35.2021.06.14.00.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 00:59:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        martin.blumenstingl@googlemail.com, khilman@baylibre.com,
        jbrunet@baylibre.com
Cc:     tobetter@gmail.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/7] arm64: dts: meson-sm1-odroid: various fixes for C4/HC4
Date:   Mon, 14 Jun 2021 09:59:21 +0200
Message-Id: <162365755420.29993.17717376637508529981.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607065435.577334-1-narmstrong@baylibre.com>
References: <20210607065435.577334-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 7 Jun 2021 08:54:28 +0200, Neil Armstrong wrote:
> Here is a collection of fixes/small additions to Odroid-C4 & Odroid-HC4 concerning
> regulators handling, USB and SPI NOR Flash of HC4.
> 
> Changes from v1 at [1]:
> - added review tags from martin
> - removed invalid patch about hub_5v
> - added proper vcc_5v gpio control
> - removed invalid hub_5v regulator already controlled by a gpio hog
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.14/dt64)

[1/7] arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator
      https://git.kernel.org/amlogic/c/1f80a5cf74a60997b92d2cde772edec093bec4d9
[2/7] arm64: dts: meson-sm1-odroid: set tf_io regulator gpio as open source
      https://git.kernel.org/amlogic/c/7881df51368027b2d3fed3dcd43b480f45157d81
[3/7] arm64: dts: meson-sm1-odroid: add 5v regulator gpio
      https://git.kernel.org/amlogic/c/45d736ab17b44257e15e75e0dba364139fdb0983
[4/7] arm64: dts: meson-sm1-odroid-hc4: disable unused USB PHY0
      https://git.kernel.org/amlogic/c/703e84d6615a4a95fb504c8f2e4c9426b86f3930
[5/7] arm64: dts: meson-sm1-odroid-hc4: add regulators controlled by GPIOH_8
      https://git.kernel.org/amlogic/c/164147f094ec5d0fc2c2098a888f4b50cf3096a7
[6/7] arm64: dts: meson-sm1-odroid-hc4: add spifc node to ODROID-HC4
      https://git.kernel.org/amlogic/c/7178f340e9299dc886e6ddf6e938f09967902109
[7/7] arm64: dts: meson-sm1-odroid-c4: remove invalid hub_5v regulator
      https://git.kernel.org/amlogic/c/303d2af21aedeaebe824411fbff912dfcdb48de5

-- 
Neil
