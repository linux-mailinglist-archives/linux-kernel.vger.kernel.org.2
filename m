Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843913319F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 23:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCHWGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 17:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHWFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 17:05:40 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6163C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 14:05:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id c10so23410038ejx.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BLF1h9dOOl/nm4YkPwhJO8yDLKzi0BU8Qb7Fi9KuQQ=;
        b=N7ZL69KBP9hd1e8qJelT3+yQFlJdrr4fZYEJ2zxL6EK8pTb2dT1siykY/qVRTW/AkZ
         P1mVdtcZYoqfMFftX+0GogX9dApUAqZoNKjACFI2xkf8wULQvhk6/P8EjzKfMNwpgt7R
         j8nPwzfbCAbJWW81KG92qL/7xA5GxP0/CY9oe7dr7wSa0NOwEzpyNy+jEhbicplGfe8P
         wQVovsm7ApkIJiBsvPpP7sm0rB6VBgx/4WRH9ow1nGbtwY1Sj3OwJA9BwulmfBbGJNde
         u9GeBO2DfG/KR64N9klioZT3RQdaUIKCsdGheYTgRLTEcWleHsL8fhuE6/hDC4ORkHDO
         UVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BLF1h9dOOl/nm4YkPwhJO8yDLKzi0BU8Qb7Fi9KuQQ=;
        b=NZ/+UxJOHc6euhkXgf/LCcGpz9RLpfE1Bt6Azqg+o6gefLP94gfRV40iimP8/C9XLt
         17wMpCH6y5m+DYvNeHweKVtLKAUAuTLSLOssQkUg1dhxyRIItivUmA+JaDkkeYbsE4T/
         eN26O1RN5mROhQFmkYqxvSbmMNLURfANgKAC7E/WUT/qTUrNARBH7VwvmaTp6ZdHYoYU
         in4Cj/lhyiVrHs4ZE964n2d3LfMbgHYs66IRkiBCsMJlc1XFKPVnR+vZJ9ROVCQMDYzJ
         tTDmk0woV9ILpWCzPnR8lTklgKM47vODB+2NrmJPXIqSajh2rsq1mnAyFcnnXNbJTZuL
         PrXw==
X-Gm-Message-State: AOAM532ElNNCxlIp5W74vZi2rR4JAkuRtTMYhn1xypiWYxHrnQJ7Ejuc
        lWZERTsvfz6a4sQXJjSw3iKHai++szjiRxsjpwT8NL+jids=
X-Google-Smtp-Source: ABdhPJxu3uZPAGvEYG0OqNdD00S29+9ljL0kAMPDjvFnMirs0xfjCSBxYgyAjKqO4U4ejtyMFHIH4u2I9QosBYiU9fA=
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr16493724ejb.264.1615241138717;
 Mon, 08 Mar 2021 14:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20210127225641.1342-1-mike.ximing.chen@intel.com>
 <20210127225641.1342-2-mike.ximing.chen@intel.com> <YCKP5ZUL1/wMzmf4@kroah.com>
 <CAPcyv4hC2dJGAXbG2ogO=2THuDUHjgYekkNy4K_zwEmQcXLcjA@mail.gmail.com>
 <BYAPR11MB3095C54BA878D8A5502CA891D9939@BYAPR11MB3095.namprd11.prod.outlook.com>
 <YEaFbyUM0Fu763vm@kroah.com>
In-Reply-To: <YEaFbyUM0Fu763vm@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Mar 2021 14:05:35 -0800
Message-ID: <CAPcyv4iXfBY7rrSLJrFV4KjJsM+_Z_KAeLK5bg73nT7PYqWHcA@mail.gmail.com>
Subject: Re: [PATCH v10 01/20] dlb: add skeleton for DLB driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Chen, Mike Ximing" <mike.ximing.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Kevin Laatz <kevin.laatz@intel.com>, maximmi@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Kevin and Maxim ]

On Mon, Mar 8, 2021 at 12:13 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 08, 2021 at 08:00:00PM +0000, Chen, Mike Ximing wrote:
[..]
> > Hi Greg,
> >
> > While waiting for the feedback from the networking maintainers, I am
> > wondering if you have any other comments/suggestions that I  should address
> > in parallel.
>
> It's in my "to-review" queue, which is huge at the moment.  But the
> networking developers review will determine how this should go forward,
> so I'll just wait for them to get to it.


Mike,

Perhaps it would help to solicit feedback from other networking
developers that have delivered kernel features to be consumed by DPDK.
A coarse look potentially flagsKevin and Maxim working on AF_XDP
updates that DPDK consumes, Perhaps they would be willing to take a
look?
