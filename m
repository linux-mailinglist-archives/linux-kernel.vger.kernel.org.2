Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677813D7873
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhG0O1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236623AbhG0O1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627396041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7LLZTnzaAUpGwYvllLAtSsIBznpCd8N+Y/dSyREjkME=;
        b=cNhYzwEicEdW+km+1HqHOzt7lZjF4lbQUeOwDPJs1pr2vFTODLN69jcdYWOuPy/kSieZGT
        ErPaALNuv4z9PkUZSliFZg3l633oo40gh3IGPocwIMY9Wo9UwUNHdw5b1TCeNGc7u6rrLk
        GodE2UHAV+lOhAVSehjlHMihHWzoixI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-GQF6-IP1MTKkniOeIvhhMQ-1; Tue, 27 Jul 2021 10:27:20 -0400
X-MC-Unique: GQF6-IP1MTKkniOeIvhhMQ-1
Received: by mail-oo1-f70.google.com with SMTP id e203-20020a4a55d40000b029025d87cea48fso8440747oob.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LLZTnzaAUpGwYvllLAtSsIBznpCd8N+Y/dSyREjkME=;
        b=LVE24oH9mKo/jW4M8RR4ueYLMXhf+Rgk3Pc9JaY468IPRL92uYFNR8JbtqU5iWChxp
         qiQFXE83rUr628CHbRT2oK0U8ldiPhSAMvXGx1mgdiksnZiEg2chAwm2zZeceGbIqh3l
         Cl2xZiCNENEo3ch864U+adsHksZ7c8QC6eIsG2xw+Sgt7lqNgYdBpruMpQN6EZfWws9g
         U3/T/GL/hJZ0Qv+oWL2pTmxq0IyX2U5LO4ekFdb8xg9caQfn2qOmXoaBCbpRXMMKC2ON
         jSNAU31tca5CHtu5DES4FElhpc9mAvOADbikIeRwdkRX3y1lX5W/vRumTZ4yVk91Gmu3
         0fPQ==
X-Gm-Message-State: AOAM532GeDqm1JZM7S5DT3fsNn5LvkWXlYRbJ7mtegC+/acm6bBnJ3+H
        Sk1F3po1cGvsnymuhr5inT1lYJjLW39JPUjQ4MKmZDYrjkZ6Ke279wbPNGwNHDQvX213W3EJz10
        ZUz72CfZ7jqadg4qfiR+spq2UcZmjxyk9dHDzN34h
X-Received: by 2002:aca:180c:: with SMTP id h12mr4617444oih.60.1627396039633;
        Tue, 27 Jul 2021 07:27:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZOfa3trSZ7dZFxAJyNWWIL4k7s9q8ZLJ5DYbYvnfqs7nFbTRgln/d9x8iD266VjxpWtIilbQA3TRjZsnX6ww=
X-Received: by 2002:aca:180c:: with SMTP id h12mr4617431oih.60.1627396039491;
 Tue, 27 Jul 2021 07:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <87sg04p315.fsf@oc8242746057.ibm.com> <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
 <CA+QYu4pDGHj--z6yUrkhFs7oW-LUrY23i+-vKJwLPWaCO=z4vA@mail.gmail.com>
 <YQAQFMDMk09wS6Qv@bombadil.infradead.org> <CA+QYu4qSw_W=hdOARxjfisRjx4Lpy-MSe1ZovfUtVb2GGMynkg@mail.gmail.com>
 <YQAWc/6I6MnOGZn1@bombadil.infradead.org>
In-Reply-To: <YQAWc/6I6MnOGZn1@bombadil.infradead.org>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 27 Jul 2021 16:27:08 +0200
Message-ID: <CA+QYu4ofYOqcuCYohFnYYO+XhAjKfpyGQ4KJr5vE4Fo=whv7UA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        torvalds@linux-foundation.org, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 4:21 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jul 27, 2021 at 04:12:54PM +0200, Bruno Goncalves wrote:
> > On Tue, Jul 27, 2021 at 3:55 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Tue, Jul 27, 2021 at 09:31:54AM +0200, Bruno Goncalves wrote:
> > > > On Mon, Jul 26, 2021 at 1:46 PM Rasmus Villemoes
> > > > <linux@rasmusvillemoes.dk> wrote:
> > > > >
> > > > > On 24/07/2021 09.46, Alexander Egorenkov wrote:
> > > > > > Hello,
> > > > > >
> > > > > > since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
> > > > > > started seeing the following problem on s390 arch regularly:
> > > > > >
> > > > > > [    5.039734] wait_for_initramfs() called before rootfs_initcalls
> > >
> > > So some context here, which might help.
> > >
> > > The initramfs_cookie is initialized until a a rootfs_initcall() is
> > > called, in this case populate_rootfs(). The code is small, so might
> > > as well include it:
> > >
> > > static int __init populate_rootfs(void)
> > > {
> > >         initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
> > >                                                  &initramfs_domain);
> > >         if (!initramfs_async)
> > >                 wait_for_initramfs();
> > >         return 0;
> > > }
> > > rootfs_initcall(populate_rootfs);
> > >
> > > The warning you see comes from a situation where a wait_for_initramfs()
> > > gets called but we haven't yet initialized initramfs_cookie.  There are
> > > only a few calls for wait_for_initramfs() in the kernel, and the only
> > > thing I can think of is that somehow s390 may rely on a usermode helper
> > > early on, but not every time.
> > >
> > > What umh calls does s390 issue?
> > >
> > > > Unfortunately, we haven't been able to find the root cause, but since
> > > > June 23rd we haven't hit this panic...
> > > >
> > > > Btw, this panic we were hitting only when testing kernels from "scsi"
> > > > and "block" trees.
> > >
> > > Do you use drdb maybe?
> >
> > No, the machines we were able to reproduce the problem don't have drdb.
>
> Are there *any* umh calls early on boot on the s390 systems? If so
> chances are that is the droid you are looking for.

Sorry Luis,

I was just replying the question mentioning an old thread
(https://lore.kernel.org/lkml/CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com/T/#u)
on ppc64le.

regarding the "umh" it doesn't show anything on ppc64le boot.

Bruno
>
>   Luis
>

