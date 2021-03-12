Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF4B3398A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhCLUr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbhCLUrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:47:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53C1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:47:41 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q12so2018721plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CaKbe7bADOn54cyXzVoag8Ux2eG3O4D4Z7StlDGKIr8=;
        b=gmoPElK/vohvjAY6Up6aCMkeb7xmZBKAbBwsBSqF7ahsMjYFbh3ebnP+1NGClZbAU2
         1itqLBic+7831voqmaouTKH75xqLoHqocB2qRchifVmu+a1nfkH+3VvfuT5Wk8sup2LJ
         ficeaz4rTvQKZmrgipjnVBoR/nVs6qOWcsgn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CaKbe7bADOn54cyXzVoag8Ux2eG3O4D4Z7StlDGKIr8=;
        b=jYkBsnQI+kyBAAucXXUNQGkigIfTLR1JKh6OJdbw0aTIaFreQo8i2LoYUR1Kstbb94
         KpPKqGWA2r4aM0ftOXl8YpDJ1mOSBNK97sxPnsjH9bodZnMS60Gseff9gehrabpa6nOj
         18YDjyRrwk9qgFaOOXj9CWLXdmG/wKmSvYtVpNJK0q7OTsZInwR67bIHNAlKPkjW97kL
         OZ1B8EDdVC2x+ApQe1GWBoD3tEtIhDC6cs6w3ewx0mjmZfvfkS/kJjwuXcjn3UnYDAzx
         7Vm4Z6yar1yAgnJtE6Hc8ZaXhyqJzToiooUKHJZ8iCpZYvIj9551hgSUtQUOoUMcu1eu
         xqKQ==
X-Gm-Message-State: AOAM5307jDi8GNm80gJ7uoV47y1RU09V8ragbEw1S/m0FHcxrh7zENbG
        B69hzhs9ErT769h0wy1qtkA/Tw==
X-Google-Smtp-Source: ABdhPJxF+dEafahhWIvMswiNKD/aT2IklzwVrJtgo+entaw/i9haJhxb3ohAYyGxu3bJZ5ZqPeogKQ==
X-Received: by 2002:a17:90a:af8a:: with SMTP id w10mr137519pjq.114.1615582061258;
        Fri, 12 Mar 2021 12:47:41 -0800 (PST)
Received: from localhost ([2620:15c:202:1:914f:6483:1dc:1bba])
        by smtp.gmail.com with UTF8SMTPSA id q19sm2053421pff.91.2021.03.12.12.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 12:47:40 -0800 (PST)
Date:   Fri, 12 Mar 2021 12:47:39 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add PMIC peripherals for SC7280
Message-ID: <YEvTa0+VC2XSO048@google.com>
References: <1615459229-27573-1-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1615459229-27573-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 04:10:29PM +0530, satya priya wrote:
> Add PM7325/PM8350C/PMK8350/PMR735A peripherals such as PON,
> GPIOs, RTC and other PMIC infra modules for SC7280.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> This patch depends on base DT and board files for SC7280 to merge first
> https://lore.kernel.org/patchwork/project/lkml/list/?series=487403
> 
>  arch/arm64/boot/dts/qcom/pm7325.dtsi  |  60 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8350c.dtsi |  60 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pmk8350.dtsi | 104 ++++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pmr735a.dtsi |  60 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi  |   8 +++
>  5 files changed, 292 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm7325.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8350c.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pmk8350.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pmr735a.dtsi

The subject 'arm64: dts: qcom: sc7280: Add PMIC peripherals for SC7280'
is a bit misleading, at least for the git history it would be clearer to
to split this into per-PMIC patches and one SC7280 patch.
