Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BBD44A708
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243302AbhKIGwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbhKIGwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:52:31 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E299C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 22:49:46 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v20so19177114plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 22:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CYQUrUcZzBOktjOhOc7ywBFO23bCaXu3jx+CJJnEwk=;
        b=B19OhJJy0VGivwYvFUuM+Q44BnrgO4mezKnX0wn5V3DrmRuTvd4+zwbT3Uy76ft+RN
         kADRoPnJDvdFBPgYgD8329wffk3q4ZAIAKqfH5FJaYPCvyVT9uzQViygUmYwMzbrzBvD
         M49I8gKXVMcFn0eGaC+dm6tkOBQXzfeElvT3+yjnLduXI76LSkeUwKdnTAH4wf/rG8Lq
         IkrUtCeKXMtbwx7PBUI2udUt0FGEjyjwk/5orT/eI4FPggLVKVccRny1deXGRQlFydSf
         ZmFud/old/iXxFF+EfpLTEJ0dYPvIfDAQheFlsOle5UWU0TfpIJVOvg01s8E3x7xSaOG
         6ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CYQUrUcZzBOktjOhOc7ywBFO23bCaXu3jx+CJJnEwk=;
        b=iMKk26lyXW1yBv67GCKap7HdUoS6K5KUlXDUaFUbGQb9/AOWsHJXBfMWk+/MUWTci1
         vR7AvrSGZkxDT704QDcd429Nr/izwWoF572nTBm6Prgj4tA4m5RWqpXJP6B8seUsZdtO
         bhUg57ZNRtole6HWakxfowja0QH2TclTIBme0vdQXW3WGlkRww2FUL11rmPm2YqnZbLH
         465hDyZ8/IL2QnkrL2fiCMbUNVqrZK8VqVKQ0N/+T10gKY6/Hrm2jF3+oCirs+gbFrnS
         fS53Y9J3nmfgnzBm8KVjSvJXbUhHXjplGVLj68RY2wZZ90VOiskZNqPE/cLveL0ouVhp
         NCEw==
X-Gm-Message-State: AOAM531ej+wWEwrPSEmxhmBTHQGp3WmgwHPjDWUP77DlK0LUHa1TElg4
        lOTxgaxM/aHrmRJy2Xvsi9o89PgyyehT8RiBt5NbOg==
X-Google-Smtp-Source: ABdhPJxtSaohFn8DeLvHIxKovWK6hMViWy42ecAhD5v3gKkOSpCKaSwCzcEGZyQ6CZyYtkWSYA7Yu7q+9fB1qSGt14k=
X-Received: by 2002:a17:90a:ca81:: with SMTP id y1mr4569160pjt.231.1636440585497;
 Mon, 08 Nov 2021 22:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20211101083629.101241-1-tzungbi@google.com>
In-Reply-To: <20211101083629.101241-1-tzungbi@google.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 9 Nov 2021 14:49:34 +0800
Message-ID: <CA+Px+wWWCY2mVoaH8T+vXpzunYxUzeuyQALV0UMhmO2_W5CPxQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_debugfs: detach log reader wq
 from devm
To:     bleung@chromium.org, groeck@chromium.org, bleung@google.com,
        groeck@google.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson and Guenter,

On Mon, Nov 1, 2021 at 4:36 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> Debugfs console_log uses devm memory (e.g. debug_info in
> cros_ec_console_log_poll()).  However, lifecycles of device and debugfs
> are independent.  An use-after-free issue is observed if userland
> program operates the debugfs after the memory has been freed.
>
> The call trace:
>  do_raw_spin_lock
>  _raw_spin_lock_irqsave
>  remove_wait_queue
>  ep_unregister_pollwait
>  ep_remove
>  do_epoll_ctl
>
> A Python example to reproduce the issue:
> ... import select
> ... p = select.epoll()
> ... f = open('/sys/kernel/debug/cros_scp/console_log')
> ... p.register(f, select.POLLIN)
> ... p.poll(1)
> [(4, 1)]                    # 4=fd, 1=select.POLLIN
>
> [ shutdown cros_scp at the point ]
>
> ... p.poll(1)
> [(4, 16)]                   # 4=fd, 16=select.POLLHUP
> ... p.unregister(f)
>
> An use-after-free issue raises here.  It called epoll_ctl with
> EPOLL_CTL_DEL which in turn to use the workqueue in the devm (i.e.
> log_wq).
>
> Detaches log reader's workqueue from devm to make sure it is persistent
> even if the device has been removed.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
> As for 2 other related cases I could image:
>
> Case 1. userland program opens the debugfs after the device has been removed
>
> ENOENT.  cros_ec_debugfs_remove() calls debugfs_remove_recursive().
>
> Case 2. userland program is reading when the device is removing
>
> If the userland program is waiting in cros_ec_console_log_read(), the device
> removal will wait for it.
>
> See the calling stack for the case:
>  wait_for_completion
>  __debugfs_file_removed
>  remove_one
>  simple_recursive_removal
>  debugfs_remove
>  cros_ec_debugfs_remove
>  platform_drv_remove
>  device_release_driver_internal
>  device_release_driver
>  bus_remove_device
>  device_del
>  platform_device_del
>  platform_device_unregister

Would you mind to share your thoughts on the patch?
