Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA5429D13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhJLF1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhJLF13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:27:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A22C061570;
        Mon, 11 Oct 2021 22:25:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a25so60392593edx.8;
        Mon, 11 Oct 2021 22:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=L/BFIYbO9ild+/sdclH6i6ugRyUNQfFYkI/wS0E/Cc8=;
        b=eNhG/gtA1Xt93PLKEuoCEoEapdjebKmcBXGittbAYBRYk8dSXlZ5i63mg3ARmf7n2Y
         QPo066ya69sy+WqSRcvxZXM4CX4JcrtKdcoaFb0syP52x3YdP9pPmxg3EZfKxTKz9rBm
         wI4qRZyKIHfunVwIvGQwtBY2PUfEKoSmex4q36JGBX7PfhKFNDO8PAWjCDoAzgDApV/+
         2b4prU8GCkpyDZ08j7srSIor2HhTMKZaSqWABPKxSY5HoMioFM/iQ+KKWWHTUagTv64K
         NdDB0rNc7o2BvGd/UdnQacWUKHwk4h7dPIHa3bBDsT7JEu8uTFS4PVgtJ/JSeie7mdwk
         r4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L/BFIYbO9ild+/sdclH6i6ugRyUNQfFYkI/wS0E/Cc8=;
        b=AAT1Uf6STZmt1QXx5zkcOh27ieS+KiT13GaokiL8rHFkikR36cwDYgJNPj7IMeE2E7
         j34ZxXPL1/Jz924rkM7meV9n9sXNCsrkBHq7rKBd0F87OorqXS1QYamqafFSmmL5mKvh
         2oZthOeb64pLFUbwVGf3RppWzot+CMXSISW0eMW8FZ3r4u9NBcCNCR4DONGJTwsTLVj7
         72kkw3PwG1GTHYfc8z4rPdqLwPMgzBBI2VgJRuNnpbDvr6zJ8n6n1bpYIDWX2gZ0sE+b
         v54vLO+4is1YI9U8TeCajXGr8FlhXlBpKk/AnM3ykh3Zzow0JKxf4LPfu9qePaFfTege
         YB8A==
X-Gm-Message-State: AOAM530NTHW9xNJExr5iFRVFr7GZyzfzRMq0Q9c5r5dG4OmNZt09n1jm
        LDxGHnFmPrBDUfH949FYBcc=
X-Google-Smtp-Source: ABdhPJzlfMTUiBEp9/2mOFl3Z8dTSbytqPeF6uT4rKXSg8L80306OjM9HlPf+EYiNzNUmr+m9qYYaw==
X-Received: by 2002:a17:906:3192:: with SMTP id 18mr31150770ejy.246.1634016326758;
        Mon, 11 Oct 2021 22:25:26 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r22sm4323321ejd.109.2021.10.11.22.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 22:25:26 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/3] arm64: dts: meson: fixups for WeTek common dtsi
Date:   Tue, 12 Oct 2021 05:25:19 +0000
Message-Id: <20211012052522.30873-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes from work on u-boot support and following access to the original
vendor schematics, plus a minor change to use revised LED bindings.

- Mark VDDIO_AO18 always-on and link hdmi-supply to fix HDMI on boot
- Add missing GPIO binding
- Update LED bindings

Christian Hewitt (3):
  arm64: dts: meson-gxbb-wetek: fix HDMI in early boot
  arm64: dts: meson-gxbb-wetek: fix missing GPIO binding
  arm64: dts: meson-gxbb-wetek: use updated LED bindings

 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.17.1

