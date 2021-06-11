Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246EC3A3E22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFKIio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKIin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:38:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:36:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d13so22659586edt.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Stfx3tnoq//z9aIvFtSvDmcurTUP4uemMAf8FTC5FCE=;
        b=ODJz0nR+PRHGbDqpSu6oJGbxwxENvsmR6RZXY7wmRVfXrpVwWLN+LxNI20J6yC6GAO
         thEK+AbufUhBTJwq42d/7IilgqGq/piHvbhUtLpY74W0A+xxLOIHHn1klzbmjqCaM7Jp
         HUB8gwdcIsJny82G1sEYXl6jFabscvf+uONfkPVJkxgyvTsi4M5YwijmsLUrb+wzlkHa
         xNEDbkpLiIxAACANHXmO3J3/Y9sY9ifICy/9ryMGcD52+tkDf8HImYS7E3OkTn2Ycmiv
         MfF82jzpnDPboRSy5XNkEtGm4hLaBejrh4Iy97I01rdv9Mc4vhmvu7bWCyhlY+IrgcU2
         h7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Stfx3tnoq//z9aIvFtSvDmcurTUP4uemMAf8FTC5FCE=;
        b=KPVQZ7HDQLOxQymyqZH5yKvHa1XPCA57Xl1fkx6HUZyaqOf3fGYs3NgXpMrU0xT75G
         d/W4l9ynaX/ml/fU295fK/WIHQMm/E4HspaTeagbaEfleJOfxTBN2wcVg7ug9VztOGiy
         hMPbDOMUYO2T4qkkaGxY5+aYzY+c5otYCuL60PzBkrg3uzrAN9sWBlXZhCTK9Ex/eJdK
         5kxYFArRv0rz57EpocUlXa7PcKEVC6vDhzgREsNTalroDnqXW+MgFuCV4eMote+Op303
         HvGwRrwkcQh26/OLzlOofLrpAeD65BpBr0LMcKEGMDbvvkOYcxA1gnJJGPDO2M0csGeb
         gPxw==
X-Gm-Message-State: AOAM533YJ2gsRAwqOvR00fAtdv3oMwD+Qfsv3HEpChLJD6MG/o3FSGtR
        tqGstYn+SwgFNhGDiV5zefwp4M7Ju7OknFQ/
X-Google-Smtp-Source: ABdhPJxoMmSH1gvyLXOsohrJtz9aDDqbw4vkDr/SQBCLO4P1/LMvoQaaaepD9fJ8MK+uFVzhCb2f0g==
X-Received: by 2002:a05:6402:214:: with SMTP id t20mr2626251edv.20.1623400590635;
        Fri, 11 Jun 2021 01:36:30 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id h6sm2387223edj.91.2021.06.11.01.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 01:36:29 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id d184so7651920wmd.0;
        Fri, 11 Jun 2021 01:36:29 -0700 (PDT)
X-Received: by 2002:a1c:7d15:: with SMTP id y21mr18785377wmc.120.1623400589079;
 Fri, 11 Jun 2021 01:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org> <01000179f5da7763-2ea817c6-e176-423a-952e-de02443f71e2-000000@email.amazonses.com>
 <YMJOk6RWuztRNBXO@myrica> <01000179f9276678-ae2bb25f-4c0c-4176-b906-650c585b9753-000000@email.amazonses.com>
In-Reply-To: <01000179f9276678-ae2bb25f-4c0c-4176-b906-650c585b9753-000000@email.amazonses.com>
From:   Arnd Bergmann <arnd@linaro.org>
Date:   Fri, 11 Jun 2021 10:34:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2-bXfDcPymMct2aUXs2m+YgbKdmAatMMs9tnc+HjS_xQ@mail.gmail.com>
Message-ID: <CAK8P3a2-bXfDcPymMct2aUXs2m+YgbKdmAatMMs9tnc+HjS_xQ@mail.gmail.com>
Subject: Re: [Stratos-dev] [PATCH V3 1/3] gpio: Add virtio-gpio driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Stratos Mailing List <stratos-dev@op-lists.linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jason Wang <jasowang@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 5:39 AM Viresh Kumar via Stratos-dev
<stratos-dev@op-lists.linaro.org> wrote:
> On 10-06-21, 19:40, Jean-Philippe Brucker wrote:
> > On Thu, Jun 10, 2021 at 12:16:46PM +0000, Viresh Kumar via Stratos-dev wrote:

> > > +} __packed;
> >
> > No need for __packed, because the fields are naturally aligned (as
> > required by the virtio spec)
>
> Yeah, I know, but I tend to add that for structures which aren't very
> simple (like the request/response ones), just to avoid human errors
> and hours of debugging someone need to go through. __packed won't harm
> at least :)

Extraneous __packed annotations do cause real problems:

- On architectures without hardware unaligned accesses, the compiler is
  forced to emit byte load/store instructions, which is slower and breaks
  atomic updates to shared variables

- If a function takes a pointer of a packed struct member, and passes that
  pointer to a function that expects a regular aligned pointer, you
get undefined
  behavior. Newer compilers produce a warning if you do that (we currently
  shut up that warning because there are many false positives in the kernel),
  but you can also run into CPU exceptions or broken code even on CPUs
  that do support unaligned accesses when the variable ends up being
  actually unaligned (as you just told the compiler that it is allowed to do).

      Arnd
