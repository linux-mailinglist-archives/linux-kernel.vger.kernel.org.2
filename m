Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35A31D453
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 04:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBQDte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 22:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQDta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 22:49:30 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD6BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:48:50 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ly28so42995ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6GN7npjxxTr3rPYtuepca6vGbGAXTsJ8Kzpp5ATUsdw=;
        b=h47RlX7opZlJG4D8MxnmNnpo3auKP9Kj9EbZRpdIYVLuZGBrnLY8j8c1VqLq7TvaLX
         RG1sE5E5XniB9TLlFY/BBXMRfvP9Q/vWJJe4xBJ0I6llgk94KjaN90THNwkBSscqaBud
         jEEoVoAftrYwVwRJzDLpa6bK0vxsGH3irp9Atu8ttwahyY7gj+ZKhScFeXEBg/lJUIE7
         LBaZOqGh8dAEHfH8Wam/0/Q3Vh4DaAAdZKLV+ak4dmQnVNDwWC0cYI+v+1hsL7EA4TmF
         X/oQTq9erjqEAktuWQU27LmLMm6OEO4mSn43/xIQJ9EycfijywRzyVb/HtmsTZNXiVnq
         7jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6GN7npjxxTr3rPYtuepca6vGbGAXTsJ8Kzpp5ATUsdw=;
        b=hlbU68parSKr4atTkLpgjR8QAZdC7YMpbv5wtN/rwFUK0o22AuUpQRKK/w6LcKpkfM
         +aoOac1Sy1aM9WGPRUjktrFmmSS7vgnZsh7+Ka9r3KoPrWKEUPJNf90pDS4qZthnn3YC
         dLPQOOK1x5GPL8lUhLOpmTnpeoKQ2Kj+6dxv+quZY6MDOZwIxF7+LWx/xGFPAPd0MuYc
         Rxz25Neu2Yd9VLsSEETDTKd1UeI5hSxmaDEnasct1EB9TVWu8kczpfPRnbSTuDZbz+c+
         3SUMooorOcQbjR6B7nC7tK/1uBO81ZwprHvRDI3UEEEWDM44LqzhO4nDD0bdsO0O756w
         2PEA==
X-Gm-Message-State: AOAM531/sSQE1mt7rC2fKGbziw1zfO8lUdQdG2gCmY+0os17lXiDqOYe
        M4EABeEwkMrbDKpjh+noI0tZQEdHrcIx3OgfKHIQJA==
X-Google-Smtp-Source: ABdhPJyjO2B4hXY24WEEGwlIuPpg4FfTezqFCUS4ic4R2uhx2bTJMEpR+dYhDb9s1MeW4T4D6mGCJLUny6JoCNgf/Ls=
X-Received: by 2002:a17:906:5655:: with SMTP id v21mr5417109ejr.264.1613533729091;
 Tue, 16 Feb 2021 19:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
In-Reply-To: <20210205222842.34896-1-uwe@kleine-koenig.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Feb 2021 19:48:39 -0800
Message-ID: <CAPcyv4gMg7ksLS6vWR3Ya=bZd5wBiRLtSGxf6mc3yqf+3rA_TQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] dax-device: Some cleanups
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 2:29 PM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org=
> wrote:
>
> Hello,
>
> I didn't get any feedback for the (implicit) v1 of this series that
> started with Message-Id: 20210127230124.109522-1-uwe@kleine-koenig.org,
> but I identified a few improvements myself:
>
>  - Use "dax-device" consistently as a prefix
>  - Instead of requiring a .remove callback, make it explicitly
>    optional. (Drop checking for .remove from former patch 1, introduce
>    new patch "Properly handle drivers without remove callback")
>  - The new patch about remove being optional allows to simplify one of
>    the two dax drivers which is implemented in patch 4
>  - Patch 5 got a bit smaller because we now have one driver less with a
>    remove callback.
>  - Added Andrew to To: as he merged dax drivers in the past.
>
> Andrew: Assuming you consider these patches useful, would you please
> care for merging them?

I've routed device-dax patches through Andrew when they had core-mm
entanglements, but a pure device-dax series like this I can take
through my tree.

One small comment on patch5, otherwise looks good.
