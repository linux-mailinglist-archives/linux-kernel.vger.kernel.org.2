Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E3D41B9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbhI1V4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242953AbhI1V4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:56:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C37E361361;
        Tue, 28 Sep 2021 21:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632866068;
        bh=5DC628JTfQgAdUOV20xA7AYdGWA68TDRdk2X9voYma8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TB91dGpae+2oXhyXtRjt4A/AnKDSZeaXqF/4nC/GuwWNcBeXU2xgPv+aMyqqnWhpQ
         R8hRAFfta3yO3WW9M76wiJqw6ODyBncufTbJ+umXyxMQ5+t06scVlpgQrBz4khL5uL
         BQrq7J2g4CXvO6qL5E8U0Qqs1xXtCV9JLC84N2xMqJ+wfoTI2Jksi7t9Ygyn4LLLNv
         HklrdNY5cvq5ZFwsrpJGTYtrAavSGtAbeg+nNTnS3zJD629U94HoLP1u+a3bMnlBsG
         xes10S4H6jPKqEweMzWOZZ+9SyJxszj/o3hZ2mkeBRUwi+wKzZSTJzhF5V8xUdR3Js
         qeI7Y3CCeHRlQ==
Date:   Tue, 28 Sep 2021 23:54:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/3] get_abi: improve message output and fix a
 regression
Message-ID: <20210928235425.02ffa1a4@coco.lan>
In-Reply-To: <YVNOZ3GKcpRxPXzv@kroah.com>
References: <cover.1632823172.git.mchehab+huawei@kernel.org>
        <YVL2trHQzxG59nXf@kroah.com>
        <20210928142739.2ffe380b@coco.lan>
        <YVNOZ3GKcpRxPXzv@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 28 Sep 2021 19:18:31 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Tue, Sep 28, 2021 at 02:27:39PM +0200, Mauro Carvalho Chehab wrote:
> > Em Tue, 28 Sep 2021 13:04:22 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> >   
> > > On Tue, Sep 28, 2021 at 12:14:01PM +0200, Mauro Carvalho Chehab wrote:  
> > > > Hi Greg,
> > > > 
> > > > As promised on
> > > > 
> > > > 	https://lore.kernel.org/lkml/20210928120304.62319fba@coco.lan/T/#u
> > > > 
> > > > I'm adding progress info when  get_abi.pl is checking for undefined ABI symbols
> > > > on patches 1 and 2.
> > > > 
> > > > That will help not only to identify what is causing delays on the script, but also
> > > > to notify the user that processing it could take some time on some systems.
> > > > 
> > > > If you run it on your big server with:
> > > > 
> > > >   scripts/get_abi.pl undefined 2>logs
> > > > 
> > > > The "logs" file will contain timestamps relative to the time the script started to
> > > > do the regex matches for sysfs files. It should be printing one line every
> > > > time the progress completes 1% or one second after the last progress output.    
> > > 
> > > Adding more debugging and tweaking the script a bit to show the file it
> > > is about to check, not the one it finished checking,  
> > 
> > Feel free to modify the script and add such debug/tweaks if you find
> > it useful. 
> >   
> > > I got the following
> > > debug output that seems to pinpoint the problem file.
> > > 
> > > The sysfs file that is causing problems is:
> > > 	/sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap
> > > 
> > > and here's some debugging output for the regex it needs to search for
> > > this:
> > > 
> > > /sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
> > > /sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
> > > /sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/
> > > /sys/devices/pci0000:40/0000:40:07.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
> > > /sys/devices/pci0000:40/0000:40:07.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
> > > /sys/devices/pci0000:40/0000:40:07.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/
> > > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:02/device:7a/physical_node/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
> > > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:02/device:7a/physical_node/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
> > > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:02/device:7a/physical_node/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/
> > > /sys/devices/pci0000:40/0000:40:01.3/0000:4a:00.0/0000:4b:0a.0/0000:50:00.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
> > > /sys/devices/pci0000:40/0000:40:01.3/0000:4a:00.0/0000:4b:0a.0/0000:50:00.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
> > > /sys/devices/pci0000:40/0000:40:01.3/0000:4a:00.0/0000:4b:0a.0/0000:50:00.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/  
> > 
> > Hmm... interesting. Perhaps the problem is on regexes like this:
> > 
> > 	/^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/
> > 
> > Which actually represents this What:
> > 	/sys/devices/pciXXXX:XX/0000:XX:XX.X/dma/dma<n>chan<n>/quickdata/cap
> > 
> > The script could have done a better job escaping "." character on
> > it (but that is not too trivial) and grouping altogether ".*" 
> > repetitions, although, in this specific case, probably the best
> > regex would be, instead:
> > 
> > 	/sys/devices/pci[\da-f:\.]+/dma/dma\d+chan\d+/quickdata/cap
> > 
> > One possible long-term solution would be to directly use regexes 
> > directly on "What" fields inside Documentation/ABI, but on some parts
> > this would require some changes, like, for instance:
> > 
> > 	/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/kone/roccatkone<minor>/weight
> > 
> > Ok, we could likely use capture groups like:
> > 
> > 	(?<NAME>pattern)
> > 
> > but IMO that would make it a lot harder to be understood by humans.
> > 
> >   
> > > And sometimes this thing finishes in 20 seconds, and others, many many
> > > minutes.  It's not deterministic at all, which is odd.  Is the sysfs
> > > tree being sorted so that this should always have the same search order?  
> > 
> > No, because it uses a lot of hashes in order to speed it up. Yet,
> > it shouldn't be hard - nor it would significantly affect the processing
> > time - to make it more deterministic. See the enclosed path.  
> 
> That patch solved everything.
> 
> It now only takes 10 seconds.  Every time.  Without the patch, it feels
> hung for some reason.

The explanation is simple  - still weird :-) - basically, when an ABI
symbol is found, the regex test loop stops.

Sorting the regexes probably placed the slowest regex to happen
*after* the one that matched the ABI symbol.

> Care to turn that into a patch that I can take?

Sure. Just sent it.

> 
> > > Anyway, I've applied this series as well, this helps in finding the
> > > problems :)  
> > 
> > Thanks!
> >   
> > > Note, I can provide an off-list tarball of /sys/ if that would help in
> > > debugging anything on your end.  
> > 
> > Yeah, that can help. Feel free to send it to me.
> > 
> > Btw, I just got an arm64 server with 128 CPUs for testing. I'm trying
> > to allocate also a big x86 server here, but I'm not sure if it is AMD or
> > Intel.  
> 
> This is on perl 5.34 here.
> 
> thanks,
> 
> greg k-h



Thanks,
Mauro
