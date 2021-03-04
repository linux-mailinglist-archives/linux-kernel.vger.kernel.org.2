Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9332DB8B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhCDVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhCDVGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:06:41 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB82C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 13:06:00 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 130so14762700qkh.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 13:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgdkSDcMMDWh1SRt3hQoa5/TwUrpy7W6CPuK58HsLUg=;
        b=E1DX7PZs5hFH2/Uww4LEeP0Z3hUElD/Z50FBpEidIfYNm73tdl4HxZ7ZgUGTCbOf8G
         Cae6dxwro3QySC0N3Md6i6iwtLazR3+zhoQ++LMM/8MEFu3SqIyOxjVC9yySHR6WnLop
         YUSxz1LtpVtp0V2gOIE68CUHxXaEP7xQv6mz/+ReaPio9y+JmYoroR+JG8aBzu6pMSdU
         Ybav276o3MN9TyPflzCLQboFY6S0hEtDC/CrSpLpJH5J6MkMBNrSR9wADMO3AesrMEHB
         Ofa+A99/jMNz7fLDNej/W+t3K36ZD4ADNbt4dpcDDDopRuvEOqnah44F0bmmLn9cQEmx
         AocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgdkSDcMMDWh1SRt3hQoa5/TwUrpy7W6CPuK58HsLUg=;
        b=K/Acare15tWzoDqC3RJOtRz55mjG7jcBKmaJXjRuNzDWIVpkNB73JFYGAq1BRgddEC
         Rzhn+bJ5O/fDoyb2ROjz+aNDzFQ5OYsI2pJmGFOtkKpEpEhCMzGs7FacQ+Vh3AzH2SHX
         jVhHOdiMUjmjUhl2x+3Nn+xDl+ig48ViHlHX2MqeRTGyyLvJWM/FLyktPWqbmHZfLesy
         v3ni5ymqejPsGk01XsCjSZUCMlc94700qccYWOsc6F/X8Rx56EZG3naF4RaCEahS6egS
         SGZ7+muaSxvOuEpm3Y3oKdopnX1rW3B2zFZcFuzrW+BqipGWQGEAmPGtP6UZD2P8zHXk
         x33Q==
X-Gm-Message-State: AOAM531b/tA81weGmEO2+x9Oqfaa/+VFNsqc0jxEg40xJFA7a79QdKsk
        ImsPPhHWnx5MW1TBNe5yleJ7nhIYANXLbpPfu86otw==
X-Google-Smtp-Source: ABdhPJzOwE+1Sg5OvskywxdoiGHdv7NJRbHDt9/fENzJUfNvdNmhW6cIta6mx85BXuIJsvrgTFTZ/pRK4X/+/EhYqMs=
X-Received: by 2002:a05:620a:1353:: with SMTP id c19mr6192822qkl.392.1614891959772;
 Thu, 04 Mar 2021 13:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20210304205256.2162309-1-elver@google.com>
In-Reply-To: <20210304205256.2162309-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 4 Mar 2021 22:05:48 +0100
Message-ID: <CAG_fn=XVAFjgkFCj8kc6Bz4rvBwCeE4HUcJPBTWQcNjrBLaT=g@mail.gmail.com>
Subject: Re: [PATCH mm] kfence, slab: fix cache_alloc_debugcheck_after() for
 bulk allocations
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 9:53 PM Marco Elver <elver@google.com> wrote:
>
> cache_alloc_debugcheck_after() performs checks on an object, including
> adjusting the returned pointer. None of this should apply to KFENCE
> objects. While for non-bulk allocations, the checks are skipped when we
> allocate via KFENCE, for bulk allocations cache_alloc_debugcheck_after()
> is called via cache_alloc_debugcheck_after_bulk().

@Andrew, is this code used by anyone?
As far as I understand, it cannot be enabled by any config option, so
nobody really tests it.
If it is still needed, shall we promote #if DEBUGs in slab.c to a
separate config option, or maybe this code can be safely removed?


Alex
