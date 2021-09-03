Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58C6400509
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349414AbhICSox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348816AbhICSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:44:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B91BC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 11:43:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s3so230447ljp.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PDBYi9Z882BNn51ficUIiFA+0LchDZSUHG8v/R1TTmc=;
        b=erwLqXCPiOkc7iLNX+1wsf+W1xGRPlDR/efCspYuJjsaoLXEbWO/Nfc5o6johJ+t5q
         Slyl6X+1hibZjNLP2somHUs5gbYWVosvZm0eAL92nNAtKKMMb5VVvbxem0vdKgNG0Q6C
         moEnDJGq8wvtO+qgfSREpcFfcutSEKxCSWIr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDBYi9Z882BNn51ficUIiFA+0LchDZSUHG8v/R1TTmc=;
        b=Q9CisniTsLKd/GrBKPaz3JZZ7reTqPG512I/nokw1k+Z7FqHikZNtgOUsnJhNvBXyA
         WxWuLQSL4p47lYrGIQnBcH/9PJfFr/vQOeiZOEDN2RrUfG6x6pwIuNBWBH0e987i4cLq
         sV/BcAvFpeTuInXJPMoLh99EqGbxBwIF6i6MoDQoWnuVpLipKBNjgWbRKPpx6jdWVFvd
         3LYw2fQrvRvGv/lm0AxqM2l1M6jDIPwRDviI7EAytPfV/xv1OjGGak9mQrAUsdSwbI2v
         OZ3aEHKNmV+VMYEMeyZiO+cBUHneyWJ4HtUTkSQPuG81NSwy3IisNPM8E8fW9tkEZP9P
         cC3w==
X-Gm-Message-State: AOAM531QzFS7dJ9n/Jp6YVzYgnhbYvG5SvhdDTG2jLuvdSnFdt9IgRDE
        gqTbYeZBrP7U0Eo4qU6J/ZZ/vu6rV5cZpaau7io=
X-Google-Smtp-Source: ABdhPJxN8BvnvVRjYx2EoPGjtnz/HqeCwVh2Gtc1wpQKQXwx9exJYhd45RrdanGe7iz9DiLFa8TvkQ==
X-Received: by 2002:a2e:9995:: with SMTP id w21mr288074lji.163.1630694628303;
        Fri, 03 Sep 2021 11:43:48 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 6sm23997lft.40.2021.09.03.11.43.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 11:43:47 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id t12so102071lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:43:47 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr261598lfg.150.1630694627536;
 Fri, 03 Sep 2021 11:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <YTIrHxWNzIwuseXO@8bytes.org>
In-Reply-To: <YTIrHxWNzIwuseXO@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 11:43:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTpYOsRPm4T2EV=Sxm52buZrMpRdwSDeedCSF4jh=M1w@mail.gmail.com>
Message-ID: <CAHk-=wjTpYOsRPm4T2EV=Sxm52buZrMpRdwSDeedCSF4jh=M1w@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.15
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 7:03 AM Joerg Roedel <joro@8bytes.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.15

So I've merged this, but I'm not entirely happy with some of the
rather insane Kconfig choices.

In particular, the defaults for this:

  choice
        prompt "IOMMU default domain type"
        depends on IOMMU_API
        default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
        default IOMMU_DEFAULT_DMA_STRICT

seems fundamentally confused about what the h*ll is going on.

Why? Because a choice like "AMD_IOMMU" or "INTEL_IOMMU" isn't some
exclusive thing. You can have one or the other - or both. Or you could
have another IOMMU entirely, despite _also_ having AMD/INTEL_IOMMU
enabled as a config option.

IOW, maybe INTEL or AMD_IOMMU is enabled in the kernel configuration,
but that might not be the IOMMU that is then actually *active*.

The active IOMMU might be VIRTIO_IOMMU, for example.

See what I'm saying? Making the default be based on some random "this
driver is enabled" when it can then affect *other* drivers that are
also enabled and not part of the decision seems to be a fundamental
confusion about what is going on, when it's not at all clear which
driver will actually be IN USE.

Now, I don't think this _matters_ that much in practice, and as
mentioned, I already merged things.

But I think people should seriously think about either

 (a) make that default something that is actually *reliable*, so that
the fact that you have possibly enabled iommu X doesn't affect iommu Y
that is actually the one in use

or

 (b) make the defaults be actually per-driver, and set when the driver
is in *use* rather than this incorrect model of "enabled but maybe not
even used".

IOW, the fix might be to just say "the default is always lazy".

Or the fix might be something that is global to a configuration and
doesn't rely on which iommu is in use (eg "on x86, the default is
always LAZY")

Or the fix is to make that 'iommu_dma_strict' variable - and the
default value for it - be a per-IOMMU thing rather than be a global.

Hmm?

              Linus
