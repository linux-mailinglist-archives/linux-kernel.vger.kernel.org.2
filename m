Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D737A6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhEKMjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:39:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51164 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhEKMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:39:06 -0400
Received: from mail-vk1-f199.google.com ([209.85.221.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgReB-0002kp-2p
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 12:37:59 +0000
Received: by mail-vk1-f199.google.com with SMTP id t23-20020ac5c9170000b02901eb5bea4eebso2396359vkl.22
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 05:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WcE5bq5wNwB/It9SUbvJNqFIhta1GVHKu5RzbulM91k=;
        b=kxc5psyBShHMeBrSIQSNALohyYm/ngzQEzGiiC4h4AAUCaaQ6ATFWViqVvblOQ4w4Q
         7poXVTb/93Vbk1z8f25tbowhkDrrn6qWurysNAkU2Fg21jW/rHgK0tBdqQGbXIKFoeg1
         987x8hiVzsVGn1vwQ59myT9BEMz6ThcHj8rGOiAUacI1gjk6qWq/A1WabENXa4cZsG0g
         fmIKe+OmooIxoLqsFSFII4fED5Z2UXvOo1G0AOZnLjTeb1I3LaRJhC21EwzqPwQJmiQo
         YNCuH/BJmR1RgfS0SR3VCduJXWwogDZuZ05cepv08qqXipN5T3gYKxBvcpetoxLg7c1y
         xVtA==
X-Gm-Message-State: AOAM5319TsVH7zU3Xlf/IpApNevISyKhoXFbHYKvjkh+xUW2WAn2U8Ll
        aCq6q46l43FvfBBAMn+DeF6gKYpHyS5C2B7lgEdALBhuBu8EW800eH+id56Br1v5mPTrXjujxZE
        XhRQm2gwzaejeQ1wWJqH7LpFKYVUi0wH6ViWx5Jnohg==
X-Received: by 2002:a05:6102:124d:: with SMTP id p13mr24169907vsg.21.1620736678127;
        Tue, 11 May 2021 05:37:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRLAGfnI9L0po9Bb5C8gz/134T5moqEUU0jXhpN/br1HUWCJqo8M1FCeaGmyr4qyowqsn1lg==
X-Received: by 2002:a05:6102:124d:: with SMTP id p13mr24169881vsg.21.1620736677988;
        Tue, 11 May 2021 05:37:57 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id c69sm823434vke.48.2021.05.11.05.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:37:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: exynos: add missing of_node_put for loop iteration
Date:   Tue, 11 May 2021 08:37:43 -0400
Message-Id: <162073661213.12308.10055643507451347667.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210425174945.164612-1-krzysztof.kozlowski@canonical.com>
References: <20210425174945.164612-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2021 19:49:45 +0200, Krzysztof Kozlowski wrote:
> Early exits from for_each_compatible_node() should decrement the
> node reference counter.  Reported by Coccinelle:
> 
>   arch/arm/mach-exynos/exynos.c:52:1-25: WARNING:
>     Function "for_each_compatible_node" should have of_node_put() before break around line 58.

Applied, thanks!

[1/1] ARM: exynos: add missing of_node_put for loop iteration
      commit: 48d551bf20858240f38a0276be3016ff379918ac

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
