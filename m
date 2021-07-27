Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84433D7865
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhG0OVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhG0OVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:21:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4496C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M+1pUZ7/JJRpCjFD0DN9T56bLm3RmYyIffaupbbBaiY=; b=zcNAGLwWwm7ZCXejiYieC2szZm
        /hB4uXHC2/SKYhRgsWGs/J5EWY/HJGn1ASGy2sOM4Rul+0fMyCSnQtkaKC8/Qxn9pZlTekTZeKuBV
        V6D7J46lhUXTfKKwzRXh6pmx7jw4VPApd74sw/edxvgw9hMov3PPE+WZaP7XKohC0pT25WrIJBvhs
        1ChfFrjygCEy8P23f4BHi0NgUCLxvNX0FDK65jqJUOlvZAu4xYq6JssFQFVYyK0Zlm1IUll3pFAw2
        GybCAzJnhOCXsrtpWKMB+riBOpDcJ6r8mwItNS4M7/qfUI+UBG68+yQl/9PKl856f5yvz+lvWGvSm
        3vHyqECg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Nxj-00F3r5-HR; Tue, 27 Jul 2021 14:21:39 +0000
Date:   Tue, 27 Jul 2021 07:21:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        torvalds@linux-foundation.org, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
Message-ID: <YQAWc/6I6MnOGZn1@bombadil.infradead.org>
References: <87sg04p315.fsf@oc8242746057.ibm.com>
 <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
 <CA+QYu4pDGHj--z6yUrkhFs7oW-LUrY23i+-vKJwLPWaCO=z4vA@mail.gmail.com>
 <YQAQFMDMk09wS6Qv@bombadil.infradead.org>
 <CA+QYu4qSw_W=hdOARxjfisRjx4Lpy-MSe1ZovfUtVb2GGMynkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4qSw_W=hdOARxjfisRjx4Lpy-MSe1ZovfUtVb2GGMynkg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 04:12:54PM +0200, Bruno Goncalves wrote:
> On Tue, Jul 27, 2021 at 3:55 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Jul 27, 2021 at 09:31:54AM +0200, Bruno Goncalves wrote:
> > > On Mon, Jul 26, 2021 at 1:46 PM Rasmus Villemoes
> > > <linux@rasmusvillemoes.dk> wrote:
> > > >
> > > > On 24/07/2021 09.46, Alexander Egorenkov wrote:
> > > > > Hello,
> > > > >
> > > > > since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
> > > > > started seeing the following problem on s390 arch regularly:
> > > > >
> > > > > [    5.039734] wait_for_initramfs() called before rootfs_initcalls
> >
> > So some context here, which might help.
> >
> > The initramfs_cookie is initialized until a a rootfs_initcall() is
> > called, in this case populate_rootfs(). The code is small, so might
> > as well include it:
> >
> > static int __init populate_rootfs(void)
> > {
> >         initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
> >                                                  &initramfs_domain);
> >         if (!initramfs_async)
> >                 wait_for_initramfs();
> >         return 0;
> > }
> > rootfs_initcall(populate_rootfs);
> >
> > The warning you see comes from a situation where a wait_for_initramfs()
> > gets called but we haven't yet initialized initramfs_cookie.  There are
> > only a few calls for wait_for_initramfs() in the kernel, and the only
> > thing I can think of is that somehow s390 may rely on a usermode helper
> > early on, but not every time.
> >
> > What umh calls does s390 issue?
> >
> > > Unfortunately, we haven't been able to find the root cause, but since
> > > June 23rd we haven't hit this panic...
> > >
> > > Btw, this panic we were hitting only when testing kernels from "scsi"
> > > and "block" trees.
> >
> > Do you use drdb maybe?
> 
> No, the machines we were able to reproduce the problem don't have drdb.

Are there *any* umh calls early on boot on the s390 systems? If so
chances are that is the droid you are looking for.

  Luis
