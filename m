Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA194085BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhIMHxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbhIMHxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:53:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695D1C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:52:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso732490wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cygGWb35mhwgdgwZFmfBqgzwCiy35oriwBT5rg97pAA=;
        b=l6tTu+J1gNVpjt0YJViPvIGVDUn95qrgSOmh4W1N7+QhW4URIcDvDJWy2mEYpQgOd9
         0mbo9KVsC8Xf7nahkNXqC7dMIsO5yCFYa21lJVSe0SZi9+R1fuPRV2756Uo3S/bfziqO
         RqYspYBo1cVHqFL9qKqUQQSr+fcXa4xZ9dfGCWVGF7DAZ+Tjm8bhJrWeR827nwrfKRE3
         wkha4LfSxt7VZxj5Q3JHpIq9xBytSXEVucVFRD2FDwV20n3AnJtjXVC9HXJDpzN6EIBv
         5NY2HwxRLk+GaQt4BXjxsB7Vt3f6nGmSFAK/WxxvZPvFh/XtDJgCj8SmHMzV3gGxH895
         Q2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cygGWb35mhwgdgwZFmfBqgzwCiy35oriwBT5rg97pAA=;
        b=jNAtx2sQAz4fdfg+k6iEB5bMGqxj3uUR5UZqbrBApcsJ+aoAO+HzP+mO38uaIOs/M0
         LMf+BjK0nIBUGhKa738Gcd2YAiYV6no9Wjp/BZpnGHF+nf9s8G9ZaTiCXogP3Qa+Oqfh
         gb0z+E2io3iDTbsYzBrYzngdv+nnbjLuE2peRfd+QLEnqmiF/Li4g225wMrYad/g6XtY
         MjJqjhtCZKXbiDiRnFoqRkAt1TOiSd2r1U9VTjiNVS60jAU39hjxhfL3fJVaz8qkccst
         Lbv/B9KpPBMUw7DS/isLF1gCEvrRjsGkFm9d0SJPuyvVZ9ips6EUTkuOwutl6IyJMad7
         5DAA==
X-Gm-Message-State: AOAM532+hfDo1azimDit6KOHFBt4yuJtPhm1ZFPn2yEyqJy/E+wKBr0Y
        QLljBaJPBotx6pPqBhqIIWG4w+Ip/pwFYyJx
X-Google-Smtp-Source: ABdhPJwKdlZlHEAetExFULHUEzt1uQWLZHnJMEz83ND/A7xfnHUhHR/XIKATjRnET3B9irrENuoMGA==
X-Received: by 2002:a05:600c:3656:: with SMTP id y22mr9945885wmq.58.1631519521600;
        Mon, 13 Sep 2021 00:52:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:9ebe:26f1:5acc:c894])
        by smtp.gmail.com with ESMTPSA id z19sm7137511wma.0.2021.09.13.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:52:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 0/2] arm64: dts: amlogic: add support for Radxa Zero
Date:   Mon, 13 Sep 2021 09:52:00 +0200
Message-Id: <163151951546.828361.7102466420110294894.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909102154.22710-1-christianshewitt@gmail.com>
References: <20210909102154.22710-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 9 Sep 2021 10:21:52 +0000, Christian Hewitt wrote:
> This adds support for the Radxa Zero SBC. The device-tree is loosely
> based upon existing support for SEI510 and U200 (also G12A boards)
> and has been developed with the 4/32 board configuration.
> 
> Changes since v2:
> - Add Rob's bindings ack
> - Drop interrupts from wifi node
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.16/dt64)

[1/2] dt-bindings: arm: amlogic: add support for Radxa Zero
      https://git.kernel.org/amlogic/c/663aa3b3c8a26bf449944c9385e8d04512d84ba9
[2/2] arm64: dts: amlogic: add support for Radxa Zero
      https://git.kernel.org/amlogic/c/26d1400f7457cdca3f1f86a7cccb0167f96e2edf

-- 
Neil
