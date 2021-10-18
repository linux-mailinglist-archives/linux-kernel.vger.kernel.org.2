Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808D143293E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 23:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhJRVrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 17:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhJRVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 17:47:36 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A94C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:45:24 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id h20so12257182qko.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kxxjnpajnLan+DlWscaEGHQpNRH8oNyJjc2GZj0gis=;
        b=eVEgfnxfaUdhUt/5YAtildIbe5oHbAKEh2BmfIwqcuqjFoffearSCUtT79nGI4rdny
         xM4+Vk5sK+Hk7aIQfB39mybUcxEQZB4upapVT+dLCf8KEq8j4//7IxbgcbVHmYRwuzr9
         AcGwq32NRkvvyyhmcIRJT2Pzydz5IGG6NOXfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kxxjnpajnLan+DlWscaEGHQpNRH8oNyJjc2GZj0gis=;
        b=FE4JqeTKKsZw5X94oQLFXNyQ8pEcJDrxuza+rS7uGoi69YIhqhXq3Rsgk12mkureqO
         xkloV/hesyPBzF+bX/0VkFfLyGfEbq/VZkbQfr8HSAz0Qp5GFpb506GQo0IIck5D7TqY
         GywgoI/2JzeOtzUL/O8L0leMKFHpNuf9k6QJfRGqZHKkFq+eJj3KwH7ZcASEqhxyUeE1
         /TYyKWcqyO3ry/Ilt47g0sIgNEn1CGJtk4VSuzuK0JSGpnlD3ad3kug3ZJFfQYhMa0GI
         vhRJSKQzsl6zDP+He7q1TtBvfWeKnUoKBB56TwPSmPhEmrc7hUXRip73Xe4XWQU71vJB
         bfgg==
X-Gm-Message-State: AOAM532ifURIR9SjOMyqlluXP+POcfoGjOjN/+GvKIrjHONpRrhIXemS
        gjO9HMBgrosKfKm6mz70Y6H8ccGBJ7Vppg==
X-Google-Smtp-Source: ABdhPJyq/21GbnVG0nIGWErK9VSXZv18wMqF4la90k8r50cm6CLdOsHEAgxsehgOfYir2Txz9iqkPA==
X-Received: by 2002:a37:aa43:: with SMTP id t64mr23382653qke.233.1634593523639;
        Mon, 18 Oct 2021 14:45:23 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 9sm6962663qkn.84.2021.10.18.14.45.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 14:45:22 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id t127so5450164ybf.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:45:21 -0700 (PDT)
X-Received: by 2002:a25:bdce:: with SMTP id g14mr31388284ybk.352.1634593521482;
 Mon, 18 Oct 2021 14:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210929153553.1.Ib44c2ac967833d7a3f51452d44d15b7b8d23c1f0@changeid>
 <86b0d847ddf06c1b445f3dbac9c771a9@codeaurora.org>
In-Reply-To: <86b0d847ddf06c1b445f3dbac9c771a9@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Oct 2021 14:45:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WnMnEckHdu0DG3U8MnyjwQ42aybFxq35nWSLG=vs=LGA@mail.gmail.com>
Message-ID: <CAD=FV=WnMnEckHdu0DG3U8MnyjwQ42aybFxq35nWSLG=vs=LGA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: pmk8350: Make RTC disabled by default;
 enable on sc7280-idp
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Wed, Sep 29, 2021 at 9:00 PM <skakit@codeaurora.org> wrote:
>
> On 2021-09-30 04:08, Douglas Anderson wrote:
> > The RTC on the pmk8350 is not useful on all boards. Some boards may
> > not provide backup power to the PMIC but might have another RTC on the
> > board that does have backup power. In this case it's better to not use
> > the RTC on the PMIC.
> >
> > At the moment, the only boards that includes this PMIC are sc7280-idp
> > and sc7280-idp2. On sc7280-idp I'm not aware of any other RTCs, but
> > sc7280-idp2 has a Chrome OS EC on it and this is intended to provide
> > the RTC for the AP.
> >
> > Let's do what we normally do for hardware that's not used by all
> > boards and set it to a default status of "disabled" and then enable it
> > on the boards that need it.
> >
> > NOTE: for sc7280-idp it's _possible_ we might also want to add
> > `allow-set-time;`. That could be the subject of a future patch if it
> > is indeed true.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
>
> Reviewed-by: Satya Priya <skakit@codeaurora.org>

If you're still accepting patches for 5.16, it'd be keen if you'd
consider taking this one. Thanks!

-Doug
