Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA7F37029E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbhD3VGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhD3VFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:05:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97440C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:05:04 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a18so28856264qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ydzc/UQSfGeVQNFG/QnxGDWnpFhecwtLoJxqG8ZG8Cg=;
        b=Ov5R523poXhFI1+DTO58fwJyVG5rNJSwtnBjJkc2d0NfuddPNjyjVNuQDvPuV3xvSz
         HvpREttduQPxVSPQAOIyOYBQxfZyhIf/3wphxaf8asWM5RUMbVBRfrz5KxXU54bvlJws
         Xz7/VHZ58xLOEFJrCnt8mUt8eX7GqtBE7DXmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ydzc/UQSfGeVQNFG/QnxGDWnpFhecwtLoJxqG8ZG8Cg=;
        b=jPQr8pjQKF2dZHFbe8EtUq2cmVTGnuHz/vzTD1xRnpszNahSwmluDm/nIml6rLfSRf
         5+12kxWvw2PyOjeD6/+CSbvPziBuHfJl9TfGwMRSa2IqSR5XT89x3qms78XKFPq7F1Pk
         LjNHPHzfCGbAHSmT8HXQAWAMD5MGgXry1qixjDeO1ES4YebIQf3RpAMuLUuBhDGS0lpr
         K215UDtNGCPJOqa5i0XM8TfCv//I1esJ9k1vgytKcja85dhpy3PQpJx/cJB9DrbbrgtB
         ZkjFhv+gCqspvLZKKxoO1Su7T22t6HQhYzsIMR8pJi1cDBvvO6Zmn7LL2vOd72Tw43Y5
         VOeA==
X-Gm-Message-State: AOAM531sKr6hKzE0GYthlgE7i17GWa9CuoxVbvCj+AUqr9YJX23YNL7e
        7AH6UrpTLllfTk//pUMK2qksvMEpKu8Lmw==
X-Google-Smtp-Source: ABdhPJxo8UhplmueTQqqHVJqBPLhoKtJ0hsR545cWCekYrabIDZsZd1iPKSA/jRo0AkltzhvL+2Org==
X-Received: by 2002:ac8:70a:: with SMTP id g10mr6186411qth.328.1619816703622;
        Fri, 30 Apr 2021 14:05:03 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 194sm2427125qke.51.2021.04.30.14.05.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 14:05:03 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id t94so31610040ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:05:03 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr10217798ybb.257.1619816691670;
 Fri, 30 Apr 2021 14:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210423165906.2504169-1-dianders@chromium.org>
 <20210423095743.v5.1.I9e6af2529d6c61e5daf86a15a1211121c5223b9a@changeid>
 <CACRpkdYkRFLvCRPSYNzYQG58QgPfhvjtHb+FBQZadyrnjC8=1A@mail.gmail.com>
 <CAD=FV=UX683grZ=poTwKXxSqYBCLdLAOCxOPhE_xVVgKbe36Mw@mail.gmail.com> <CACRpkdYfugrJ4WGn=w+viGXE6s5cdHjLC++jHPLVy_QH09KA8Q@mail.gmail.com>
In-Reply-To: <CACRpkdYfugrJ4WGn=w+viGXE6s5cdHjLC++jHPLVy_QH09KA8Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Apr 2021 14:04:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXxTz8hi92y6p3hX7iVEHuqKHsrKPSnX_a__WCEQRAKw@mail.gmail.com>
Message-ID: <CAD=FV=XXxTz8hi92y6p3hX7iVEHuqKHsrKPSnX_a__WCEQRAKw@mail.gmail.com>
Subject: Re: [PATCH v5 01/20] drm/panel: panel-simple: Add missing
 pm_runtime_disable() calls
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 29, 2021 at 6:28 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Apr 30, 2021 at 3:25 AM Doug Anderson <dianders@chromium.org> wrote:
>
> > > I think pm_runtime_disable(); need to be added there?
> >
> > I'm a bit confused. You're saying that I need to add
> > pm_runtime_disable() to panel_simple_remove()? Doesn't this patch do
> > that?
>
> It does, sorry, too late at night :D
>
> I was looking at the previous patch and mixed up which was the
> patch and the patch to the patch...
>
> Thanks, apply this!

Pushed this one patch. Rest of the series is pending adult
supervision. Overall summary:

1. I could probably push some of the early sn65dsi86 cleanup patches
in this series since they have Bjorn's review and are pretty much
no-ops / simple cleanups, but there's probably not tons gained for
shoving those in early.

2. The whole concept of breaking up the patch into sub-drivers has no
official Reviewed-by tags yet. Presumably Bjorn will give those a
re-review when he has time again. Assuming nobody is really upset
about it, I could land those which might unblock some of Bjorn's
future PWM work. It would probably be good to get an extra set of eyes
on them, though, just so someone else agrees that they're not "too
hacky" or anything. IMO it's actually a pretty nice solution, but I'm
biased!

3. Laurent and I had a big discussion on #dri-devel yesterday about
the EDID reading. He's not totally convinced with the idea of doing
this in the panel when the bridge could just do it by itself, but it
sounded like he might be coming around. Right now this is waiting on
Laurent to have time to get back to this.

My summary of the IRC discussion with Laurent (please correct if I got
this wrong):

a) In general I argued that it was important to be able to provide the
EDID and the DDC bus to the panel driver. Providing the EDID to the
panel driver allows the panel driver is one of the prerequisites for
my proposal for solving the "panel second sourcing" problem [1]. Being
able to provide the DDC bus to the panel will likely be important in
the eventual solution to Rajeev's problem [2].

b) Today, if we provide the DDC bus to simple-panel then simple-panel
will assume it's in charge of reading the EDID.

c) Having the panel driver involved in reading the EDID feels like it
makes sense to me. The panel driver knows how to power the panel on
enough to read the EDID. It also might know extra quirks needed to
read the EDID on a given panel. This feels a little cleaner (to me)
than just re-using the panel's "prepare" and assuming that a prepared
panel was ready for EDID read, though I can see that both may have
their advantages.

d) Laurent proposed that some eDP controllers might have special ways
to read an EDID but might not be able to provide a DDC bus or an i2c
bus. If we run into controllers like this then we would be painted
into a corner and we'd have to come up with a new solution. This is
definitely a good point, though it remains to be seen if this is
common with eDP (like Laurent says it is for HDMI). Some eDP panels
need custom DDC commands in order to be configured and so hopefully
all eDP bridges out there at least provide a DDC bus. It does feel
like this could be solved later, though. My patch series is leveraging
the existing concept that the panel driver is in charge of reading the
EDID if it's given the DDC bus, so it's not creating a new mechanism
but instead just continuing to use the existing mechanism. If the
existing mechanism doesn't work then it can be improved when there is
a need.

e) Laurent worried about circular dependencies and wanted to see my
solution to the problem before deciding if it was too big of a hack.
Hopefully it looks OK since it solves not only this problem but also
the HPD GPIO problem and will be important for when Bjorn exports the
PWM from the bridge chip.

[1] https://lore.kernel.org/lkml/CAD=FV=VZYOMPwQZzWdhJGh5cjJWw_EcM-wQVEivZ-bdGXjPrEQ@mail.gmail.com/
[2] https://lore.kernel.org/r/78c4bd291bd4a17ae2a1d02d0217de43@codeaurora.org

OK, I'll shut up now. ;-)

-Doug
