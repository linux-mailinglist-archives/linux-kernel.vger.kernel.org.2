Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A298333C89E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 22:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhCOVku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 17:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhCOVkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:40:33 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA55FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:40:30 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t83so26016583oih.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nx8G1AcBrlEuSc1D0DFjZmdDS58DPXg/j7KwcDrAISo=;
        b=vBByiXJIED1VpkV6NN1+O1ZvIOsCG8+q5xJuZipiKe8XE6p4DZWTj+1uB7TFFqVSgF
         BjuTSAAQtp/r3gcILEW/MW6Fb0y4AkVNMF5Rb5WCME+DQIHTGLdSjunc0rJa7PDTY3JY
         lSkP1eIVE4i53y0TrocmEz3ZrP0cEp3iRdQtOs3q9n4Jardf/XnSUzVCco35X4m2gBDS
         oTxyS4u/v1FiII9DH1tse4Ttblu5PnikdEnkB1ENfKM8Zp4/cNLuqBEYArjSXtElXoeo
         PVbcs3VRNEwgi4IqphyhDLhc5um5ZsD4AWOumGst1hXo7K4sqvRC/yTXqYnTGZe5qKKE
         MgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nx8G1AcBrlEuSc1D0DFjZmdDS58DPXg/j7KwcDrAISo=;
        b=k6yYD4RO3lWZpGQumNyg4RLLHWcR0E9AK0N4Lm1kjTc9kMA9XrJHCPveUZj/V7eZeC
         j7YRYU91CuEzQlzVPlTiIkHx85js1Y3g7TUKwsuEUVb9I4go8pci7AdlAuQ+Vu6qDwVq
         wIg3FgGMu9nmX5WzyqapIzaGJ+zCVsydDoQXTT+yUR0/f+W5v9KOuKJVx72M5A6KN4ls
         C38LewRjsk4x8dmAvOIuOAqcbl6bICTZtIPDDjmdUl44TyYGDCjZb42TjWxmJjie7CMf
         jKEyNm4Rc1aF/TaVYkaFjWWLjjlKggvuExZqHnn0YbgwCvvlmOlMuhuuDRYv15U9PpXS
         NrqA==
X-Gm-Message-State: AOAM532FR6GioVleSl6ln4YuXL5uVvtpOunTcvTNgjZlklMJmT53o26G
        GBdxDy6ynNrCdJ+/7U+FLYtTblpji1I=
X-Google-Smtp-Source: ABdhPJx4sh+bfK4K+FSxrxZrngVoOW+Q+NSwbnKN6Bt46UeYsSbz5tZzTI2FuTLxias9GjrBoUYwXg==
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr917973oia.44.1615844430385;
        Mon, 15 Mar 2021 14:40:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v1sm7522718otk.67.2021.03.15.14.40.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Mar 2021 14:40:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Mar 2021 14:40:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.12-rc3
Message-ID: <20210315214028.GA231136@roeck-us.net>
References: <CAHk-=wgAr4Z2deEQs+5L6bJb68FouwBZUSURh+m-47TBnEsGZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgAr4Z2deEQs+5L6bJb68FouwBZUSURh+m-47TBnEsGZg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 03:00:21PM -0700, Linus Torvalds wrote:
> So rc3 is pretty big this time around, but that's entirely artificial,
> and due to how I released rc2 early. So I'm not going to read anything
> more into this, 5.12 still seems to actually be on the smaller side
> overall. Also, because of the rc1 debacle, there has been a bit more
> rebasing than usual, so the history of some of the commits sometimes
> looks more recent than it necessarily is.
> 
> Other than that, things look fairly normal - there's a big peak in the
> diffstat around the io_uring fallout from the new thread creation
> model, and sparc makes an unusual showing on the architecture updates
> side, but other than that it's all the usual things: drivers (gpu,
> net, usb, staging, sound... all over), architectures (x86, arm64,
> s390, powerpc in addition to the already-mentioned sparc), filesystems
> (cifs, nfs) and core kernel (networking, VM, timers, scheduler..).
> 
> And the (by now) quite usual documentation and tooling updates (mainly
> perf tooling and selftests).
> 
> And random other patches.
> 
> Full shortlog appended, although it is a bit larger than usual, so
> maybe not as easy to eyeball as I'd hope.
> 
> With this, we're obviously back to the usual "Sunday afternoon" rc
> schedule, and I think we should be all back to normal in general for
> this release.
> 
> Go beat on it,
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 436 pass: 436 fail: 0

Guenter
