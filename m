Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466EC412A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhIUBmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhIUBjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:21 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541EC01AE7F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:44:38 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso25202344otu.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=A/kXMZfJhqt02ZS8GGmiL49TuAUrXKmTxuOnxlSxegU=;
        b=iKHw2zpvbPtXA2P0qsFHYJgm0jk1RJiQJTLnDf3OoKbn4Vvoz+J34laKYpXAHyqzG5
         c6XrpgLjq7/u6RZbPDTjQVL0okEkAeaZTQ4X7PONK5l+T/bJhQIAzbsmbyyxPM2Nn/kI
         MkOsBWLni6VwWwuwevv3hfecll8QDOkGNUYtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=A/kXMZfJhqt02ZS8GGmiL49TuAUrXKmTxuOnxlSxegU=;
        b=Or2kHunZOUQAlOskjYiD4rFi47efR17s72P/N/W+PUptXrQBkuvpVvNqME3prtbXeY
         42es/wIDb2HQXXxGj/o9O2dAyOUZsJV2nmGFXurS8Zq5EAPCxPp5L/Su9kiIc8RJxd6H
         OO5bAlB1Yd8kwwE96rQpurjXPV6ZkHQj1PAU+uElxxAuvJdGOfXL5Ekccw5j9RkWaFJX
         QsN9UAbB71cQEpZjEFJSnY2p8PAUn6aG7tIZG3ya3lFz4BSpaPG0QRSMA1ESBCIVes1w
         sUq3xBvvQ2M4Wh8/3/Am18DUxDKD3tCFtnmktOI2wjHwqeWA5sE5MFNf0Vrkp6wFbfdI
         19aA==
X-Gm-Message-State: AOAM530ewN99Ze5xHrpgsnM9lL+X1LmyawXZXc/6r8Jd3zreNilqGecY
        xGsfpRjqw11w3mWYOhSXFGdru2KGrFCtPNM/Q+FcTw==
X-Google-Smtp-Source: ABdhPJyqq0NHNKGjdhhgQelqooPrq6FF2LZaRIXFShWd5fjag4Kx6i4gemME+YY2Hq3J71L7khQN/6s0RHfdDLXyQhc=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr21376104otp.159.1632167078302;
 Mon, 20 Sep 2021 12:44:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Sep 2021 12:44:37 -0700
MIME-Version: 1.0
In-Reply-To: <1631872087-24416-7-git-send-email-rajpat@codeaurora.org>
References: <1631872087-24416-1-git-send-email-rajpat@codeaurora.org> <1631872087-24416-7-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 20 Sep 2021 12:44:37 -0700
Message-ID: <CAE-0n52QhzuzXRe_DHDdMXpdP7osmHCTHUaKpyBCBkWMrn3Apg@mail.gmail.com>
Subject: Re: [PATCH V8 6/8] arm64: dts: sc7280: Configure uart7 to support
 bluetooth on sc7280-idp
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, mka@chromium.org, dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-09-17 02:48:05)
> Add bluetooth uart pin configuration for sc7280-idp.
>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
