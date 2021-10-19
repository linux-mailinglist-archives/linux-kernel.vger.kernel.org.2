Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB77F432D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhJSF04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhJSF0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:26:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70456C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:24:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so1283689pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhzvNbl+T3QTbO3uejMZ4jzkOn0FTL1ZbgvVKqR+RXU=;
        b=D4f3bxGd1Kfff9zfGhu+4xHEaRC2IEcu1hn71M2FfG9InRqOV5g72twM5oYlmDKUny
         QctIzfXkpD4lt4BZ77nkKde4qp+3m9S6eYdrzPDVoZxgZ8/mIZtsUBIL02X09CQc1Eq7
         /VZYe+1G/1P2nUaiPEhgslwXUPSG/71/6UCuatmBuP9FNd/0CCfKvtGl8j9h49OAt/KY
         /hVCBW3UFSuHbwd5M7r78AsBY4U/ViW3Z/1dG/a2waGmhwZTopXzMILNGCaEwnPJIK0I
         lPcVHiJEWpedu/jw3kifBeToHLlYpL4ZKcTjdHpNmJ/NOnKrfRnD3gD8mud3LsJpwaT+
         hVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhzvNbl+T3QTbO3uejMZ4jzkOn0FTL1ZbgvVKqR+RXU=;
        b=xW1e96yz1rn4rqAvW+VCh2agINB5fPicpqzPrD1SohKjEPXTRcj1J5i/N2kNZewVVJ
         6WoH/kyT7LCcuE9hVLW4bBslOnEwscrLa8j/zQtlu7urDX1KXW+f+vst52geI0aOFy4V
         +v9Z61Z24e66eehuksCbRqOnGSzBTLpL6+9Y6AvEZaCqLaQsuO1gxm7PVh/4x4ilncDk
         rbK0jhB4kfaWKyTZ32agbpGK8s8gfBaDdxHdaKmpRuiwIlfYh+gYKt9iAKZ//4I7eMeh
         sDz+5tjH30nZlXWX+gYylMFJvJtiCBn7X0rOFmPi+qIIOhUsAm+T2RNJ1ZH/6h8rW9X9
         dkFQ==
X-Gm-Message-State: AOAM532rLhorQCW1tJOG/aZyIxWzWG29cAWRcr7DsbQa1cTJiAQD5zdR
        qxwraQKunqLlaK6/Q0T0tfAkVgJXJuY/6gis5rw340x7T8OWRcYF
X-Google-Smtp-Source: ABdhPJyGzvVDlkHjPqOuS0tuuNdONYYwsxXy/HKfq0DdWGoYb+vRvomlvsOBrvym5NPfvTK16egacyz1LbJT+++FGMo=
X-Received: by 2002:a17:90a:1507:: with SMTP id l7mr4049449pja.141.1634621079667;
 Mon, 18 Oct 2021 22:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211018090247.3779368-1-tzungbi@google.com> <CABXOdTfs4BPcx=A=Np--zVymJZ5g6S2P=Q5JE2T63zpJKUgJJA@mail.gmail.com>
In-Reply-To: <CABXOdTfs4BPcx=A=Np--zVymJZ5g6S2P=Q5JE2T63zpJKUgJJA@mail.gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 19 Oct 2021 13:24:28 +0800
Message-ID: <CA+Px+wXrTjHVXYHENX0t2F0RHP-cLane9YLyMKRDNnkrki8BUw@mail.gmail.com>
Subject: Re: [RESEND PATCH] platform/chrome: cros_ec_debugfs: detach log
 reader wq from devm
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 4:59 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Oct 18, 2021 at 2:03 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> > Debugfs console_log uses devm memory (see struct cros_ec_debugfs in
> > cros_ec_console_log fops).  However, lifecycles of device and debugfs
> > are independent.  An use-after-free issue is observed if userland
> > program operates the debugfs after the memory has been freed.
> >
>
> It would help to see the backtrace. Without it, it is difficult to
> determine where the UAF is observed. Also, most if not all of the
> touched functions access struct cros_ec_debugfs all over the place,
> not only for the wait queue, so I am not sure if moving the wait queue
> out of the data structure is the correct fix. It might instead be
> necessary to disconnect memory allocations from the ec device.

A trimmed backtrace is in the commit message, but the more verbose one:
[  426.174308] Call trace:
[  426.174314]  dump_backtrace+0x0/0x3ec
[  426.174318]  show_stack+0x20/0x2c
[  426.174324]  dump_stack+0x11c/0x1ac
[  426.174329]  print_address_description+0x7c/0x510
[  426.174333]  kasan_report+0x134/0x174
[  426.174337]  __asan_report_load4_noabort+0x44/0x50
[  426.174341]  do_raw_spin_lock+0x214/0x308
[  426.174345]  _raw_spin_lock_irqsave+0x68/0xf0
[  426.174350]  remove_wait_queue+0x3c/0x10c
[  426.174355]  ep_unregister_pollwait+0x120/0x170
[  426.174358]  ep_remove+0x60/0x2a0
[  426.174362]  do_epoll_ctl+0x590/0x7f4

I guess only the wait queue in the struct cros_ec_debugfs has
deep-coupled to console_log debugfs.  There are 2 more file operation
scenarios appended after the "--".

> > An userland program example in Python code:
> > ... import select
> > ... p = select.epoll()
> > ... f = open('/sys/kernel/debug/cros_scp/console_log')
> > ... p.register(f, select.POLLIN)
> > ... p.poll(1)
> > [(4, 1)]                    # 4=fd, 1=select.POLLIN
> >
> > [ shutdown cros_scp at the point ]
> >
> > ... p.poll(1)
> > [(4, 16)]                   # 4=fd, 16=select.POLLHUP
> > ... p.unregister(f)
> >
> > An use-after-free issue raises here.  It called epoll_ctl with
> > EPOLL_CTL_DEL which in turn to use the workqueue in the devm (i.e.
> > log_wq).
> >
> > The calling stack:
> > do_raw_spin_lock
> > _raw_spin_lock_irqsave
> > remove_wait_queue
> > ep_unregister_pollwait
> > ep_remove
> > do_epoll_ctl

Here is the trimmed backtrace.

[...]
> > ---
> > As for 2 other cases:
> >
> > Case 1. userland program opens the debugfs after the device has been removed
> >
> > ENOENT.  cros_ec_debugfs_remove() calls debugfs_remove_recursive().
> >
> > Case 2. userland program is reading when the device is removing
> >
> > If the userland program is waiting in cros_ec_console_log_read(), the device
> > removal will wait for it.
> >
> > See the calling stack for the case:
> > wait_for_completion
> > __debugfs_file_removed
> > remove_one
> > simple_recursive_removal
> > debugfs_remove
> > cros_ec_debugfs_remove
> > platform_drv_remove
> > device_release_driver_internal
> > device_release_driver
> > bus_remove_device
> > device_del
> > platform_device_del
> > platform_device_unregister

Here are the 2 other cases.
