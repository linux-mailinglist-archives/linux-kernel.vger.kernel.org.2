Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC544E4CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhKLKqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:46:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233189AbhKLKqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:46:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2269C60ED5;
        Fri, 12 Nov 2021 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636713825;
        bh=Qj72yeNhSNc7MUPjPv5VU8s3oafXSlRNI19trRuQtDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPjf8YdBfWVCfvk6YCZC1jXvdJa7z5K4hm67qa5KEUAjoo2waiZ+MZxUfHj6u6QF/
         ibmy3d++dweh6bqvgoz10MnVllIuTEDgl9zs0oQLT2LrGvX3hbcMD4G2NTEYRzP8p2
         H5ec3kCykBSnOwv0h9icaszZ4ulRs+OBOdX4QwQM=
Date:   Fri, 12 Nov 2021 11:43:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YY5FX/sQZSkBh2vz@kroah.com>
References: <CAHp75Vcp=hC1oL5FBQDDFe8EBxWB9Po4FKNS9ZGtD3q-yQPtAw@mail.gmail.com>
 <CAHifhD6p9qSm5dv1spz+oPRhRkBZeQspHNEphE49fODacm-S6g@mail.gmail.com>
 <CAHp75Vfk5WHWiQxwmqEzVEymgpvjxKWEZbaQ9+=Et7N63Ps=Ng@mail.gmail.com>
 <CAHifhD5bGZOcZFNsHYFeecikHGUts73U4k6=aUVNTKEeETW5rQ@mail.gmail.com>
 <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com>
 <CAMj1kXHoRa+9gS7OEZZH2SSZQ8Tf4BUMdh-p=+OvWEb1a6ffFA@mail.gmail.com>
 <CAHp75VckB0RA6zoLRQ2UOcQRgMEf6sNxDGfpsNVr+92eArhD=Q@mail.gmail.com>
 <CAD2FfiH9OcKyUo6xjTfSENrEKF=4kZiGU4rT0FriK6KgKYSzyw@mail.gmail.com>
 <YY4PHacrS4czhEx3@kroah.com>
 <CAD2FfiFTsj63NJTKjOhHU0FZ53uHCnG9SDdfqkj3cGcH=vos=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiFTsj63NJTKjOhHU0FZ53uHCnG9SDdfqkj3cGcH=vos=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 10:09:14AM +0000, Richard Hughes wrote:
> On Fri, 12 Nov 2021 at 06:52, Greg KH <gregkh@linuxfoundation.org> wrote:
> > Why don't we just export these areas to userspace and let the decoding
> > of them happen there?
> 
> Unless I'm missing something, the patch from Hans-Gert does just that:
> exposing the IFD BIOS partition that encloses the various EFI file
> volumes.

But it is not tied into the EFI subsystem at all, binding only to those
resources.  It does not do anything with any efi symbol or access
control.

Again, that's my primary complaint here, the driver HAS to be able to
tell the kernel what resource it wants to bind to and control, right now
it just "assumes" that it can have access to a chunk of memory without
any notification or checks at all, which will cause problems on systems
that do not follow that assumption.

So while you all are arguing over oddities, the main complaint here of
"this driver is not ok as-is" seems to keep being ignored for some odd
reason.

I'm going to just ignore this thread now and wait for a new patch to
review.

thanks,

greg k-h
