Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0235D40F33D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbhIQH3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbhIQH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:29:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1ABC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:27:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u18so11818070wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxTXBHJqU7RR9a49yqQjWpbG2NbNPVK/5PjCc/Yjeb8=;
        b=Qbk2KEturmAbJqgDKUYYrlSgYiyY3lGDetYhmrEK+NGbKMuJIuxfGqmYBW4w/YT/88
         ZtDCrIjDIIWXG3RoM7CBo0OB49876VpHXTTA6Ty12wDY/OhuHyLHU1lI8uvIpVLKJ06Y
         BjATW35xbrTCwHQ3ZKSyoLB/9DwY/5R0vIYYRFGw+LTTQNl3VWmP0uTxUsX6xxt2Zqp2
         DFflrYRBGLQ4GPP+ldEB+Hv5TAs9Uj7jvLMJ3zBvvO3g0eZiba48c/oMaK2h9OE5eixx
         awZhmfRJC6Mi16EWsNltIFhfsd4eOcfP1KMiB+WJ/WR5mPloUeDDcA03lDDhveExjnH2
         ZKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxTXBHJqU7RR9a49yqQjWpbG2NbNPVK/5PjCc/Yjeb8=;
        b=ykGfVJoZWqnTCs4rXhg8ugoGIaCSvyZ7gZBB3Ytv8r0OktJBiGH5gO5maUMJxLLrjU
         7/xV8XctNvJUoeMMQhiiLRsHK4ojCknm8eA9zYQglEE+Fi22eUxqFOIi64mbrgxRJAH5
         x92Pj3mWlZIquygdo99jTHaKMFGaL9RTHxbaJr145UH+vu6am8axFR8OVpzIuAP3ddyQ
         oUfT/F9S9suuZk6XtjI5nYBY7Ge99RHJr2ShpwPpmNZfWZ1lf+6scE7kZHu1USB07BsB
         OoceUD/bFiXOxenRnTvq2/PQNp5tY8QtHED0E6Fgxabg2yK2bODHbSDLjmjLqNtXcmd0
         ONIQ==
X-Gm-Message-State: AOAM533ibt3W68wkUvJGPuD6+XA/PTvPQn8Rp2Z8YJqoJ/WDuEoBbsZc
        yKdF0Mdd201NuFpel4ZqVWduFg==
X-Google-Smtp-Source: ABdhPJxkIQE8ZUfNFBVHAIoWL72FYkFUxDDXpV2GYzAp6lpUk9xvBeKN6+Jp9yTAX7/9u+HFkXAqqA==
X-Received: by 2002:adf:fd12:: with SMTP id e18mr10449923wrr.275.1631863675219;
        Fri, 17 Sep 2021 00:27:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:7c8c:5a9b:1b6e:1623])
        by smtp.gmail.com with ESMTPSA id o2sm6500714wrh.13.2021.09.17.00.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:27:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Vyacheslav Bocharov <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/4] arm64: meson: add support for JetHub D1/H1
Date:   Fri, 17 Sep 2021 09:27:52 +0200
Message-Id: <163186366690.1044811.10268335087144036716.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915085715.1134940-1-adeep@lexina.in>
References: <20210915085715.1134940-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 15 Sep 2021 11:57:11 +0300, Vyacheslav Bocharov wrote:
> Add support for new home automation devices.
> 
> JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation controller with the following features:
> - DIN Rail Mounting
> - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
> - no video out
> - 512Mb/1GB LPDDR4
> - 8/16GB eMMC flash
> - 1 x USB 2.0
> - 1 x 10/100Mbps ethernet
> - WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE 802.11a/b/g/n/ac, Bluetooth 4.2.
> - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power and Zigbee 3.0 support.
> - 2 x gpio LEDS
> - GPIO user Button
> - 1 x 1-Wire
> - 2 x RS-485
> - 4 x dry contact digital GPIO inputs
> - 3 x relay GPIO outputs
> - DC source with a voltage of 9 to 56 V / Passive POE
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.16/dt64)

[1/4] dt-bindings: arm: amlogic: add bindings for Jethub D1/H1
      https://git.kernel.org/amlogic/c/c649e25c0fcd53e0f1e83f710fefbda9d2809c32
[2/4] dt-bindings: vendor-prefixes: add jethome prefix
      https://git.kernel.org/amlogic/c/a1732cca0ed3d1ac2a256d16302c93443d636146
[3/4] arm64: dts: meson-gxl: add support for JetHub H1
      https://git.kernel.org/amlogic/c/abfaae24ecf3e7f00508b60fa05e2b6789b8f607
[4/4] arm64: dts: meson-axg: add support for JetHub D1
      https://git.kernel.org/amlogic/c/8e279fb2903990cc6296ec56b3b80b2f854b6c79

-- 
Neil
