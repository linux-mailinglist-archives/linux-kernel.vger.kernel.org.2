Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012023B4BB2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 02:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFZAv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 20:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFZAv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 20:51:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649E9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 17:49:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hz1so17900157ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 17:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsPYqHisx+CRriQgLe+WZPgjbFJGODTyPk7JJCtjcMA=;
        b=MBfVWP/HXgTW8+j5vKh+7gR/wE4PEAQ5obDdr2IT6jHMw2gcw3vpWyQj8uXQecgkIb
         jkjK6xT98jrNObCf9goyrMY35okHovQ6qpzIr4mSgQHGgBbe8JNaWvxbblCPkDISeG6r
         Ymx/Ou8Y/VblYyPMAtIXOIm+Ifgwo/sYWtJ/5LqqswxRjaj4QRkzQG0qP3vYK4yWXxNU
         JJWSnTu2edBUN2ggYzDHR6Sw+D+d9VDQ7xDTVIur1L7RRA5JVpRasZyc0pBrXFQv9vk5
         gqoEvKomXtKTLNGyqHFFDOiFL7vwzJmas2z+Xbu92SUHcjBWz9NrVE7WL1FBx0+jCVFn
         6SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsPYqHisx+CRriQgLe+WZPgjbFJGODTyPk7JJCtjcMA=;
        b=lY6ttd7MfwgFJo5fm/RTYcsjyjpvrM2pgq0R8SBBUamdZoJZSB8P1mz4ikCOGgHUSc
         m8WG18AdhS+0Ve2VOQLbSt/bf9Bhk36oT9Ad2UQ1Dydn5Ux+kNl+VPRLAgoTNWqsLnOl
         gK+7ruXjHmY0doNRQeuZZ9KwHzNk55FZhYjTtqYAXwSCr5H6iWUZdoEDtTVYzzIzVVoo
         vzLcG5i2GOYr0yAgLbaBXzEsBtYRL8ZkDWpf5XydV09aiz9DNDyZTkkmGZMajDHvZAdR
         nZHDbk4z31KNcQt0Zh7Vy8rXe66PWNTrzYq9RJGGzfPlJuk5nxy1nQaOIOWrs0SPS7q2
         x33Q==
X-Gm-Message-State: AOAM533qYJSKU71AhI3evgzbybJE+tBvmVHR+cBKr+P7bAtm+D0BZyXy
        cxw+PI4g2+JdIlqixZlsmyCTmOpUniO619IR0qAbKSVOwd1InMb0
X-Google-Smtp-Source: ABdhPJw3h+8mJ9wnFOy59j/eYjUYZ82HsFuKqw+J4R2ORDG35gdsMWC5BADAWJrZfv9ja72PhHyOOwcNl596QarNLbg=
X-Received: by 2002:a17:907:264b:: with SMTP id ar11mr13377197ejc.525.1624668572742;
 Fri, 25 Jun 2021 17:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210622043329.392072-1-axel.lin@ingics.com> <20210625183935.17fae37f@coco.lan>
In-Reply-To: <20210625183935.17fae37f@coco.lan>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Sat, 26 Jun 2021 08:48:56 +0800
Message-ID: <CAFRkauBKCpp95yFEYsH6TEfzSWc--zqR8oLVkmdExmTOiVS-iw@mail.gmail.com>
Subject: Re: [PATCH] regulator: hi6421v600: Fix setting wrong driver_data
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -     mutex_init(&sreg->enable_mutex);
> > +     mutex_init(&priv->enable_mutex);
>
>
> > +     platform_set_drvdata(pdev, priv);
>
> This won't work, as platform data was already set, as it is already used
> as part of the MFD/SPMI binding logic. With the current

I think you mixed dev->platform_data with dev->driver_data.
Can you check again?

Regards,
Axel
