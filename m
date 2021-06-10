Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82093A253D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFJHY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:24:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40763 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhFJHYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:24:24 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrF1H-00006d-Iq
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 07:22:27 +0000
Received: by mail-wm1-f72.google.com with SMTP id m33-20020a05600c3b21b02901a44b1d2d87so2708557wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VadSajW5H4JLmd3wkcDKHmTiiBiDnefV2rMQY04z28=;
        b=K3n1VYylOruAi3IB+R8BMM1gDV0GzLu9+O32UCdsJirc1XBPQNOZfoM9rGi4D0/nAf
         zq3BAxzqJ78IbpJHNfFfkNq9kg9CzvrB+kg4QWY7vmta1XRhZaWgOrQqRcaaAsg6zl5b
         4EpLGATyfa3QNnQkTpeVSQ+ns/zmCvRS8pVY1SRWaj3eMaRcamJVpjZTe7ZvBIyRwqvA
         wRYQft4G86GQX1xlrboHeSS8lXD07rNEHHAwHmbBVKfb1xkH2nLaQfFjPiSduHWjzT52
         JSsOlL/o7UaSO9+KfpJqMzxEEifC7NkuY/qpNq9K+xGk2l8l0IJR654IUxq6QEg3hltx
         ykzg==
X-Gm-Message-State: AOAM532rOJvp4WAVckzOoHokWCsK2+CSBeXsRlnON/71oCwIpKt6dYwv
        oMwVUQOyZ4NWfzTk3xLNynqAdeoNiuMXwqaqAJPKjRTbAr4NSMisUUlnqZPfMF4XrFd0blqAbbH
        WpXcEht51Bk8bCvAdG8zdE1RsiKleDQsDYe259KVYrw==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr3674091wrr.71.1623309745414;
        Thu, 10 Jun 2021 00:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYKqp7/tU/D0jmZXC6cq5GMH3PaAT2LB5mizmzqtiooFKKcoD4gXmpsPoaVVfOWirvKR1XqA==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr3674072wrr.71.1623309745252;
        Thu, 10 Jun 2021 00:22:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id j11sm2024658wmq.4.2021.06.10.00.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:22:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nathan Chancellor <nathan@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: Delete dead debugfs checking code
Date:   Thu, 10 Jun 2021 09:22:16 +0200
Message-Id: <162330973162.9991.7770026774132794997.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <YMCQDTSyG8UuQoh0@mwanda>
References: <YMCQDTSyG8UuQoh0@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 12:55:25 +0300, Dan Carpenter wrote:
> The debugfs_create_dir() function does not return NULL, it returns error
> pointers.  But in normal situations like this where the caller is not
> dereferencing "emc->debugfs.root" then we are not supposed to check the
> return.  So instead of fixing these checks, we should delete them.

Applied, thanks!

[1/1] memory: tegra: Delete dead debugfs checking code
      commit: c7c65703260c88a3e4d7387b2d03023c3625c6d4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
