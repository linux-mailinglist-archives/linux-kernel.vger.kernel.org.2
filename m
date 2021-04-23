Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4B369ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbhDWTPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhDWTPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:15:41 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B69C061574;
        Fri, 23 Apr 2021 12:15:04 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id c195so56820957ybf.9;
        Fri, 23 Apr 2021 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYBBVBUJb9QpmRIT8Xr6jh598vn6KpVl6M3aNNacvdQ=;
        b=bPV6qGiepOZtKubGYKOwxJMzMjosn8zgBOMi6AfXqbc8iJO1Dpq5EEVzVbBo93Zu0M
         1ZfiqNL/A5U0/lgXc2Oen56cFdYyxaiLRwSZwJ2jpdBBZPb2J4XwXHnwX0BOolcOjvCO
         4aC2mPIPLfB0nkES7qreogNxs7YRvdOXq4csKiDzEtqGW7gx2Vce8nQc03rJFVSA+KEk
         VEhyGTpHiga8X1/fbuTPPtq4lz7zuzL1sSH1Oqs+u6Tji2AWYxAOgvec58JyoQNcdjWk
         zeSzdV0pHpwlJ1wX7lVm4YTv+w61hA2ujOmP8+i70y+6mBxLbZKGSj+sOOWcKErpNv5a
         W/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYBBVBUJb9QpmRIT8Xr6jh598vn6KpVl6M3aNNacvdQ=;
        b=NkMl8vSEljrZEEykw+cMWCcyFnMU0Af9sfXzDdxJJ/1VFsJakcRBYwKHASgiGaJbMR
         inRHtaRf+xcs42NcqujWmX80ulPthxelcsJaf7yztvaQlAr9ZBxBHo/VLVsPgG/0k0oF
         Esqr6xFSu2qHAJB8pesE6vxoqYldDvuq9OFQPnLbVG5sOtc0t16xrilfJewYRW7/pZAt
         wSST5qxkBPN4XnIHS7ke+GUCvPDvIG7NgBkEr4v69P3+f4o2D2nr0XSBy2SReDB+4ur9
         GtJjo6TSc0MYjcKX6Q0esq1zTOdCpmiDqmbHKmOksGrUnDdJVPfxhSzC1sjkGLGNhWx+
         nM8Q==
X-Gm-Message-State: AOAM532vcDk0G0AHx6Hz6KWGJRs3A5HWnMmKEVgooP5D5wRoU6Zc+bkF
        q5RVRRP3gDJViM3FXVkWXY7LmfndzZpU4b9/3HM=
X-Google-Smtp-Source: ABdhPJwLzB81isuGskELcFGhiWHaTvQIDCs9DoK/nbCuecsfWvXHIPGCxSlGveQbDXk30J5uEZXGUz/APREPvqqEzf0=
X-Received: by 2002:a25:6803:: with SMTP id d3mr7979088ybc.422.1619205303516;
 Fri, 23 Apr 2021 12:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210423184012.39300-1-twoerner@gmail.com>
In-Reply-To: <20210423184012.39300-1-twoerner@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 23 Apr 2021 21:14:52 +0200
Message-ID: <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model macros
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <trivial@kernel.org>,
        Joe Perches <joe@perches.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Yorick de Wid <yorickdewid@users.noreply.github.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 8:40 PM Trevor Woerner <twoerner@gmail.com> wrote:
>
> The dev_printk()-like functions moved to include/linux/dev_print.h in
> commit af628aae8640 ("device.h: move dev_printk()-like functions to
> dev_printk.h").
>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

LGTM

    Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
