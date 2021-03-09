Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17881332C4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhCIQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhCIQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:38:07 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3D6C061761
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 08:38:06 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n16so28107609lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXEn5JSpgBw/y2eHpwVO9g48Km7rMDXnZlE1bBW2r8s=;
        b=XbafCFFSFzMS+QhMLTOXgWvBugQJw48RI2zwRMEER0qGPENxJ5iZchaFs+rKwEnikM
         1tw9Xx483823KTezlF5evj1N7lBynSwiixNRWDWfNIVwAwowxVk550YYcbVzT4P0nXjo
         zmqi+9cd7JD9CdkiObbpmaNyz8VKgVTn9dhW1K1yaPxT+7VZEao5sP53AUdNGDXHri3j
         k4lx6fKk6tszQoyJgAFHNqhhGRyB8+9bsJ/F3zZC4Xcu2m+9UA3oJ7PGHWX2fITVWdQk
         Ps67OIw9ivU5AytiWUd3KoemZe4H9sK75XQy3jxZH8dQNjSC9JWOYLeMiNGL+Nh+KsVk
         lpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXEn5JSpgBw/y2eHpwVO9g48Km7rMDXnZlE1bBW2r8s=;
        b=GQk2RGittonyzbEVApLc7hdb8cVn/6KB3RHUcBeJRYA6le92c75AubrUdEpHrasU22
         sYcCcq+FDBQSRtZu1tSdUfP448I2Dm/qe9CHu0XC9Dqzj1HVDOwql6zkfubLTTbgn8ra
         7iFNLMy6UKvKVpGMMdnwOkb+5Ot9NP/6GNEDdThe8WKDEhgESmeKZY4HgNIuWcm43rAE
         v2Dv2QuHI3xT1noLrTi+OLFphrcnaHfck5+csOA7HQz+Krz5wrb0P6D//t5ARUmertw9
         HEgum+u0y/M5O72ox9n01rWfjlgsuhBCgz2YM+TlfJLx59Cy/FXVr4nBDpeJyjL89x2i
         eHdQ==
X-Gm-Message-State: AOAM5335gjxDRdiWnYi8IZTqdlk2SOdrnU/l98Omfqdhr7vghMdtRmfW
        sfZBpgq2kBJTVFMzO3hWR+u/CMA6KBDj7PLucavjdQ==
X-Google-Smtp-Source: ABdhPJzph/W4+niKbEazqjfqIFq8ME97OA1IS7zhqExaRlDOuU14W5Llytf7OgyeKHYK9RZaGHLYo9BD0e1mWXcMU3o=
X-Received: by 2002:a19:6b13:: with SMTP id d19mr17882973lfa.291.1615307885055;
 Tue, 09 Mar 2021 08:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-27-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-27-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Mar 2021 17:37:54 +0100
Message-ID: <CACRpkdYzkOCurtLaeyZ+A6EWnSPGU66by4gYoCpLcn=52hTEPQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 26/27] dt-bindings: display: Add apple,simple-framebuffer
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 10:42 PM Hector Martin <marcan@marcan.st> wrote:

> Apple SoCs run firmware that sets up a simplefb-compatible framebuffer
> for us. Add a compatible for it, and two missing supported formats.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Marcan: tell me if you need me to apply this to the drm-misc tree
and I'll fix it.

Yours,
Linus Walleij
