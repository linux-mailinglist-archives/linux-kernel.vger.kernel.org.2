Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB144B0E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhKIQPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:15:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhKIQPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:15:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E5A660FD8;
        Tue,  9 Nov 2021 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636474356;
        bh=D6I/ihDzq5GZ+o9AC797Q70ArakfkssMr8IrbtSNPLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vczQ8Ciq8UvvlcwBnp7Q1YNH+/MCURcMEgJ7O4yl2rHGyAiwF8HJxbgdKjW3dnbQo
         6tvitC5SoVq2YiY4HqapI/aQScn0il/7ogdCZWLcQGC70nvuN12+xZwi0GePo+jHr5
         MojLvDgt3X54YPj0LtxJBEIDw/nuCvETcSO57TrI=
Date:   Tue, 9 Nov 2021 17:12:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        philipp.deppenwiese@immu.ne, Richard Hughes <hughsient@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YYqd8pNx53BX13Sy@kroah.com>
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com>
 <CAArk9MN99YjKV2AKCYsUqh7LNVCb2ddvcSnRgGGsXePkM6Q86Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAArk9MN99YjKV2AKCYsUqh7LNVCb2ddvcSnRgGGsXePkM6Q86Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 10:55:54AM -0300, Mauro Lima wrote:
> Hi all,
> 
> On Tue, Nov 9, 2021 at 3:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Nov 09, 2021 at 01:01:30AM +0100, Hans-Gert Dahmen wrote:
> > > Make the 16MiB long memory-mapped BIOS region of the platform SPI flash
> > > on X86_64 system available via /sys/kernel/firmware/flash_mmap/bios_region
> > > for pen-testing, security analysis and malware detection on kernels
> > > which restrict module loading and/or access to /dev/mem.
> >
> > That feels like a big security hole we would be opening up for no good
> > reason.
> Please, can you explain why this could be a security hole?

We restricted /dev/mem and now you want to open a portion of it back up,
hence my worry that now you can read information that previously you
could not read.

> IMO if the host is compromised the attacker already has information
> about the BIOS version, and after a quick lookup they know the BIOS
> vulnerabilities or the lack of them.

So you are saying that you do NOT need this access to get the BIOS
information if you have root access?  If not, then why is this needed?

confused,

greg k-h
