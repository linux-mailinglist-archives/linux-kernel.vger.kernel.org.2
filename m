Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907453B5E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhF1NCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhF1NCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:02:12 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01699C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:59:47 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d19so21878160oic.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jtoR+dB4s4toiUlJR30gbikEjrU3dQvTd9Mbu6LSkCg=;
        b=II1Rc0H4xco8ao/KIg5FWdiCn9iRpJw8ptvKaRvYzjd4Dyfg08crCTYnYXpKvj4PcE
         Uv2qfCsuDIwzG6G6UtDbNIFj0sRvS1LhNSmHVdlqnTfX7qSJBH/OOtpPR87z/ztSb6Jh
         uIwsbzPdrhZsLchZRSS546bD/dpU/kic1dFrte4lQbfHUBgej2MymsPDn4zwFTR04vBj
         BSwtIWl/zw+R01rToGAuYRusqazr5sfbItYHXQb4ONvwau8hJPcy1h3tdaLj8YIv4CUB
         P3QnEFhEUXWg52UHacp7ylm02aTW8wOzgFOPFTsO7qyHHGR2EdVFk4izgd2/oKhi1q7K
         +7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jtoR+dB4s4toiUlJR30gbikEjrU3dQvTd9Mbu6LSkCg=;
        b=VYZWuexwGAdvnIm9aTQyn6gsb1Q/XeIorWrr61eyD3xfKO+skse916lmJpEc9s236D
         JPX6LFnCFz1ryDvxLJ04tEls5TpOPvXin6ugRsYvNekZ9d7CkD8YWE8y5dxzrkIjXJhO
         RpXejbvDeLoVngUyEdnCQie3o4YooJ+wPRvrUYxGhEUVIus4ncHIGfZkH9C4zgf+IsDV
         83kXV5t8cRvPC84f1FxKNF+jGRmjOef1zEInVP5iG+dVenZrkJIFZsKWN/T8Up1ib3tj
         gu/XpFGpSB4MtilywnzJFUtnKu8C0gnb9kvEuoKR3QcheEISKoBbmexkfkbks16t+xCo
         r+2A==
X-Gm-Message-State: AOAM532oObmYhIFdrqak2sR++lhVDMbV0CKRAD8BVitXkjyICqMptShx
        mVeb/MQyITYR+tuMAVpKDqWlu42fYxw=
X-Google-Smtp-Source: ABdhPJxw7EM/E+ozN6fScq8T4OE+RsuYqqx64+EVZCRFv71Tz/f17sAOWllGfZGB6JjX49vAeKeGdg==
X-Received: by 2002:aca:d413:: with SMTP id l19mr1151593oig.88.1624885186358;
        Mon, 28 Jun 2021 05:59:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w5sm3068194oiv.7.2021.06.28.05.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:59:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Jun 2021 05:59:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.13
Message-ID: <20210628125944.GA4085561@roeck-us.net>
References: <CAHk-=wj7E9iTGHbqfgtaTAM09WrVzwXjda2_D59MT8D_1=54Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7E9iTGHbqfgtaTAM09WrVzwXjda2_D59MT8D_1=54Rg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 03:45:50PM -0700, Linus Torvalds wrote:
> So we had quite the calm week since rc7, and I see no reason to delay
> 5.13. The shortlog for the week is tiny, with just 88 non-merge
> commits (and a few of those are just reverts).  It's a fairly random
> mix of fixes, and being so small I'd just suggest people scan the
> appended shortlog for what happened.
> 
> Of course, if the last week was small and calm, 5.13 overall is
> actually fairly large. In fact, it's one of the bigger 5.x releases,
> with over 16k commits (over 17k if you count merges), from over 2k
> developers. But it's a "big all over" kind of thing, not something
> particular that stands out as particularly unusual. Some of the extra
> size might just be because 5.12 had that extra rc week.
> 
> And with 5.13 out the door, that obviously means that the merge window
> for 5.14 will be starting tomorrow. I already have a few pull requests
> for it pending, but as usual, I'd ask people to give the final 5.13 at
> least a quick test before moving on to the exciting new pending
> stuff..
> 
Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 462 pass: 462 fail: 0

Guenter
