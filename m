Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593C940591E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbhIIOgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbhIIOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:36:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896B8C16F95C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 06:44:35 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q3so2339979iot.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MT6LELj4ua3aahT+trdn6bXJH9gCWz9tbef2rNohf7g=;
        b=IXyY+qdUdaheRneEYpQoeQaywPUici9JGiF9t3WphFb1G7trbxB12r2NpEjXOwCtSr
         9M99G/fDFwvMROTDGAX4O+m4sTH51AVg6zKXEzgcq4Ebs7UyZpLBlwjyyGtQyybTS6Zp
         ennj9eYjrCgyO+gT45uBHdiqbU+TFK9SoPHSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MT6LELj4ua3aahT+trdn6bXJH9gCWz9tbef2rNohf7g=;
        b=8G6/UvrdUfN+Jxu0OIIyCUpORdYSK2v9qXGEWB5cWvGoSafHjcYixjlzLdPtwbZF8R
         QerwP4Ne3xNeA3zsNj8O2g768/xnp3RkITPkH6wT4107urH3i1vbfXVJWqXOkkoCr6by
         7hq5dZBwn21T61d/X4OKndZ99S3OnWoSk79JDNjzK3fylhqwS7UueyVCaku9rxODTMPL
         P0jBVlcvMZ2zgkzQc5ZPFB/vLexs9ahQIut9ptknYs6RU5EsooCC4EMc9X/TnVmzsNJV
         bL+Jc1UNRw2JQd3lqHiHE/49r7OaIqDGHTpNCpTRIIjr3nyfgmyrmcscEsit5oE6J60F
         1zrA==
X-Gm-Message-State: AOAM532Gp+6efvou4AKE5qJTvxJKV96OdQiH7TOiSaCjEsmc3PFnqRdY
        Pu6+F2tP/8gIrZsP8jeIxbFcrIP2k6nnGA==
X-Google-Smtp-Source: ABdhPJzyBJ3/6J4jOkKtHLfZz72UEp15gMbODSMGJuiA+MyIy3e314FmZjl01OTtHmjE6RN7UurVtg==
X-Received: by 2002:a05:6638:619:: with SMTP id g25mr2920950jar.38.1631195074615;
        Thu, 09 Sep 2021 06:44:34 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id b8sm882629ilc.41.2021.09.09.06.44.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 06:44:34 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id x5so1949181ill.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 06:44:34 -0700 (PDT)
X-Received: by 2002:a05:6e02:e02:: with SMTP id a2mr2454160ilk.180.1631195073651;
 Thu, 09 Sep 2021 06:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210909014623.128976-1-sashal@kernel.org>
In-Reply-To: <20210909014623.128976-1-sashal@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Sep 2021 06:44:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U2dGjeEzp+K1vnLTj8oPJ-GKBTTKz2XQ1OZ7QF_sTHuw@mail.gmail.com>
Message-ID: <CAD=FV=U2dGjeEzp+K1vnLTj8oPJ-GKBTTKz2XQ1OZ7QF_sTHuw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.14 001/252] drm/bridge: ti-sn65dsi86: Don't read
 EDID blob over DDC
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 8, 2021 at 6:46 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Douglas Anderson <dianders@chromium.org>
>
> [ Upstream commit a70e558c151043ce46a5e5999f4310e0b3551f57 ]
>
> This is really just a revert of commit 58074b08c04a ("drm/bridge:
> ti-sn65dsi86: Read EDID blob over DDC"), resolving conflicts.
>
> The old code failed to read the EDID properly in a very important
> case: before the bridge's pre_enable() was called. The way things need
> to work:
> 1. Read the EDID.
> 2. Based on the EDID, decide on video settings and pixel clock.
> 3. Enable the bridge w/ the desired settings.
>
> The way things were working:
> 1. Try to read the EDID but fail; fall back to hardcoded values.
> 2. Based on hardcoded values, decide on video settings and pixel clock.
> 3. Enable the bridge w/ the desired settings.
> 4. Try again to read the EDID, it works now!
> 5. Realize that the hardcoded settings weren't quite right.
> 6. Disable / reenable the bridge w/ the right settings.
>
> The reasons for the failures were twofold:
> a) Since we never ran the bridge chip's pre-enable then we never set
>    the bit to ignore HPD. This meant the bridge chip didn't even _try_
>    to go out on the bus and communicate with the panel.
> b) Even if we fixed things to ignore HPD, the EDID still wouldn't read
>    if the panel wasn't on.
>
> Instead of reverting the code, we could fix it to set the HPD bit and
> also power on the panel. However, it also works nicely to just let the
> panel code read the EDID. Now that we've split the driver up we can
> expose the DDC AUX channel bus to the panel node. The panel can take
> charge of reading the EDID.
>
> NOTE: in order for things to work, anyone that needs to read the EDID
> will need to instantiate their panel using the new DP AUX bus (AKA by
> listing their panel under the "aux-bus" node of the bridge chip in the
> device tree).
>
> In the future if we want to use the bridge chip to provide a full
> external DP port (which won't have a panel) then we will have to
> conditinally add EDID reading back in.
>
> Suggested-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20210611101711.v10.9.I9330684c25f65bb318eff57f0616500f83eac3cc@changeid
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 22 ----------------------
>  1 file changed, 22 deletions(-)

I would suggest against backporting this one unless you're going to
backport the whole pile of DP AUX bus patches, which probably doesn't
make sense for stable. Even though the old EDID reading was broken for
the first read, it still worked for later reads. ...and the first read
didn't crash or anything--it just timed out.

-Doug
