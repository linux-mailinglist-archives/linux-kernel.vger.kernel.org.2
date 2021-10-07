Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3717424DB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbhJGHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbhJGHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:09:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48F3C061746;
        Thu,  7 Oct 2021 00:07:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g10so18832750edj.1;
        Thu, 07 Oct 2021 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpotU76vDdSm2eyI0wHhAXO0FhpuVMiLp6edMsQuB/8=;
        b=kkEwdCfbTMghfRCVfLPPLp6Ro4F1GGM3fceeohiUVlRN4EvoS4bUU9ZEXdgNEcYSPQ
         GqAsnu/9pLxoqx9/4XrtPZGMjLaG1cTG8SI+wqFhLWPUg6ltkKAg9Egsk/1tu02ev+bT
         vB6yL1wCtirUM6SrADyGQJjRQwGgvaD8saIxAOpJFTm4GwRmOnBdRjCgGkI0jbVT/LYA
         DUEdSsEUFz7oc2mT9zolDrRgEKm6+j9Ja6Q+6sGMF9C2+4cAf7FTDWoPhM0nQGcFplDi
         362TcgNl4Uqr7APsGnhAdmCoDYqiagqQkjVOg0ajKvBiitYSGIHuQi8kOx9/LsUGVRer
         REdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpotU76vDdSm2eyI0wHhAXO0FhpuVMiLp6edMsQuB/8=;
        b=B3D/NmWgMJgtPyqFLgFNEmI6XMp6hYZsLUci46EMNYsTSfhMlLBj6M9BUPfXeyn8Dy
         kQh1IF1SYFtTQ5uRCPlggmUTp1o9UUoXJ3tAvtvtMO0Dr21bTgxB5XEQ3T4tlPR+OTVh
         nsCAiFictvIQDJMpino+WDncU6udHY7kJUPivgyqln7hjTGochRQvZGM4qfCrLYTmAMK
         0tvlxI+1jGXAZRBIbZb8T+PW/9dvCQlEMFJhPO+fddRL2SFZVN+aFeUroSpKX59jArgR
         wpQZ5fFhs/EFEb3C1g48pmqR57InS8Daj2/fem61WxBwKbhCwvJcjQLfkG+PL0QIpqWW
         yDAQ==
X-Gm-Message-State: AOAM533vuCbhagApG/0UKEWAEmlD7mTlIQwQp8XlciGFShW0pDYPzkmo
        aSXGJHobcoJAWOE+lxRHwkguv9fFO/C+oQSWmGg=
X-Google-Smtp-Source: ABdhPJzPiN2EYEiuKmeFZCvmZzjTLeaum6RWXkWNbQ1qvZhfFyAItuboJf5DUkY/AeLRN5wZXWuWQUVdU1fvcd/tiwk=
X-Received: by 2002:a17:906:5a47:: with SMTP id my7mr3576173ejc.128.1633590442300;
 Thu, 07 Oct 2021 00:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633572679.git.atafalla@dnyon.com> <5004d52da527bf1dd9e5b17e20b2ce50a0b57b5a.1633572679.git.atafalla@dnyon.com>
 <4682758.31r3eYUQgx@alexpc>
In-Reply-To: <4682758.31r3eYUQgx@alexpc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Oct 2021 10:06:46 +0300
Message-ID: <CAHp75VdbZmGeCq8A1E3AJU4T39xPUhomzrQqZNaDj8Zi0x9WrA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: sound: max98927: Add reset-gpios
 optional property
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 5:45 AM Alejandro Tafalla <atafalla@dnyon.com> wrote:
> On 7/10/21 4:38 Alejandro Tafalla wrote:
> > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > ---
> >  Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Sorry, I forgot to add:  Acked-by: Rob Herring <robh@kernel.org>

And commit messages?


-- 
With Best Regards,
Andy Shevchenko
