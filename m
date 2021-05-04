Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14CA3723CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 02:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhEDAGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 20:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhEDAGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 20:06:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5BC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 17:05:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q2so5618484pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlwag/uSXI11ILOIN89++20RL6/tXX3LDSgQBRBdBOU=;
        b=ZQm8gFiW96TZMryAmLMnN0xnS/oS/3U8vLNnaJWFPJmfVBsGpLfYb8L0+IUNhSNr3+
         ADT08NYza76P++MU6x3/ETruXrriu4w82WIVNRjqN0KqB+aLcRoFwcmdV5Luvxnpf0sq
         bAT97oaVJ+cig/8tht9DwnLaDN+R8NGSEAcajrTBzwwNGB3v5mExK/xtHKPyED4S+/qf
         GLqufTBW8lMhq2xNoFvK4gaM0nf1Y3m/9jawWdlrxvLAl2zN2BBTl6JpBmwJb8g0xLyk
         wkQKh7RPkmiQ126PUUn55ZAmG0o6pje7F2BwAwTj6eNfipHUUomPiCmgZu2BG5bPGTdz
         oDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlwag/uSXI11ILOIN89++20RL6/tXX3LDSgQBRBdBOU=;
        b=ApRPnj/FFG9Syj4/jqVS9fRQifAyYaGwKhOGub/Meq3+Vb+SBGoSeI1Bt6r0WVMAMv
         Qe6O6YOpZPYNB/sQbPuwnekC9RgVYTQvvXYQwxgfwAmy8eSjV+PIdh7ypJQdqtJbaq2B
         UGX6xba3nmxo3Tvy9tf+7qHHWKu89UxDrAyWuAzaIyUGD0tjzro0pAuXF3ExEHMqvZZ4
         jGxC1TbjBxke3K+4jm4C1p2o7GFzKmbH90h7ejKAH4JbLvgnNg4B0xAVGpQ+mZLOtBMJ
         vUtme6AfzSmWN/P39FJll2EakvSZ9uqzYY5l9m04owGdVHjgNITyO2UCpYjX72bYXiA8
         jOEQ==
X-Gm-Message-State: AOAM530dxfzYeq3J2DXzfCBC4hJNBmvM33fyNjdQ8zFbW5NJF9NEbAqS
        kg2Il/Ys8TEUEY4yhSNbHlf7OA==
X-Google-Smtp-Source: ABdhPJwZ+dFy8uvseVcLfYrjvph2vOhgI+bPnckBb9XnFgLOdOCwxUBjA0t+PHSHMR6Hn+tVwrQhPA==
X-Received: by 2002:a63:4648:: with SMTP id v8mr12263361pgk.34.1620086758143;
        Mon, 03 May 2021 17:05:58 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id f201sm10222879pfa.133.2021.05.03.17.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 17:05:57 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] soc: amlogic: meson-clk-measure: remove redundant dev_err call in meson_msr_probe()
Date:   Mon,  3 May 2021 17:05:54 -0700
Message-Id: <162008674673.40672.9817801757275466869.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210409110243.41-1-linqiheng@huawei.com>
References: <20210409110243.41-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 19:02:43 +0800, Qiheng Lin wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied, thanks!

[1/1] soc: amlogic: meson-clk-measure: remove redundant dev_err call in meson_msr_probe()
      commit: 4f2f0162a389196fb4092aee93ef4a89f96390be

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
