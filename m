Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48A8337B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhCKRzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:55:31 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:41422 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKRzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:55:22 -0500
Received: by mail-pf1-f170.google.com with SMTP id b23so50743pfo.8;
        Thu, 11 Mar 2021 09:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7tZ+HS6prF5aUrltkb4FNPwzywOBjXvCQfT/EqBA63A=;
        b=orvG6MEFdsG9rk8i3krP9s6aEzCWUO7i6Im08vUOI6sxbCI5AhEuATexRQXoD5wYdK
         ioYeLxLIcZyVXwgWPnqMTDpuspQwTbRIXw40bUFZL+DEJVex9v0LXL/iX+2aYA457m0Y
         xovR1SSjw9jzjCmS7ExOGAaOo9mzp4BbuF4rQ2Wu8MW/xk/l8mFMqGrpqpD6kR9QP4RC
         Y7r0xFfDDSvxmQfLcZCLXrWRjmOgBrT6HhOl3ic3eyxKK0SbhciYobjW1Bn14cR9MNbH
         xSpoDqlRjyka1n8f4XZ1jp7hSzMqtjbVa12El6FCo1H5ch56ftYI8Q7y9bW7OPrKPLaB
         n39w==
X-Gm-Message-State: AOAM5330R3fKJiYeXMDw0PeenGMDdHbbBaJ734zAJgoxPR6nKF4rVdna
        WQDKxnkUU2OZpegtuuGF3pr92rO67CssHQ==
X-Google-Smtp-Source: ABdhPJwL83azCPmYJtaPThACd9KaOQ6aUMLRVehcwqXg6/xywG5eRZlUEcGnG9aFnQQpHJo9tBt5OQ==
X-Received: by 2002:a05:6a00:1345:b029:1e3:d231:49cd with SMTP id k5-20020a056a001345b02901e3d23149cdmr8766983pfu.3.1615485321861;
        Thu, 11 Mar 2021 09:55:21 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 197sm2968008pgg.53.2021.03.11.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:55:20 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E53364024E; Thu, 11 Mar 2021 17:55:19 +0000 (UTC)
Date:   Thu, 11 Mar 2021 17:55:19 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 1/2] init/initramfs.c: allow asynchronous unpacking
Message-ID: <20210311175519.GV4332@42.do-not-panic.com>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
 <CAHk-=wiK_0RATa3AnRSODtSN2X5Cc0RfudLpr16aLhwxoU1yEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiK_0RATa3AnRSODtSN2X5Cc0RfudLpr16aLhwxoU1yEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 02:07:36PM -0800, Linus Torvalds wrote:
> On Tue, Mar 9, 2021 at 1:17 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > So add an initramfs_async= kernel parameter, allowing the main init
> > process to proceed to handling device_initcall()s without waiting for
> > populate_rootfs() to finish.
> 
> I like this smaller second version of the patch, but am wondering why
> we even need the parameter.
> 
> It sounds mostly like a "maybe I didn't think of all cases" thing -
> and one that will mean that this code will not see a lot of actual
> test coverage..
> 
> And because of the lack of test coverage, I'd rather reverse the
> meaning, and have the async case on by default (without even the
> Kconfig option), and have the kernel command line purely as a "oops,
> it's buggy, easy to ask people to test if this is what ails them".

If we're going to set this as default it might be good to document on
init.h that components that need content in initramfs need the wait
call.

> What *can* happen early boot outside of firmware loading and usermodehelpers?

*In practice* the only thing I can think of at this time is races with
other rootfs_initcall() calls, granted ordering among these is done at
linker time, but I can't think of a issue with them:

arch/x86/kernel/pci-dma.c:rootfs_initcall(pci_iommu_init);
drivers/iommu/intel/irq_remapping.c:rootfs_initcall(ir_dev_scope_init);
drivers/mfd/sta2x11-mfd.c:rootfs_initcall(sta2x11_mfd_init);
drivers/thunderbolt/nhi.c:rootfs_initcall(nhi_init);

But Cc'ing the maintainers of these components just in case.

  Luis
