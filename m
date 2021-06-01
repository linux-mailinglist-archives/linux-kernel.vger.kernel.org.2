Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0847D397889
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhFAQ7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhFAQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:59:50 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:58:07 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q6so7568236qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldU/TPmtPmVs6oGr7yGz/gAY04wIfA/VvvfcSuok9Fk=;
        b=ItrTAwFyEd3vy4gcIMd1nyNP0+p9wLUpoepc2e8uV8llGt5bIcguuOkSItn+6rpc9z
         Fc0Te4vtTh3Nw60Q7F+W0cNouuLl8j8GBlj6SUNYWeWdgIVL1iepdsaHtMug2yW2Ec4h
         NSDfw/DRmV5Dai8I+dDkG+HF4HSBW2P+o0LBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldU/TPmtPmVs6oGr7yGz/gAY04wIfA/VvvfcSuok9Fk=;
        b=TjgRFWBuv0ta7okWjbmRzWDg3yihSDin9pplIeUrRcxtPxG4KjCD/j3g3gU9q51KOh
         E+Ve7jzJhXY5orMZ+o0BXF+FNHQO5S4oB7w+A/x80Ir9JccO2AXWJzf0rNVsqv992u1y
         WpJ88iUeOFkaFOLsAQGkyeDR6B6URfn0oWSV11f4GI/PAHptWgsgiRtgCmy2sH12+2RL
         Xk9Tp8Py/cBjraLwUUqIuYUSUegG12TUzDu2ZD2o1YPD/9KL7P7cil27fWgsdmZzcV96
         C6SIg3GUF7wD5+gX9wt8xOwRsNQMPMf6wiQ1TPdwT8gsc4knF9g66TtxoW+TPrkQRpIB
         Y4AA==
X-Gm-Message-State: AOAM531IDBVgGAyrpCp2yTqwLH5vP1UGZOwQZ2JPATfJAE9jdvoHns8f
        UZZryWGdYBDcKT6vAhIvzXvYTlhLseupew==
X-Google-Smtp-Source: ABdhPJwHWemSa8q8NIyeTm4kkmZnqTI87oiCQfTFip6mivZXEOTQ+xNELQLG565EmZStdOVRrp2CpA==
X-Received: by 2002:a0c:e8cd:: with SMTP id m13mr2592348qvo.52.1622566686417;
        Tue, 01 Jun 2021 09:58:06 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id j22sm11276413qkk.58.2021.06.01.09.58.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:58:06 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id z38so22161712ybh.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:58:05 -0700 (PDT)
X-Received: by 2002:a25:8191:: with SMTP id p17mr40654965ybk.405.1622566685333;
 Tue, 01 Jun 2021 09:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210510075253.1.Ib4c296d6ff9819f26bcaf91e8a08729cc203fed0@changeid>
In-Reply-To: <20210510075253.1.Ib4c296d6ff9819f26bcaf91e8a08729cc203fed0@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Jun 2021 09:57:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WMfCi9fVHxUqRiy+abgQU2K28BfOHfUrUpwcwUVrrOOA@mail.gmail.com>
Message-ID: <CAD=FV=WMfCi9fVHxUqRiy+abgQU2K28BfOHfUrUpwcwUVrrOOA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Modify SPI_CLK voltage level
 for trogdor
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Wenchao Han <hanwenchao@huaqin.corp-partner.google.com>,
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

On Mon, May 10, 2021 at 7:53 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> From: Wenchao Han <hanwenchao@huaqin.corp-partner.google.com>
>
> On coachz it could be observed that SPI_CLK voltage level was only
> 1.4V during active transfers because the drive strength was too
> weak. The line hadn't finished slewing up by the time we started
> driving it down again. Using a drive strength of 8 lets us achieve the
> correct voltage level of 1.8V.
>
> Though the worst problems were observed on coachz hardware, let's do
> this across the board for trogdor devices. Scoping other boards shows
> that this makes the clk line look nicer on them too and doesn't
> introduce any problems.
>
> Only the clk line is adjusted, not any data lines. Because SPI isn't a
> DDR protocol we only sample the data lines on either rising or falling
> edges, not both. That means the clk line needs to toggle twice as fast
> as data lines so having the higher drive strength is more important
> there.
>
> Signed-off-by: Wenchao Han <hanwenchao@huaqin.corp-partner.google.com>
> [dianders: Adjust author real name; adjust commit message]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 +
>  1 file changed, 1 insertion(+)

I think this patch is ready to land and it's what we're now using in
the Chrome OS tree. See <https://crrev.com/c/2821728>.

-Doug
