Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE539DAE9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhFGLQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhFGLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:16:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683C9C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 04:14:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y15so12809844pfl.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vwjre3Nx9lcRecu/sCNmfW6cdOf4/1XBy78rgnv3N58=;
        b=dJKs0tSXYz21mjLf2r6ZCQGfcth9EOOi7Zgro3A0+xi6jU+RTwp5dR0m2r5lV2nLkh
         hwDsk8SXPdmgZUbnTBq6PsKmVuRXUAMHl7UsgkYZrgQSaiHdB2qXiNbPQU+Oy86v8Lgy
         6WPZDR/hXfqDZOrcrzldhuDaanvM2Em5iSZCTiEZh0FcVAWZW06KlvxxXbJ8GsGiYup9
         aWtK1Ng8hy5X+5+u5npj017k+ldlKg+S/jgeZxBICoTMk2qfMmzzT7agTIwfnDB9vHjM
         MpzPW2Jw+uu/i9BlGm9Ew67bBJY+cwpuN5Xb7BuMaUZNnIpjgdyr6k26+9SkQZQC6utc
         9cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vwjre3Nx9lcRecu/sCNmfW6cdOf4/1XBy78rgnv3N58=;
        b=kD/NQufiYGNwKp1VqeUdUbvBaHQ8KLyJc3U+Xj5q2FKr5r+JxOcxO/F5ETDUMZ9xlH
         immx6DWLnTJnWj8sNzrMm0Aex1LxCG+gs+3m5xYXAi53B8jW2+IBybZw1Bcf0BESAnIL
         Cf+kK6ngDik+GJV7ebdUaJOQ3ap1j8lsITkTRazl3vC8HVjQUFHhYw5K98khVC/cuwMu
         fqyz4Dn73mNZQs4pZ0xWPfMp9wG7iUhDJCvYxaL5S+Pt5CuHGg8U0mdAN0KDq2YZ9j9A
         bczoHII4Dmcfg4xm06d5S89iRQR/9EoY9DBKsyYAKLeOJOkWFV2ORjpA6QeZltFfGU5n
         16uA==
X-Gm-Message-State: AOAM530msn05GcOTADKfivVo1VFAyiKtLZqp7fD2jWu6ONqpcgbwmq/C
        6ViMvg22rhRKUX8uwgWGAOnYyw==
X-Google-Smtp-Source: ABdhPJwjFUpttbtgrWv/2I6/RzLLimhb4EWubzaYS1RqaNe7dXSyFxKKJiO9ae01utbqixPySVZD2g==
X-Received: by 2002:a05:6a00:82:b029:2e9:c6db:e16d with SMTP id c2-20020a056a000082b02902e9c6dbe16dmr16150380pfj.78.1623064457954;
        Mon, 07 Jun 2021 04:14:17 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id i22sm8110693pfq.6.2021.06.07.04.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:14:17 -0700 (PDT)
Date:   Mon, 7 Jun 2021 16:44:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Kyle Meyer <kyle.meyer@hpe.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-acpi@vegr.kernel.org
Subject: Re: [PATCH] acpi-cpufreq: Skip initialization if a cpufreq driver
 exists
Message-ID: <20210607111415.ede2s5ay7255x5pm@vireshk-i7>
References: <20210521221906.199436-1-kyle.meyer@hpe.com>
 <CAJZ5v0iJUhUyucYEDHXKqXrsy6=3dGUz0uy1pDpx+kKOi_NB2w@mail.gmail.com>
 <CAOh2x==tXk2Lt_f14_azHNYG2mZzMb9-1b2YUVj=+i=-JLemdg@mail.gmail.com>
 <CAJZ5v0g-NMLa1UVYKpF2ehgk=6dJkKRonUY0AGw6HyRCDaQMmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g-NMLa1UVYKpF2ehgk=6dJkKRonUY0AGw6HyRCDaQMmw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-21, 13:02, Rafael J. Wysocki wrote:
> On Mon, Jun 7, 2021 at 9:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > I am not sure how this is supposed to work. If we return 0 from
> > acpi_cpufreq_init(),
> > then the driver will never be used, since it's acpi_cpufreq_init()
> > will never get
> > called again later.
> 
> Unless the module is unloaded and loaded again, that is.

Right.

> > cpufreq drivers don't follow the generic device/driver model where a driver gets
> > probed again if a device appears and so this is broken.
> 
> It is broken anyway as per the changelog of this patch.
> 
> On systems with several hundred logical CPUs this really can be troublesome.

Hmm, I agree.

> > Please revert this patch.
> 
> Well, you can argue that the problem at hand is outside the kernel and
> so it's not a kernel's business to address it.

Exactly, what we did here is add a band-aid to make a userspace tool
happy, the kernel was doing the right thing earlier.

> After all, systemd-udevd could learn to avoid attempting to load the
> module again if it fails with -EEXIST,

That is one way, right.

> but I'm not sure how different
> that really would be from what this patch does, in practice.

The very first difference is we won't be adding an incorrect hack in
the kernel to solve this userspace problem. Else in order to make
acpi-cpufreq driver work, after a user unloads intel-pstate, user
would be required to unload the acpi-cpufreq and load it again, which
will surely look confusing to the user. Why unload to load it again ?

Leaving a module inserted in an unusable state is not the right
solution to fix a problem IMHO.

-- 
viresh
