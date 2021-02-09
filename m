Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52924314A77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBIIij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:38:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhBIIhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:37:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3504C64E79;
        Tue,  9 Feb 2021 08:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612859823;
        bh=i8uBJJbz4wyAmxHfuAXfsQmKEl6vb3POsuLIzc8SaIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqxvFz4YCv9q3RSFDSqKmmqpJ2aMZLcQyQJopYaMfvjN4as7D8HT+M39QGKlE9GF8
         OE9Vbk1XUnX84l+wmiYTZdK+2ZcuGIZsOv+afPaafbC2KZeeqSr9t7Vq9XZ1m/ig4a
         Z5c/SzTR2rAlMhkL+qbL3tGY7tkBqBlTyyElglPY=
Date:   Tue, 9 Feb 2021 09:37:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Aaron Ma <aaron.ma@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>, peter.chen@nxp.com,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xhci-pci: Set AMD Renoir USB controller to D3 when
 shutdown
Message-ID: <YCJJrVp2DvCzigCw@kroah.com>
References: <20210204051850.64857-1-aaron.ma@canonical.com>
 <CAAd53p4euFiw7pfDnD2H8oMVeeTqQ_c+wOFDLM2xPccn5MewiA@mail.gmail.com>
 <cd4595e6-67da-885c-1a67-6dfd71425b8c@canonical.com>
 <CAAd53p4z1ydFi5pwOZJnsrBDPNVLKU0ygqa0+kdZdXWYocPLgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p4z1ydFi5pwOZJnsrBDPNVLKU0ygqa0+kdZdXWYocPLgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 02:50:15PM +0800, Kai-Heng Feng wrote:
> On Fri, Feb 5, 2021 at 2:45 PM Aaron Ma <aaron.ma@canonical.com> wrote:
> >
> >
> > On 2/5/21 12:27 PM, Kai-Heng Feng wrote:
> > > Can you please test the following patch, which should address the root cause:
> > > https://lore.kernel.org/linux-acpi/20201201213019.1558738-1-furquan@google.com/
> > >
> > > It also helps another AMD laptop on S5:
> > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1912935
> > >
> >
> > No, this patch doesn't help on ThinkPad AMD platform.
> 
> Thanks for the confirmation!
> 
> Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Mathias, want me to take this in my tree now, or are you going to send
me more patches for 5.12-rc1?

thanks,

greg k-h
