Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D413721C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhECUm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhECUmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:42:24 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C139EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 13:41:27 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id z1so3343604qvo.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BVEWhYBD+xtNsbo3lAuegOEINH/TnK8x6KkSQvrHSkc=;
        b=maWCCqkx0oH1zSZ/q/GRT9vao0fkAFsVj063WxGPB1qM8s/UjGnuJdKNRT6bMP4kiw
         L4+J9CU69hnWD+bOSoUADl1jrTF4/psQ7Di/8qRinh3NO5KHgbf6pU9EjtVGOwIETAec
         L/cXPywRZw9M6rUEbphDnPpsXBS7J0droG0iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVEWhYBD+xtNsbo3lAuegOEINH/TnK8x6KkSQvrHSkc=;
        b=U4PXMMSBZ1kwFHWxN5dmtba9zEGwlcUDCqRIaJ5d5Lqe0rDFUTOkEp3VAkJZFiKaUR
         K8JOcR+xF8UtnNpu/Md+ucvQdEPWmq6fUW/LZxhZBySd7A0FFV1tPS46w459ztnzlZbQ
         DksPF178I9uvZtqjkL8ILxs9MvmD1IQdG2T/l7x8JU90vRBpI98a9VL4Sdp9nzdpJ/uR
         stz5WOIxZWW0ZI8m9zkcBgfRX4lPL31G828E0R4w+D/AlL9IRPumqL2f8hGYNDJyAawa
         tiUGhgWjNHTAPr+YlymcNZkXHJmplJcziLLIfPqGq0Q8yImvy3+92meJgE0UcCtqb1vh
         4oFA==
X-Gm-Message-State: AOAM533Y88HR5LxhDgs/7bEGp1i0wwDcLbhvNGBvfLOaPnbTFBRdrEHq
        xF7kj9IyaaNeiHvk+duG8WxZv9C7hlfDag==
X-Google-Smtp-Source: ABdhPJzKHAK2QDb7/5tyM5H6YHQR0n6gnJwU/MH3vfaJdwgYfFfCBSWAWSMKYdiEiqpaTDWRswvB6A==
X-Received: by 2002:ad4:4e94:: with SMTP id dy20mr21653100qvb.50.1620074486769;
        Mon, 03 May 2021 13:41:26 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id r5sm781319qtp.75.2021.05.03.13.41.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 13:41:26 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id r8so9290851ybb.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 13:41:26 -0700 (PDT)
X-Received: by 2002:a9f:2183:: with SMTP id 3mr17021447uac.0.1620074475074;
 Mon, 03 May 2021 13:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210423165906.2504169-1-dianders@chromium.org>
 <20210423095743.v5.1.I9e6af2529d6c61e5daf86a15a1211121c5223b9a@changeid>
 <CACRpkdYkRFLvCRPSYNzYQG58QgPfhvjtHb+FBQZadyrnjC8=1A@mail.gmail.com>
 <CAD=FV=UX683grZ=poTwKXxSqYBCLdLAOCxOPhE_xVVgKbe36Mw@mail.gmail.com>
 <CACRpkdYfugrJ4WGn=w+viGXE6s5cdHjLC++jHPLVy_QH09KA8Q@mail.gmail.com>
 <CAD=FV=XXxTz8hi92y6p3hX7iVEHuqKHsrKPSnX_a__WCEQRAKw@mail.gmail.com> <CACRpkdZVH=h37hSjvjcNmRwV-RoBB-nvUbrOT80DoLr7n81R3Q@mail.gmail.com>
In-Reply-To: <CACRpkdZVH=h37hSjvjcNmRwV-RoBB-nvUbrOT80DoLr7n81R3Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 May 2021 13:41:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vzn0ih_RqR_ySJzFtq0B0x_4a-Uwjk56GeLyUZtTEXrQ@mail.gmail.com>
Message-ID: <CAD=FV=Vzn0ih_RqR_ySJzFtq0B0x_4a-Uwjk56GeLyUZtTEXrQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/20] drm/panel: panel-simple: Add missing
 pm_runtime_disable() calls
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
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

