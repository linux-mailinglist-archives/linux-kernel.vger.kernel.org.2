Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FE5365B04
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhDTORe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhDTORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:17:32 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A268DC06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:17:00 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id z1so43135606ybf.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWa/Pvzykr9jxpXsZVGAYuoX86X+fgUShL4fzcLfV1k=;
        b=rxkxBUOfV9PeFmI8f4UzV30pWj7o2G5EMnBAUucaJYciyE3r2PYkSbB4wBLA76+mVw
         g/ytbkuqljIFseX4QssJ1DniLoUd5DVTWewWzhuXEu3KH4JyvwR+8QOZJShwy+Op+rRF
         33b13XgoxWeypl0NcwLVSWifS/KBfCHUDEFa0uanALE6thx5yf7TpXO3OQpaTt0x0Uiq
         uIqErfEyGBUSkzG9guSsD+MNbHBUJ9JBBO6dBtWoTAikQZBgJgrEkvaJrfzrhZw5kT86
         bOFQyWv59mj0zPN3UBU6rXQtRGuhOggK0zUYJcpSlDluoc9Y06vSGd3JMrDLjuRJKcgC
         ZOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWa/Pvzykr9jxpXsZVGAYuoX86X+fgUShL4fzcLfV1k=;
        b=j+ATLKVDBL22mu8icjerH7/klp9JdSrUH2PbU57QDilAIeWsR28uS2aGzm6mF5H6Cg
         NAo2B4tjrfL+rY1vaVe/tC0DL8tV0BiuCy382gjFIPZNpGctPovVvTaRRqsniP7S1IiH
         +e2AFihive5tZdDYf23SAs0N96OfluUsxNwF3yT3pXGpnHkE9fBfHnkLpgLcWnmPPPc9
         +ePKi/j0LK4+gX6mzZdVLIfIsm7uUJWKo2GgEwXbAy1H4GS2clsZJ7my/aGHnGQxvPRP
         +7lWXdNNURS/3IM7cueWg5NnBQZVsmr9NSzvLXCZbrhwzFiEzbrmQkmp+y6Tm/A21lU4
         6CbA==
X-Gm-Message-State: AOAM530OSUNi/mgYtSbQTplspuO/clgg/D7ztrDs0IxVXsAk8c6rCOL1
        luY2FgqnHzfbDuI97z2anF9IrPYeK5vPurfFc+DbQA==
X-Google-Smtp-Source: ABdhPJwcojOkAiBJUuT7EFTGaIOyskZb+NL+/fvTT6dzWoPHzaSCq09qM1Msn7okEt4IgVBpCc1Q9JnDUhsPdJVZJWU=
X-Received: by 2002:a25:4883:: with SMTP id v125mr23500327yba.253.1618928219291;
 Tue, 20 Apr 2021 07:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYskw4f8GDnn+YngdXihFGs5vP5EekDNqECY7XKTd9cbRg@mail.gmail.com>
In-Reply-To: <CA+G9fYskw4f8GDnn+YngdXihFGs5vP5EekDNqECY7XKTd9cbRg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 20 Apr 2021 16:16:48 +0200
Message-ID: <CANn89iKKXcuczM9XUbg3ntLUFMLdaJCO5ojNJ+UT4kaTVKuE+g@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in page_to_skb.isra.0+0x300/0x418
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
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

On Tue, Apr 20, 2021 at 3:45 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following kernel BUG reported on qemu-arm64 running linux next 20210420
> the config is enabled with KASAN.
>
> steps to reproduce:
> ----------------------------
> - Build the arm64 kernel with KASAN enabled.
> - boot it with below command and you will notice
>  /usr/bin/qemu-system-aarch64 -cpu host -machine virt,accel=kvm
> -nographic -net nic,model=virtio,macaddr=BA:DD:AD:CC:09:10 -net tap -m
> 1024 -monitor none -kernel kernel/Image.gz --append "console=ttyAMA0
> root=/dev/vda rw" -hda
> rootfs/rpb-console-image-lkft-juno-20210414125244-133.rootfs.ext4 -m
> 4096 -smp 4 -nographic
>
>
> crash log:
> -------------
>

This is the fifth report, have you tried the proposed fix ?

https://patchwork.kernel.org/project/netdevbpf/patch/20210420094341.3259328-1-eric.dumazet@gmail.com/
