Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F642404B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhJFOn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhJFOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:43:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE40C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:42:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f9so10931000edx.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0td2RzzWB2z+l6HDdbG2dIj7T/sC37WwJzm2wfFcaM=;
        b=N9fo6K/OrE4x3+31KhOS52zVYfPjwu6Uhc0b4vuP8O3kRHbBMn5O6YpmKd2iM3LQdJ
         fbdj8ApgPonXF59yxfwmZV3LjzwJUliE3wTmfTohtveegxDr2DEfhI8zek/jSPyKdG/U
         wM5Lp1PCcT+jvwo0Ooitzzahfw0dBQ+q4uopGAM5E+VoEIcs4OfgYoqdjYBMpSIP6gon
         t/Fl8AkMtIud73n8fzMzZSH05fa5etx1+nQbI+WcpLVdcDyB6MlHGMB2F7HD4M4Jmf6y
         pf2ewdrlH3wjAm2CSKpUwbozOlzeLvevusnUAEi2Lf/dq0wvsF5Dc554aJ0rdDY2Ph+a
         YnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0td2RzzWB2z+l6HDdbG2dIj7T/sC37WwJzm2wfFcaM=;
        b=KonEysWVNr9CNMmQP1dWL7gOen3HvK75whn92rjWb9oKJI8YTmZcML6oc1cyOOoN1l
         e3OUhyh2FAHMlmEKR8OYUQdnTUAZHR8yTd0Mrw5BM36RfJFWvMz9uqTuD+RCjSwb35Gq
         zv9mjlLonprds3sEnzj6vtunIwIrIciKbZgUQIpvV7iD1ul572qx+bmmY7Mdm6ayq31I
         vLi/17RykgsEjKdDawEruABcoeOzy2yrEIsrnId/HEmsCXGo5GptsJRUz+Zxbx+pMrfX
         y3eGSGlatRR9BE/wwTaobbhZN/kWvVvqV08SG+pMTiL3bgr0xeM4CUoVBjyT9fMbO1F4
         zWBg==
X-Gm-Message-State: AOAM530CQOGjxnmkhT/I9ltPnCmMMtGtTqYPqsg9YO5iiZzwDlT7BVZo
        AkoxOmAY6ukdlRuloYlaGo1z853UWCm0cxj7OASxxA==
X-Google-Smtp-Source: ABdhPJyjdQd8GwnXfYNZjS3ojduYmevbThlJeISnxOCUman4h6KUX8ZaNAc+AHy6Hh9mWovnyZl63TaaDwLRCUUvQBg=
X-Received: by 2002:a17:906:1f95:: with SMTP id t21mr5802928ejr.234.1633531265640;
 Wed, 06 Oct 2021 07:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211006143902.129864-1-sohaib.amhmd@gmail.com>
In-Reply-To: <20211006143902.129864-1-sohaib.amhmd@gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 6 Oct 2021 16:40:55 +0200
Message-ID: <CAMGffEnakMLZ-ZEqO+0ucJjQUFhrdq1CyMpR2gdEesUO8H2mxg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Fix typo in rtrs/rnbd
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 4:39 PM Sohaib Mohamed <sohaib.amhmd@gmail.com> wrote:
>
> Remove repeated worlds:
> - "as as the"
> - "the the name"
>
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
For all 3 rtrs/rnbd changes, all look good to me.
Acked-by: Jack Wang <jinpu.wang@ionos.com>

Thanks!
> ---
>  Documentation/ABI/testing/sysfs-class-rnbd-client | 2 +-
>  Documentation/ABI/testing/sysfs-class-rtrs-client | 2 +-
>  Documentation/ABI/testing/sysfs-class-rtrs-server | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
> index 0b5997ab3365..e6cdc851952c 100644
> --- a/Documentation/ABI/testing/sysfs-class-rnbd-client
> +++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
> @@ -128,6 +128,6 @@ Description:        For each device mapped on the client a new symbolic link is created
>                 The <device_id> of each device is created as follows:
>
>                 - If the 'device_path' provided during mapping contains slashes ("/"),
> -                 they are replaced by exclamation mark ("!") and used as as the
> +                 they are replaced by exclamation mark ("!") and used as the
>                   <device_id>. Otherwise, the <device_id> will be the same as the
>                   "device_path" provided.
> diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
> index 49a4157c7bf1..fecc59d1b96f 100644
> --- a/Documentation/ABI/testing/sysfs-class-rtrs-client
> +++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
> @@ -78,7 +78,7 @@ What:         /sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_name
>  Date:          Feb 2020
>  KernelVersion: 5.7
>  Contact:       Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
> -Description:   RO, Contains the the name of HCA the connection established on.
> +Description:   RO, Contains the name of HCA the connection established on.
>
>  What:          /sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_port
>  Date:          Feb 2020
> diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-server b/Documentation/ABI/testing/sysfs-class-rtrs-server
> index 3b6d5b067df0..b08601d80409 100644
> --- a/Documentation/ABI/testing/sysfs-class-rtrs-server
> +++ b/Documentation/ABI/testing/sysfs-class-rtrs-server
> @@ -24,7 +24,7 @@ What:         /sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_name
>  Date:          Feb 2020
>  KernelVersion: 5.7
>  Contact:       Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
> -Description:   RO, Contains the the name of HCA the connection established on.
> +Description:   RO, Contains the name of HCA the connection established on.
>
>  What:          /sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_port
>  Date:          Feb 2020
> --
> 2.25.1
>
