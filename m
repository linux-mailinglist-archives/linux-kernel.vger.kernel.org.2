Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A5241B9E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbhI1WJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242494AbhI1WJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:09:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DEAA61357;
        Tue, 28 Sep 2021 22:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632866859;
        bh=s29u+ndGckzyi3RdYvXQRzn9okKr6F7XeNAuFwFBAEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mbRghuJx0LY9gMG60LB8EEezX9DZZfcdAXycn0LE760bC8X75ZWJ88gmHtK9y3joL
         WZZW/27NzHzhj86qfoAp6Hd3COJaGwyCYyumJVY3O/4HBnE9o4TW9cM1tzpMB/+lPz
         S4vLw6SrdHQmMRH+sxFfAzO16WhsDW3jop8n01/ljkU3u2SmUzOFQw4xeY4qhIuUth
         iQc5Mswmk9zOYrnVajl6v2t0bQH3X5SW1y6GKYd60ioGlu3QpskSUbSka4wXk0MshI
         6OnuiZJek+kVHIfXmoX7O5UEdilCq4IjZOms9vmwwHhAybBbCK+rnAgHLSBbZY55vZ
         KtyZMPgO989CQ==
Date:   Wed, 29 Sep 2021 00:07:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] ABI: sysfs-bus-pci: add a alternative What fields
Message-ID: <20210929000734.77328446@coco.lan>
In-Reply-To: <20210928183403.GA715406@bhelgaas>
References: <15ba8c07f1b0fd7359106920c8e34a7b9af7aea6.1632750608.git.mchehab+huawei@kernel.org>
        <20210928183403.GA715406@bhelgaas>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 28 Sep 2021 13:34:03 -0500
Bjorn Helgaas <helgaas@kernel.org> escreveu:

> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index 1eeac7f59672..16afe3f59cbd 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -1,4 +1,5 @@
> >  What:		/sys/bus/pci/drivers/.../bind
> > +What:		/sys/devices/pciX/.../bind  
> 
> Wasn't somebody just updating these wildcard-ish items in pathnames?
> 
> Ah, it was you :)
> 
>   https://lore.kernel.org/all/4ede4ec98e295f054f3e5a6f3f9393b5e3d5d2a7.1631782432.git.mchehab+huawei@kernel.org/
> 
> Changing "virtfnN" to "virtfn<N>".
> 
> Is that same sort of thing applicable here?  My system has
> 
>   /sys/devices/pci0000:00/...

Yes and no ;-)

See, there are lots of places under Documentation/ABI that already use
X, Y and Z uppercase letters to identify wildcards. As there aren't any
sysfs entries that have those uppercase letters, I opted to teach the 
get_abi.pl script to threat such uppercase chars as wildcards. The same
can't be done with N, because the USB subsystem (and a couple of other
ABIs) use uppercase N as valid symbols like "bNum.*".

Long term, one alternative would be to replace the What fields by a 
regular expressions on ABI. That would avoid some magic inside 
get_abi.pl. However, a change like that would require touching almost
all files, and has a drawback to make them more obscure - even
if we use named group regexes.

Thanks,
Mauro
