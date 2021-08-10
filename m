Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E803E54B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhHJH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbhHJH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:59:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB9C061796
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:58:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g138so547342wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=az+6FbSVeQcfGxgUtfAori5lUKY+79GO47gVQy0HruY=;
        b=oHSnIxVK1R+pxluaznogtJUMVrSIlFuRXfYUMzUeGgoOkk6ypUuvTf5A2TcNYZRQKN
         mLIyMvSMRkceMA53LvBUjQepkis4FapdxtKMdlk+OanN9HdKL4K/7i6N1uhorIDv73EB
         FjBYC6a1cUgRlGQk1DPqDgdE1CNj85ArR7kppfaRSo6zPRcQnEe1MvpJcM3PtPLRy4E/
         ILQsBWfMTI9vjjb8PnMEtvl+FaqWuPNh35knUmPTiJ+vyZ+GiX8+q+dcLriIhtC/G2oK
         B1IZn+KDAmMLKMUR2zXqoe0W25tD3OI/3hnjtZPKj0lCfxdD5vBGXktUH8ojmprhqnG2
         7Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=az+6FbSVeQcfGxgUtfAori5lUKY+79GO47gVQy0HruY=;
        b=syTqyq7e/0tjQfFKqD6J2DHwF6JoeaZ1DpjrZ8aeelrltZKgq3WhYDgnvbgzYDOgYy
         Fr6FsehsWckbgUy1fFEfndpdeZ7bTHd6bwufJ8dh4T3rXP6mAwxq09aBKi5FEYU8r/9V
         092GWsoO8ttMlo0C+7uUwjWczwfnzCA+AcqLbsrvZdqtCmp67Ai7rK87CmO5tFVU4a8o
         TcWFQkQGx5SG200xKXcfQ9dOGbNxGp4IwVzmZAqtfQP8wgjfLWm/ctn4V2bkRU0fqC/Q
         4qsj0HuNzxH9ok1nJ2dRPgYGgj+4u49vPhPXCJJtYGcmxlAOApZrFNivDRPzC0klbayI
         05Hw==
X-Gm-Message-State: AOAM5336FR+y9PyF3R98/3Wc1MXUf4nE+8fP6APSZj7HPPNfFugBnxG6
        V5nNnOXAf1LLu7Tn46jNuaXvRA==
X-Google-Smtp-Source: ABdhPJz8XCNayFApSfos4bR2F31+2QXn4+nRfP5W1mwgK39NBwUs+TU0oX74xTulywVs1cp4h0Ol0w==
X-Received: by 2002:a05:600c:3b12:: with SMTP id m18mr21387489wms.143.1628582328412;
        Tue, 10 Aug 2021 00:58:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:b710:2b6e:27aa:f0a0])
        by smtp.gmail.com with ESMTPSA id d5sm22175380wre.77.2021.08.10.00.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:58:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: add audio playback to vega-s95 dtsi
Date:   Tue, 10 Aug 2021 09:58:35 +0200
Message-Id: <162858223387.1486110.6330831652699678995.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804140258.4666-1-christianshewitt@gmail.com>
References: <20210804140258.4666-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Aug 2021 14:02:58 +0000, Christian Hewitt wrote:
> Add initial support limited to HDMI i2s and SPDIF (LPCM).

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.15/dt64)

[1/1] arm64: dts: meson: add audio playback to vega-s95 dtsi
      https://git.kernel.org/amlogic/c/c6cf488e3bfdf92427686317d99e0342516753de

-- 
Neil
