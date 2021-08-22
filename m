Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584A23F4114
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhHVTLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 15:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhHVTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 15:11:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3F5C061575;
        Sun, 22 Aug 2021 12:11:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 7so13455340pfl.10;
        Sun, 22 Aug 2021 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WOhtJyCLvDyk28Uv6Zj5si2SYr4yFsA2nofOG2/o1k=;
        b=Wz0kZ27KKW6Mkr0Ljumz+UEeVmlScKBd3SqmrVBy6KUfr0wF7nyeSOKn17vo71LplZ
         oZ2FRQhL3WZekO7gvtgQDi99tK5ZmTJFqu8qfP7zzNuQVSAkx0+fxEkR//gcJ5Dh/X1r
         B6LyfFsNTSZv3XnjF0RInJ0sFom9tDOsnjcaZwD1/sKl7H70ggBXS1n/0xU9jRaJcL/j
         TzoxI0ObF11ea83IhP7yeEfwZAfd5SDKZ9WqS2w53TTFaqZqUJy2I/1aABEg7lw79ejV
         y3nfCNPkOcgLdIoeT6EmOETyueHNf5R7e29BP7/Xkw4L6HzEv4dmvvkMDtpbnv98FR4W
         VJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WOhtJyCLvDyk28Uv6Zj5si2SYr4yFsA2nofOG2/o1k=;
        b=AQeTLauzBJXzEFPDTcrThoHNIzVG5n4nSh0YP0ez6ml94DSUbVygNWkcsGE+a6IcmR
         Q1uI13VBWsO1FL5ty8TyBezOq3gGLPnh4WoClMkPdzZ3d/N1jwI5aWqYwrraVis3TI+x
         GhLU7bTo4+cQRbo/1ZmUxN4DnXNLUtErsMByHT4J//UZB1ohjR4de/Kpj8fmk6ikqOjf
         mlfktHGxAqCoEa+22dNVpFfm0TX393AGzfoppo5HCfzovAvcOi8U96ZgYmnTwx2EoJ3I
         BkddMGtC/vS70vldHN8YNAz+PF74GGc2rtOgoPvc3UKVBiT5jNVSvYHl6SmOy04MXoBj
         lwQw==
X-Gm-Message-State: AOAM533P01piTcrPfTP6WnF5YkH1qXIE8tj6mZWCZu8JSpwTwK1zu+JR
        KHwLyRbpVR4LC3Jb6oGFruM=
X-Google-Smtp-Source: ABdhPJxYC7o83eBX/pP5vI/s2sm27ag7i588rxJM1xgfgu0UDLC/aq3mqIR7U+jtN3rxmI4KNTSelA==
X-Received: by 2002:a63:dc03:: with SMTP id s3mr28947680pgg.88.1629659470822;
        Sun, 22 Aug 2021 12:11:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u9sm15542103pgp.83.2021.08.22.12.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 12:11:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 5/5] dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65
Date:   Sun, 22 Aug 2021 12:11:00 -0700
Message-Id: <20210822191100.3714613-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806204446.2981299-6-mnhagan88@gmail.com>
References: <20210806204446.2981299-1-mnhagan88@gmail.com> <20210806204446.2981299-6-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Aug 2021 21:44:36 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> Add bindings for the Meraki MX64/MX65 series.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
