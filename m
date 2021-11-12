Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B491044E20D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhKLGzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhKLGzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:55:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27FD860D07;
        Fri, 12 Nov 2021 06:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636699937;
        bh=3z9fwfrXafXz1v0JMezNYLQv1XDhle64SZ4vD13dYAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JtKSl+3dronxPT4t8UvjFUIjd+z6wD7/TiD3dhCrh/Kn6pQ5Wiqv86T7G7LIWmd8K
         GjkCW9Vxz3BDJZGztbw5tFQvmarIQQ4nvja65jtVrNUb8zLPciZejSx7VOrqLiVosD
         4BuNspZdh8YeXpX7dwv32wa+XHJWeq93c7p7L+v4=
Date:   Fri, 12 Nov 2021 07:52:13 +0100
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
Message-ID: <YY4PHacrS4czhEx3@kroah.com>
References: <YYzxWPIWFAV04LRU@lahna>
 <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <CAHp75Vcp=hC1oL5FBQDDFe8EBxWB9Po4FKNS9ZGtD3q-yQPtAw@mail.gmail.com>
 <CAHifhD6p9qSm5dv1spz+oPRhRkBZeQspHNEphE49fODacm-S6g@mail.gmail.com>
 <CAHp75Vfk5WHWiQxwmqEzVEymgpvjxKWEZbaQ9+=Et7N63Ps=Ng@mail.gmail.com>
 <CAHifhD5bGZOcZFNsHYFeecikHGUts73U4k6=aUVNTKEeETW5rQ@mail.gmail.com>
 <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com>
 <CAMj1kXHoRa+9gS7OEZZH2SSZQ8Tf4BUMdh-p=+OvWEb1a6ffFA@mail.gmail.com>
 <CAHp75VckB0RA6zoLRQ2UOcQRgMEf6sNxDGfpsNVr+92eArhD=Q@mail.gmail.com>
 <CAD2FfiH9OcKyUo6xjTfSENrEKF=4kZiGU4rT0FriK6KgKYSzyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiH9OcKyUo6xjTfSENrEKF=4kZiGU4rT0FriK6KgKYSzyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 09:07:42PM +0000, Richard Hughes wrote:
> On Thu, 11 Nov 2021 at 15:50, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > I was thinking about SHA256 hashes or so (as they tell about
> > binaries). In any case the interface for this seems to be in the
> > kernel.
> 
> I'm quite sure you don't want to put those EFI format decoders in the
> kernel; there is all kinds of weird compression schemes, volumes are
> recursive, and vendors like to hide weird things in the undocumented
> (or reserved) areas.

Why don't we just export these areas to userspace and let the decoding
of them happen there?  That's a real "thing" that the kernel can easily
detect is present and know to export properly as they are defined by the
UEFI specification, right?

Yes, that will not help for the non-UEFI x86 systems, but it's a
start...

thanks,

greg k-h
