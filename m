Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42445357D47
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhDHH0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhDHH0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:26:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB06DC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 00:26:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a7so1326939eju.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 00:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uc0+K23/mnmrGZb/moKeuXxpkliqVKEbLbv9zEjV7os=;
        b=WVtRSvInqHDhiAmJeygIIMY+NJgA2MQHivyD8pFQCNfi/he+Rp+bV8D4ztue5ZCkgF
         IwjMOIGhfK6srRlLWZwxEgt3XNyaf1OOpB1y2jmLXRtAhYXGE8PA8RN8PwawUwvLk2PY
         +ILTFGtpX57kx5edzbJKqLYnT9pc7aw7Si25venr17LUGq2cxmCmsEosT4gDA3n7xdL5
         r1MzkJgbC5A1aMktVmk8FKKrfdb664L8rXkakkJCJTjYjrwEbSSMIOEaSLRKqeYJ4Nqg
         BEVhWqDWJrH0vGqrnP1GdcOL5akSN+kuks/QGVDXdq7MUJ7WbayEcmXSOesJG67D9l1G
         0V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uc0+K23/mnmrGZb/moKeuXxpkliqVKEbLbv9zEjV7os=;
        b=AcOmtH/yGDr9LDhA1xJAn0OfF0UGCE78zonay5zTMF5MGcO6X6PbHs9GduDNRhKW1U
         8K57ztCsOspe719QSczdHQq1wM8ypAl3rSvKTb7+BddQE6eRPzCWGAb46pWpHs3RONli
         WHXdwj++vDBrKSPTYiSvdtRFsAslwItgdP5r8XgqKGWfOjTfhogtdlSFl55dedXchzFe
         NCtLn+ojYiKxQ/2+9xCuqL0GMVJP/NJB+NV3Zp7mDWOYhhfO12T4vtaP5XNxzkPJiy+x
         pEtAadVr0XP/sm3j7yHzgs5xx7qDCdK/VW0N0zRsXFPMg9A/Wrug5eYqJHBO5LVvgrnn
         y1kQ==
X-Gm-Message-State: AOAM531/khCOW3oZuIM0MWxvuW+1wa0dpTNrcE53atb/E4V/tM3upJD5
        R9CNbnXSqM59hsMXlRe6+EcOk4fsLmLxHsC+3zeAaQ==
X-Google-Smtp-Source: ABdhPJw18kBoh+onA4dUbdWI428NmdwenjK1YYrGNeQCvI6EOUl6BbOpSnvCgr02MnejMCe6GDfg9mCc4mrUS49SMds=
X-Received: by 2002:a17:906:32da:: with SMTP id k26mr8407259ejk.483.1617866765729;
 Thu, 08 Apr 2021 00:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210407061456.5914-1-gi-oh.kim@ionos.com> <CAKwvOdnaLT8sn4e3PQoASjKaNP4gUKQikhxtJM5G94-7CMUKTw@mail.gmail.com>
In-Reply-To: <CAKwvOdnaLT8sn4e3PQoASjKaNP4gUKQikhxtJM5G94-7CMUKTw@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Thu, 8 Apr 2021 09:25:29 +0200
Message-ID: <CAJX1YtaiPSVfUn6bVCGo+9S77LGN4TAf5PyxeOGxJYZuxgvUSQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Introduce sysfs_streqcase
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        laniel_francis@privacyrequired.com,
        Kees Cook <keescook@chromium.org>,
        Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 10:07 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Apr 6, 2021 at 11:15 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> >
> > As the name shows, it checks if strings are equal in case insensitive
> > manner.
> >
> > For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
> > strncasecmp to check that the input via sysfs is "mi". But it would
> > work even-if the input is "min-wrongcommand".
> >
> > I found some more cases using strncasecmp to check the entire string
> > such as rtrs-clt-sysfs.c does. drivers/pnp/interface.c checks
> > "disable" command with strncasecmp but it would also work if the
> > command is "disable-wrong".
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> I do wonder if these (sysfs_streqcase and sysfs_streq) could or should
> be conditionally available on CONFIG_SYSFS=3Dy; don't pay for what you
> don't use (without needing CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy)?

Good idea.
Thank you.

>
> Also, it might be nice to share the second half of the function with
> sysfs_streq via a new static function.  Though it will just get
> inlined in both for CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy, it might
> help the compiler if CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy was instead chosen
> if the compiler cannot outline/deduplicate the shared code.  At the
> least, there's less duplication between two very similar functions; if
> one changes then authors may need to be careful to update both.

Yes, they are exactly the same.
I will make an inline function for the common code.

>
> Are either of those concerns worth a v3? =C2=AF\_(=E3=83=84)_/=C2=AF

Sure, I will not forget to add 'V2'.

Thank you for kind review.
