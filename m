Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C123F12CC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhHSFfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhHSFfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:35:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C32C061756
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:34:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v2so6897170edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzBtTyUuZAZ36Cvu3BHXUN5QOP1AlqjuoYzkcck7J1A=;
        b=YaLJ+ZaUmHM3LQ2Pl6U11IaU1qu9qqCJf5sCiVrZ98oAsu79x+O415kgpEy1un6i1I
         NVSa6wDxZgaBUI0Cuh6NOzHTN4mAS5inXiC6lj5BF2uZ2lR8AyJgdoHZtfin3xDEC4Wl
         5p5puCteOcl9Af1R2tOQSsDteczmhBGJQ8LHMppYBf5n4dGuSxdt4LF4gsVJEbmjkxmk
         qLNoObhXGmoxWRfD6Aun1k5gYcMnSOmIH5lN6at/RrETTECpKpun8EOoHjF2w9tWYkK9
         SzLjsKbbnDfrdUD1qkJU2iiXhK8dhw1tNrrx+gPOi9qZ8vgS0QjsPjX2bIIcrUS8ZuvW
         piSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzBtTyUuZAZ36Cvu3BHXUN5QOP1AlqjuoYzkcck7J1A=;
        b=lnIyK0oKeYBRiLYeUK6A/A90FXIDdXEwrCP3VKNnnCODHj4y+yIRR0zIgqG/VwcfU0
         IOg0Id5PxIqPEwZvIgBD522UyL3erEeNrjtfYi1f6AbBHgYX6QLAKVo3PgLzLUI5k83H
         DID8ONY5Hh6NTdTCYEjjTjyScydzHnGdiTiUXpW13scwL3uDiWieQzszEG28h4nSYOpy
         EpuVjtx0hUaYv073hDmP0CqUPkqZpabjAj+ADHug2mbBRoMZlLPW4CW1CM9K8KivcOKW
         k305y8Uj8mZ8rcm0vbWR21dyUAn/P9s0JlnvdKwYQA02CciD3D9wRazNlbhNcrsJlhj5
         XPVQ==
X-Gm-Message-State: AOAM532F6yK6xg/zSy1IkcbG26S4K4+LqJAvAEClwpS1B9l6FOZ/wjXl
        J7+Qr9Ynd0Yq27N8YpaZ2uXRBbGs9Cc/nexO+wQ=
X-Google-Smtp-Source: ABdhPJzBatjLL3awV/q6HXSBADXn5zyqN3/eccPfkLzcCrDeOzTapJW7A1LtPdzCPGSa9mzEUIr51TbhQWimpeRnEWc=
X-Received: by 2002:a50:ec0e:: with SMTP id g14mr13880265edr.157.1629351272988;
 Wed, 18 Aug 2021 22:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <202108172206.9cbgvI53-lkp@intel.com> <4dabc78a-f9ee-4e7d-8bf3-ea1c6cef8530@intel.com>
In-Reply-To: <4dabc78a-f9ee-4e7d-8bf3-ea1c6cef8530@intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Thu, 19 Aug 2021 08:34:22 +0300
Message-ID: <CANhJrGOh+9PoMmsv-Q9petTV-hv9rv9nOitg0NCQHqXVXzJvvw@mail.gmail.com>
Subject: Re: [kbuild] drivers/regulator/bd718x7-regulator.c:531:8: warning:
 Excessive padding in 'struct bd718xx_regulator_data' (8 padding bytes, where
 0 is optimal).
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 19, 2021 at 6:26 AM kernel test robot <yujie.liu@intel.com> wrote:
>  >> drivers/regulator/bd718x7-regulator.c:531:8: warning: Excessive
> padding in 'struct bd718xx_regulator_data' (8 padding bytes, where 0 is
> optimal).
>     Optimal fields order:
>     dvs,
>     additional_inits,
>     additional_init_amnt,
>     init,
>     desc,
>     consider reordering the fields or adding explicit padding members
> [clang-analyzer-optin.performance.Padding]
>     struct bd718xx_regulator_data {
>     ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/regulator/bd718x7-regulator.c:531:8: note: Excessive padding
> in 'struct bd718xx_regulator_data' (8 padding bytes, where 0 is
> optimal). Optimal fields order: dvs, additional_inits,
> additional_init_amnt, init, desc, consider reordering the fields or
> adding explicit padding members
>     struct bd718xx_regulator_data {
>     ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~

I don't have a good feeling about these checks. Especially when a
struct is composed of other structs - which may be modified
independently of the code we are looking at here. Any unrelated
addition of a member to any of the structs (well, maybe not the one at
the bottom). I guess fixing all the users of these structs when
something changes would cause quite a churn of changes... What is
expected to be done as a result from these mails?

Best Regards
    -- Matti
