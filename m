Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0823E41C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhHIIor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233926AbhHIIoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:44:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B464A60462;
        Mon,  9 Aug 2021 08:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628498666;
        bh=grKMIOHGb1ru2VuvTfMUqYUzzhQ8CKPOf/66tvSq5SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohGQ0pIcLDIwANoZV7kjmnxzXBUNFuQw6YcdqMD1JTOKpdiE6h+u0gZ5iu3NX63/T
         CPB4KgXOi9pLRJOZ+1urLnJehhN9tao6D/3eWOk8UGUXGdioLpf5JzVALc8ziIGs2X
         aM3cyJpa5ApvCP2z9kjuNxY7spMM/MyhH07XkHb4=
Date:   Mon, 9 Aug 2021 10:44:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: read() via USB bus
Message-ID: <YRDq530N/9uu2J0x@kroah.com>
References: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com>
 <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:15:29AM +0200, Oliver Neukum wrote:
> 
> On 09.08.21 09:58, Muni Sekhar wrote:
> > Hi all,
> >
> > PCIe memory mapped registers can be read via readb(), readw(), readl()
> > kernel API's. Similarly what are the kernel API to read the device
> > registers via USB bus
> >
> 
> Hi,
> 
> I am afraid this is based on a fundamental misunderstanding on how
> USB works. It is based on passing messages, not reading and writing
> registers.
> 
> USB devices are primarily based on endpoints, not registers. A literal
> answer to your question would point you to the clear/set/get_feature
> standard requests of chapter 9 of the specification, but that really
> will not help you, as you are making assumption that fundamentally
> do not apply.
> 
> I hope this list stays friendly to newcomers and we will answer
> specific questions, but at this point I must advise you to first
> read an introductory book.

Along these lines, take a look at the book, Linux Device Drivers, third
edition, which is free online, as it has a chapter about USB drivers and
how they work.  That should help you out to understand the issues
involved with USB devices.

If you have specific questions after looking at that, and reading the
basic usb-skeleton.c driver in the kernel source tree, please let us
know!

thanks,

greg k-h
