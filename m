Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224A0367211
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245069AbhDURyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:54:47 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:43673 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbhDURyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:54:46 -0400
Received: by mail-lj1-f182.google.com with SMTP id m7so37892181ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=LC2lzwECAZsnsDhvoASp8fXv0S0GlT0VJd1mQnP02Yk=;
        b=WSCi/kgYVIRXe9wETG7QKDJPscYc5GcU0OOQuGn5aHboOjenjwuimEE9vZpr9jqjpL
         okCJ9VZu5lKanw5G8lHngDOsXrWCiMqCyU6hNuogab521w8olxvBjy5o4Hw/MhO8+0Km
         FwGb2gsFXW7AqH8mx7BsCFK1Ow36oIq48ktytM/gPOzj7/EtYTdN2HsinB5whL6q7MTU
         Mjo/uE8OYuZtyftTlG1SEe4UqhKZ84afirnhcBJ5VqcdQcZ/8sPwmLY5aWetjCb0IHJy
         7On842DC0DJHpshZsLkw5RyUQEoA9GGdSacPRl/JJbCT8pSRmsU0yIdwMY7Mz9chz/XM
         EPsQ==
X-Gm-Message-State: AOAM530B5/J4TQLOhK6xql0t7BEPSvwa1EMo1gcVDu+pudAFd7zpCa9x
        oHdOnBH+l9/prKOuKChuhbE=
X-Google-Smtp-Source: ABdhPJzlqslUxu1IDJOWDSp90tnVzPybiWoZyTsQPe9PHRdWKy9qFGbQ6HqV9Te+lfNVvJRI6JU5Dw==
X-Received: by 2002:a05:651c:210b:: with SMTP id a11mr19486963ljq.9.1619027652056;
        Wed, 21 Apr 2021 10:54:12 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id y6sm24814lfh.204.2021.04.21.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:54:11 -0700 (PDT)
Message-ID: <203a8c7449664512883153d4fb1a2c67882a40c4.camel@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: bd71815: select CONFIG_ROHM_REGULATOR
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Fritz <chf.fritz@googlemail.com>,
        Axel Lin <axel.lin@ingics.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210421145302.GA36124@sirena.org.uk>
References: <20210421135433.3505561-1-arnd@kernel.org>
         <20210421145302.GA36124@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 21 Apr 2021 20:54:04 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2021-04-21 at 15:53 +0100, Mark Brown wrote:
> On Wed, Apr 21, 2021 at 03:54:27PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The newly added driver is missing a dependency as shown by this
> > randconfig build failure:
> 
> This doesn't apply against current code, please check and resend.

I guess that the series which this change is patching was merged to
MFD-next but not yet to regulator tree. So, if I'm not mistaken the fix
needs to be applied to MFD - or wait until the rest of the series gets
into regulator tree.

In any case - thank you Arnd. This fix is correct and needed (reviewed
by me).

Best Regards
	Matti Vaittinen

