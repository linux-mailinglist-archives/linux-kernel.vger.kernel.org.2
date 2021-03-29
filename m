Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE9234D487
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhC2QHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhC2QHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:07:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:07:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y18so12858086qky.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2tJ34SW4jrHJri6gw67H0wvGraWyIt4USuLVf0C2eM=;
        b=GC462xaBMRhJ2Eg7lkA6WeeOnHsYjJbAp7YGB3uHNWWsUKUWq0+/KNHc6unUex7fOZ
         OyjUJ86cSqxt7XZpVIceOdbPGydX1JHY2Wo3UptaJvygqAWzsXDJwjju3fXAElFrutDI
         HIyemZPRzo1F6TDoJ53UFlWlq4YWUTEmyu6hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2tJ34SW4jrHJri6gw67H0wvGraWyIt4USuLVf0C2eM=;
        b=Ma+7nFlmCtpHgBMKD04xMCe5ompnS4vyy5Nx0n3AhDp01g/KdBFZ+GzrxDXx6jIF7D
         L/mcpu9HCWxd7JIkq7i+IX9svsfcBbqf8ALlgG+kvtPUy9klgA7wzQCkX/nOkgwTcB1h
         gkJK4Si99W9jtXLqedDvapobogowxC5d1YbDO3SaODNxXqKf7AhF24oMscLw5E4FCTV/
         kT10Sxa3DLKzELOyBUBjFCNpgedEVNYyz+KiVcSa981VDOOXTssu1LT8y+OHMZv8aL2i
         +KFlae3PKz1K23dMgwkE8MzqARbmTK9oPB/6RiBUbvnn1MDc8e7ntsTCVzZ1zC/ug7U2
         2Ilg==
X-Gm-Message-State: AOAM533sohxFHaPfeQZOjm0uFl7JfuCOYvxH17NrsKtF/WXrA+7Mx5Rd
        S+cnx5KRNnyLVS5UgsNCgL6T+9/6I8p+dA==
X-Google-Smtp-Source: ABdhPJy5dPjUqeQ3ujkOgss5S/HrUvNN8QrJb+1Xn+Mk/Wde6cQRW4axRlNEmkjiWyQ+rX3W81Ektw==
X-Received: by 2002:a05:620a:954:: with SMTP id w20mr26729381qkw.57.1617034039484;
        Mon, 29 Mar 2021 09:07:19 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id b21sm13291512qkl.14.2021.03.29.09.07.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 09:07:18 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id i144so14312917ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:07:18 -0700 (PDT)
X-Received: by 2002:a25:69c1:: with SMTP id e184mr39188232ybc.345.1617034038260;
 Mon, 29 Mar 2021 09:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210316140707.RFC.1.I3a21995726282f1e9fcb70da5eb96f19ed96634f@changeid>
 <YFKQaXOmOwYyeqvM@google.com> <CAF6AEGtu+GBwYfkH3x=UuPs5Ouj0TxqbVjpjFEtMKKWvd1-Gbg@mail.gmail.com>
 <YF3V8d4wB6i81fLN@orome.fritz.box>
In-Reply-To: <YF3V8d4wB6i81fLN@orome.fritz.box>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Mar 2021 09:07:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VDKQCMtxd2NMRefxQm5uzDS6_rUVP5YsTsDEYX+jSipw@mail.gmail.com>
Message-ID: <CAD=FV=VDKQCMtxd2NMRefxQm5uzDS6_rUVP5YsTsDEYX+jSipw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: display: simple: Add the panel on sc7180-trogdor-pompom
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 26, 2021 at 5:38 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> The point remains that unless we describe exactly which panel we're
> dealing with, we ultimately have no way of properly quirking anything if
> we ever have to.

Just to clarify here: with my initial proposal we actually could still
quirk things if we had to. If the quirk needed to be applied before
power on we'd just have to apply the quirk to the whole board (which
we'd have to do anyway). After the panel was powered on then we could
read the EDID and apply a quirk based on what the EDID tells us,
right?


> Also, once we allow this kind of wildcard we can
> suddenly get into a situation where people might want to reuse this on
> something that's not at all a google-pompom board because the same
> particular power sequence happens to work on on some other board.

That's a legit concern. Of course, people could already do that with
existing panels right? One would also hope that if they reused this
they also used the "more specific to least specific" rule, so someone
could reuse (without any problems) with:

compatible = "some-other-company,some-other-board-panel", "google,pompom-panel"

That doesn't seem like it would be terrible.


> Similarly I can imagine a situation where we could now have the same
> panel supported by multiple different wildcard compatible strings. How
> is that supposed to be any cleaner than what we have now?

I'm tempted to call this (same panel supported by multiple different
compatible strings) a feature, actually. Specifically:

Even if the exact same hardware is shipped with more than one board,
it may have a different EDID programmed into it. From what I've seen
the timings used on a panel may need to be adjusted based on the SoC
used (and what clock rates it can provide / features of the underlying
display driver), EMI concerns, and power consumption concerns. Once a
different EDID is programmed in it then it sorta becomes a "different"
panel, right? I think sometimes (?) panel vendors assign a slightly
different model number per board, but I'm not sure.


-Doug
