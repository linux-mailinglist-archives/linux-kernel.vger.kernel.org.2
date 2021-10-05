Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AF1421B46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhJEAnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhJEAmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:42:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D4C061764
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:41:04 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r75so22392287iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8/bkKiby+7EkwB2wz+nIC2A5KBIG95pAQLX24jqAYI=;
        b=M4ztBx95ziwV0D+GbQdUtLp28pZJUKwn8h37ftcAcvY9Q+EomhOOR8ELG6jdaRGj3a
         QVUY+CqmNTnFHSoiLipf+EsQQkWXzpd3KFueYcdENLdMuAKkkHMaY/0f7xI77fy+JeFB
         EaXeVy1tYdpZoF8k/8oUKSLYtCLcaRmwShGnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8/bkKiby+7EkwB2wz+nIC2A5KBIG95pAQLX24jqAYI=;
        b=l/SxPnCrUkywpiS1icU4dx8qlUmavaYodb4yYFZJvOd5kZrQe224iCOxhQug3QTp3F
         8C7AL6r2i6WKGT8AcHmPI0bpWjjdr4hhUokO75mfbwASaLJNTqY+vOEtfLhSdPHMfcTE
         qTPK7NE2DnYFVF5KokpQn6IKG1p6NqKX8ERBgKUVRyh0j2QRh1ExKjAk/FJ5Ei7JCrIE
         jIH/x3/jMto6QgNsjH+u0fh5IC+nZpS1Z6fv29PA37+eqC7QYEw1FvdyRhFQS205pbwg
         x4VzRXLMU0lbf6LWCRWjp0GVte+11hhPBuk29Znu6asQV8Zh0hNsPWvGyozTL7t0uC61
         E2Yw==
X-Gm-Message-State: AOAM533wUWm9trUKEIZ9fTrdIpbK4gr40eekeXeXBIPlXIeJkR+YQY9i
        W2twQoeqqiEqY4+5AiR6uthQ+Xn6KuU3BA==
X-Google-Smtp-Source: ABdhPJxil3pNNRzc25ovCHFqTft4B8kgod0e+7G3Oe3gPPlpvf0174fVNEy9NMFn/xJfMA2eFryxFg==
X-Received: by 2002:a02:c4da:: with SMTP id h26mr167978jaj.101.1633394463858;
        Mon, 04 Oct 2021 17:41:03 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id y2sm9865917ioj.12.2021.10.04.17.41.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 17:41:03 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id q205so22382570iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:41:02 -0700 (PDT)
X-Received: by 2002:a6b:2ccb:: with SMTP id s194mr153772ios.128.1633394462524;
 Mon, 04 Oct 2021 17:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211004092100.1.Ic90a5ebd44c75db963112be167a03cc96f9fb249@changeid>
 <CAMuHMdUsoBO2hjd0tAecAjnwCUbp=d8i8vaUFDT6Yn3emw2s9Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUsoBO2hjd0tAecAjnwCUbp=d8i8vaUFDT6Yn3emw2s9Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 4 Oct 2021 17:40:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8MoYX2deqD_YE6ii9+VFbwqX0bre=5xaYe8ZwwExziQ@mail.gmail.com>
Message-ID: <CAD=FV=V8MoYX2deqD_YE6ii9+VFbwqX0bre=5xaYe8ZwwExziQ@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: Fix crash with zero/invalid EDID
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        kernel test robot <oliver.sang@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 4, 2021 at 10:14 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Douglas,
>
> On Mon, Oct 4, 2021 at 6:22 PM Douglas Anderson <dianders@chromium.org> wrote:
> > In the commit bac9c2948224 ("drm/edid: Break out reading block 0 of
> > the EDID") I broke out reading the base block of the EDID to its own
> > function. Unfortunately, when I did that I messed up the handling when
> > drm_edid_is_zero() indicated that we had an EDID that was all 0x00 or
> > when we went through 4 loops and didn't get a valid EDID. Specifically
> > I needed to pass the broken EDID to connector_bad_edid() but now I was
> > passing an error-pointer.
> >
> > Let's re-jigger things so we can pass the bad EDID in properly.
> >
> > Fixes: bac9c2948224 ("drm/edid: Break out reading block 0 of the EDID")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> The crash is was seeing is gone, so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for testing! I'll plan to apply tomorrow morning (California
time) to balance between giving folks a chance to yell at me for my
patch and the urgency of fixing the breakage.

-Doug
