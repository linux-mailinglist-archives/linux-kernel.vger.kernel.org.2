Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A013061C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhA0RS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:18:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234977AbhA0RPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:15:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1064364DA9;
        Wed, 27 Jan 2021 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611767698;
        bh=kYY8ilRGfiiSF/WUBVz8wEgrDLz0uywZZmaL40DCVmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmFeI+W6PrYomXlVvbXIZRka5UDciU8i6Vx7xWEcLi6pyr5uXzaoYiB3AnLF3QUJD
         IgU2BFmPJzoBQmiSRsvl60CU8vs3Nl6Jlm+uGxtdprMMBrdn+CY3fXCtUdhmSuD1S1
         wlEKhgrjMmLDctSaEbaI/MvRpiCDpWBuzS6kav9YAJTxVOat2ppXKQSVnhXtqbRd29
         fqtTWVDxX2mOyaKZT7BAoathVnvzEyYmlY1NDqTAVcNR6tGWC2IneqzfDjYsmv6WDK
         JTEgrgNi76WNDbETWUIy3PXjyGc8xKBCp7ew1QSEQG8s/voaE/qA43wD4v4uAUsb0n
         Z1RVa+dpyElvQ==
Date:   Wed, 27 Jan 2021 17:14:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: WARNING in __do_kernel_fault
Message-ID: <20210127171453.GC358@willie-the-truck>
References: <0000000000009bbb7905b9e4a624@google.com>
 <CACT4Y+agFz7Y32pkV7nObxB3KjCcN1p335h1HE4dr94rsDvndw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+agFz7Y32pkV7nObxB3KjCcN1p335h1HE4dr94rsDvndw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 06:00:30PM +0100, Dmitry Vyukov wrote:
> On Wed, Jan 27, 2021 at 5:56 PM syzbot
> <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15a25264d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=45b6fce29ff97069e2c5
> > userspace arch: arm64
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com
> 
> This happens on arm64 instance with mte enabled.
> There is a GPF in reiserfs_xattr_init on x86_64 reported:
> https://syzkaller.appspot.com/bug?id=8abaedbdeb32c861dc5340544284167dd0e46cde
> so I would assume it's just a plain NULL deref. Is this WARNING not
> indicative of a kernel bug? Or there is something special about this
> particular NULL deref?

Congratulations, you're the first person to trigger this warning!

This fires if we take an unexpected data abort in the kernel but when we
get into the fault handler the page-table looks ok (according to the CPU via
an 'AT' instruction). Are you using QEMU system emulation? Perhaps its
handling of AT isn't quite right.

Will
