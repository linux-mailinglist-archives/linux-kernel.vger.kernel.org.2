Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A697A4170C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245738AbhIXLW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 07:22:56 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33134
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245733AbhIXLWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 07:22:45 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C6E1402DA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 11:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632482472;
        bh=qTTRq/cF6M6VkeBluJMjAjm+Uf6cMUMQZt/uJUhnSPk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=XQqyVh/JiP29uoqogwb78Hn+6rSSLciGWSVG7CuIFcEvtcyJM2SJlLz69FpyQWhxo
         GdKFim8fRZu6CGANXJf6lwHxBvIfcv9ibr3bYimZIq6APjBvCNdwUWNWFgcFSJL0hu
         iaPDz185WasLcXwOAYsUqzCU5OIIj9xFzMtRulC6UebSphg7K7AcaZbE076Fbevgmn
         6WM34jBIK+KDYF8qKy7VShWSVJiQHDE9/0a4+NJoBTmrgTgsuKKctDPIrBZX0jeCXO
         m2L8r3PlepdnQnnFUD8fezzjYdIsADlWCIn/wDkQRJHqtQraP/ZuiCDhxnKNX7dArb
         k1uHiOX64aeQA==
Received: by mail-wr1-f71.google.com with SMTP id s14-20020adff80e000000b001601b124f50so7780835wrp.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 04:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTTRq/cF6M6VkeBluJMjAjm+Uf6cMUMQZt/uJUhnSPk=;
        b=RqioPWrUkxFraqGYVa0BJUyW1k6966M5CIUTuR0X3q/iovr6q91cuD8EMOwSrDUazj
         AbJryXItUpNTcpq2rZ+8RHoo7m64JxBTiSCHA2UI1J3USbIqy9ZsNe2PZ6SmNOlnQLW2
         wUJDRBnX8lMF64JeDHl2WW731MGZGF8+spKRvizxZ49x4w53xPlKfP5WFfq6Jixjb+/k
         +8A9lp7CmM+f+XpsDuvXCLHqr5TeLOpzFIWbMoyTyWIGCF6vIgTyCW1/USIl1e3TIKQK
         Z26OEjemyECFmSoZTcvQS8GZy2sEEHSJxBUiMNW1rS+ZYBYlOTi7ppZzczphNHHTiTQV
         pnIQ==
X-Gm-Message-State: AOAM533Re80/DcJu0P2yRiWZW8d27BBBq4bFJg3JFPToEGIDLtL0cUBq
        NujNfz7SRHBQS1m5c9JAOyWuGYfwEoBbQvm/mCAEHKF6XGrHoaJ3OkxL+A4qtGxfxS+Ynv/L7Gf
        5H9bhaYcNjB87wwteTWz/AimP5xF4BEdSTT2muRyylQ==
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr10457387wrz.319.1632482471695;
        Fri, 24 Sep 2021 04:21:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgaaL4O++/B8KXnrTWwkZY7SeSfSOlTkgSIyuaQJFk5An9tksPtF9/mV0VQ+s/IPzXcKTlLg==
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr10457371wrz.319.1632482471530;
        Fri, 24 Sep 2021 04:21:11 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id b7sm9881473wrm.9.2021.09.24.04.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 04:21:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] memory: tegra: Make use of the helper function devm_add_action_or_reset()
Date:   Fri, 24 Sep 2021 13:20:36 +0200
Message-Id: <163248239878.48775.4100179078920031712.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922130002.586-1-caihuoqing@baidu.com>
References: <20210922130002.586-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 21:00:01 +0800, Cai Huoqing wrote:
> The helper function devm_add_action_or_reset() will internally
> call devm_add_action(), and if devm_add_action() fails then it will
> execute the action mentioned and return the error code. So
> use devm_add_action_or_reset() instead of devm_add_action()
> to simplify the error handling, reduce the code.
> 
> 
> [...]

Applied, with simplified commit msg (no need to write too much for such simple
change), thanks!

[1/1] memory: tegra: Make use of the helper function devm_add_action_or_reset()
      commit: 1d8e0223bb52071ffc59391f0ebefa06ce5643d7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
