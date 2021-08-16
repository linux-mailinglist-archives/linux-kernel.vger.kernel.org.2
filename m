Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049EA3EDDEC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhHPTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPTcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:32:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE4C061764;
        Mon, 16 Aug 2021 12:32:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so1898401pjb.2;
        Mon, 16 Aug 2021 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TvjkC3OzklTqvyYZtJmWv25nS7ZlW9XQtygCEdEp0s=;
        b=hon9DUoXHg5TNKQIIs4OqYnbNQQa6nqbqDTtFtfsW6ofPy7Z9RItsJ9LlqldrmYfiH
         TWy3Fmpo/NooaHsU2h62CrQDOUfQ1nxeMLeAGywLV3HuSj7gYObZh48mp4dGbCrmqShc
         vLncn/U3amz41uNf87jAXVhrar0i/liSDF0jEKi3V/a+FZI2fOK20/ruZw6sLSxfppXA
         uk/jxPdt+xD2uFKo1Z2M65NMrHpP99AfWzCQNhuwkfegbaUzZ/M0YlpvsUXBBMARLFFZ
         +XyaGq8vpssmXi9oSj/BkaJuZWd8tQf6uTD0UpXzpTTZS7PIAcLkLIIxZeeFRlRareUj
         S/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TvjkC3OzklTqvyYZtJmWv25nS7ZlW9XQtygCEdEp0s=;
        b=JYxg+BqVXJA2s16gSFY7qWdhlEpx2PQ97a7ijJ62P8JSil1H/C84+EPw2Fb/XTTeJX
         /b6u8JR192C15juvb7EO0llSvJof4U/fJNsgr3rFBua5q19iHaQUk7qSLqEIF9Hmmoye
         KY8aXFb1jYEChaq9SAKyOKu4kudSKGO6McXy2G1ZhQ5nCeOieqHPobRPYO4R2EKaMntX
         qA9obnDyY7pIlzQInqFey+dw2AoE8EvEdNX/5hb5d08GXX7ruzV3/l+yO+1xpMEngQm+
         f5Fm3REnYp0f3SirYccw14sQ0lVNemity/zgb80z4xwMDKVfvE6BUBTtSwgpojxMLngp
         kpdQ==
X-Gm-Message-State: AOAM5312z4ALAlU9PEZRg5kcHPfcuwcTdbVdEO6FIMA6R00yC/uVuiZf
        yFcdNBSMsvEVfNmuV4JallixhigZit189482Hvo=
X-Google-Smtp-Source: ABdhPJyacnZ7Js7Ws9K1z3pV9Mh3aw8GMuxd17nY/9VV8EZ8DJBxlUuUaKhvei/8YPjFoP3h4GucSANqO2u9UpTsPtE=
X-Received: by 2002:a05:6a00:d41:b0:3e1:3316:2ef with SMTP id
 n1-20020a056a000d4100b003e1331602efmr326226pfv.40.1629142327682; Mon, 16 Aug
 2021 12:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629091915.git.gayatri.kammela@intel.com> <81b6292e50af54fb7eeabfefde6f4a3d283b0b96.1629091915.git.gayatri.kammela@intel.com>
In-Reply-To: <81b6292e50af54fb7eeabfefde6f4a3d283b0b96.1629091915.git.gayatri.kammela@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Aug 2021 22:31:31 +0300
Message-ID: <CAHp75VegAcEeWQXPfufcDC1cHLbC3JRsChm2zKATGWnYWfGEfg@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>, chao.qin@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>, mlimonci@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 8:02 PM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:
>
> As part of collecting Intel x86 specific drivers in their own
> folder, move intel_pmc_core* files to its own subfolder there.

>  .../pmc/core_platform.c}                      |  0

platform.c is enough.

-- 
With Best Regards,
Andy Shevchenko
