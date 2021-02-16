Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728EA31C8B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBPKXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhBPKVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:21:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2DA264DE0;
        Tue, 16 Feb 2021 10:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613470861;
        bh=ELgcIQXALPguJaOZgn++Pynu3kfkRH1G8GoAn1mqJ7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dUNelPnuuhmu96bj6fTNcSfGg47UQELco9Wybizd4fEB1Y/c4kFxMzMXmOpiTvjap
         dhzMWT3ffyy863iy2K1oUy5JCvgwb3+ohpz/xFE6/t1KwKJ4Dh65Q5NDKSsA7LWwYc
         IAOv468qpJQ7/a8lOkiFljTzalBE/tAHpFnhXTfz/4LZSo0i6i2Iqh/UKdXizawoXC
         eC19rg+pFzrgWQ4paUI8i5vfujOENcw2lhsJ59zC98szkP65I/e42JCxIHAd1QkGu+
         jcfslsRYBk49+SuyxdPTBc1pQqqTkv78BiIQ2EI6+zMpWfP7EIPnzwH3EBdZk4d6Sd
         iQSx67iLfrylg==
Received: by mail-ej1-f49.google.com with SMTP id g5so12149426ejt.2;
        Tue, 16 Feb 2021 02:21:00 -0800 (PST)
X-Gm-Message-State: AOAM531DwpUExM21556kTFZS4pbhoqIWtIpPkBpPEhB0yqDnAdyFsf9r
        F+vUj0DxavsJ0DCASmULWLwWpxQTjMrQATktoKY=
X-Google-Smtp-Source: ABdhPJxX5NZv34e/hqZBU7CvR8NWGRl3k9oSuP8v63dIVVtzMYfS1vLWWxVVIDu5jyJywxm+62+AJJnAl0q6bab3aBM=
X-Received: by 2002:a17:906:2898:: with SMTP id o24mr19293928ejd.215.1613470859401;
 Tue, 16 Feb 2021 02:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20210215121713.57687-1-marcan@marcan.st> <20210215121713.57687-24-marcan@marcan.st>
 <20210215191748.uhus2e6gclkwgjo5@kozik-lap> <CAK8P3a0YzRVa+fa_7xFxR8f+pwSCo5w5kuaPsSSQscR10jwPww@mail.gmail.com>
In-Reply-To: <CAK8P3a0YzRVa+fa_7xFxR8f+pwSCo5w5kuaPsSSQscR10jwPww@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Feb 2021 11:20:46 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc+j9F_TVq2ir0ehVvph96UgkjRRCK7Df4KR0tVgWOAng@mail.gmail.com>
Message-ID: <CAJKOXPc+j9F_TVq2ir0ehVvph96UgkjRRCK7Df4KR0tVgWOAng@mail.gmail.com>
Subject: Re: [PATCH v2 23/25] tty: serial: samsung_tty: Add earlycon support
 for Apple UARTs
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 at 11:19, Arnd Bergmann <arnd@kernel.org> wrote:
> > > +     return samsung_early_console_setup(device, opt);
> >
> > Don't you need to handle the error code - set PROT_DEFAULT() or whatever
> > was there before?
>
> __set_fixmap() has no return value, it just writes a page table entry and
> does not fail.

I meant, handle samsung_early_console_setup() error code (NULL).

Best regards,
Krzysztof
