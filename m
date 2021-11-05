Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70C3446AEF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhKEWfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhKEWfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:35:43 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541AC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:33:02 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o83so16777028oif.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=fWPW6vOrV4yWuNKQyKDDkLamXrngpvFNOzlcY43dNqs=;
        b=iKVG85gppzXqEaEOcL5Bb84m05PjYOdlnIwqPMXq+hWd3vGImllScnpAoM8rou02x6
         zYzmGPkKPG7RowxQPg4xyPG3c/FKplaDd2p/I4ccOzLnNlzFKWulOb4CUOHAjMOZBCG/
         axL+CUfZ9a8YWytneRUIm9D4Wx2ZZB7f5YCZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=fWPW6vOrV4yWuNKQyKDDkLamXrngpvFNOzlcY43dNqs=;
        b=ZNn85Ve1sOlsUCbGyIHBNtjBOv7jzK2S9HzRd+X6utskPGpHh08ZzM1CJbmiNu6E1F
         kfNOEC47iAGcBpFpcMb2gJbmPlrvMsG1wGxyg0fh2mip7rviRXFIEJWjjnQne2xRZOhK
         LJtZKAoWHc5KaQ2tsHjXL75tXeKAmbSpPeq9NGdHtwcDLDgsx4li+EOuyG1y05QqFKN5
         RX5KixdLWVHJSacbrYNeIBKJBb/mVByyFpWc6vTDSCQNmpO39VG9QNP+Aq3uLsnta/xz
         +ilTvtbhr6wctBzSvLAvTUSUUMVIWJMfUekXPaVvEJCp1SX/0r+tbUEutPzPaWYXxN2R
         RZwQ==
X-Gm-Message-State: AOAM531lL6O/HnKzfPmofnxNgIOecU9Vr/A4mxpjH/nSbk0dbxZSmrJd
        LKnIn+h8WDQHClRZLS1PkqgJs0CYA4vOtE4K9cZ+tg==
X-Google-Smtp-Source: ABdhPJz+sZay+XktcSS+5myteHfFnaSYRjh0L2fXVqz51OpDz37VcMg34X0qvr4jMDBdhRGzkOJ7h2s7RmQz9/39vB0=
X-Received: by 2002:a05:6808:a96:: with SMTP id q22mr16520113oij.164.1636151582339;
 Fri, 05 Nov 2021 15:33:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Nov 2021 15:33:01 -0700
MIME-Version: 1.0
In-Reply-To: <YYVudQzp8Kxweewq@ripper>
References: <1636133291-10551-1-git-send-email-quic_khsieh@quicinc.com> <YYVudQzp8Kxweewq@ripper>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 5 Nov 2021 15:33:01 -0700
Message-ID: <CAE-0n526B0_ZyyPs++cVUHy9w+ruadLY7BzYuDH8acn5qq6A_g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: do not initialize phy until plugin interrupt received
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        dmitry.baryshkov@linaro.org, quic_abhinavk@quicinc.com,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuogee Hsieh <khsieh@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-11-05 10:48:37)
> On Fri 05 Nov 10:28 PDT 2021, Kuogee Hsieh wrote:
>
> > From: Kuogee Hsieh <khsieh@codeaurora.org>
> >
> > Combo phy supports both USB and DP simultaneously. There may has a
> > possible conflict during phy initialization phase between USB and
> > DP driver which may cause USB phy timeout when USB tries to power
> > up its phy. This patch has the DP driver not initialize its phy
> > during DP driver initialization phase. Instead DP driver only enable
> > required regulators and clocks so that it is able to receive HPD
> > interrupts after completion of initialization phase. DP driver will
> > initialize its phy when HPD plug-in interrupt received.
>
> Is this a hardware requirement, or is this a issue with the current
> implementation of the QMP combo phy driver? We should not hack up the DP
> driver to circumvent the latter.
>
> Also, I don't suppose there's anything here that prevents the HPD to
> come before the USB PHY is powered up? Even though that seems less
> likely in practice...
>
> > This patch also provides a positive side effects which balance regulator
> > enable count since regulator only enabled at initialize phase and resume
> > and disabled at followed suspend.
> >
>
> Is this something that needs to be fixed separately, so that it can be
> backported to stable kernels?

Agreed. Please split the regulator balance problem from the DP
initialization delay.
