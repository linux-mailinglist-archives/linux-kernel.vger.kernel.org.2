Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85C434E054
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 06:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhC3EtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 00:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhC3Es4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 00:48:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E96C061764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 21:48:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so22797055ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 21:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ra/Cywsf9MTC1TzREsEXMVfY44WVYc3NAp2y/G/b8Ls=;
        b=ZlHhRG9zITr7DP+trbH7erLGSg6+vgRwy/G760pYuqdoVGidk5zQvzSMGJWxADROIJ
         XSh210tE4NbhB06edSpok5yz3xUsVqBDm7mpIo1pDwB/8D0B84CS9IpEv7SeQBYuOhoj
         QvmQEcFQOth9hpSzDW5aBFZDWUGFA5YGmEoCBrEhFJpSoZ1K6og8Dyh8mq2+wKuFnVun
         a3bc1oQjOGYBMJ+6DvIC7sQr81k0LEVffYgIoJays92U4t42zhzJz0f2bQntH7x8lFwP
         LB7ngZkmsiOpTcqlHgy2hjsRCiHJ2UgaPGegRsYMt8iSyT+RKp5ZT9G59e/PjM62NykS
         NtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ra/Cywsf9MTC1TzREsEXMVfY44WVYc3NAp2y/G/b8Ls=;
        b=rfMN6qHHzWnP6iV/9eVraz1ZarSnzVm6SfS4nYmo8x6vw9V91zXQ8T0hXoDhfvRjsC
         fqymLd8OtNVBnNGbXF7wlVyYdB6m3zDmI6wm6VFAE9IIF7aSoqr2Dwi7oOWPckgjiZd4
         OzQxvScWYVbvwcaM5FE3qQOgjqWpTiO2dGeCL6lqm3twYn2HZKPrcaoZmgtcCO8hoTjO
         aiLsHbCLbRWD8e3aQJ2A/W6iOnVWIQffJmB5BkwZFGAyrE/mw0yCsmUaMn1GHobK45/5
         F7rX9yr2Dil1UWI5p5VMPARWGq9SPfArX2yg2Co7ltSH2BIkwBp7XZay3VQDQb109cH+
         GWdQ==
X-Gm-Message-State: AOAM530e3rQ5t5qgYNad5qCHnxaZ4PW9npv3hm8dC9QDc+1zduys2q9V
        i3a/nbNxUEUJV/AW7CSzOrfaT43vWQgpdyhhWNmv5w==
X-Google-Smtp-Source: ABdhPJzzA/YU3+84uy/mkcICjvHV4CCKL49dEwtLGRAj+Yr7WGwa3Wd+xkqambZLgT3hHxoZ+3eu20ESlnn54qaSnLg=
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr32325114eji.323.1617079735058;
 Mon, 29 Mar 2021 21:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161661971651.1721612.7457823773061754064.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210325171126.GD2356281@nvidia.com> <CAPcyv4hMHAK4=eGuvP5Bg_2YfQCLt5cd5ku0tUUNY3VCxkKmaQ@mail.gmail.com>
 <20210329224439.GI2356281@nvidia.com>
In-Reply-To: <20210329224439.GI2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Mar 2021 21:48:44 -0700
Message-ID: <CAPcyv4htAdJwAyGjeo+nxZNCOz5-zosCXxp2rwttxjfgxMK8uw@mail.gmail.com>
Subject: Re: [PATCH 2/4] cxl/mem: Fix cdev_device_add() error handling
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-cxl@vger.kernel.org, "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 3:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Mar 29, 2021 at 02:03:37PM -0700, Dan Williams wrote:
>
> > Ugh, exactly why I was motivated to attempt to preclude this with new
> > core infrastructure that attempted to fix this centrally [1]. Remove
> > the  possibility of "others" getting this wrong. However after my
> > initial idea bounced off Greg then I ended up shipping this bug in the
> > local rewrite. I think the debugfs api gets this right in terms of
> > centralizing the reference count management, and I want to see
> > something similar for common driver ioctl patterns.
>
> There is a lot of variety here, I'm not sure how much valuable common
> code there will be that could be lifted into the core.. srcu,
> refcount, rwsem, percpu_ref, etc are all common implementations with
> various properties.
>
> The easist implementation is to just block driver destruction with a
> refcount & completion pattern
>
> The hardest is to allow the underlying HW driver to be removed from
> the fops while the file remains open.
>
> Usually whatever scheme is used has to flow into some in-kernel API as
> well, so isolating it in cdev may no be entirely helpful.
>
> The easisted helper API would be to add an 'unregistration lock' to
> the struct device that blocks unregistration. A refcount & completion
> for instance. I've seen that open coded enough times.

I do agree there is too much variety to widely unify. At the same time
it is a common enough pattern for devices that allow removal before
final close, especially devices that support hot-removal disconnecting
is a better pattern than blocking unregisteration.

Just the small matter of time to see this through...
