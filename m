Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B2041A2FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbhI0WdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237839AbhI0WdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632781896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8uDCCFVi8WNzzV1qh+gVDfNhqWmM++aw0AxvKz46Bpw=;
        b=RnVJ3UyvcE3FTnWLc7WqswOwI6WN0U+IBXcuRkDHEfqPDHtfjkPDcLUYVmkYVFn74+TP0Y
        g/NFixnS6eGS9XxWFdalsqFA4D8yQe1Nm7ZvYVfhxiTKOQdi2Id6m9arROkoNSCb8ImMQd
        UIZOKUvZbjdTIvcgJG6pdomJn/+OPJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-zwWRKSraNVCZ7P2rCjPa3g-1; Mon, 27 Sep 2021 18:31:33 -0400
X-MC-Unique: zwWRKSraNVCZ7P2rCjPa3g-1
Received: by mail-wm1-f69.google.com with SMTP id j21-20020a05600c1c1500b0030ccce95837so481883wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8uDCCFVi8WNzzV1qh+gVDfNhqWmM++aw0AxvKz46Bpw=;
        b=Vuo+/cUWleVThj+YAf4b9KjOWXX+HysXZzuUrrgbES4KCC/cDOlaHdOxGNBdK5y3K9
         AD4cEjgGxYqTokhoOB7VRB7Ac/+GSa8xcaHF9V+n5zt2DK08/pkpatETcC7mkSOHDxAL
         FRqmOc9RBq8oFDy9kMuVNrangTHfwg2sTtG9RXzlr0oy9Pcz48i6rMMBeQctMxtUcFH1
         N6ubh4gi6pWPoDY7dgKmOh2JkN103eDvXfg7n4JNY69UwzlL2CMDkyMacMhDAKjP7QTC
         GMVtYRf04b/VLsDU4eFdxTXP+Baa4MyNnMTkxQlSJAPyj6ler89/BTAdnw9Er9AbfEnL
         xJxg==
X-Gm-Message-State: AOAM530douLuNNGoy7vMIqzcpD8/KlSq2+JFjM/FzqRiY5o470jOgDyn
        KHVSiRKUJWhpMIu0M8fSvp7rSnOMw1T2cKZcy1OOVXYCdzdLXf6fmXCYg0iZyO7NPmmgnh7WDTp
        NH3lEhMcPEpL/lFrD7zeuC1Xo
X-Received: by 2002:a05:600c:1c01:: with SMTP id j1mr1419704wms.1.1632781892023;
        Mon, 27 Sep 2021 15:31:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfSyhj78JUXtac1A3f8LrBeD8L5OeFaLuQwaUEgc+7sKWmBk/tbktT6UwAoT3zrRIIWB8dSg==
X-Received: by 2002:a05:600c:1c01:: with SMTP id j1mr1419688wms.1.1632781891791;
        Mon, 27 Sep 2021 15:31:31 -0700 (PDT)
Received: from redhat.com ([2.55.4.59])
        by smtp.gmail.com with ESMTPSA id d7sm17884225wrh.13.2021.09.27.15.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:31:31 -0700 (PDT)
Date:   Mon, 27 Sep 2021 18:31:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc3
Message-ID: <20210927182647-mutt-send-email-mst@kernel.org>
References: <CAHk-=wgoE8XBPVA6Mu4CygxX9TE0FgWaAsVUJOe8KQH-CzEcAA@mail.gmail.com>
 <20210927110548.GA771805@roeck-us.net>
 <CAHk-=wiuGKOBvgje56X-EdOp4mnoz4C2nM1ML6DqRFfsptai3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiuGKOBvgje56X-EdOp4mnoz4C2nM1ML6DqRFfsptai3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:55:52AM -0700, Linus Torvalds wrote:
> On Mon, Sep 27, 2021 at 4:05 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Sun, Sep 26, 2021 at 02:21:52PM -0700, Linus Torvalds wrote:
> > > So after a somewhat rocky merge window and second rc, things are now
> > > actually looking pretty normal for rc3. Knock wood.
> > >
> > > There are fixes all over, and the statistics look fairly regular, with
> > > drivers dominating as they should (since they are most of the tree).
> > > And outside of drivers, we have a fairly usual mix of changes -
> > > architecture fixes, networking, filesystems, and tooling (the latter
> > > being mostly kvm selftests).
> > >
> > > Shortlog appended, it's not too long and easy to scan through to get a
> > > flavor for the details if you happen to care.
> > >
> > > Please do give it a whirl,
> > >
> >
> > Build results:
> >         total: 153 pass: 152 fail: 1
> > Failed builds:
> >         mips:allmodconfig
> 
> Gaah. I assume this is the
> 
>    arch/mips/include/asm/sibyte/bcm1480_scd.h:261: error:
> "M_SPC_CFG_CLEAR" redefined
> 
> thing still.
> 
> It's been pending too long in the mips tree, I'll just take the patch
> directly and finally empty your queue of build failures.
> 
> > Qemu test results:
> >         total: 480 pass: 479 fail: 1
> > Failed tests:
> >         sparc64:sun4u:nodebug:smp:virtio-pci:net,i82559er:hd
> 
> And going back to your -rc1 email, I see
> 
>  "The qemu runtime failure bisects to commit 694a1116b405 ("virtio: Bind
>   virtio device to device-tree node"), and reverting that commit fixes the
>   problem.  With that patch applied, the virtio block device does not
>   instantiate on sparc64. This results in a crash since that is where the
>   test is trying to boot from"
> 
> That commit 694a1116b405 doesn't revert cleanly, but the conflict is
> trivial (we've removed a "return 0" since then).
> 
> I've added the guilty parties to the participants list, but if this
> test failure remains in rc4 I'll just do that revert at that point.

Just sent a pull with a fix for that.

> > Almost there ...
> 
> Almost.
> 
>                Linus

