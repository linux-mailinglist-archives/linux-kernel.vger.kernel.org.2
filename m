Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0C44699D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhKEU2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhKEU2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:28:01 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453A3C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:25:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d70so11123268iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrK07k0Lpn9CHC7K58jZi/mGEAzkF+QHwrwjm8onEpQ=;
        b=J5P2n9oSkKMVEby8FUnF9XKM7m7v29C9QXYnLi8ad3Gc0hFBr8XXUfoBnhnXCvQbCT
         jjaOYs//TeGM0x1WTuneAjydHwuzeXNZNwzHdKUuZS2sIpjpZ2EB5MdBULXyZcxFH2im
         KFtNl/2wO/3NMsNLqEPqj3//SqItdZo7l97A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrK07k0Lpn9CHC7K58jZi/mGEAzkF+QHwrwjm8onEpQ=;
        b=43+rKvpDUgQ8qcK6a8UtFY547mzvJgLXsICFYtHk5LrY0Fdc6RozvS9Rpa4/Ezw56f
         o3eKG0wWISkqhyZ0RaSWwHUYFqV3P1fS627Zb8yZ3MlEnvZ9wv7cIIM+Pe81KWIu7bC4
         V16OJ2TJDb9V2/MFEF5keUQy1bm+bBX9UhlxS+iimk0uYoFkYtzlmHhqSJFaSdlXeCaT
         W5x0GYnGaUj6gPRu1vUEqdPpHlGHYOLTpzd+JHGRa+QIviDngeklIrs3y489h3rtLfN0
         3fmiA3TBKxv4ZjENmVg+wAM+OIVKe+1OYMMNG8gbJIVf6p3ZpCT5tLUVLqUP/+axPdly
         +gxA==
X-Gm-Message-State: AOAM530WNb3HFBtCTObuo/LA5p8GR1JOcTwXUzPmAWcmmp2jXxtTjaFE
        q9Nkcv3ayA9/K+tvzE990vN3uGbEiR/3mw==
X-Google-Smtp-Source: ABdhPJwkYCzOoyTghHLNVnCVOhZl+51oXbC96pJiOUMKc/zwiAW5j5+uvgbN7eEtQeQ2dwo6jzbY9A==
X-Received: by 2002:a05:6638:2113:: with SMTP id n19mr11076757jaj.8.1636143920453;
        Fri, 05 Nov 2021 13:25:20 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id d7sm3541179ioh.0.2021.11.05.13.25.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 13:25:19 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id y17so10656258ilb.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:25:19 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a67:: with SMTP id w7mr35042875ilv.165.1636143919429;
 Fri, 05 Nov 2021 13:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211105183342.130810-1-lyude@redhat.com> <20211105183342.130810-4-lyude@redhat.com>
In-Reply-To: <20211105183342.130810-4-lyude@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Nov 2021 13:25:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VA53LyEA+jDfU6mQ0USwfSBiLK8KfWfc91U9X9f=oN9g@mail.gmail.com>
Message-ID: <CAD=FV=VA53LyEA+jDfU6mQ0USwfSBiLK8KfWfc91U9X9f=oN9g@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] drm/dp: Don't read back backlight mode in drm_edp_backlight_enable()
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 5, 2021 at 11:34 AM Lyude Paul <lyude@redhat.com> wrote:
>
> As it turns out, apparently some machines will actually leave additional
> backlight functionality like dynamic backlight control on before the OS
> loads. Currently we don't take care to disable unsupported features when
> writing back the backlight mode, which can lead to some rather strange
> looking behavior when adjusting the backlight.
>
> So, let's fix this by just not reading back the current backlight mode on
> initial enable. I don't think there should really be any downsides to this,
> and this will ensure we don't leave any unsupported functionality enabled.
>
> This should fix at least one (but not all) of the issues seen with DPCD
> backlight support on fi-bdw-samus
>
> v5:
> * Just avoid reading back DPCD register - Doug Anderson
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 867cf9cd73c3 ("drm/dp: Extract i915's eDP backlight code into DRM helpers")
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 40 ++++++++++-----------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)

You forgot to CC me on this one! ;-)

This looks good to me now, so FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
