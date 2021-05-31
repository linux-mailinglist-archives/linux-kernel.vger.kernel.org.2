Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE13396658
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhEaREX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:04:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42792 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhEaP4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:56:01 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lnkF8-0001Fz-H6
        for linux-kernel@vger.kernel.org; Mon, 31 May 2021 15:54:18 +0000
Received: by mail-wr1-f72.google.com with SMTP id f22-20020a5d58f60000b029011634e39889so952374wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBsy4F7jKH3SpIbmGFnwxwge6ODZS5L/G/FMfomXAiA=;
        b=WPPV/cR5V6wVW2vmIj1kZQPptkX5rx8y5UJaGe9fo6LRO4dx1xYIApojKb4IYspD25
         d5WJtPln0H7q0LYkraHOdjSXP4wsI3MI3u0G9+OODUwneaCiKYdFwmMd6tBa+GOweMcl
         RaD0GDa/WLXpG5XS3KxGkCnismaSB19oSLdeJ/AJuCt4EnWYQZs/1DzqYv8LW2NtIOdE
         5VDll/Lxe9gA5UWfUZ7klo7K0qItSK7+KDt2GKMXqGbT1nPwjFCQl0gh91a0oTg43mnT
         C09p7ha8gT2FF4E8JQas/iPjALa8O8rBk6KWThgy2rcta0bvlr1rCtbIJ8kPaPPxhnsr
         D2eA==
X-Gm-Message-State: AOAM533/yjgpBeaJliRyeEnhqQNn0LrxgAzShWidq/TflIz4meQkWbRm
        UO2UL6zZahyURZ6ni23cADePurDs8pmrHHVb3t/IA8F50xfWGipec2MplKVNU/sXwzMsqrIVBjK
        PKyzcBN/AuWg1hk/iG4lnT1l1MlaHe1b+s3vPhMkQeQ==
X-Received: by 2002:a5d:6e04:: with SMTP id h4mr22526591wrz.256.1622476458294;
        Mon, 31 May 2021 08:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc5/XqtsAvzunerv9scOT0vi0T+fqQgLaptB/fTaUryshQ2AateJkvN0M3O1eK/oaFSwSLqg==
X-Received: by 2002:a5d:6e04:: with SMTP id h4mr22526580wrz.256.1622476458147;
        Mon, 31 May 2021 08:54:18 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id u18sm15309089wmj.15.2021.05.31.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 08:54:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: exynos: Disable unused camera input for I9100
Date:   Mon, 31 May 2021 17:54:13 +0200
Message-Id: <162247639430.59481.5717460828748837476.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210530105535.4165-1-timon.baetz@protonmail.com>
References: <20210530105535.4165-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2021 10:55:44 +0000, Timon Baetz wrote:
> As the back camera is not implemented disable the second pair of fimc
> child nodes as they are not functional. This prevents creating the
> associated /dev/videoX devices.

Applied, thanks!

[1/1] ARM: dts: exynos: Disable unused camera input for I9100
      commit: 135adbbee4c66f89b57519633cbf8c3c35b6c4da

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
