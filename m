Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD844ACED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbhKILyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343641AbhKILyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:54:08 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64694C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:51:22 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id o83so33216839oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMK6SnHP7XOL/nzbm1KS22pVeT/yVqRtpG4D5bAlLtY=;
        b=o9FwO7JCulklcAOt08HURze6MgADdmgcfLw3Yl4MCHTMoFLONnBFI0Vc09v1fn4Ru1
         a8sSgNlHwT73XBbn3Rtvl9qOR9H/8XdGjeZ2kt9amCQmP/vrh9Ql/m9TqCEzKxmn2ck2
         1iZItOphR9RBsP/Wx5Rh7PRHJcs87JiPoPXQLYosgsujYhKXvfklJlb8zp2WDcG+SCLz
         Zh5hPpuhnG76txv0tu3QIahyuXIMUFjknLT4m3kjK66ydWl3NrN61xyanki+aMIiExYK
         kz6K4gZOzlyomsHYCPRrpYTMDak6kyS29r3Z+mBeSKbX/Bb9XbUjiEnUBJ6FaLtnuuQE
         K3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMK6SnHP7XOL/nzbm1KS22pVeT/yVqRtpG4D5bAlLtY=;
        b=cKksfJANvGvuGlID3aeyrG5Qk02uNnAbaCMU720o4xq47FFZJJj4CFIPgveOBm4vjh
         Dqw9FejDdur6zfpr33oEbj17/ycIXZbNpc0hinYtJTl0nKWl/tb3Vcfnwx7xNbTHlvvp
         BId9rfcGmgwKfdt9jUajAZOQ3waECswK2Vq1DBQvML4p6zPYqNcQbQ2sLE0B6PpcIr99
         mrTbTpqGlZw33a5SdbjgfeSn7Au4OCCuNL5PRmYkEe26TANo0kXIsfuLQY9h4tu5G0We
         gVxpIaQAb0mRCPh9okJs+M91liI5O6h+m9dfaP851NpNVP0wdYzNXB6xcS2dYrZUGdHR
         SjrQ==
X-Gm-Message-State: AOAM531W7V4k1BIknngf0zs3wphpxWMywfCRBsiykg1U+hWCg9l0vUS3
        098srORDt1M79r2kKsbSKLrg7dWHL7OY8cm8rPMzWg==
X-Google-Smtp-Source: ABdhPJzh5h6N1umE+Ysu5XocKatjpgfgpDggcSizG4BYyhksOtzOtMD8oSphQQMP0yAmmkHhJPnOvtLfi83T4u+8cUM=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr5237493oih.162.1636458681847;
 Tue, 09 Nov 2021 03:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20211105130338.241100-1-arnd@kernel.org> <20211105130338.241100-2-arnd@kernel.org>
In-Reply-To: <20211105130338.241100-2-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:51:09 +0100
Message-ID: <CACRpkdZ=z2YZ0rtD3=xqEQOMbwph-BEb-3xP_LajCzykmpYgSg@mail.gmail.com>
Subject: Re: [RFC 2/3] gpiolib: remove empty asm/gpio.h files
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org,
        gerg@linux-m68k.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        dalias@libc.org, ysato@users.sourceforge.jp,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 2:04 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The arm and sh versions of this file are identical to the generic
> versions and can just be removed.
>
> The drivers that actually use the sh3 specific version also include
> cpu/gpio.h directly. This leaves coldfire as the only gpio driver
> that needs something custom for gpiolib.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Excellent!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suggest Bartosz can queue this in the GPIO tree.

Yours,
Linus Walleij
