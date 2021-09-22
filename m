Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8D41460E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhIVKWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhIVKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:22:03 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF7CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:20:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a10so7530684qka.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJKyuUo2cdSRgXWfPtF0UIR+koPgLUlkrvvmEUF334g=;
        b=EHagsB4VKGNEf68iLliTBnVZFaSLCT5+qRa69PdjB5hw7F7wX7FQKprU0O748XQiRe
         UYWFzxeLKiqtHyQJWs5z4A+jfwnrrXRjF1dc67BHoWWnFUwq/q96hh8W+oK1VSlu/NH8
         ktQEnBLA5ilAsnXO6nYMXrJ+UjCZ9wHgx+PVqH2Mx/XE3OMZWbO2GsGnxSUc600DAawN
         lgzHo4UbhSym3kfOr6U96u2JLmgdQgVgzfcOsIi5G4TuLnQQ1juDQ4v7QVel/KLGgVS4
         fsms+Sq/IXWuPc8mKn1ipD5lDcohMDWLCB9Fa2gDrjfWPGFkRyPP5Xi0JvcehWdNJUrS
         O2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJKyuUo2cdSRgXWfPtF0UIR+koPgLUlkrvvmEUF334g=;
        b=TrIkFXpd9rtMfP5yXw+aY4yTNXwzmAADfWwqV/cjSuLApszrkMTA8APDgXvGgJgFwV
         UPvPpIi5cwfwIgPO0n7wr4998f6JaY2O/f/uoyB6Ux9fp+y1LQWYGMDlNzo5c1318X/R
         NWryXvVJ9Nowq7T8T1txaoR5WbYaE6X4N874Grk9UgWVfuKV+cTtwylyjkl0VIxa6fPj
         iwyCcWmJodPySf4PQoNA/1n9K6Vx2exZRf++0XfbWYBxpsPznBJaivuxFA/BQEmAosVJ
         CTYtJ9dMTiAElAMDmye675P6xAYtQIbaeKeYnZ8rxzYfX4nbIPcKfz1gfMuCJ57hjAuY
         oEJw==
X-Gm-Message-State: AOAM5301UCYNWfbxHtkNAIAbB9ZwPd/0YhQLDEDOtpoHRlQFZUio3S6g
        rqUtb2XpvK6zBpAdjf1g7Yp9Bi19ay3kktKoC0xCpA==
X-Google-Smtp-Source: ABdhPJwcR9hONH14/tIOQaEzKtYwof3QggJr6ydYypXbFaTw48vYpEYA5ppNEBfTij+28tygr8MBNi49A8wWTZO9C6w=
X-Received: by 2002:a25:7146:: with SMTP id m67mr43831164ybc.353.1632306032671;
 Wed, 22 Sep 2021 03:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210717045627.1739959-1-daniel@0x0f.com> <CACRpkdbE+_DJFhBCmtz5JwJupf7QkkWZhXrgf1KG_3rPqvEm0w@mail.gmail.com>
 <CAFr9PXmFHanrx4Frg3hQwo-RbAY-UXxC=FOAj++cshSHa99z3g@mail.gmail.com>
In-Reply-To: <CAFr9PXmFHanrx4Frg3hQwo-RbAY-UXxC=FOAj++cshSHa99z3g@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 22 Sep 2021 12:20:22 +0200
Message-ID: <CAMpxmJUoG7qPhy2CxapCn1M=w_AssOQsEmyvXO18OpedM6hBjw@mail.gmail.com>
Subject: Re: [PATCH 00/10] gpio: msc313: Add gpio support for ssd20xd
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 1:50 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> + Bartosz
>
> Hi Linus, Bartosz,
>
> On Fri, 30 Jul 2021 at 19:12, Linus Walleij <linus.walleij@linaro.org> wrote:
> > I suppose Bartosz can just merge the 4 first patches into the
> > GPIO tree and you can take the rest into the SoC tree?
> >
> > Yours,
> > Linus Walleij
>
> I just noticed I hadn't to'd Bartosz about these. Is there anything I
> need to do for the first patches?
>
> Cheers,
>
> Daniel

I only have a part of this series in my inbox and patchwork doesn't
have it at all - can you resend it with me in Cc?

Bart
