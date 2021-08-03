Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138923DEE3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhHCMwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235635AbhHCMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627995154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1e0CmMEL83WqdLcdVYEsCcbtntf5BnVnii0Ea1ZAFFA=;
        b=CwlBDCkv81kyOWCw6dCW+xukC7oZlrE1EJwFjCUsTeh7RMosKGWs7IDV3Xm40g9QKeqpIv
        hrWl4SNTug52xZiCTHpXDtxRd/rsqsTT2AFrdB3Ty0K0meTlhvQiHkV37A3eobHYFuvJyh
        BTUbW81UqB+kM+ajd1AsMhznLng5ji0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-iFDlqXdHPzKR4kWkEEqHRg-1; Tue, 03 Aug 2021 08:52:30 -0400
X-MC-Unique: iFDlqXdHPzKR4kWkEEqHRg-1
Received: by mail-pj1-f70.google.com with SMTP id g12-20020a17090ace8cb029017797b2c0f8so9436150pju.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 05:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1e0CmMEL83WqdLcdVYEsCcbtntf5BnVnii0Ea1ZAFFA=;
        b=E0hOnK5ZmxFEYQX/1/YDQhpN6j2C9Ddz8LFHH8bKUUqgyLEXNcSe3JiZ5BczocUwYD
         7vmxch1h1kTgRPxUZc2qEojL7MiDUsbQhJQ4yldK4QI03we4KQVZ2u4K9vR0k4Z4bfmH
         SAzXRvvWn6r+2eLeAn+Cy6PXl3VtyIpE4pbYP8IEQAZEL/z0Hq2dE7Ul11QXjJB18FN9
         UWpb2R7HzGMV2vKNcxSFZd+cZkgq8zkGrr8BdgWXtt+gnm4PQPGYqmcxUrf7GgvE8rzi
         Igf1gYEY7yKZA2kSBdoVruXe8ZgofCSmxGa7LPi1B+aX9Bhq7qA1e7iPrVyAy+nmhd3P
         UyLQ==
X-Gm-Message-State: AOAM530Kd+fhWmni/lbX1RhI+OO/0mMbGLic/CqQgkUz995/JLbAFSVW
        Q40r8oCUJs5Zpk+pTW8tLTAiIfBRWcVmTTJWVa2px/EaMK7EeErAzB+O3Q+3dJQX5+eMnih4OFT
        aKz4t/YIjgIAJ5vI2prJVgODGBrEG0TNUq8X9JXTw
X-Received: by 2002:a62:b615:0:b029:34a:3920:a7ea with SMTP id j21-20020a62b6150000b029034a3920a7eamr22355465pff.21.1627995149487;
        Tue, 03 Aug 2021 05:52:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4ikkr08NYYktnHUlEdmpFVB7A+oX79XPR1VnPIsMyaCkS1EbwHZ+ZyqfBBTwjkVz3XU8wsDGoYgkiCgoB/Tg=
X-Received: by 2002:a62:b615:0:b029:34a:3920:a7ea with SMTP id
 j21-20020a62b6150000b029034a3920a7eamr22355435pff.21.1627995149184; Tue, 03
 Aug 2021 05:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210730043217.953384-1-aik@ozlabs.ru> <YQklgq4NkL4UToVY@kroah.com>
In-Reply-To: <YQklgq4NkL4UToVY@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 3 Aug 2021 14:52:17 +0200
Message-ID: <CABgObfb+M9Qeow1EZy+eQwM1jwoZY3zdPJfZW+Q+MoWmkaqcFw@mail.gmail.com>
Subject: Re: [RFC PATCH kernel] KVM: Stop leaking memory in debugfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 1:16 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Jul 30, 2021 at 02:32:17PM +1000, Alexey Kardashevskiy wrote:
> >       snprintf(dir_name, sizeof(dir_name), "%d-%d", task_pid_nr(current), fd);
> >       kvm->debugfs_dentry = debugfs_create_dir(dir_name, kvm_debugfs_dir);
> > +     if (IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
> > +             pr_err("Failed to create %s\n", dir_name);
> > +             return 0;
> > +     }
>
> It should not matter if you fail a debugfs call at all.
>
> If there is a larger race at work here, please fix that root cause, do
> not paper over it by attempting to have debugfs catch the issue for you.

I don't think it's a race, it's really just a bug that is intrinsic in how
the debugfs files are named.  You can just do something like this:

#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/ioctl.h>
#include <linux/kvm.h>
#include <stdlib.h>
int main() {
        int kvmfd = open("/dev/kvm", O_RDONLY);
        int fd = ioctl(kvmfd, KVM_CREATE_VM, 0);
        if (fork() == 0) {
                printf("before: %d\n", fd);
                sleep(2);
        } else {
                close(fd);
                sleep(1);
                int fd = ioctl(kvmfd, KVM_CREATE_VM, 0);
                printf("after: %d\n", fd);
                wait(NULL);
        }
}

So Alexey's patch is okay and I've queued it, though with pr_warn_ratelimited
instead of pr_err.

Paolo

