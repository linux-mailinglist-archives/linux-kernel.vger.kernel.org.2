Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAD3DC51C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 10:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhGaIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhGaIoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 04:44:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23AC06175F;
        Sat, 31 Jul 2021 01:44:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nh14so6855450pjb.2;
        Sat, 31 Jul 2021 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3sNeR4rQkD2rt2foyoAbSEVgs7Om1khjteSFZ1dUxE=;
        b=nwAKXv6PW7cJpOjNlVW5K87IReZsfDpb6B7djWKHoaBR3t8BZfR/mEu3V7kI2jukX+
         at1qMeEo9FEaO4VpHNAT/mkRCaX5lx/y3gz5qpAtqr2rXHWjRccjzdyjiqgoiQm6aQOC
         V7e7Zx2wcSGjqf9a1qHLaj1hhxxQii2iTQ4d6LDjKpe+b2XbAPal4cjFAqM+CQ9Cj2wi
         Tm7Pmx5aTPn34/Urr1G2nj3tExtEjmPvFdqrFt8G1IAgXfGwQyvKMLOQt0pG/E2fDh83
         sUKi+Me6pQWyuxY3VFWpK8qAbWGbqHStxBn+uvSSuXgJ96vNKr/wSNUgsxEh1SxOhG7P
         22ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3sNeR4rQkD2rt2foyoAbSEVgs7Om1khjteSFZ1dUxE=;
        b=pznHlK/kv6ZKJ31YN/KasrAj8ZrO9ldDfzh+2m05ktpNDWayhnLax4vbg5/nbfd3g5
         HNPDY8f3XyVaTitopgp+KlLqInAggk05wJZzvanqfml/akd0eyakCDQNCG6zmt0w+sP4
         ZN5jrAwajhymgsmMJsVLbrn22TamxUUYcD/b0x6X7eDzenmpAMZogzLPPN1TnnccGtZ0
         rbWYkdfA28g4AQJ21GE9+gHIbZPiPO8fcGBVG3V00AI2FwPPnHzNv0l7YzQdegoj9qwP
         KH3neEE8NT3WtitznlLuiYJJI9WH/0Xmxoj8WzKsRU798D2IpzYI/rJdjD/1N63x9UJw
         HIgg==
X-Gm-Message-State: AOAM533oJTOrBrXTSrd/sLi8Gc+fow25+e2XAn1oG1Oyeut7I2x2iDlR
        Ke/cB/4J9MLa8bRz2fBqiKf7gooUVXq0PgyXe/o=
X-Google-Smtp-Source: ABdhPJxtoJAtzV9UmNNyyLrCgtI4SzZvD47CgcwaUkMVshhrJr4+wuDs82BxE6pJx7ccYGZGL00nAXf3H9cUW4c34Zs=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr6799176pfi.7.1627721047667; Sat, 31 Jul
 2021 01:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627710765.git.gayatri.kammela@intel.com> <41f013b885b19ee7362272bb646ddd8a46d09fbb.1627710766.git.gayatri.kammela@intel.com>
In-Reply-To: <41f013b885b19ee7362272bb646ddd8a46d09fbb.1627710766.git.gayatri.kammela@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 31 Jul 2021 11:43:31 +0300
Message-ID: <CAHp75VcX0Xg2iamrew4qvzo1765MaSnr2uQ3ZMksS=3YiSthZw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] platform/x86/intel: pmc/core: Add GBE Package C10
 fix for Alder Lake PCH
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
        Alex Deucher <Alexander.Deucher@amd.com>, mlimonci@amd.com,
        "David E. Box" <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 9:10 AM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:

> Alder PCH uses the same Gigabit Ethernet (GBE) device as Tiger Lake PCH

Alder Lake

> which cannot achieve PC10 without ignoring the PMC GBE LTR. Add this
> work around for Alder Lake PCH as well.

...

>         /*
> -        * On TGL, due to a hardware limitation, the GBE LTR blocks PC10 when
> -        * a cable is attached. Tell the PMC to ignore it.
> +        * On TGL and ADL, due to a hardware limitation, the GBE LTR blocks PC10
> +        * when a cable is attached. Tell the PMC to ignore it.
>          */

TGL -> Tiger Lake
ADL -> Alder Lake

-- 
With Best Regards,
Andy Shevchenko
