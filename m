Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5574F365EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhDTRdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhDTRcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:32:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E7AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:32:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g5so52781523ejx.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8gplG+9IWvQuoNRL+JXMPE+0PdJp+Z/VjGIXtau6h+I=;
        b=h11A4XqVQ5m+6C611s/dtODxxzHe4778dEl548tUa84MqdLN/1XV7WK1IMzUSSN9Od
         VnvgJdVbSHQ/ImL9hfmZeA/wPSbzQWrsgOeMqo4LrMFTgKVLQXo/kssnETIoiOSNqXF2
         +9CKxEzjfMwY19mG4Z7SY4V9KjsQEt4vbNotk2uwPu8nZYZW2of5Fu6ATNssl2Jl+ADN
         KprCeg0geSqGm1BuM/VAe8s2otgrvGsf50x9RNc8/FX5fX/n4m1wYTTYc3OgXUnis36k
         6JhVjFqzN1QdwciBjvJBIkgOj6l410ZvUVqd9RdJqPWewVChWgInz7coHNkFB8O18R2f
         UZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8gplG+9IWvQuoNRL+JXMPE+0PdJp+Z/VjGIXtau6h+I=;
        b=oCRM5auO/ncqsa2Pd9RpQWfuQsBj37QUwRYz72ge0MOWpnEZYs9ZIyoOaTTqgVITyC
         kB1vkRusZiNDFBLXSVG6JGCREPmgrHY2bN83l7TTHaIk6saMVoOyCg9VUM2sBtfdJneX
         0p8VjRA3Qt10khcFK3OAWoOjcQI5HC5r/Ed4ZhoQ3xPHggzQzkLqW0Mq6FVTsw0Dgxfh
         XPGfL63lSbdLbJdlQGXFjngaB1MPkDu0v/qMpY/gKjByCnCjEEO0O6PkDEOEaH9jsk+V
         YCvStds+okChrviKgiFh65/cG0UBB/O1mHUgS8Ewxml+2Lx2kbebKbQRRGeK+RPNdYBs
         tvcw==
X-Gm-Message-State: AOAM530Efrg11zi8f8eXZA4joz1j+542BKhtl7t5Q3hzqB6k9iNPIRUu
        RB7dNJnTRMsHwM1DiEdcipmujwf5fMDlAMAqc8sUjA==
X-Google-Smtp-Source: ABdhPJzOn7y5okWAFlw0xW1bqDHcjSKKZ3FzjRQhbt0MYpvhmlpKo3RbVc4qKURwgiYCMCk8hFP4aX57tXHPp1o0sM8=
X-Received: by 2002:a17:906:4e51:: with SMTP id g17mr14564426ejw.18.1618939941345;
 Tue, 20 Apr 2021 10:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYskw4f8GDnn+YngdXihFGs5vP5EekDNqECY7XKTd9cbRg@mail.gmail.com>
 <CANn89iKKXcuczM9XUbg3ntLUFMLdaJCO5ojNJ+UT4kaTVKuE+g@mail.gmail.com>
In-Reply-To: <CANn89iKKXcuczM9XUbg3ntLUFMLdaJCO5ojNJ+UT4kaTVKuE+g@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Apr 2021 23:02:10 +0530
Message-ID: <CA+G9fYusGV=Qn45EvHU34VS=dkUh0DUPZkCffm=25tz+4_f3Yw@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in page_to_skb.isra.0+0x300/0x418
To:     Eric Dumazet <edumazet@google.com>
Cc:     virtualization@lists.linux-foundation.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alan Bennett <alan.bennett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 at 19:47, Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Apr 20, 2021 at 3:45 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Following kernel BUG reported on qemu-arm64 running linux next 20210420
> > the config is enabled with KASAN.
> >
> > steps to reproduce:
> > ----------------------------
> > - Build the arm64 kernel with KASAN enabled.
> > - boot it with below command and you will notice
> >  /usr/bin/qemu-system-aarch64 -cpu host -machine virt,accel=kvm
> > -nographic -net nic,model=virtio,macaddr=BA:DD:AD:CC:09:10 -net tap -m
> > 1024 -monitor none -kernel kernel/Image.gz --append "console=ttyAMA0
> > root=/dev/vda rw" -hda
> > rootfs/rpb-console-image-lkft-juno-20210414125244-133.rootfs.ext4 -m
> > 4096 -smp 4 -nographic
> >
> >
> > crash log:
> > -------------
> >
>
> This is the fifth report, have you tried the proposed fix ?
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20210420094341.3259328-1-eric.dumazet@gmail.com/

I have tested your patch now and the reported issue got fixed.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Tested log link,
https://lkft.validation.linaro.org/scheduler/job/2555544#L208

- Naresh
