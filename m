Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515E734FAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhCaH5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhCaH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:56:56 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0222C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:56:55 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i144so20255219ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgUMXHodW4czfJMBWwIWPw31+/LFTP5qzOrrXtIPGCw=;
        b=Siv9O1/aTQJTOyFg1U8gNhaIBW8T+gXHDEXCMOZ2f/3rI2FvWEV9BghJoV768fl4qc
         eOopFW94WgxW3h+K4y5MaW8oVhFM7g/MjxwrFcTVqbJf5aeF8mrSUFrCBcwTZlUWHVyV
         B7njSXFqe3NUYw7qc/A4Zc5zkw+TDFdM2J7g0MNAXQBKJyojzTMb/csPbvei63oXB6m1
         lTxtyJMBYyVkN9X+fuYY1q0lpH0jVJN2005oGF10yvvBdICWKy10f19jdfWxob9JQtT/
         zMT73JClBXLQuzGhvOn0+Fbta9Y/ofAcXgG6ixJ9XlOFT2K5mCPOYt2EyhV5Cvs4ZP0t
         2AIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgUMXHodW4czfJMBWwIWPw31+/LFTP5qzOrrXtIPGCw=;
        b=axstM1Y0MZCq77ofTHeCaXRN8VVDCMDvw0JJ30dbq5n50sCoZyEGZB7OwMvNxP2Ixq
         4bDTNUXYSsvRP9pAgv3UI65UoyTft6+Zst/I5f9gS9TFnLetbpV5BCvH5DvPoURaNAtJ
         BHCqdLzr0hNXdZovvH48KLPu0if7CrlAddpmR9avOMmKH1V9lKe1zwNYcvOR2gAO88r5
         CS1NHxNzp37y5XdlRK3/WBvA+LpI7hk42LXIk2ea4HaxNXrnADfDY4k4MYNCQVwX3BT0
         ZeYzAbFKm5aacsLCxWq/7eU6mWNE3rYb5NuIbwcI951tl8cb7Z754W1fSfN7Jso97Q7L
         IF3w==
X-Gm-Message-State: AOAM5302d+pjGlbb7BMIQqq+suz9O9lpqEwBd+qLGFh5HxzkSeJwijhi
        StDT/dUlj119S3DYVCsOFkHxgyTEVFihr4R6d6pgoQ==
X-Google-Smtp-Source: ABdhPJwAe6p7zIWjynyOOC6a+3NfJhGUZjRoLUE0/8hsS4pKJyVaZq3xDAXiChU5+H6y8JagPw7lbs2FDJQYG4Q+M+o=
X-Received: by 2002:a25:768c:: with SMTP id r134mr3126449ybc.366.1617177415233;
 Wed, 31 Mar 2021 00:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617017060.git.matti.vaittinen@fi.rohmeurope.com> <d1ec9f4cb6dd9afcfbeecfa717e863d75e18133b.1617017060.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <d1ec9f4cb6dd9afcfbeecfa717e863d75e18133b.1617017060.git.matti.vaittinen@fi.rohmeurope.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 31 Mar 2021 09:56:44 +0200
Message-ID: <CAMpxmJVKmBp06_2Hd4XF-eL4KfgZFy1o+xUvvs6H=TaAnkmYhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: sysfs: Obey valid_mask
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 1:41 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Do not allow exporting GPIOs which are set invalid
> by the driver's valid mask.
>
> Fixes: 726cb3ba49692bdae6caff457755e7cdb432efa4
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied, thanks!

Bart
