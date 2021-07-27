Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDC23D7845
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbhG0ONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236860AbhG0ONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627395187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCIvxt012zZrKawWncDVulQUNMSy0P3fxqe99oFzfpg=;
        b=Phy6PbqD1ZG7gPKZJMWm1qiG1967joga1dnHuDjRsCc0wp/BfgOxuh/WCIOSTtrHeNdRW6
        WjFQaAL9DnOLu0/Sj/EnbQa4cqSrQgPIdO0NWQXOIjlDgaP7BxtJRia4iB7X86bD9eJdep
        fznTK9zAdMpp/zDJHj/VcoHzne2p6uY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-7J5tHVsfPqKvv4D9Ohqmcg-1; Tue, 27 Jul 2021 10:13:06 -0400
X-MC-Unique: 7J5tHVsfPqKvv4D9Ohqmcg-1
Received: by mail-oo1-f71.google.com with SMTP id s6-20020a4ab5460000b0290263980f2b45so8411279ooo.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCIvxt012zZrKawWncDVulQUNMSy0P3fxqe99oFzfpg=;
        b=sXQqd/5TqezeEN4mOkTwvQwEoaogZSIc6mMRHWXVroa5gXU7Jruvlg9XVMTb6AxxJX
         gh/Rs27PYHrZH7LhvOlO+DJPReM5KjizM7aIpw4BL6VOmOfgA54HtVl8wxSG6C+P3UxY
         XFt/X4RjPgbZcWs34Kjr8v214QxKeOV7XZJtbV/yLeHJKl9QNuln9hjjWmbVzVss5CXJ
         9S0ksnV7tq5l6O4EP6R3WUX0eGrksIKwB1cK6kDIKW+LuHJSLHKqCbGU6xJrQGGkTCYT
         7/D89frQTLex7u1L70nwKIbJA1/YyUwQvLUxgXi1V4Q1ncCPplaqRRJxXFxIs8Q4Rc2N
         QARQ==
X-Gm-Message-State: AOAM531hgvWMmHS+pz5b7M1TrDpwFXc1DzkPfQcz5APOBpS+mhRfanZc
        s2MzvSNipRa80pcleTNwOE28/WtJYM28rVU+9r8msOXKYv3rSgcSnfa3sSWV0QYeFIjgNh6+Mbx
        n6dDokL3/EYTZJaQ8dBFrORHBr6GRy3Xtr2bItaqk
X-Received: by 2002:a05:6830:40ae:: with SMTP id x46mr15350699ott.71.1627395185382;
        Tue, 27 Jul 2021 07:13:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEdxV4ON1Xt42mpntGNUGbbBqtrP8TtFobqrtuBJVlMJ9Z1nsmRcqvYhN7oQuhWba/QGez1EPMcqDhxDRAzzE=
X-Received: by 2002:a05:6830:40ae:: with SMTP id x46mr15350676ott.71.1627395185128;
 Tue, 27 Jul 2021 07:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <87sg04p315.fsf@oc8242746057.ibm.com> <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
 <CA+QYu4pDGHj--z6yUrkhFs7oW-LUrY23i+-vKJwLPWaCO=z4vA@mail.gmail.com> <YQAQFMDMk09wS6Qv@bombadil.infradead.org>
In-Reply-To: <YQAQFMDMk09wS6Qv@bombadil.infradead.org>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 27 Jul 2021 16:12:54 +0200
Message-ID: <CA+QYu4qSw_W=hdOARxjfisRjx4Lpy-MSe1ZovfUtVb2GGMynkg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        torvalds@linux-foundation.org, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 3:55 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jul 27, 2021 at 09:31:54AM +0200, Bruno Goncalves wrote:
> > On Mon, Jul 26, 2021 at 1:46 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> > >
> > > On 24/07/2021 09.46, Alexander Egorenkov wrote:
> > > > Hello,
> > > >
> > > > since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
> > > > started seeing the following problem on s390 arch regularly:
> > > >
> > > > [    5.039734] wait_for_initramfs() called before rootfs_initcalls
>
> So some context here, which might help.
>
> The initramfs_cookie is initialized until a a rootfs_initcall() is
> called, in this case populate_rootfs(). The code is small, so might
> as well include it:
>
> static int __init populate_rootfs(void)
> {
>         initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
>                                                  &initramfs_domain);
>         if (!initramfs_async)
>                 wait_for_initramfs();
>         return 0;
> }
> rootfs_initcall(populate_rootfs);
>
> The warning you see comes from a situation where a wait_for_initramfs()
> gets called but we haven't yet initialized initramfs_cookie.  There are
> only a few calls for wait_for_initramfs() in the kernel, and the only
> thing I can think of is that somehow s390 may rely on a usermode helper
> early on, but not every time.
>
> What umh calls does s390 issue?
>
> > Unfortunately, we haven't been able to find the root cause, but since
> > June 23rd we haven't hit this panic...
> >
> > Btw, this panic we were hitting only when testing kernels from "scsi"
> > and "block" trees.
>
> Do you use drdb maybe?

No, the machines we were able to reproduce the problem don't have drdb.

Bruno
>
>   Luis
>

