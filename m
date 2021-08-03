Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5A3DF61C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbhHCUJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbhHCUJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:09:32 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4666C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 13:09:20 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so21823433ota.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/KZKCjnFh5BKZu2KIsfFmmFiIjkF/h9tteMntf9BJ8Y=;
        b=hOFgqrrzW2IAV3YZCxNDNqnJZItMegMe1VI69lm8ik30j4B5rqVxr/IEGdnIQqnB4X
         Jq1Czj/KXh433bmpZoWbEFEylw/Pn4jdK7o90p7USNjCQxfW5eQZzRYuMpAiyjbvbPxG
         VVdEdfkw80xXk1oAS/1vOpZ1/rJpJguVg/p3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/KZKCjnFh5BKZu2KIsfFmmFiIjkF/h9tteMntf9BJ8Y=;
        b=LmhadVcselDoajUicXksyP2DZzjasxwxF5Hfw+LcUTEInPMjav9mU8zpzGCTBUp0wz
         QvaoJzmj8mKcSvZ3qMcom598r1RReVOQvqthRCdEME24dgSp5xlZIBFefjnyMlhEha94
         OO74VtyjZBQWFylraiVMLPdyyGWPfnnVylPV+TgicV+nCR6g2TWm+4CbG9uRygnlzefD
         gfHKKmX8Svx+10Z9FNUIu9xvvGLSoO3AQVdenIVhR+KfyfzWFhGMhAO3FjO9zGXIxrva
         5QRqYWxpwkDAgYU/CrnReCuqpRlwdmqKspBeIO/v25Z/JtdlUlOSVtyX9D4pInWrCHrT
         FfOQ==
X-Gm-Message-State: AOAM531wsEf0YWwYNaQbKYMBF1Y6OS8BcEYBIVuJSBUwce8SjX8edCCk
        orGY8DJr2KcXdAWIDz+tCSysM7n6jpUpMgKFfPLouQ==
X-Google-Smtp-Source: ABdhPJysxfT1U9uGt9nsh5yQLTpopi/8CZ5Kck3OSg9MK8KloJG9UDSWBnr//f2uQIsAgC8G1VK1gNshpiJ3C/EmUo8=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr447074otq.233.1628021360166;
 Tue, 03 Aug 2021 13:09:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Aug 2021 15:09:19 -0500
MIME-Version: 1.0
In-Reply-To: <1627995852-24505-1-git-send-email-skakit@codeaurora.org>
References: <1627995852-24505-1-git-send-email-skakit@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 3 Aug 2021 15:09:19 -0500
Message-ID: <CAE-0n51=GAb+B-46gH7MKwiMbP8EqNnFKNQr0X3JFeAMP4rPNg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Remove pm8350 and pmr735b for sc7280-idp
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        satya priya <skakit@codeaurora.org>
Cc:     rnayak@codeaurora.org, kgunda@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting satya priya (2021-08-03 06:04:12)
> Remove pm8350 and pmr735b die temp nodes as these pmics are
> not present on this board.
>
> Correct the tabbing for pmk8350_vadc node.
>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---

Fixes: fbd5a1d22607 ("arm64: dts: qcom: sc7280: Add ADC channel nodes
for PMIC temperatures to sc7280-idp")
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
