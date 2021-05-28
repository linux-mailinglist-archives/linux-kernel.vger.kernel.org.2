Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6783943EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhE1ORd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbhE1ORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:17:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED035C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:15:56 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e10so5704973ybb.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LI5IGM0D78MTUoUFDTgUpmogKOWf0ihJRhL46wXSKU8=;
        b=e4FV5ERIdW+TXgAHjCebrUCBGT0BRhGVHi2En8XUBymNI3VdjQpj3CcCPleVEpsy+w
         KXiYLiClyRnPu0FZaWTAC0tFn2UVpmr8qIuA0CfEdnSwsMWwA7vhNOfNCqxRd6Me1PgQ
         iLIL0D3/ggelGlk0Z83HYGPO9/vlLnmvcxSBw3LY0iE1GKeIN2ZYJfEsu8x63jVACXFT
         v7Stzvm/WGl+SICtCqvGcM1Yue5VTpA1u+0182wWkTglGqcejJx5ri2HuMj/6cjCuA/q
         QPTHm74i5BIBGp9WquRuXVmD8KC0YYGpSM4nVqKbjjOIXqBfrGPbUG+z7F9e1XnvJqix
         CHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LI5IGM0D78MTUoUFDTgUpmogKOWf0ihJRhL46wXSKU8=;
        b=hyI0N4gkY9rc9iSBhMyPyGuqOFTV/PEu8pSH0ts8RWZ1Ib+MyvEmrUsZEDs+K2LAlX
         63ZaESQmPVmb8xyZlI1sZ4xYD2zr5qUPy8iL4YRHXOeGfQ5t8O/ofLMoqdVsA4NCx/pd
         ImOG2K52Se+NayJGe7sPDNh/OH5LbjmobzqUTlKHylLNeKVS6gge4KjI+NXr/szWhfHO
         5I5vhM1ZUZy3JZHtESWasdulfcYd6SENR41gnkn3KAW4Uuh7nS9ivetM0aMdH1fRwH90
         dfcZxo5jOpdkBkThBLl50WTAeDhwXa58FiW1WNZBq3Dd/1iF06+vjPvrG0tDzIwVwcJZ
         KJBg==
X-Gm-Message-State: AOAM533zxXr8Pel1rfYCmw6dz7DK+QE6AgjTzuwSMCE09uUZ7PP7N88f
        Hd25L3Z1+CWeEQ6W4/vvtNaHyWcU4MYesqK4AyOkNw==
X-Google-Smtp-Source: ABdhPJwoITmD6InX3l8RTV0EAP5LfoJbfxiueQh3sFnmbEO/9hWm0T1698jOZNtSanVW9CMgNqh0GfAJyu2jRv+zxhE=
X-Received: by 2002:a25:420c:: with SMTP id p12mr9783448yba.25.1622211356179;
 Fri, 28 May 2021 07:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210525183518.63149-1-andriy.shevchenko@linux.intel.com> <20210525183518.63149-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210525183518.63149-2-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 28 May 2021 16:15:45 +0200
Message-ID: <CAMpxmJU+2Qhg_zOCGShMgrPftb_x1q3v3bVyN-dPx9e1b=UjPw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpiolib: Switch to bitmap_alloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 8:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Switch to bitmap_alloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
