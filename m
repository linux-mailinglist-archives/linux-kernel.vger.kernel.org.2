Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F6639D786
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFGIix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhFGIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:38:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57EC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 01:36:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f20so5236897wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqAD7JyQJLtIUaTq7HisxnM/3X8ut9jR2CAddAB1Cqg=;
        b=doyN4rgRGFyq1Kz5xW+zSGP5eyprWLTmJNWt5GNCkcTtUajEwG24mgCalhI3uWmOKW
         E7LCI4cmGi21nURQKDnzjr6hmcWUA+rBgfNF0vs0mpK1jp45ve6KaLrJPGXSoe771ahY
         YKf6eaFqhhkVJBN+po2m0v/39VhNx4Arqs+4GJXeCrwOnb/BEDmWL6RlCMNOZVyPCcx2
         bFmYtkdXB5wB3CTjH+SBYgDr/uhhou6x/6QjqNkwbIk+KvX/AwWrxXr1Hfu+EZD8AZ59
         C+/A0ECO+spDAadILs7h5QCLyZDNdFTp7/Urc2/s3rg+8a9uhPG29gc1YAzWaRhruw29
         ym6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqAD7JyQJLtIUaTq7HisxnM/3X8ut9jR2CAddAB1Cqg=;
        b=tPlJc90619Il2PNNCiBinCKa5yyamdSk4FhLG4RPXK752G0/OagOY2NcX2FHqPv5g6
         fSECmUaEn+vhqZ+OZ9oKvVcXpLHHhSifYyTr/h42UezlNqCcZiavjX6EVoIOywL/XX04
         WL3FvWNbU3t/NPJJHbc0LwK0xnqz4f3PwZ8QYzctDCwdWHc6JA0AOvazQsdkLv/Z3BP/
         9AoDDQH7eWTyf1mlwOAljNUDYm9a/iuIztnVbX5IiZUvY/e5448YhmM/om/sPhAYY+FZ
         2vhcywY3yAjIiClENuRD2f3ado+92djOyeZJW34c9d1JILa+1s+FfelwcnI2YE5ohDq8
         GwAw==
X-Gm-Message-State: AOAM533bkpXFHdBIo2NUaWoq0f7S+FZOYuT2jc9rDDK1Zmy3vHuwjWto
        KG9v9Xpi3yXroOcPpoPT+8wknj/QkUpVSsW37kJlYw==
X-Google-Smtp-Source: ABdhPJz8hM3hqr1V4jECe7fc+5nfq3AknPzC5rkIflKDlHDhykr0xPABNXJ3M2qlpZSxchzC5A0kjKaWCdCtcDbvsBk=
X-Received: by 2002:a1c:b782:: with SMTP id h124mr15900314wmf.168.1623055007668;
 Mon, 07 Jun 2021 01:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210605073534.3786194-1-jernej.skrabec@gmail.com>
In-Reply-To: <20210605073534.3786194-1-jernej.skrabec@gmail.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Mon, 7 Jun 2021 09:36:36 +0100
Message-ID: <CAPj87rNFXkoRJw2_Y7aW0+7mzOYGpirs6YgUfuFrDFfXcyOMeA@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: de3: Be explicit about supported modifiers
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Daniel Stone <daniel.stone@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi@lists.linux.dev,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2021 at 08:36, Jernej Skrabec <jernej.skrabec@gmail.com> wrote:
> Currently only linear formats are supported in sun4i-drm driver, but
> SoCs like H6 supports AFBC variant of some of them in multiple cores
> (GPU, VPU, DE3). Panfrost already implements AFBC compression and is
> sometimes confused what should be default choice (linear, AFBC) if DRM
> driver is not explicit about modifier support (MiniMyth2 distro with
> MythTV app).
>
> After some discussion with Daniel Stone on #panfrost IRC, it was decided
> to make modifiers in sun4i-drm explicit, to avoid any kind of guessing,
> not just in panfrost, but everywhere. In fact, long term idea is to make
> modifier parameter in drm_universal_plane_init() mandatory (non NULL).

Thanks Piotr & Jernej!

Acked-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
