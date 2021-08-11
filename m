Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126333E95CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhHKQVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHKQVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:21:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382ACC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:20:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w1so6711838lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TP3ufg1FSgd52Z8zyecJ3z2FJfxxpEJLtGauUCReCG0=;
        b=EA116gbTFYV7o499N6EJRHWJpCb8E2cDR0KgG9vT5t8Ki0uDt41w7TZRef7nzLjAUy
         UxWG1a3ITXp/zwWJES+A2QmPSrpf6qK3SJgg3e2aC00nDoCc1sPpGjZf8HpjD4pZnot3
         ERmXXUn8oCwiDwA5toJaM50lGWo9uwncEZGX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TP3ufg1FSgd52Z8zyecJ3z2FJfxxpEJLtGauUCReCG0=;
        b=QwXnWixBeTmiv+DeM347gQNc4vdpcoMQgh31XkiP41Ts3inhyiNF2nqLfjplp/UpPj
         P4CPKOpAqUIimSrzagqLavwR56Y0Kis1Bwl7/KGFcabSyyBnESXe6HDJWd+Y1lVUGygQ
         WZm+Odn28I4LnIM/S5J/8DWlEvsXCJphaQzDi70il1ot7p2EEuerfCe9u09tDp3USsE0
         pEJBFWOkgFTnpeEL+jsJxbKWoOPGI/N4BCRUhk0A6Df6IclzD0VqWVO/k26hHdjMPk7y
         8KxwsrXVfUJojjMCgr191tHkRM9Nx9+sjvTIKg8WXRGvNd5TFabRzNTn/chgoQBAaaNv
         lklA==
X-Gm-Message-State: AOAM5326uazhCvApvAkN2PMl1koiLpVQVqkAYuF5i/KYfRVweOdcI8K1
        RW5IzTeQMjrEDsY7oDng2QID4Q3Ni2JK1zU9M0w=
X-Google-Smtp-Source: ABdhPJxgc5/4JFmCUWV70GI8+ubauuP2AejaHxq+XLMk4UJbeztV52TcNTzIqM2cHre4neMNHir5Sw==
X-Received: by 2002:a05:6512:3b0f:: with SMTP id f15mr27748809lfv.187.1628698838236;
        Wed, 11 Aug 2021 09:20:38 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u18sm739276lfo.280.2021.08.11.09.20.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 09:20:37 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id t9so6915454lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:20:37 -0700 (PDT)
X-Received: by 2002:a19:491b:: with SMTP id w27mr11814406lfa.421.1628698837270;
 Wed, 11 Aug 2021 09:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <YRPaodsBm3ambw8z@miu.piliscsaba.redhat.com> <c13de127-a7f0-c2c3-cb21-24fce2c90c11@redhat.com>
In-Reply-To: <c13de127-a7f0-c2c3-cb21-24fce2c90c11@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Aug 2021 06:20:21 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg6AAX-uXHZnh_Fy=3dMTQYm_j6PKT3m=7xu-FdJOCxng@mail.gmail.com>
Message-ID: <CAHk-=wg6AAX-uXHZnh_Fy=3dMTQYm_j6PKT3m=7xu-FdJOCxng@mail.gmail.com>
Subject: Re: mmap denywrite mess (Was: [GIT PULL] overlayfs fixes for 5.14-rc6)
To:     David Hildenbrand <david@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 4:45 AM David Hildenbrand <david@redhat.com> wrote:
>
> I proposed a while ago to get rid of VM_DENYWRITE completely:
>
> https://lkml.kernel.org/r/20210423131640.20080-1-david@redhat.com
>
> I haven't looked how much it still applies to current upstream, but
> maybe that might help cleaning up that code.

I like it.

I agree that we could - and probably should - just do it this way.

We don't expose MAP_DENYWRITE to user space any more - and the old
legacy library loading code certainly isn't worth it - and so
effectively the only way to set it is with execve().

And yes, it gets rid of all the silly games with the per-mapping flags.

               Linus
