Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02CB370F89
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhEBXFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 19:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhEBXFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 19:05:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E91CC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 16:04:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r9so5207758ejj.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 16:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=groRywuNlEF2UBp2F0MI+2GBRzz6sWwtdyxWNmpmmRY=;
        b=XlDPMzJXgrzyFIiIUejSgpr8siSc/rwclMr+de4rxvXJsRPZL9PIM7tbmtGascXm2n
         oVfjQqFS/OXhX1J3QXgr8i/yhufjyXvVrdlGN/vjcVPguwxgyCBBbiUitB6idSZy7RtX
         UUXg0ed+ZJF8e0VHN6v5VswddIAOVhHQn5wmXllUoRvnme867D4/+F/pvUAvxN6p+oZh
         tq/H/SyQO6ZaY0wWpnbjLEpfnIy2KdmNZtDaTv/+Sh26sVrQ1xjVoYBhV/Fi8xumHqZd
         TNEsfCmh9XyXZjF/bh8TWZaMAuEEu5P3oDFfhoy9rjHjMSM2abTsLsgPcQoDmxS7IqGR
         DjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=groRywuNlEF2UBp2F0MI+2GBRzz6sWwtdyxWNmpmmRY=;
        b=XK8Ipx9EKRjUoCSkXY/+odFm+7ir6GquxdJqjMiyLw8bKvd7Lskc+eSE8zV0S3q0tG
         piFnqWtidwg20lIHaKwLpEjPSLlXSUH04hlwTsGl01OMFLN7SrSz//pPr1F1rrEl4oHF
         YnKFobA5DAfX4K5qztIxLqxBgtZZx8WNwTFxuCLDq0VYHVyHxXVb+HQPnb0WOzRNpLz3
         gVfsw12nOXhlrjD2L7F/0KMFOmm1lQyxUNrXv1pe41MDtlUzQXS2UQM5bJh+re2zIDG9
         iE1E0KQaP0mSodbPSJVTpVHP+OTJ53I6GbPCHN/JpsQJUPE9FLW3YgmUmGFCaLP/x948
         2aMQ==
X-Gm-Message-State: AOAM533MlVySevTjbSk5MhT9SQh4E0tlPgRoVIY53XGsYj8XLINrDGvc
        rVSdabBm4VlcvvbHtU7o+x9QkgNcf1iqcn3PAiUwK/uR6Ko=
X-Google-Smtp-Source: ABdhPJx+3/RZteOj6iiJHEdVbJAzXt75ZO0LERj7jXAZI+xt67C1ubzHFuEe4f2afzlwisHDLxFMnwvdAptTlOq+hZc=
X-Received: by 2002:a17:906:57c3:: with SMTP id u3mr3607793ejr.162.1619996660335;
 Sun, 02 May 2021 16:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210430082744.3638743-1-narmstrong@baylibre.com>
In-Reply-To: <20210430082744.3638743-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 3 May 2021 01:04:09 +0200
Message-ID: <CAFBinCC5piZDgyxezJp8Yi3Ny5B6WRD-XdWN7s2gm8_aqza=fg@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: fix shutdown crash when component not probed
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 10:28 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> When main component is not probed, by example when the dw-hdmi module is
> not loaded yet or in probe defer, the following crash appears on shutdown:
>
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
> ...
> pc : meson_drv_shutdown+0x24/0x50
> lr : platform_drv_shutdown+0x20/0x30
> ...
> Call trace:
> meson_drv_shutdown+0x24/0x50
> platform_drv_shutdown+0x20/0x30
> device_shutdown+0x158/0x360
> kernel_restart_prepare+0x38/0x48
> kernel_restart+0x18/0x68
> __do_sys_reboot+0x224/0x250
> __arm64_sys_reboot+0x24/0x30
> ...
>
> Simply check if the priv struct has been allocated before using it.
>
> Fixes: fa0c16caf3d7 ("drm: meson_drv add shutdown function")
> Reported-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
