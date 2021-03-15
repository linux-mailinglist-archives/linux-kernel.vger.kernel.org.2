Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E940D33C41B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhCOR2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbhCOR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:27:31 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6FBC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:27:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x10so32450308qkm.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RWsr2dPzW/uEOT8VZ8iZlXJJghlQaV6e0purSmrMZA=;
        b=Oh+asBWgl0e+s4jNwID+FX550YAUPxSA3NyjhdQjlXvO16M284r3JkguajAnXlfQ3m
         IJS2z9GAlA4iJexn6ICVLjwrMTchB71CIyOZiYqSkxaUdU4YNCXT3W8razfrkuozsAHI
         MmUd7wOLscry0xBFdNpMRE+MLo5VA8sQRlg7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RWsr2dPzW/uEOT8VZ8iZlXJJghlQaV6e0purSmrMZA=;
        b=uDUgcyFJsinLQ1SWXLmXNuzC38zqnoTT8OLfvNW4xE42cx8XGyNdx1glsg5b6IV5ON
         ozZ9/7dwM9n3oqA000liO6sGqoJ85pFwlIBuL14bgKBZr02F46m2vKlLkCynIA7D3MQd
         Eh7UGyJa3hAwpjM/kzNpUHq6hhUFwRrhIPlklCNKFMEts40Hea40mkaZOSClj6R4xQxy
         /YA1S/48QYT2gacq9rSaAxt3vHhEkkgUB9Y/XJo1aUYZinuvveUvXhz9TDXxpwiSzDKT
         aFO8R9iHWE+FBZFlgIDA1Qu29aJHdJobH8uHoT9r1CnKv0TCPxOeG8YgySTZ/VBPDhiw
         MXZQ==
X-Gm-Message-State: AOAM5315Mw2VtdJg6m1C+4ESZwmLE2yY6rEDVGFireRSBXstmdEJ8r3Z
        MUlLnzIvfzwX/XwvMsAxYW1BWsOf5IWsDw==
X-Google-Smtp-Source: ABdhPJzWSFuzCMXx7i3vccNdHI5IorthVPbhw6lNoL4cx9nY3Bt/wVhfliCaf52gasY+8fC9CTIsrg==
X-Received: by 2002:ae9:e884:: with SMTP id a126mr24051008qkg.444.1615829249979;
        Mon, 15 Mar 2021 10:27:29 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id a14sm12981986qkc.47.2021.03.15.10.27.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 10:27:29 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id f145so17609666ybg.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:27:26 -0700 (PDT)
X-Received: by 2002:a25:2654:: with SMTP id m81mr1035747ybm.405.1615829245523;
 Mon, 15 Mar 2021 10:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210312234310.3490809-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210312234310.3490809-1-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Mar 2021 10:27:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uvtdrb7N=UX2+XwNnYJd3_JWjrnjcMVnH=A3xq4oFQQw@mail.gmail.com>
Message-ID: <CAD=FV=Uvtdrb7N=UX2+XwNnYJd3_JWjrnjcMVnH=A3xq4oFQQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sdm845: Move reserved-memory to devices
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 12, 2021 at 3:42 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The reserved-memory regions used for carrying firmware to be run on the
> various cores and co-processors in a Qualcomm platform differs in size,
> placement and presence based on each device's feature set and security
> configuration.
>
> Rather than providing some basic set that works on the MTP and then
> piecemeal patch this up on the various devices, push the configuration
> of these regions out to the individual device dts files.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Added lost memory-region to the db845c wlan node, as spotted by Doug.
>
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 90 +++++++++++++------
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    | 87 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 87 ++++++++++++++++++
>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 78 +++++++++++++++-
>  .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 45 ++++++----
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 83 -----------------
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 86 ++++++++++++++++++
>  7 files changed, 431 insertions(+), 125 deletions(-)

I will leave it up to you to evaluate Konrad's feedback that this will
cause a bunch of duplication since I don't have enough experience w/
Android phones to have an informed opinion. In case it matters, this
addresses the feedback I had on v1 and thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll also repeat the feedback that I had on v1 that I focused much
more on cheza than on other boards and didn't check every last thing
on every board to make sure no changes happened.
