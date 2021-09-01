Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BD13FDEB2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343713AbhIAPcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244434AbhIAPcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:32:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C63C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:31:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n27so7558828eja.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dsuhvXX76hOQeJoPDJljlY+ezW6yiXQY+zesm9qzvQs=;
        b=jyVO5OvKrLrerLgG+AMJkCrN67BjtvT7Aoi0OjBblnbirfwF5iV5c4PUfYrKqtgEgu
         n1QgSOJovoFKjR+/km7ubUgfjbZXXfYj8b/z2hXt8fNra0JPuhTsewXkJ8M9E3GN5CK4
         kZfa53Eys8voleaFMBuLQq24RO2V4rT2YNNQmoDDi1vdvX6HwSHJkl+//+b00SpuVBxo
         Wfr8/ipeOP8N8GlUIylYt2oi3NgO5zvpVP22ZxEP279Ej6JN3jniGVrRIYQnzjWwzLEN
         WzmLciSv/eBvrAQX3Mw3Ckycq2k/kv23g0u3uNiyRR51BTQ5pBqrDTqbHuzEDYOxvtkh
         6UoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dsuhvXX76hOQeJoPDJljlY+ezW6yiXQY+zesm9qzvQs=;
        b=ZyV23wdhtAUTLtSlv9oNzfiONm3hrEBVropDPAIRx2zHhm6r1eiaY5sJgXrfiDm0lJ
         MJt4pVRvfZdJk2ON/wMiLuCG3EiAD4xUvyc59yXPTXhuwt+rP/8HnLOn6rsicQ7Jo2wg
         pE9DOtFmsQR2IHNz6aW8buuKeDA5lOyp8Odq58QuUkvrQl1kjIA93VqcwkBuq7vHFvyq
         bVwhJR7jNTe4DoadrZ9HEAomLuMO8zMk6SB8LL3EEaVYv/cB0ih1v2hWGRt8kk2zMz51
         6YeQ5st4gQ2Ua9+3byDJZqvFZyCcWpyu/lD2SyHlpFmfMBwBVa5MWo26bOCsoV0ZDh31
         h1Vg==
X-Gm-Message-State: AOAM532ve0gM8v9LGbBqWH57n4Ri8Z0l6M7cicz/U1d7tFrGkmehp2NM
        MIXsUpesJOh/EjPIqd/A/Ow=
X-Google-Smtp-Source: ABdhPJy3q16jqERBgwVEnjzmGdMqTZ/q6C8k9CzEfYc7tWekVjbunW10NLYbeHyZi46pnrqzRVtA2A==
X-Received: by 2002:a17:906:680a:: with SMTP id k10mr24000ejr.298.1630510294210;
        Wed, 01 Sep 2021 08:31:34 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o12sm9626edv.19.2021.09.01.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 08:31:33 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        =?utf-8?B?Q2zDqW1lbnQgQsWTc2No?= <u@pkh.me>,
        Willy Liu <willy.liu@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] arm64: dts: sun50i: h5: NanoPI Neo 2: phy-mode rgmii-id
Date:   Wed, 01 Sep 2021 17:31:32 +0200
Message-ID: <6939430.QNQgkB6KyE@kista>
In-Reply-To: <YS6WxHtJtNDaBxqz@lunn.ch>
References: <20210830151645.18018-1-u@pkh.me> <1746741.3t3T1tWQfl@kista> <YS6WxHtJtNDaBxqz@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 31. avgust 2021 ob 22:53:24 CEST je Andrew Lunn napisal(a):
> > True, but then again, DT is a bit special, since it's not used only by 
Linux. 
> > It's shared at least with BSDs and U-Boot, which most likely have 
independent 
> > driver implementation. That's why it's good to have DT fixes referencing DT 
> > related commits. As you said, DT described HW wrong.
> > 
> > Looking at past Allwinner related DT commits regarding this issue, we were 
not 
> > totally consistent. Most of them reference commit where emac node was 
> > introduced in DT. But I also found a couple of commits which indeed have 
fixes 
> > tag for bbc4d71d6354.
> 
> All true, and it is not a big deal if it does go back further. I don't
> care, we can let the Allwinner Maintainer decide. Ah, that is you :-)
> 
> I just want to try to keep it simple for somebody who is contributing
> their first Linux kernel patch. If it is good enough, i say accept it,
> and we can do a bit more education on the second contribution.

Maxime, Chen-Yu, thoughts?

Since there are both approaches for fixes tag already in, I guess this is also 
fine.

Best regards,
Jernej




