Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF133C882
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 22:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhCOVe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 17:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232981AbhCOVd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:33:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 284D064F37;
        Mon, 15 Mar 2021 21:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615844037;
        bh=PiOdIRfh5JF1oWZaCo8Qfv/rudcJe097U45aNhFQGME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0AqCdwOpDTjZY8SdduINB81Nj55YiNDb4N7gNvZZFukeCqV+weylXPdSY5JhCMr9c
         C9XZC0TGsWG6w+urAyq4W8jPmlNkMR1Y6dp6piiWhatCAcIrrrxM35/EkMPUBK4VHq
         e/M6PL4lj6Mn8C5WkM5r6HSOqBshYzSgXsG8u4w4=
Date:   Mon, 15 Mar 2021 14:33:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
Message-Id: <20210315143356.ce87a0be2b4b2a273d6c49b9@linux-foundation.org>
In-Reply-To: <20210313212528.2956377-2-linux@rasmusvillemoes.dk>
References: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
        <20210313212528.2956377-2-linux@rasmusvillemoes.dk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2021 22:25:27 +0100 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Most of the boot process doesn't actually need anything from the
> initramfs, until of course PID1 is to be executed. So instead of doing
> the decompressing and populating of the initramfs synchronously in
> populate_rootfs() itself, push that off to a worker thread.
> 
> This is primarily motivated by an embedded ppc target, where unpacking
> even the rather modest sized initramfs takes 0.6 seconds, which is
> long enough that the external watchdog becomes unhappy that it doesn't
> get attention soon enough. By doing the initramfs decompression in a
> worker thread, we get to do the device_initcalls and hence start
> petting the watchdog much sooner.
> 
> Normal desktops might benefit as well. On my mostly stock Ubuntu
> kernel, my initramfs is a 26M xz-compressed blob, decompressing to
> around 126M. That takes almost two seconds:
> 
> [    0.201454] Trying to unpack rootfs image as initramfs...
> [    1.976633] Freeing initrd memory: 29416K
> 
> Before this patch, these lines occur consecutively in dmesg. With this
> patch, the timestamps on these two lines is roughly the same as above,
> but with 172 lines inbetween - so more than one cpu has been kept busy
> doing work that would otherwise only happen after the
> populate_rootfs() finished.
> 
> Should one of the initcalls done after rootfs_initcall time (i.e.,
> device_ and late_ initcalls) need something from the initramfs (say, a
> kernel module or a firmware blob), it will simply wait for the
> initramfs unpacking to be done before proceeding, which should in
> theory make this completely safe.
> 
> But if some driver pokes around in the filesystem directly and not via
> one of the official kernel interfaces (i.e. request_firmware*(),
> call_usermodehelper*) that theory may not hold - also, I certainly
> might have missed a spot when sprinkling wait_for_initramfs(). So
> there is an escape hatch in the form of an initramfs_async= command
> line parameter.

This seems sensible.  And nice.

Are you sure that you've found all the code paths that require that
initramfs be ready?  You have one in init/main, one in the bowels of
the firmware loader and one in UML.  How do we know that there are no
other such places?

Also, all this doesn't buy anything for uniprocessor machines.  Is
there a simple way of making it all go away if !CONFIG_SMP?

