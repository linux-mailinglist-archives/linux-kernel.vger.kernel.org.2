Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8933C32BD3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384131AbhCCPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:36:29 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:45992 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356812AbhCCKsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:48:23 -0500
Received: by mail-lf1-f46.google.com with SMTP id k9so16441723lfo.12;
        Wed, 03 Mar 2021 02:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jYgzsnlOAmYZJCXvodiiaS5LSTl/fmjcB2g3B44MqBU=;
        b=kiKxQTi1UmFpZGW2AB3jjJm0rurOjuD0TSrDUC8W2CSRi3BaAXLHb70YbAXukbaS1U
         sKWJH9mkj5I/ZxjoJJ05MgD/bG1GqKwoEBLNTdvIlFAs1blZOQlh6IBNdtolYJ+IJ1Mw
         0N4pSoZxmfvnCasEUR89xoG8qdEv7/wW51FVjnOFd4LJC0F8/fHxiG9462DreYWrambg
         IoWTTtY6ixXFwTfXBbu9YEx8EX2DQtlsXwDsxtYDVWgF9kZkUp+vwNq2L02IagXuEV5Q
         kXg1KZwg7H33i/xxS7/GupdygW684pbmQG+vW3FA61UT/oWu8eZWa6jPC6Qo+P4BWZrt
         nJ0Q==
X-Gm-Message-State: AOAM532wZ+/+MynSgFjyc1d0TmoSEaFFDdVpMFZXeWe2ZRfynZzrQMkU
        E9y3gStoX/W8AFPxluPTp6N+lTMKfT0=
X-Google-Smtp-Source: ABdhPJxWgi3dnPLit7ylRzc3OmTAEL9RYSBCM13MOHiSLsmqvfM1liV4Oac7SYcpo1euA5vnbYeGrQ==
X-Received: by 2002:adf:b345:: with SMTP id k5mr27360948wrd.14.1614767920947;
        Wed, 03 Mar 2021 02:38:40 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a21sm7112918wmb.5.2021.03.03.02.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 02:38:40 -0800 (PST)
Date:   Wed, 3 Mar 2021 11:38:39 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     taehyun cho <taehyun.cho@samsung.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Message-ID: <20210303103839.it7grj3vtrdmngbd@kozik-lap>
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com>
 <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YD9lTjWc25Nn7jAR@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:30:38AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 03, 2021 at 11:24:01AM +0100, Krzysztof Kozlowski wrote:
> > On 03/03/2021 03:26, taehyun cho wrote:
> > > 'ARCH_EXYNOS' is not suitable for DWC3_EXYNOS config.
> > > 'USB_DWC3_EXYNOS' is glue layer which can be used with
> > > Synopsys DWC3 controller on Exynos SoCs. USB_DWC3_EXYNOS'
> > > can be used from Exynos5 to Exynos9.
> > > 
> > > Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
> > 
> > NACK because you ignored comments from March. Please respond to them instead
> > of resending the same patch.
> > 
> > Anyway, when resending you need to version your patches and explain the
> > differences. Please also Cc reviewers and other maintainers. I pointed out
> > this before:
> > scripts/get_maintainer.pl -f drivers/usb/dwc3/dwc3-exynos.c
> > 
> > The driver - in current form - should not be available for other
> > architectures. It would clutter other platforms and kernel config selection.
> > If you want to change this, you need to provide rationale (usually by adding
> > support to new non-Exynos platform).
> 
> No, these crazy "ARCH_FOO" things need to go away.  For systems that
> want to build "universal" kernels, why are they being forced to enable
> "ARCH_*" just so they can pick specific drivers?  That is not done on
> other architectures, why is ARM64 so "special" in this regard.
> 
> How do you "know" that these cores/devices are tied to specific ARCH_
> platforms?  We don't, so that dependency should not be there.
> 
> Just let any arch pick any driver if it can be built, you never know
> what it might be run on.  Removing ARCH_ dependencies in Kconfig files
> is a good thing, please do not discourage that from happening.

It's getting more generic topic, so let me Cc Arnd and Guenter (I think
once I discussed this with Guenter around watchdog).

This is so far component of a SoC, so it cannot be re-used outside of
SoC. Unless it appears in a new SoC (just like recent re-use of Samsung
serial driver for Apple M1). Because of the architecture, you cannot
build universal kernel without ARCH_EXYNOS. You need it. Otherwise the
kernel won't boot on hardware with DWC Exynos.

Since DWC Exynos won't work without ARCH_EXYNOS - the user will not get
any usable binary - I think all, or almost all, SoC specific drivers are
limited per ARCH. This limits the amount of choices for distro people
and other kernel configuring folks, so they won't have to consider
useless options.

Anyway, that's the convention or consensus so far for entire SoC. If we
want to change it - sure, but let's make it for everyone, not for just
this one USB driver.

Best regards,
Krzysztof

