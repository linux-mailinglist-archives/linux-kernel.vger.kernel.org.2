Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF73CA11D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 17:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhGOPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhGOPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:08:39 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F20C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:05:45 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 77so5442900qkk.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9XBHwcIdHUxNKVM4wGK0XBk/N9gC6lff9eNP3xp8WY=;
        b=IKakzWP6ML7xBuxkG8r1AUGroQm9EkS34wWZtZi/qPupZNGIx9Y50ImRtszCPvWqtr
         HNjpoZK6U443+FrGhIV7rvo6yEkYmgj+lOu+n4Seg+Rax7o+RsJQYfea7pHvYpi9HS8j
         jvjFt64ikbioYi8gqiKhjGSP3tvZTy10B8AUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9XBHwcIdHUxNKVM4wGK0XBk/N9gC6lff9eNP3xp8WY=;
        b=IT/qVhhTZmKei76vw9LlUKQpqBYGH3eRB6Eb1vVMib++Lwjh62PPDAeGlcc9p5Vmww
         eT4EZAUZ5RlJ5jywmKSAQw0WmXOtxqSqsZy0TM/eDSwlQzWfAOtCnxUKgsTIlwPpjfVW
         67RNwAJ/kdTtgmmRxq81zWb3MeUSaNsxshM5MQiJBLq5qUmdGFk80Szv3ZdxBJU492ct
         RNeBdlxDg+3SHspsg2IedeGTUgs1hUfno8R/1XbcPiUtMXc4ESC6H7hqVtjtDNfaO/Qc
         NIVnK/sI6/yPPXZ5Mcx/21JFQtRag8AV28qrYfgf8yQwxNryNmKf8Br0UuvwzL7vjhvF
         wD+A==
X-Gm-Message-State: AOAM5338ghdzAidtf2vc9V7Y2hI2jpFXGdEKzbTb/mcSzcasQATySEtV
        SBPFUGtSG8q1o2HKE2Wi+XsPGTWum3u05w==
X-Google-Smtp-Source: ABdhPJw9c8MSSiBBYo68S5C8TSatP7wyTcVs+usVV3JBA8T26PTnOX1NzTeVf4dYph3Q0Pq7v6ZeyA==
X-Received: by 2002:a37:a413:: with SMTP id n19mr4459426qke.462.1626361543754;
        Thu, 15 Jul 2021 08:05:43 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id j3sm2545347qka.96.2021.07.15.08.05.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:05:43 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id r135so9662610ybc.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:05:42 -0700 (PDT)
X-Received: by 2002:a05:6902:521:: with SMTP id y1mr6092923ybs.32.1626361542520;
 Thu, 15 Jul 2021 08:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210714093334.1.Idb41f87e5abae4aee0705db7458b0097fc50e7ab@changeid>
In-Reply-To: <20210714093334.1.Idb41f87e5abae4aee0705db7458b0097fc50e7ab@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Jul 2021 08:05:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULfkbw08xH7D1K2HvpiYzQCGFT8oqVAOnpTcdmRTGC3g@mail.gmail.com>
Message-ID: <CAD=FV=ULfkbw08xH7D1K2HvpiYzQCGFT8oqVAOnpTcdmRTGC3g@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-simple: Power the panel when probing DP AUX backlight
To:     Rajeev Nandan <rajeevny@codeaurora.org>,
        Lyude Paul <lyude@redhat.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 14, 2021 at 9:34 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> When I tried booting up a device that needed the DP AUX backlight, I
> found an error in the logs:
>   panel-simple-dp-aux: probe of aux-ti_sn65dsi86.aux.0 failed with error -110
>
> The aux transfers were failing because the panel wasn't powered. Just
> like when reading the EDID we need to power the panel when trying to
> talk to it. Add the needed pm_runtime calls.
>
> After I do this I can successfully probe the panel and adjust the
> backlight on my board.
>
> Fixes: bfd451403d70 ("drm/panel-simple: Support DP AUX backlight")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-simple.c | 3 +++
>  1 file changed, 3 insertions(+)

Pushed with Lyude's review to drm-misc-next:

5ead9b5b1575 drm/panel-simple: Power the panel when probing DP AUX backlight
