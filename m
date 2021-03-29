Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2D434C1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhC2CIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhC2CHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:07:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3774C061762
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 19:07:49 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso10862905otq.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 19:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=33BUB9NPkhecwhiP+JMlpJbR0y9CgZ2Jmpq0oPOxIQk=;
        b=t5ekW7ea1m1zelWsFej4WsSte5tR40UOSY6GqCEnbLqjkvKS5p3sZ+fspzJPEfLw63
         GHUvvwWVguMVf1YetY7O6/yUsNOYz5nHm//deRMFDbuC1Cq+QOxFfY8zQNBWQiNgIjiH
         BuSs2joLe9CQsfUWbCLJlpeQs7qa+z/Ee9hCaweIu0I/CdbbrpdukcJkhNw9oRwHqUfD
         hV9E2t81cRfBcd0dhaAcziz24vMxG3ykp85aSMqmyCeOzmSCZOPnb0o1Paa5YzxM5O0b
         HhJNvzatpGdBDSzm3+AxVNunN/z2Dzl1f/qY7ZIbCv9HOAP/Pwq6d7DEgZ1LYkJBHdZ2
         1kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=33BUB9NPkhecwhiP+JMlpJbR0y9CgZ2Jmpq0oPOxIQk=;
        b=ewdAYy2PIobYO2XaxCe5FGjeutCZENDo54nfJwcPLUGa5bwOt7XpWut+xGdXP3c6kx
         hNXNF0J28yRIfecdQKk/niQxcrr1UUfmGvX+0ZeEk93qyEh8SqjHDW4bTDV/cD9dl191
         MFNyn0DcunnxF+pjBmV1gllEO0Ga7a2VGppnf17TgcPbWegGQF29ksF1k7ztLo18cfMI
         zPCkv4m/Jsdln2FsCCPy2jDeW2ClMVe5PrvgVEC+52tf9gjNn6BZjI+SsDhR11k3Ophw
         KkO4cJVZcTUwqpdKJ6aqBABEt5EcDSbhdriYsy7bmZxI1hcOSkYSpHJPlTnMxLDMBKga
         zuoQ==
X-Gm-Message-State: AOAM531/cOvGDHdlC2hDs5/1M2vO0R/XJNGCQPswAlUb8HoUV/cEfdkC
        W+SLc7t0SneYnwZ7D2mqCkaviUho+ps=
X-Google-Smtp-Source: ABdhPJynqhS1hSQVjVS0E2kwAS/y30NKm44zTPnN7oCrWGscRQOGLlHhdrfeF16OtQ1pxcRy5dIhbA==
X-Received: by 2002:a9d:591:: with SMTP id 17mr20267864otd.115.1616983669134;
        Sun, 28 Mar 2021 19:07:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13sm4038734otk.61.2021.03.28.19.07.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Mar 2021 19:07:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 28 Mar 2021 19:07:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.12-rc5
Message-ID: <20210329020746.GA250550@roeck-us.net>
References: <CAHk-=wg89U6PLp1AGhaqUx4KAZtkvKS6kuNmb+zObQhf1jez+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg89U6PLp1AGhaqUx4KAZtkvKS6kuNmb+zObQhf1jez+g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 04:05:54PM -0700, Linus Torvalds wrote:
> So if rc4 was perhaps a bit smaller than average, it looks like rc5 is
> a bigger than average.  We're not breaking any records, but it
> certainly isn't tiny, and the rc's aren't shrinking.
> 
> I'm not overly worried yet, but let's just say that the trend had
> better not continue, or I'll start feeling like we will need to make
> this one of those releases that need an rc8.
> 
> Most of the changes are drivers (gpu and networking stand out, but
> there's various other smaller driver updates elsewhere too) with core
> networking (including bpf) fixes being another noticeable subsystem.
> 
> Other than that, there's a smattering of noise all over: minor arch
> fixes, some filesystem fixes (btrfs, cifs, squashfs), selinux, perf
> tools, documentation.
> 
> io_uring continues to have noise in it, this time mainly due to some
> signal handling fixes. That removed a fair amount of problematic
> special casing, but the timing certainly isn't great.
> 
> So again, nothing really scary, just rather more than I would have
> liked to have in an rc5.
> 
> Shortlog appended for people who want to delve into the details,
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 458 pass: 457 fail: 1
Failed tests:
	openrisc:or1ksim_defconfig

This is not really a new problem. I enabled devicetree unit tests
in the openrisc kernel and was rewarded with a crash.
https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
has all the glorious details.

Guenter
