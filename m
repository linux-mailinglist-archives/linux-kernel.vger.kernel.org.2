Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07B3C73B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhGMP73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbhGMP72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:59:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90CAC0613DD;
        Tue, 13 Jul 2021 08:56:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w15so21980272pgk.13;
        Tue, 13 Jul 2021 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkUgRBuDDTuqSHeo8ZDHf6GNDnL7WlSVrrAS8awCmls=;
        b=gf0iGBX6WEkKHEx5ckstlflxSmHtZ5pqmRY2XWAPU0zIsNdXL3qkkkomZqAb8Txu5G
         MR5MfE1LLk0UAPdLcRvhcmco4g3ZyHdjWgqS3aVG/dAA2bgKvzMnNzcUtmgNkE3q/qDQ
         1HyDEtxtPN7gPn8ri156mEAh49yZS4WVs0Ojbd77+fMU/r9NXqcNcaJET5WmKMatqEBk
         A9wqKP5P2Z0EULu71ssrDsMf41XDTSBpL5lRtA1GuAuAX5OoOUbGdJh+eSwRIEyCikZV
         G0/12w8OUyKayhpFW7cU/nu8LBdZQA3H6hy3LcSV6z6ubYQ4GcS3dJbjKCiKqMxq9YSA
         h+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkUgRBuDDTuqSHeo8ZDHf6GNDnL7WlSVrrAS8awCmls=;
        b=rtPH4ilMXpiebx7D/lzvPYoFlNzelOMzy+g/IltssfRxtfV9/G8/N7ZnjcwYZyfTKy
         v4AEn86gzLmOW/cCAMzIq2IVHrspVTyDqDaZRHtlqZBm1QrX4RBpXqAEVmKrLYA3DmTb
         TJS8KrhAHroHk1YrdjORuXMr47LMsBCG44ppT7Rl1SZ4jkwPqxxls5SUsuxzK+Fcz2q2
         BjAWVmQnLVkjCIleIYGAKpbJYphrMP1yfzf8emXPhbIrjhW9RWclMBOpOB0KRAHE42Vz
         sxmXur0LOKJ12mK1bHnbSykKhP8WGG/rCxr+JZ5BYlwt7FUlu4ulSCHT0qsJmY3CtHM4
         mxoA==
X-Gm-Message-State: AOAM532rCpB9LG78jkkZmYZ7agP9PBxLS3SAGCD+KollE9i13hEEy/6P
        rR5WLfsSo5bgLacPnGrPaZXoLGpgxw7AvDXZQkw=
X-Google-Smtp-Source: ABdhPJxan9EflnhwmIouyYlhigesmxK4vLk5tZ2D7f8d76++4SNktmkv0Rk1kAGD/vXHsqATGr0E+TfD6rTthFEEtjU=
X-Received: by 2002:a63:d014:: with SMTP id z20mr4898653pgf.203.1626191798398;
 Tue, 13 Jul 2021 08:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210708224226.457224-1-djrscally@gmail.com> <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk> <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk> <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk> <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
In-Reply-To: <20210713152454.GC4098@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Jul 2021 18:55:59 +0300
Message-ID: <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 6:25 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 13, 2021 at 12:32:26AM +0100, Daniel Scally wrote:

> > I do think it can simplify driver code too; a lot of them aren't written
> > to parse platform data to get the init data, as they're just relying on
> > reading it from devicetree so in the event that we get more cases like
> > this, we need to modify those drivers to look for platform data too. On
> > the other hand, even the drivers that don't directly call
> > of_get_regulator_init_data() still do that lookup during the
> > regulator_of_get_init_data() call in regulator_register(), so the ones
> > that do parse platform data for init_data structs will check DT as part
> > of regulator_register() anyway. Imitating that seems simpler to me.
>
> The driver code is trivial boilerplate, assuming someone doesn't go and
> implement a helper to register stuff separately like I suggested.  The
> proposed swnode stuff would involve duplicating the DT parsing code.
> This seems like a whole lot of effort for something that provides a
> worse result than either of the existing things.

I'm not sure I follow. Where did you see the duplication when I saw
the other way around?
Converting code from OF to fwnode APIs in most cases is smooth and
doesn't add any overhead to the codebase,

-- 
With Best Regards,
Andy Shevchenko
