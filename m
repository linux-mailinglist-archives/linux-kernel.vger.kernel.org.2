Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0C338B02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhCLLIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhCLLID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:08:03 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21198C061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z2so1542846wrl.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ekg9MII0TI+MyhMFP0/nYouVodRISvmcgxRIutfa8gw=;
        b=S26w6Y4XpmuO40c4iok/jm2VChmskuFX3ft8KufVzSVv10/YjjF320m1BW8GcV8+5s
         HbcLf88pC7E9X8msvz4FLiEhP94H51DlJEufiR+xcyEU/qCitfHPGZ9tz0uYSL6SWg04
         mI+ftjS6jzy+Q2OZNt0EVe+b+9zNapbkQ+lDOk3rUBANGv10JPKmpio0bl8HtzpVqaCV
         gWn6ja3/fItJTrpZiQKr/zbJj6rwmxGtXw4EEt+Bp3vCrI4yZOrWyhgx8rWMGo3K3/He
         DwZ8Ffezw3xexsrKz+3oSuLj1+TMR+shiUTx6OSuAmCxPGjV7t7YxrsRtxwr+GCiQGNx
         VqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ekg9MII0TI+MyhMFP0/nYouVodRISvmcgxRIutfa8gw=;
        b=Mtuk2BV7T/edrhPJXSoYloPcjDLTe5UTwYffBJ0QB0z1hMk8HJglQ3VPXu+pYhJ/l5
         D+DfUkEold8b/NZqxLwyL93sCtY75TuyxRWjMUKzNu/tJwquJgDbSjCrJXt7MdKDufut
         jpr97LDRLHF34gwtSjx6B4tFrLqyMMXLShPdPTseroRsCo51HoCGzRvwkk6G8emoP9xG
         404hJM16YBDnMkdPxQLBnhFR9LJi7tVXkRMqqJWDnxL4RSL12TWztIRjXmcY4y/sknPO
         AVme3XcS24hxpZ5CnMIcaeQwR72LphTKNs6l+HakVV/GYIMnibE+PP5YKkEH5A0ZYG8K
         Du2A==
X-Gm-Message-State: AOAM5338+3ZKHidlvQQ26Zz/5f1EEi30PxMAPSctscuttrTkVJlKHJQE
        VDXKLt4B8rvaCxvlLbOmVnFTxg==
X-Google-Smtp-Source: ABdhPJwO81VJNHlk5GNRAl6TkevpvhpdmshUt1Yx3S23LsdLEGUh7fucIUOJyYvtle51OUjy5HDxYw==
X-Received: by 2002:adf:8562:: with SMTP id 89mr13493979wrh.101.1615547281770;
        Fri, 12 Mar 2021 03:08:01 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f126sm1813003wmf.17.2021.03.12.03.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:08:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Anton Vorontsov <anton@enomsg.org>, benh@kernel.crashing.org,
        Colin Cross <ccross@android.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Josh Cartwright <joshc@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        netdev@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 00/10] Rid W=1 warnings from OF
Date:   Fri, 12 Mar 2021 11:07:48 +0000
Message-Id: <20210312110758.2220959-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (10):
  of: device: Fix function name in header and demote kernel-doc abuse
  of: dynamic: Fix incorrect parameter name and demote kernel-doc abuse
  of: platform: Demote kernel-doc abuse
  of: base: Fix some formatting issues and demote non-conformant
    kernel-doc headers
  of: property: Provide missing member description and remove excess
    param
  of: address: Demote non-conformant kernel-doc header
  of: fdt: Demote kernel-doc abuses
  of: of_net: Demote non-conforming kernel-doc header
  of: overlay: Fix function name disparity
  of: of_reserved_mem: Demote kernel-doc abuses

 drivers/of/address.c         |  2 +-
 drivers/of/base.c            | 16 ++++++++--------
 drivers/of/device.c          |  6 +++---
 drivers/of/dynamic.c         |  6 +++---
 drivers/of/fdt.c             | 19 ++++++++++---------
 drivers/of/of_net.c          |  2 +-
 drivers/of/of_reserved_mem.c |  6 +++---
 drivers/of/overlay.c         |  2 +-
 drivers/of/platform.c        |  2 +-
 drivers/of/property.c        |  2 +-
 10 files changed, 32 insertions(+), 31 deletions(-)

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: benh@kernel.crashing.org
Cc: Colin Cross <ccross@android.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Josh Cartwright <joshc@codeaurora.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: netdev@vger.kernel.org
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Tony Luck <tony.luck@intel.com>
-- 
2.27.0

