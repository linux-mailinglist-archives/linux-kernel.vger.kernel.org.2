Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3730344FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhCVTXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhCVTXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:23:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75844C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:23:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u21so5198019ejo.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DX81xpKR3NVOCyK3ejwbrnW+v8s68jGVqeWwVOT6Amo=;
        b=l5t0AGwxS1yfpVVoibj20aQMIcGvSdZuLwxDieUjzW4trn6U6txHei1HKNBTfVPI1c
         oun4GVakBxDjSEIu4y2qge3Vk9c87gY8aPGDOAUczeuKzfkMYIzA+BmW92PoCNXBhcbd
         AQOW95FYeEvnxCsb852kHor4PVhaKkpyuO2DiXwP/ZTLO3paU5KiYF/oOYvJbxzvWzX/
         qy+6M0sZ/EYk35nvCoGp93xP8hekRsRHGpzhS9XK5kMkduubPpeu8bbmyPwB0fNpe+ob
         fOT6ZVzwfyCImD9yQYXz1vqMy9OQO8WZy2Nb9N4QrsNNO3npl/7pnH6qhT1lPfDdRgEH
         d39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DX81xpKR3NVOCyK3ejwbrnW+v8s68jGVqeWwVOT6Amo=;
        b=rhESbISGB7g/qEZy4lNLa0XyW9s1w18+KwlIL1avu9oBNwIk/173GcfIlN7Mx7zHN2
         glHTKjhrMPKScYNmDN4KtsLjoKjnNte+xNOSzHZaI47lKwx4HEFTbShFaEJn7zGEivjG
         tHs4E3zTzU5ROoByudYPiMrqzh6jzoVzyzd97SqCKnvLZk/+GUHDqstGJulV/vjOV4OI
         QnCf8W2NCj/2y8/mmP4tJGbBS2WwgEtOCr7VrFYMO5SyyIzFGqPC5hBGKuy62/6wdl6e
         4RaBX6V0s/hVf8V6TAoypWp5znuHHRaUbVzC+Gsi9eP7g0pD9xCIgdtnez6IzkwRZcoc
         qEHQ==
X-Gm-Message-State: AOAM532ljkmUmInDFOpzHIm243rndvqk8yZE/RiOfrgFZpB2RuR/zVca
        BopvU6ExkyzYFJhn6TVuSEqgTA==
X-Google-Smtp-Source: ABdhPJyplTOh79M3+bB6N3SgTZlTu+XSpnp6lzlPNLrGB2iHs6PVOXKuYGyBm9zQpxMkTw5huPIf2A==
X-Received: by 2002:a17:906:2759:: with SMTP id a25mr1373890ejd.122.1616440995158;
        Mon, 22 Mar 2021 12:23:15 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id u59sm12384865edc.73.2021.03.22.12.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 12:23:14 -0700 (PDT)
Date:   Mon, 22 Mar 2021 19:23:13 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kgdb: fix gcc-11 warning on indentation
Message-ID: <20210322192313.fw46yficc7mfjinu@maple.lan>
References: <20210322164308.827846-1-arnd@kernel.org>
 <CAD=FV=WY6yxx+vkH+UU4VYei29xBftdnyRBE1OpEELmJ-kLfFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WY6yxx+vkH+UU4VYei29xBftdnyRBE1OpEELmJ-kLfFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:04:57AM -0700, Doug Anderson wrote:
> > +       if (verbose)                    \
> > +               printk(KERN_INFO a);    \
> > +} while (0)
> > +#define v2printk(a...) do {            \
> > +       if (verbose > 1)                \
> > +               printk(KERN_INFO a);    \
> > +       touch_nmi_watchdog();           \
> 
> This touch_nmi_watchdog() is pretty wonky. I guess maybe the
> assumption is that the "verbose level 2" prints are so chatty that the
> printing might prevent us from touching the NMI watchdog in the way
> that we normally do and thus we need an extra one here?
> 
> ...but, in that case, I think the old code was _wrong_ and that the
> intention was that the touch_nmi_watchdog() should only be if "verose
> > 1" as the indentation implied. There doesn't feel like a reason to
> touch the watchdog if we're not doing anything slow.

I'm not entirely sure I'd like to second guess the intent here. This
macro has been there since this file was introduced but several callers
have been added since then. We have to guess their intent too!

So, whilst I think you are probably right, v2printk() does appears in
places such as the single step test loop which makes it pretty
difficult to decide by inspection whether or not touching the watchdog
is useful.

It's something that could be further examined... but I'd be a little
reluctant to combine it directly with a whitespace change!


Daniel.
