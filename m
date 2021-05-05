Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8B373C99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhEENmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhEENmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:42:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E04C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:41:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 10so2146713pfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LvAhCgtUw7Hhr1tXS7DhiAKfCYCLt/FOGUyMtLSYxOI=;
        b=aPpqzCJkwTT9710KNxqM20TsKpE/Bz1oEwLIynCse6Kk6EZ4YyElTcbROymZjjaLSO
         stgYkbvWfp8eELXvsookgOyMvrxUbJ8Dubb+WhRP+0ytalCco0+JcTYufEkSVGnru1qU
         dwGmffCJF4AKk7XZFukpAmWv7qWuJ5+LoqRAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LvAhCgtUw7Hhr1tXS7DhiAKfCYCLt/FOGUyMtLSYxOI=;
        b=cK33pCRNyi8rtyjaj0sXX9Ew0fyI/1WDMsIi6eg62+wUNIRalx88vjx38zTvYG+8+9
         y9hh9OMrygoCxMne05dzDITPEm7hPI+gHrRKwresvTRtAUFpP0d7VhjPJvHtLQ91r2Pb
         6JQLWtSqL+JTuKcc+Lml8djkxUaNW/t4rsm9cLSLeNG7h/60s+bo3YhraFEFxZBdd0kF
         /dxCjxorff21q2h8NM7whIx3lalKzUzgld4Lr+pspkRe+KJSG/JXvRk9XTMQFpWsib9N
         O21QkZNlXHZACe6YCutdKmEurB9hM0DAMoI2pZQAnVkx1BHyOIT9ywW4AVgTDztCxObs
         GpNg==
X-Gm-Message-State: AOAM533PHkRD+ZUxwpuSCXyARSB2xZW1ZsqmMykJd+gMtdjHXAOdKZea
        f/sNHySynH5TjaJUs/g8JJP27rzS/ShLrQ==
X-Google-Smtp-Source: ABdhPJwlouJAoO/xkva4XHpCRR1HtaP540+oIE3e9nJ1WehVXwq4RYFg+UZVQoVNIEJD3B+fbETctg==
X-Received: by 2002:aa7:8c17:0:b029:27c:e3ae:ee8a with SMTP id c23-20020aa78c170000b029027ce3aeee8amr28932339pfd.41.1620222072443;
        Wed, 05 May 2021 06:41:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:8770:f856:b2ff:e5e4])
        by smtp.gmail.com with UTF8SMTPSA id d199sm15761735pfd.187.2021.05.05.06.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:41:12 -0700 (PDT)
Date:   Wed, 5 May 2021 06:41:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V4 2/8] arm64: dts: qcom: sc7280: Add thermal-zones node
Message-ID: <YJKgdjpXEE83gY0/@google.com>
References: <1620197726-23802-1-git-send-email-skakit@codeaurora.org>
 <1620197726-23802-3-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1620197726-23802-3-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 12:25:20PM +0530, satya priya wrote:
> Add thermal-zones node for SC7280 SoC.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

The patch won't be needed after 'arm64: dts: qcom: SC7280: Add thermal zone
support' (https://patchwork.kernel.org/project/linux-arm-msm/patch/1619778592-8112-4-git-send-email-rkambl@codeaurora.org/)
lands, but looks good for now.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
