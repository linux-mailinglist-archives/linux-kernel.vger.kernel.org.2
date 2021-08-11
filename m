Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7D3E900A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbhHKMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbhHKMGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:06:16 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7FEC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:05:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m18so4186999ljo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVOtFYGU43ov9I+yQxtGQ35j2i18nVVfQ4awTJDgPJ4=;
        b=CPWX39SnW8CZrFW2qn0MNAMA+30m493YsPeMGcpMEubsgqTWN6/FRsFotEu/mHURnp
         0+ZFMd04KyBRc2s9+ojx5Z2PwuLRdtJAAAoIj2JIXeT7t4ImCzbIiEdA4SyfEHAUax/u
         aNgmm/gKi5t9S+ZQIf8B07FvKhFWC9C8BlVPolSrHOS1c5zO8ibQngqhvpbUMie4103W
         51wG7T5Ko5xRt2bQUi5p4Ok61zuCUFdrHQ0YadkUFiIs8UTxdNVlXHEhz2zo+poBBDjG
         f/cR+ScOfMVUUD5u4jXmzPDon5LprjRo5WwbvYQ/z1HRsqQ5Kkhxh6Ta39OOQtSyQbt8
         vFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVOtFYGU43ov9I+yQxtGQ35j2i18nVVfQ4awTJDgPJ4=;
        b=a+z9vpTQ7jv7xlTzAJlar5sZMIwTyeylHiUy5yoFOnv0Bi0XGDCts7jlf1k8vvS+qN
         nUh+5GFUx8jCZGjQRKDeBlil7gXVKm2iEUJ54+jwjoB9GwaF5qg3NafChx12rh1T58bg
         VVCXp+CLZ9ZDAbzURwM3l24XcMiSh8kzAKBmgFrkzJZeq5nEhF+AetaKTcjzjXOJiP5Q
         03s3KMiYsPr5cAQB5UhajjXC9MUjNuPSL4y7ImraFoV3SH1mVKFZlODq4mz8tZui/FHt
         7zLF7J6H1W85+94O7PN25pxr1Svbfgj95SynmlGIsYVoWDtVTMEadFmwguUcmyjQvCBN
         K07g==
X-Gm-Message-State: AOAM531YwzsmA1lksguO0z+jy+Xt9CFML+X5OVd5iLcLoQLyEEwoTwZA
        vkarQ/WL30nPJ3mvUKg2SwYE2jNH1Cvwuz6hoV39/Y925uE=
X-Google-Smtp-Source: ABdhPJx2sxRjFcOgDyC1RUaJopNkQ29AiB1uUuxLikUrXJiGT/rVKH5OFuPAlNvzZgJw/fJGDIE17l0RC7IA+EZ/fWI=
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr23507045ljp.74.1628683551136;
 Wed, 11 Aug 2021 05:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210803173925.57216-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210803173925.57216-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 14:05:40 +0200
Message-ID: <CACRpkdawS25uPOf4c2m+Z0aNSN2UMNouhd6SrmRhNrLecnwzEQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate forward declaration in the
 consumer.h header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 7:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> struct acpi_device is repeated in two branches of ifdeffery.
> Move it out and hence deduplicate.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

That's neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
