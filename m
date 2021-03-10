Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E254F334C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 00:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhCJXZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 18:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhCJXZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 18:25:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25748C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:25:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 18so36488227lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgKseNFFkrrRFclSHj6wbS3S/tiTuRT8S1xZlIqzXlo=;
        b=IjSkl6wJ2e929mSFyx3S1AYyWJi8WZsF060mBGXt6Rvngu6a9brGEMgy8OQcuKs/i4
         QYHuH8hDjrhyCURvf340UfFNAKq+RK8VjIAFe3FugcoEAlsXvViQ6pdDHoiYbni6neu6
         E4CETeLfFF/D7jbdJFYpwerqbqKuUvGHv15Apwy0EgMlUsRvDTmsMMbiB0XiD2cTVKpD
         BFDbNtwNJp/BJD1okzaEvCGaTbn7P/WfAxpp+wyZCd6qP9aPw2tKjQg60pfFCta0j9Mm
         rlL8T0YsoMyRZAh4bGwRaKcYYwrCBVZyiBeeN+uZizv5gBuJAZukyTXOE7q/U/xQwavI
         VBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgKseNFFkrrRFclSHj6wbS3S/tiTuRT8S1xZlIqzXlo=;
        b=VVDNzrjBvw97BnJoDI3TpvuUkX59Jziq/GXM7/pbM6pnfDlS56ApA+CfPwE1Lr4ZoJ
         /d9grwaNiaepe6JinYXAsqC9wj6ylZ09GFyG05o6uBlDwrSS6DJKuTmvYj27oK8wS3qG
         krNt6o7vGAc9wG5r9VvRSbDpatjqPF76aSt2UEHkF6heCDurqOMsndi1qHimW28AZn4H
         ITzDZlRMe2GsOSgCp3Zbh0Ao/JwL/EPbQgwGOHA9njUnGQchFNxSFqmg1od4YFTee4NR
         05ZEOsW23kEp6FlW3FeqmHP5M+0KQDVSrQ9TNwS0j7b4lZ6NXixjlpByGIHZpL/9XlEW
         Queg==
X-Gm-Message-State: AOAM530q47IlVFSP6aNkmMAhD7mu2eoEL8LdUFW7aXpzvNRj4rHOc0BE
        04pTDHkhb68TxtY69Nq6CwuK0WbOhrIUVzxRY6Q7JA==
X-Google-Smtp-Source: ABdhPJwGk6XtIb3w/iX57ttUl7E3k4dv+R8ze9Q1sAcTvGDDr2Xt4Qko01grmgJD8rFH0mJ9Oh66fDhzHwkgI2//SbY=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr514695lfo.529.1615418716717;
 Wed, 10 Mar 2021 15:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20210115224420.1635017-1-dianders@chromium.org>
In-Reply-To: <20210115224420.1635017-1-dianders@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 00:25:06 +0100
Message-ID: <CACRpkdYUs2W3b_u8YrmYwq_kcUCf0DhZ-o2o6O2EmU5rdtv=BA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm/panel-simple: Patches for N116BCA-EA1
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:44 PM Douglas Anderson <dianders@chromium.org> wrote:

> - ("drm/panel-simple: Don't wait longer for HPD...") new for v2.
> - ("drm/panel-simple: Retry if we timeout waiting for HPD") new for v2.

I couldn't find these patches in my inbox but my concern would
be that at some point panel-simple will turn from simple into
panel-rube-goldberg-machine.

Given that the talk with the manufacturer may result
in even more quirks... maybe this should just be a separate
panel driver?

(I expect pushback because I see how handy it is, but
I am the guy writing new panel drivers all the time rather than
using simple.)

Yours,
Linus Walleij
