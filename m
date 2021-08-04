Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33383E09D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhHDVKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHDVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:10:01 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5CCC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:09:48 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id m13so4043219iol.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DDuDp9xj9y+rrWppusE6gmVYzLBup1vgAlMNghHvaM=;
        b=Ld8ZFNDhBPYA6MmzixECIwGagdHr+WHiXBuRCjBzq/WE+lj/QdGsoYwBV+K0FS7D49
         1ApQygsfhan/neAA87N9r1/9OIAKKyjGLdqe7hfnXrFAtOrIRcQtxCWv6Ts0tspIwSs1
         OkeBCXmcWwRljXSxA8SnwLvF5S6gbTHKIoYc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DDuDp9xj9y+rrWppusE6gmVYzLBup1vgAlMNghHvaM=;
        b=CBY3JkYVpvdoIJsluE4GN1j9ekybKNRtb7NnOYSU585YODua3G8Y8ZAn+7g5Tr3qq6
         xJBVhKeL3LsmiPKd/w8aZP5vA/jAQbfH08rzaNQA8A+wz6p/Tqsf/oF2TRQa61OkqmT4
         6Exxf2r3Gnab8gcQCx5GF5vvn87KRA6ytlvSkrfSKY908sLydMkZn9hkCFJWJmY//X5c
         Gh5JdQ/z+M+Bz+eLAwOZI7E/X2EOaVwMVfLT0HnKhGuwCECE/o1KSoJ/in+o9513MVbh
         uU/edk8esgGNxGaUtqEhsqyaK7PVFsF85hOLcwpAtEPmua32eCHUFaW+DzcDwYn32mnU
         yRyA==
X-Gm-Message-State: AOAM532gU3shANBlPPpEflbS7Nh7zDx1O7c2WUaUDGF9P+bMAH7U2rXd
        YJHHNRJG995Sfw/s62Y5B8DM4OVlmtw9epzJo0JXiQ==
X-Google-Smtp-Source: ABdhPJw0mOybeM3dYriDbE4P+cjOY+Ld7jhKBY/sqQWK+2paixaaMl+3LFKS8qESFm8OeL4h8HNsBdJD8DsTjptakuw=
X-Received: by 2002:a5d:9d19:: with SMTP id j25mr80888ioj.84.1628111387933;
 Wed, 04 Aug 2021 14:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210405202857.1265308-1-gwendal@google.com> <CAPUE2uvZzXUoG+Fr7c3q0ysMUz0eb36PrdknG37FkG1v2h7zUg@mail.gmail.com>
 <CAE_wzQ-bMhrH7pcwNRRTgLFD3opYE2UriU_N=-bu+neq8MHFrQ@mail.gmail.com>
In-Reply-To: <CAE_wzQ-bMhrH7pcwNRRTgLFD3opYE2UriU_N=-bu+neq8MHFrQ@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 4 Aug 2021 14:09:37 -0700
Message-ID: <CAPUE2utqRi9+Rb3UPE6FFRVoKDE5z+NFk1TL5Nmb7CW-VpBK=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] platform/chrome: Update cros_ec sysfs attribute
 after sensors are found
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v2 patches I submitted were wrong, as cros_ec sysfs driver is
modifying the attributes of the class driver, not its own. I repost a
patch that takes that into account.
Gwendal.

On Sun, May 30, 2021 at 10:36 PM Dmitry Torokhov <dtor@chromium.org> wrote:
>
> Hi Gwendal,
>
> On Thu, May 27, 2021 at 2:01 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > [+dtor]
> > Is this change acceptable? I was worried it could break when
> > asynchronous probing is used [https://lwn.net/Articles/629895/], but
> > since all probes are deferred in a single thread, it is safe.
>
> I think this is a bit awkward that we need to poke a separate sub-driver.
>
> Have you considered having cros_ec_sensorhub.c create its own
> attribute group (it does not have to have a name and it looks like one
> can register as many unnamed groups as they want) and have wake angle
> show and store methods directly in cros_ec_sensorhub.c?
>
> Thanks,
> Dmitry
