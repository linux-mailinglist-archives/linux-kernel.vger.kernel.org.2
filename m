Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9163454EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCWBVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhCWBVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:21:37 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208FAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:21:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e33so10084116pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=D6/t64GWTSvYj3tg/pZ5Ic42OSmLCS9eM7+HxTJh7bY=;
        b=VliLkGKlUFWXjHYPHKhIoC9T8J/tXbQBlLhNPRFKpcSDmcYqAJwrSP1aEMERW9alSF
         +/C6VVdeBGrMAl6EuoauewV9NOcKnut05ZmeYuZQkmsrz6WSWGaB1xefKkXg/LWSUhtz
         54ZrfHpYG6uA/l01ZR+VOyiPyQIwl6EVfUCf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=D6/t64GWTSvYj3tg/pZ5Ic42OSmLCS9eM7+HxTJh7bY=;
        b=uKf3fWl3hHKdKNlldKRsde/ca8NvhcdC/olDuHVqhle9px7CRzvj971ob3x6Vkr+So
         AEDpT2sozgqhVLOnlFwf9Mf+ugI4RGVdrTAsaZMjK925Ewn35sEK7+WwTzBIQexlcMes
         BsW0zRUmVtQQLOQysTmiZqtAJETpSyLlJ32JUSvlI7iU1Yf7/+SDpjfBZd+1dudho/VT
         RN7H+cysDejkIG1d7SRysb6bHGgRWC1hNju8XVta4WwdZno/FJM60mhz8Ma2N53HlT6P
         N40dnr91NwKLJXmFZWkOF0wkMeD9Nvn5xm6N/OXbtLXuj+Mrm1IcSUiuIp81UV0QFXeT
         l6Mw==
X-Gm-Message-State: AOAM530yZBonzzIyd0Wd3YeacXmSYIFwkwFt3e+nuzcSYQ4cVT4vTYTM
        V/7UhH0/yVf5SytAIGcdc0lUwg==
X-Google-Smtp-Source: ABdhPJw2Qp+2mIKNhFX1I+6sZk2cFgPwhAQgZTyBkhIWBJDj29kcgwl2c2YRP52g3ltzroCn2P4Oag==
X-Received: by 2002:a17:902:6ac3:b029:e6:c6a3:a697 with SMTP id i3-20020a1709026ac3b02900e6c6a3a697mr2657330plt.2.1616462496621;
        Mon, 22 Mar 2021 18:21:36 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-ab57-754e-edac-e091.static.ipv6.internode.on.net. [2001:44b8:1113:6700:ab57:754e:edac:e091])
        by smtp.gmail.com with ESMTPSA id j188sm15051642pfd.64.2021.03.22.18.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 18:21:36 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Subject: Re: [PATCH v11 0/6] KASAN for powerpc64 radix
In-Reply-To: <5a3b5952-b31f-42bf-eaf4-ea24444f8df6@csgroup.eu>
References: <20210319144058.772525-1-dja@axtens.net> <5a3b5952-b31f-42bf-eaf4-ea24444f8df6@csgroup.eu>
Date:   Tue, 23 Mar 2021 12:21:32 +1100
Message-ID: <87ft0mbr6r.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> In the discussion we had long time ago, 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20190806233827.16454-5-dja@axtens.net/#2321067 
> , I challenged you on why it was not possible to implement things the same way as other 
> architectures, in extenso with an early mapping.
>
> Your first answer was that too many things were done in real mode at startup. After some discussion 
> you said that finally there was not that much things at startup but the issue was KVM.
>
> Now you say that instrumentation on KVM is fully disabled.
>
> So my question is, if KVM is not a problem anymore, why not go the standard way with an early shadow 
> ? Then you could also support inline instrumentation.

Fair enough, I've had some trouble both understanding the problem myself
and clearly articulating it. Let me try again.

We need translations on to access the shadow area.

We reach setup_64.c::early_setup() with translations off. At this point
we don't know what MMU we're running under, or our CPU features.

To determine our MMU and CPU features, early_setup() calls functions
(dt_cpu_ftrs_init, early_init_devtree) that call out to generic code
like of_scan_flat_dt. We need to do this before we turn on translations
because we can't set up the MMU until we know what MMU we have.

So this puts us in a bind:

 - We can't set up an early shadow until we have translations on, which
   requires that the MMU is set up.

 - We can't set up an MMU until we call out to generic code for FDT
   parsing.

So there will be calls to generic FDT parsing code that happen before the
early shadow is set up.

The setup code also prints a bunch of information about the platform
with printk() while translations are off, so it wouldn't even be enough
to disable instrumentation for bits of the generic DT code on ppc64.

Does that make sense? If you can figure out how to 'square the circle'
here I'm all ears.

Other notes:

 - There's a comment about printk() being 'safe' in early_setup(), that
   refers to having a valid PACA, it doesn't mean that it's safe in any
   other sense.

 - KVM does indeed also run stuff with translations off but we can catch
   all of that by disabling instrumentation on the real-mode handlers:
   it doesn't seem to leak out to generic code. So you are right that
   KVM is no longer an issue.

Kind regards,
Daniel


>
> Christophe

