Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEEA4235C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 04:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhJFCWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 22:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJFCWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:22:07 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0515DC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 19:20:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p80so1102879iod.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 19:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qw5ALBDvPGn69OlbxmlXviRczREpAygguJSlIswWdLw=;
        b=gouZhV8KTp3FExHNgmSHQ9NHjT/H6/1XmoQCCbIXdLmuBMdoHLkUyKYpnhvJm5m9TR
         mCA9H/CGQFKjUHotNj3soqKVAz3xOTjg+B2dFqVtFImI8FxSasJg8IyJKA0a6hAapP8L
         BMiPDMN9+TBopb54525kdJsgwGGqZLTPYFYaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qw5ALBDvPGn69OlbxmlXviRczREpAygguJSlIswWdLw=;
        b=ys8P7GGIqtMgDJY+PDO9u5TmFIMSv1KzKXJzdaoaT6QVSCzQNEOqhw5f8o2ZGOutBB
         mLbVJ1Ee4MsIUXrbtTNsLCDYMLWmoMNqgI2jT8AGGzoVFUWmMEQDXXj/7Rfvct8PODiZ
         rBE6Mh8hwqVd73RwCCe1m337yWJ02qkf6zHx1fUujtbHP+/ry6aMJSdYNSZXM9+MnsSl
         Eo3wqZj6WHGi+U4+5bm3wcGMWF4zHl3pl27YG9QBuamP0KB0/LgJcN9xjBRruN/wij95
         JHm2X2l3C6OxONOksNQRTG3nnoMjGT2WsC5NhzYNV3m7AWfQeWAA6uaL8hqiK4T6pV6u
         WGzQ==
X-Gm-Message-State: AOAM530K/wDjKmaQCZscswZLJ9K4DTjjKBxQJMe7vYkqnucPR8abhqzI
        t/mczr/mUM92za1EfYkSM0BfG6JlYpF1Jg==
X-Google-Smtp-Source: ABdhPJxrLhkyBa9Xor4J+4VylhDVkjNvWVbZn9ncqI3nc4ExKvqHZPdfbtXCAel65q3Z1CWdsjv/Dw==
X-Received: by 2002:a5e:a916:: with SMTP id c22mr4516595iod.211.1633486815220;
        Tue, 05 Oct 2021 19:20:15 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id v4sm570977ile.24.2021.10.05.19.20.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 19:20:13 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id g2so225197ild.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 19:20:13 -0700 (PDT)
X-Received: by 2002:a05:6e02:17ce:: with SMTP id z14mr5414711ilu.120.1633486812940;
 Tue, 05 Oct 2021 19:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211004092100.1.Ic90a5ebd44c75db963112be167a03cc96f9fb249@changeid>
 <YVyAutDoR4otVBS9@intel.com>
In-Reply-To: <YVyAutDoR4otVBS9@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Oct 2021 19:20:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UD0BN55DCCRdFqpvsh9bCnKx0hpoc=5Fqc1F9qDXbyjA@mail.gmail.com>
Message-ID: <CAD=FV=UD0BN55DCCRdFqpvsh9bCnKx0hpoc=5Fqc1F9qDXbyjA@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: Fix crash with zero/invalid EDID
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <oliver.sang@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 5, 2021 at 9:43 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Mon, Oct 04, 2021 at 09:21:27AM -0700, Douglas Anderson wrote:
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
> A bit of historical fallout zone this part of the code. So
> not the easiest thing to read in general. But looks like what
> you have here should work.
>
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Thanks! Pushed to drm-misc/drm-misc-next:

e7bd95a7ed4e drm/edid: Fix crash with zero/invalid EDID
