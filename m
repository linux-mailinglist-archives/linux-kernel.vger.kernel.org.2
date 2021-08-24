Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14D3F6747
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbhHXRcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbhHXR3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:29:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D6C06114B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:00:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id i28so38809623ljm.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dL9ba3yUu6lSJ0YhxN/X5vzaVX0fX38NNuDKyk4dZZI=;
        b=YZ4Ro47ELEDWuai57Dne3vrEso9qPxNoHIDO/4mRCB5MMRJWwZ2M3peJcvzynsOo5y
         Pqo3xyqBOUtVLE7GPn/c0Zmdrl71Re2BysX+3tnTueSeITJtmfqTf4nJVt6uys7Mab7m
         X4wADbNkN2ugEPhpsNnPSAA7HVwg+MA8y2eVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dL9ba3yUu6lSJ0YhxN/X5vzaVX0fX38NNuDKyk4dZZI=;
        b=X+S4eNSbBFZucTltZoj5ZQ8or18K0mdRV4d3fAnUC0fRhIiD1FNwxCCPO3D0yP8/Yw
         YnKtKzme0BciEqaACE6nhZOCBwjjGgLg2+KSADqf90moHkTOYzLI8ygryb7voxrQZASD
         YF+fhnzCLxVfV1twLUtyIq7IkY4FHu0Rhzi+IzDpNrFdxQjKPI+AZEo64TWwPEkszxQh
         J+FKVG9RdVTiKFWtIwlSyLFYxKz//yrejH43cPEV9SBoERsXBdOb++qR23779PtSBBXA
         Dlkb6Ao8Nkr/734AfufdgEv6XBc6zl4Y2/NlBYKKYO3iNNIpwlZby3eDUcZDCc6tT9kK
         HhBw==
X-Gm-Message-State: AOAM533q2gnq7zfzrA27M9gqyZAAFR0TOJJxRrxi0onJLM3aHpM3H2Wa
        9NKjdf+t8R/9qA07aqEaF3++x0ufUPEwFlPZ
X-Google-Smtp-Source: ABdhPJwWX4YrfJE5Hxf4n9W6uIaeZbwPFEhenfLjznSKdPbzkemZ+qwG3upexNKiDZuIQMbcccqSHw==
X-Received: by 2002:a2e:89d8:: with SMTP id c24mr32521503ljk.419.1629824451482;
        Tue, 24 Aug 2021 10:00:51 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id f24sm1805583lfh.241.2021.08.24.10.00.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:00:50 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y6so38850306lje.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:00:50 -0700 (PDT)
X-Received: by 2002:a2e:3004:: with SMTP id w4mr30290770ljw.465.1629824449585;
 Tue, 24 Aug 2021 10:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210824165607.709387-1-sashal@kernel.org> <20210824165607.709387-74-sashal@kernel.org>
In-Reply-To: <20210824165607.709387-74-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 10:00:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQhb689WEk__vLy-ET4rL69cjq39pGTmrKam=c_0LYGg@mail.gmail.com>
Message-ID: <CAHk-=wiQhb689WEk__vLy-ET4rL69cjq39pGTmrKam=c_0LYGg@mail.gmail.com>
Subject: Re: [PATCH 5.13 073/127] pipe: avoid unnecessary EPOLLET wakeups
 under normal loads
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 9:57 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> [ Upstream commit 3b844826b6c6affa80755254da322b017358a2f4 ]

This one has an odd performance regression report associated with it.

Honestly, I don't understand the performance regression, but that's
likely on me, not on the kernel test robot.

So I'd hold off on applying it for now. It *might* be some odd test
robot hiccup, but ..

          Linus