On Sat, May 1, 2021 at 5:07 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Doug,
>
> On Fri, Apr 30, 2021 at 11:04 PM Doug Anderson <dianders@chromium.org> wrote:
>
> > Pushed this one patch. Rest of the series is pending adult
> > supervision. Overall summary:
> >
> > 1. I could probably push some of the early sn65dsi86 cleanup patches
> > in this series since they have Bjorn's review and are pretty much
> > no-ops / simple cleanups, but there's probably not tons gained for
> > shoving those in early.
>
> Those look good to me as well. I'd say just apply them.
>
> To me it looks like up until and including patch 18?
> Feel free to add my
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> On these.

OK, thanks! I've just pushed these patches to drm-misc-next with your Ack:

63358e24ee79 drm/panel: panel-simple: Cache the EDID as long as we retain power
31e25395d8b7 drm/panel: panel-simple: Power the panel when reading the EDID
4318ea406e02 drm/panel: panel-simple: Remove extra call:
drm_connector_update_edid_property()
b137406d9679 drm/bridge: ti-sn65dsi86: If refclk, DP AUX can happen
w/out pre-enable
f7a5ee2cd3e2 drm/bridge: ti-sn65dsi86: Code motion of refclk
management functions
9bede63127c6 drm/bridge: ti-sn65dsi86: Use pm_runtime autosuspend
5c4381eeb709 drm/panel: panel-simple: Get rid of hacky HPD chicken-and-egg code
bf73537f411b drm/bridge: ti-sn65dsi86: Break GPIO and MIPI-to-eDP
bridge into sub-drivers
bef236a5206c drm/bridge: ti-sn65dsi86: Move all the chip-related init
to the start
f94eb8a32863 drm/bridge: ti-sn65dsi86: Cleanup managing of drvdata
3636fc25f760 drm/bridge: ti-sn65dsi86: Add local var for "dev" to simplify probe
52d54819c8ae drm/bridge: ti-sn65dsi86: Clean debugfs code
dea2500a820c drm/bridge: ti-sn65dsi86: Use devm to do our runtime_disable
905d66d08d0f drm/bridge: ti-sn65dsi86: More renames in prep for sub-devices
db0036db4851 drm/bridge: ti-sn65dsi86: Rename the main driver data structure

Things not pushed:

[v5,15/20] i2c: i2c-core-of: Fix corner case of finding adapter by node
-> Can't push i2c things

[v5,14/20] drm/bridge: ti-sn65dsi86: Promote the AUX channel to its own sub-dev
-> Won't work without rework. See [1]

[v5,19/20] drm/bridge: ti-sn65dsi86: Don't read EDID blob over DDC
-> Needs Laurent and also patch 14/20 to be resolved.

[v5,20/20] arm64: dts: qcom: Link the panel to the bridge's DDC bus
-> Needs all the rest resolved.

Let me see if I can find a way to work around the AUX channel stuff
and then I'll push a v6 of just what's left.

> Just to keep you busy and make sure you don't run out of work
> (haha) I noticed that the gpio_chip in this driver can use
> the new GPIO_REGMAP helper library with the fixes just
> landed in Torvald's tree.
>
> At your convenience and when you think there is too little
> stuff in your sn65dsi86 TODO, check out
> pinctrl-bcm63xx.c for an example of select GPIO_REGMAP
> made very simple (this works fine as long as they are bit
> offsets starting from 0).

I seem to recall you mentioning something like this. When I looked at
it in the past I wasn't convinced it would be easy. See my response
[2]. The rough summary is that I didn't think the helpers were happy
with the pm_runtime() model that I'm using. Did I get that wrong?

[1] https://lore.kernel.org/dri-devel/CAD=FV=UTmOP8LDaf-Tyx17OORQK6pJH6O_w3cP0Bu-KRYaHkYw@mail.gmail.com/
[2] https://lore.kernel.org/r/CAD=FV=VqD-dY=v23KYuTqy8aRNQJJzJ7h_UOcdEBYuK9X51MQQ@mail.gmail.com

-Doug
