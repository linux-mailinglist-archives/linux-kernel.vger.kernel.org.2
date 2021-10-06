Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67707423897
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhJFHQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhJFHQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:16:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E916C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:14:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z20so5940040edc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FKkxnwefK1XcTkS6okwbr7gjiMnKsW1UTNUB6PW2j2w=;
        b=g06bWCmXD+yHAFiTj+dK2QFfu3sHDEpXt0L9HMbp4Kxbi6r45x/8xczfAifQ437RDh
         6fhDSMLmBCqaeaG2NQQxH2+ujYY/XJBucOOO/e9S81kA8Oc5oBatiXawqNax1N4c+g5j
         BuD0jEuVAytVHbK4NDUPabBCwVZPilI/Y5xt1vz/b7HCDattQvQfnQsEwnR81TczT4Vt
         nFewLf4UnOtflL3k8XlEabw/MjJXwADhXJpGubqA2U9l4ZXxxq9wvw/AyPT1KnaeRcgQ
         VFMXJ/cGbxv4nrT5K+9xFJZ/tPkF6OToqTKXFD78sKwEOR3ZycrTK3h8D8SzDjyuo778
         mUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FKkxnwefK1XcTkS6okwbr7gjiMnKsW1UTNUB6PW2j2w=;
        b=E2sWX5XukAf8J0SGKTCeF8klyaKNzt8UZ90hvb9B8EoMw8/SnJ2jefwL2BYA40sKDw
         EPNcDNwN7A9T1NQAaRIA2/xR4nhB4oy/CUGdw/11B5pO+vWTNPJrHcFtj1l8cuhosxre
         w3HfsAipPdiu9fTStBllhmGhGEWZt3yrvGrzCiz8wOZDV4xAm0LVsoTADRnghyUGMqq4
         zGDI4Kc2iza5fvk6fK7nmJuo4w+9TEmCN+tolDI1CzvpYEYjxq3LHfkTCqmjoomoYJHF
         qbZ0pI8a0NxYzB8GGwQc3QdIdrmkfvtpQPCePyAtnLpt1xThi7PZTRpym5K4i48XHD0E
         1p5w==
X-Gm-Message-State: AOAM530qyA8qC768DRtL4zs1wJ2poDFfVqCSUScTW45m3zdVBaQmCJAh
        HO7sR84rb6KxakoixKrb3Q63Uy9cm1vU3XHHKi8=
X-Google-Smtp-Source: ABdhPJw8QdZkF6XMyKpSlg8+1P4hneFTaXWcVOLoUrfRsXTroViZFGMMfnGtU7K9X8JO3msqLsvCkTkqdJ4IGWsSo/4=
X-Received: by 2002:a50:e188:: with SMTP id k8mr33120433edl.119.1633504488999;
 Wed, 06 Oct 2021 00:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211005212634.3223113-1-lucas.demarchi@intel.com>
 <CAHp75VfT+dSNYSntj9O5a9NVGnbf_raxWLiS7ciDMe-kRL-+=A@mail.gmail.com> <20211006063029.owhu5hjtaivib5d5@ldmartin-desk2>
In-Reply-To: <20211006063029.owhu5hjtaivib5d5@ldmartin-desk2>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Oct 2021 10:14:12 +0300
Message-ID: <CAHp75VeajZkMzS5PA_D+cip_3BatdPS4mH6w_3zCoy_-yY0MdQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: add linux/string.h for strlen()
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 9:30 AM Lucas De Marchi <lucas.demarchi@intel.com> w=
rote:
> On Wed, Oct 06, 2021 at 08:57:27AM +0300, Andy Shevchenko wrote:
> >On Wednesday, October 6, 2021, Lucas De Marchi <lucas.demarchi@intel.com=
>
> >wrote:
> >
> >> linux/string_helpers.h uses strlen(), so include the correspondent

correspondent

> >> header. Otherwise we get a compilation error if it's not also included
> >> by whoever included the helper.

...

> >I=E2=80=99m afraid this potentially can add into header dependencies hel=
l. What
> >about moving the user to the C file?
>
> I can do that, but I don't see the problem here... afaics it has been lik=
e this
> for 7 years, since commit c8250381c827 ("lib / string_helpers: introduce =
string_escape_mem()"),
> and the only way it was never borken is because
> linux/string.h is already being indirectly included from other headers.

> So just adding it here is harmless.

Quite possible.

...

> Anyway, if it's preferable to move these functions out of line, I can do
> so.

I have no strong opinion, whatever maintainers will decide then!

--=20
With Best Regards,
Andy Shevchenko
