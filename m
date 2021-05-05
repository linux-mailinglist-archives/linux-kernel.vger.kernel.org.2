Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E189374822
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhEESni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbhEESnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:43:35 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AC6C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 11:42:37 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p12so3813059ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtVgorg1zZS8VLz6ZkmKBwpxdrKeM7t+NX3g8df9hyo=;
        b=fi/t3BnthT3poNXreQ6uLoaV03s0lm1WWZczRRqTuTs3qxP9jJknjHU5ah47WMVazy
         MN9JWJuif6XkC1SfR6fZSi7FSYJLDZq9P3hTTF9ZtARuYc5NrhmjVxCzcdP5g8CpAXNN
         QhkKSS62haSnoPmNyChnQ6bDHRBGTumBek7TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtVgorg1zZS8VLz6ZkmKBwpxdrKeM7t+NX3g8df9hyo=;
        b=nD7Cor8xhwZEUNGOWlQN9jOX7+WYiLJ7e8b3G1+bYhFoBqDuHNPsafAS0ZWvt+OqqO
         hbU3QPg7t2uIOFcTCQ+VYkO4OMXEktYbO/CqfosWaAP3l1fZ5L2xfBWsnfQjvmO+S+KQ
         R09V22s1BcJ2mgsup+qlqAkOI/D9k3X8G7lNOLlWNH+g9v5UkbsrK/PAA+9sy+oQUsQd
         AaRjmKYVZyM5xpH/XSABFpptZeRh316HjLuBSPBufoDiytjfEYDwqESw/0suz/YzOair
         jtKWIsEBkPYyJh3AnvAmiV4l8IxI0ge4ySvo1T0DQ72AHHSxhjEzVajzK6ywkYb3xoNC
         cPrw==
X-Gm-Message-State: AOAM530KiwONiq9YeBDrnBxgYy2x2MKu/B+ROMHbc9PNykxE72+pMl1R
        +3R12DwCyGWSGj8icNXFPirUXCLY5wZg/39Jrbs=
X-Google-Smtp-Source: ABdhPJx4U0TJUDmIhaeUJWm/ZCdOsRPCUie9p1pzlLGwd76DYByByjM+gdUAtJ3rntRLY37Efjb2GQ==
X-Received: by 2002:a05:651c:106a:: with SMTP id y10mr182128ljm.470.1620240155854;
        Wed, 05 May 2021 11:42:35 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id u25sm7729ljo.60.2021.05.05.11.42.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:42:34 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id v5so3763283ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:42:33 -0700 (PDT)
X-Received: by 2002:a05:651c:3de:: with SMTP id f30mr161074ljp.251.1620240153569;
 Wed, 05 May 2021 11:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
 <20210429154807.hptls4vnmq2svuea@box> <20210429183836.GF8339@xz-x1>
 <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
 <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com> <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
In-Reply-To: <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 May 2021 11:42:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com>
Message-ID: <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com>
Subject: Re: Sealed memfd & no-fault mmap
To:     Simon Ser <contact@emersion.fr>
Cc:     Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 3:21 AM Simon Ser <contact@emersion.fr> wrote:
> >
> > Is there some very specific and targeted pattern for that "shared
> > mapping" case? For example, if it's always a shared anonymous mapping
> > with no filesystem backing, then that would possibly be a simpler case
> > than the "random arbitrary shared file descriptor".
>
> Yes. I don't know of any Wayland client using buffers with real
> filesystem backing. I think the main cases are:
>
> - shm_open(3) immediately followed by shm_unlink(3). On Linux, this is
>   implemented with /dev/shm which is a tmpfs.
> - Abusing /tmp or /run's tmpfs by creating a file there and unlinking
>   it immediately afterwards. Kind of similar to the first case.
> - memfd_create(2) on Linux.
>
> Is this enough to make it work on shared memory mappings? Is it
> important that the mapping is anonymous?

All of those should be anonymous in the sense that the backing store
is all the kernel's notion of anonymous pages, and there is no actual
file backing. The mappings may then be shared, of course.

So that does make Peter's idea to have some inode flag for "don't
SIGBUS on fault" be more reasonable, because there isn't some random
actual filesystem involved, only the core VM layer.

I'm not going to write the patch, though, but maybe you can convince
somebody else to try it..

            Linus
