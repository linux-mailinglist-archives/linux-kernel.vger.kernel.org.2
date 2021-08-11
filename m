Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34C13E970D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 19:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhHKRwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 13:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhHKRwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 13:52:04 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557AEC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:51:40 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so4319444oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2DfNuz5O7Mpdzge58x7dhXEmqV1KbsWUVKw3z3NErkw=;
        b=KegjHwRhqP0eyTIjTxdo+VQWrHOjxNclssYbN0gYdv+UXtuPfpLohCE61Br2R0f0xS
         sVV35sxF3U+OMySclqVD79ydUWjUvGcKMnapmPU/O6z0A22kYnk00cKWLKFDpniF2zh7
         YgjtJ2yV4YWL/DTcfHaijEnuQsELdmlb8846E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2DfNuz5O7Mpdzge58x7dhXEmqV1KbsWUVKw3z3NErkw=;
        b=Dkh8ScRCD4E6HqpUEsn89q4QfONTR5woKVHWTFMyV+cZNljiRR2T3um8QsXkZuglCl
         bpkct1cr6RnrVS2uF1uWoDegqs24PMQ0o3ppPam2RFw1tbZsSffM1n8kuUPNtRx9lBW+
         qKJETZUCT93Igshs//oFzGXd3drxFz6ytNiviW7oC9piAQrv7X8cmEIeWG92yKgcGIHL
         D00C/NNm1bmfrWInD12qT4oonJKjbocReUb6c2JYs9rtWA0Jm9E7AwWutLGVML/GKz0R
         d8gzLRT/XzmFfLzEjKKYEUAm6xxMBwmYoHg5IDynu1ptq6IAnnOTeW8iuvjjhxSIDBoO
         GHSQ==
X-Gm-Message-State: AOAM533r3Ru7WN9/WCPeoESeKbCiPjWdM9z7LIkKxIagwDHcZX/wRGKo
        RVsoF4cEOhDJHtQz2gEvDj6v67LnVG/85p7+eKUYcw==
X-Google-Smtp-Source: ABdhPJxP4Vj/nnRZByQ6ppiULeaZtVP0wwSMf/t1xhztsfuKaN7WpnJStix5REbZv/OdPm2wJyTwoly2glhXlLB7PX4=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr120971otq.233.1628704299752;
 Wed, 11 Aug 2021 10:51:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Aug 2021 10:51:39 -0700
MIME-Version: 1.0
In-Reply-To: <1628691835-36958-1-git-send-email-akhilpo@codeaurora.org>
References: <1628691835-36958-1-git-send-email-akhilpo@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 11 Aug 2021 10:51:39 -0700
Message-ID: <CAE-0n51i2OcQ5G=nDXyOQwYoT4j3iyRKu8r-YYotmqTNfaBzhQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: qcom: sc7280: Add gpu support
To:     Akhil P Oommen <akhilpo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akhil P Oommen (2021-08-11 07:23:54)
> Add the necessary dt nodes for gpu support in sc7280.
>
> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
