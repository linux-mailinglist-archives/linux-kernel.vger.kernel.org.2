Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D843D78AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhG0Om7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhG0Om6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:42:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AkaBNPYXPSH5QJ9u4d74khubMTmlV7qCcVkpVnXkH6c=; b=B7Hl2VPksWfIo72jKQsjVRfnNf
        o7Y9idx/haNq4838PpWgvohXJVAmCOhjTF9To668mPk4Jc9kNdGvSQo4rWuEDngn96bapceYxJIdn
        F7JOClN8imgyLebuR6apGwD7e/WTbL+C9jeSMWRhbQqSslH5xkeRa6pD7r8X2WOGuxdgboTK8riiT
        K1J+0Jns4lYcq2A7L8wvohBzjqbj3JEHwg9IvybN5juVC8nf+pAdOblSCLo2i2QZSfLs8hm4TV0Is
        AgbgT4//szySyi6ghQIMAnPIeKflxHrBJ/x+4u8mHe4nfbO6+a4XLBV16GqiJ38MRGrqbQP0e7n5i
        uiM+0F8A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8OIA-00F4rK-CM; Tue, 27 Jul 2021 14:42:46 +0000
Date:   Tue, 27 Jul 2021 07:42:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        torvalds@linux-foundation.org, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
Message-ID: <YQAbZhCwLS7vb/ag@bombadil.infradead.org>
References: <87sg04p315.fsf@oc8242746057.ibm.com>
 <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
 <CA+QYu4pDGHj--z6yUrkhFs7oW-LUrY23i+-vKJwLPWaCO=z4vA@mail.gmail.com>
 <YQAQFMDMk09wS6Qv@bombadil.infradead.org>
 <CA+QYu4qSw_W=hdOARxjfisRjx4Lpy-MSe1ZovfUtVb2GGMynkg@mail.gmail.com>
 <YQAWc/6I6MnOGZn1@bombadil.infradead.org>
 <CA+QYu4ofYOqcuCYohFnYYO+XhAjKfpyGQ4KJr5vE4Fo=whv7UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4ofYOqcuCYohFnYYO+XhAjKfpyGQ4KJr5vE4Fo=whv7UA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 04:27:08PM +0200, Bruno Goncalves wrote:
> On Tue, Jul 27, 2021 at 4:21 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Jul 27, 2021 at 04:12:54PM +0200, Bruno Goncalves wrote:
> > > On Tue, Jul 27, 2021 at 3:55 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > >
> > > > On Tue, Jul 27, 2021 at 09:31:54AM +0200, Bruno Goncalves wrote:
> > > > > On Mon, Jul 26, 2021 at 1:46 PM Rasmus Villemoes
> > > > > <linux@rasmusvillemoes.dk> wrote:
> > > > > >
> > > > > > On 24/07/2021 09.46, Alexander Egorenkov wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
> > > > > > > started seeing the following problem on s390 arch regularly:
> > > > > > >
> > > > > > > [    5.039734] wait_for_initramfs() called before rootfs_initcalls
> > > >
> > > > So some context here, which might help.
> > > >
> > > > The initramfs_cookie is initialized until a a rootfs_initcall() is
> > > > called, in this case populate_rootfs(). The code is small, so might
> > > > as well include it:
> > > >
> > > > static int __init populate_rootfs(void)
> > > > {
> > > >         initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
> > > >                                                  &initramfs_domain);
> > > >         if (!initramfs_async)
> > > >                 wait_for_initramfs();
> > > >         return 0;
> > > > }
> > > > rootfs_initcall(populate_rootfs);
> > > >
> > > > The warning you see comes from a situation where a wait_for_initramfs()
> > > > gets called but we haven't yet initialized initramfs_cookie.  There are
> > > > only a few calls for wait_for_initramfs() in the kernel, and the only
> > > > thing I can think of is that somehow s390 may rely on a usermode helper
> > > > early on, but not every time.
> > > >
> > > > What umh calls does s390 issue?
> > > >
> > > > > Unfortunately, we haven't been able to find the root cause, but since
> > > > > June 23rd we haven't hit this panic...
> > > > >
> > > > > Btw, this panic we were hitting only when testing kernels from "scsi"
> > > > > and "block" trees.
> > > >
> > > > Do you use drdb maybe?
> > >
> > > No, the machines we were able to reproduce the problem don't have drdb.
> >
> > Are there *any* umh calls early on boot on the s390 systems? If so
> > chances are that is the droid you are looking for.
> 
> Sorry Luis,
> 
> I was just replying the question mentioning an old thread
> (https://lore.kernel.org/lkml/CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com/T/#u)
> on ppc64le.
> 
> regarding the "umh" it doesn't show anything on ppc64le boot.

There is not a single pr_*() call on kernel/umh.c, and so unless the
respective ppc64le / s390 umh callers have a print, we won't know if you
really did use a print.

Can you reproduce the failure? How often?

  Luis
