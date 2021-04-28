Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7236D237
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhD1GcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1GcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:32:15 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:31:29 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id j6so4734504ybh.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNbceJ2JPy17A3jIMWMtBBJqu9jLShZ5Gqf22qewDXA=;
        b=EJaXHE9qosy2Xm2b5VHtfxSMpk+/LnJ/RyBCswUXYSuznYT7DlLpZHP8CLD9DK1fgE
         hftdE4h7KSJXW9GnX+/mNv6ugDWpBewdXS+9g54vl7GQUa1xJbvCOIVsTLlyTrpNF1tk
         82ItMhUJbzZPIj4jovBPpO3d959ZMF8Tv7594=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNbceJ2JPy17A3jIMWMtBBJqu9jLShZ5Gqf22qewDXA=;
        b=o2zVjjA28uBrIXOhITYrqf+meS9PS90qhyFOLTluVhWH/uTTviCZyNMAALNYqk5QL7
         RYxyw8N+D1mGbHcPl5c8eOEtmLa4nHQCSX4D8LN4ZPADndo2ONNOozzFXDC6Nh1ZqXat
         WJUENZcib+44CGUxbpNVyoybU/2STschWjfEs6Bh6aqFfRK+/iojqJIjbzq8AL1V6HPm
         e85FDjzWRRTvKVCTNJPO0Cp/B+ldcqyWPDVR3OnXK+D+E83fJUTwCbemwjhDgih/zMas
         sdV7PTo+aHePj9Al9gFeRzWkX70GGNZNf5ZFv/7BwCsMF+uZ5goXOWcp73D+rZgiVKZd
         4fUQ==
X-Gm-Message-State: AOAM53126VIFl/BhVCSw/V+5mAepdou2LsVBLfebuABZA3emAgsflwJE
        DUDmx42QtlpXgtXZ5wxD/IPYDuiyaGpxqRXERLUa
X-Google-Smtp-Source: ABdhPJzokc03Du5N/maoI43vXKBCcwRm5pu0iU1IIRyTDnZz7nX/Uxdplb7O6nlg16pgeJh2NRMVxiwUJgoXKOw1Vkk=
X-Received: by 2002:a05:6902:728:: with SMTP id l8mr15508196ybt.326.1619591488539;
 Tue, 27 Apr 2021 23:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXUXMz51GMRM6s7YqGYgfZwRhW=y0aCALM-C3APU0=GjZ+X_g@mail.gmail.com>
In-Reply-To: <CAKXUXMz51GMRM6s7YqGYgfZwRhW=y0aCALM-C3APU0=GjZ+X_g@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 27 Apr 2021 23:31:17 -0700
Message-ID: <CAOnJCUKrqOXGY7ePLEqxtAk39_fbhxt0wVhEtrv5m6X2wwuUpw@mail.gmail.com>
Subject: Re: MAINTAINERS section RISC-V/MICROCHIP POLARFIRE SOC SUPPORT with
 invalid file references
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Atish Patra <atish.patra@wdc.com>, Conor.Dooley@microchip.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 9:15 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Dear Patish, dear Conor, dear Palmer,
>
> Commit df29598aaf5c ("MAINTAINERS: add microchip polarfire soc
> support") adds the new section RISC-V/MICROCHIP POLARFIRE SOC SUPPORT,
> but that section solely refers to files that do not exist in the
> repository.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
>
>   warning: no file matches    F:    drivers/soc/microchip/
>   warning: no file matches    F:    include/soc/microchip/mpfs.h
>
> The patch series, [PATCH v4 0/5] Add Microchip PolarFire Soc Support,
> never adds those files, though. Are they coming through a different
> patch series into Linus' tree or do you intend to refer to other files
> instead?
>

The actual files are added as a part of the following series.
https://patchwork.kernel.org/project/linux-riscv/list/?series=467187

As the "Add Microchip PolarFire Soc Support" series added the basic SoC support,
we thought it is better to update the maintainers file in this series
to provide the information about
the maintainers for the PolarFire Soc.

Should we just remove the Files section or update the maintainers in
the SoC system controller series ?

>
> Lukas
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
