Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7027355C28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhDFTZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbhDFTZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:25:25 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1034BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 12:25:17 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so15709927otb.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r8FrDvlhVQSR8Ju+eXU79u5LULU4LRHUL5/yvNgxUos=;
        b=AWKsxNZGnQvx/OgF7t6YZs8rm5ppVAP2TjaDbZTMqm9s+Yd3JAQeNWVGfbDoUB35gN
         1svCfBthWA1SeM0d+OCg/gkq/jxWj7ch0AsxYjJaz9EvgsXTDQDKxW9WF/cn1Qt8TUuW
         1dLCPbt57RBxJkdlJhHNWCDbTSbbRTAqVcp8POLW185sZ0Z25WiHvq7y7VCMlIa6UVuB
         HBwwRuvnmwGB/7zlWZmnRvNTIF1JkEORhp4ECXNX7BfSF2MCbajEwZgUJFV2TunBYdMv
         CbuKX9QkY85rnZVD8p05qriRS07pUZpJEwQh2yPSH3GLlZGQFRCHbKzZO4Wlji0ZbFC1
         mCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r8FrDvlhVQSR8Ju+eXU79u5LULU4LRHUL5/yvNgxUos=;
        b=hEk6V38ei6uHVSf8ZTAZ7gy/fs42fbUM9yNewmPVHgitZdSXdVRTFnpEQES9VSmbpZ
         OqY1cX6vEadQQuRVyRei5wM+0W2W7euVf3L+3FE+Zz5LKRtU8jIJz3WWsQvj1Wym3GjG
         iFUry6PuFrLuKqmiZZK5N2xVX+rXhdQHFonioWuze+vVVqcCMtnhZ+XX8P30KfvgXsbz
         /EUCTN+ktMvCx+cMrHJ29ZxpbtboyE0Un4FOwza/8c/6B8g3Pi8/sVu693W9vJn0mhkb
         1Gkr97MpvI0h1G/oFiPPwaWadlD+zLI7+gK9g+K2nYUxyrNOqlXXulKaBXHJyOujzCzF
         SoBg==
X-Gm-Message-State: AOAM533J8/C6j4IVnYpaaQ8Mi5cJzSSJEU4HtKBpFeJJ9B4WRfpPwOMf
        RPIXlmYY1L/yXd89JDe3qTbSL2t0cvc=
X-Google-Smtp-Source: ABdhPJwJaOmYWjpIoo6mE3nDk3y37Thfwo2Mqy18HbCRFoEP4MX3jAKKrPjxzSTZe99IcY9hhwrtMQ==
X-Received: by 2002:a05:6830:24a1:: with SMTP id v1mr26898293ots.119.1617737116463;
        Tue, 06 Apr 2021 12:25:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 62sm4875577oto.60.2021.04.06.12.25.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Apr 2021 12:25:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Apr 2021 12:25:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v1 1/1] driver core: platform: Make
 platform_get_irq_optional() optional
Message-ID: <20210406192514.GA34677@roeck-us.net>
References: <20210331144526.19439-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331144526.19439-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 05:45:26PM +0300, Andy Shevchenko wrote:
> Currently the platform_get_irq_optional() returns an error code even
> if IRQ resource sumply has not been found. It prevents caller to be
> error code agnostic in their error handling.
> 
> Now:
> 	ret = platform_get_irq_optional(...);
> 	if (ret != -ENXIO)
> 		return ret; // respect deferred probe
> 	if (ret > 0)
> 		...we get an IRQ...
> 
> After proposed change:
> 	ret = platform_get_irq_optional(...);
> 	if (ret < 0)
> 		return ret;
> 	if (ret > 0)
> 		...we get an IRQ...
> 
> Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch causes all my "sh" emulations to stall during boot with the
following repeated error message.

sh-sci sh-sci.1: Can't allocate rx full IRQ

Reverting this patch fixes the problem (and the message is gone).
Bisect log is attached.

Guenter

---
# bad: [9c54130cd25528028b2d38f6ada0c79e92210390] Add linux-next specific files for 20210406
# good: [e49d033bddf5b565044e2abe4241353959bc9120] Linux 5.12-rc6
git bisect start 'HEAD' 'v5.12-rc6'
# good: [3981dcd7199773fc8cfbbcc6173e3521b8e49035] Merge remote-tracking branch 'crypto/master'
git bisect good 3981dcd7199773fc8cfbbcc6173e3521b8e49035
# good: [da18b6c82eba21e87d6ee76b7b0382eca123cc79] Merge remote-tracking branch 'ftrace/for-next'
git bisect good da18b6c82eba21e87d6ee76b7b0382eca123cc79
# bad: [021e2b99a3cb523408609ca1792ab623ff16f334] Merge remote-tracking branch 'staging/staging-next'
git bisect bad 021e2b99a3cb523408609ca1792ab623ff16f334
# bad: [685f903c62e3929370293bad184afa04b6fddebd] Merge remote-tracking branch 'char-misc/char-misc-next'
git bisect bad 685f903c62e3929370293bad184afa04b6fddebd
# good: [67d49fe7e4d40cfe6919b434d6a4e837230af9d4] Merge remote-tracking branch 'ipmi/for-next'
git bisect good 67d49fe7e4d40cfe6919b434d6a4e837230af9d4
# bad: [69e2ae87cfa94c77c3503715e9e0a68e6cc69f8d] Merge remote-tracking branch 'usb/usb-next'
git bisect bad 69e2ae87cfa94c77c3503715e9e0a68e6cc69f8d
# good: [2665a13a3e9ef3d08b9ac4b48328ddfba9126987] usb: typec: Fix a typo
git bisect good 2665a13a3e9ef3d08b9ac4b48328ddfba9126987
# good: [967f6d162d9fa415cf140d3eef5576d566632292] dt-bindings: usb: mtk-xhci: remove redefinitions of usb3-lpm-capable
git bisect good 967f6d162d9fa415cf140d3eef5576d566632292
# good: [d225ef6fda7ce9ff7d28764bd1cceea2d0215e8b] base: dd: fix error return code of driver_sysfs_add()
git bisect good d225ef6fda7ce9ff7d28764bd1cceea2d0215e8b
# bad: [72a91f192da032b68519fafaecce03fd002d669a] driver core: add helper for deferred probe reason setting
git bisect bad 72a91f192da032b68519fafaecce03fd002d669a
# good: [1768289b44bae847612751d418fc5c5e680b5e5c] driver core: platform: Declare early_platform_cleanup() prototype
git bisect good 1768289b44bae847612751d418fc5c5e680b5e5c
# bad: [ed7027fdf4ec41ed6df6814956dc11860232a9d5] driver core: platform: Make platform_get_irq_optional() optional
git bisect bad ed7027fdf4ec41ed6df6814956dc11860232a9d5
# good: [318c3e00f13c2f6e11202a22cc302ea8c70552ea] driver core: Replace printf() specifier and drop unneeded casting
git bisect good 318c3e00f13c2f6e11202a22cc302ea8c70552ea
# first bad commit: [ed7027fdf4ec41ed6df6814956dc11860232a9d5] driver core: platform: Make platform_get_irq_optional() optional
