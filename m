Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB341AD85
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhI1LGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239306AbhI1LGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:06:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CEC160F9D;
        Tue, 28 Sep 2021 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632827064;
        bh=CuyVtVWN5y7u72S4IqpRbRMpbZfiFf1u3LqsMG4w/cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaZ4OQmc5a24cUhfgG8iThEd9ZuvmI469h3XpG67sklVXYQH/8F7xVtXdXwu9EE3n
         D640okFRTIxye46vModAQv5TBZmOOJbS7nYCNx++J+fFSoDFb9MJ4hsqEo6vqqQPh6
         NjbHeYJn0qSPIuydUogy7FWkEn3n9tBNmv1ftLrs=
Date:   Tue, 28 Sep 2021 13:04:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/3] get_abi: improve message output and fix a regression
Message-ID: <YVL2trHQzxG59nXf@kroah.com>
References: <cover.1632823172.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1632823172.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 12:14:01PM +0200, Mauro Carvalho Chehab wrote:
> Hi Greg,
> 
> As promised on
> 
> 	https://lore.kernel.org/lkml/20210928120304.62319fba@coco.lan/T/#u
> 
> I'm adding progress info when  get_abi.pl is checking for undefined ABI symbols
> on patches 1 and 2.
> 
> That will help not only to identify what is causing delays on the script, but also
> to notify the user that processing it could take some time on some systems.
> 
> If you run it on your big server with:
> 
>   scripts/get_abi.pl undefined 2>logs
> 
> The "logs" file will contain timestamps relative to the time the script started to
> do the regex matches for sysfs files. It should be printing one line every
> time the progress completes 1% or one second after the last progress output.

Adding more debugging and tweaking the script a bit to show the file it
is about to check, not the one it finished checking, I got the following
debug output that seems to pinpoint the problem file.

The sysfs file that is causing problems is:
	/sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap

and here's some debugging output for the regex it needs to search for
this:

/sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
/sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
/sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/
/sys/devices/pci0000:40/0000:40:07.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
/sys/devices/pci0000:40/0000:40:07.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
/sys/devices/pci0000:40/0000:40:07.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:02/device:7a/physical_node/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:02/device:7a/physical_node/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:02/device:7a/physical_node/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/
/sys/devices/pci0000:40/0000:40:01.3/0000:4a:00.0/0000:4b:0a.0/0000:50:00.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
/sys/devices/pci0000:40/0000:40:01.3/0000:4a:00.0/0000:4b:0a.0/0000:50:00.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
/sys/devices/pci0000:40/0000:40:01.3/0000:4a:00.0/0000:4b:0a.0/0000:50:00.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/


And sometimes this thing finishes in 20 seconds, and others, many many
minutes.  It's not deterministic at all, which is odd.  Is the sysfs
tree being sorted so that this should always have the same search order?

Anyway, I've applied this series as well, this helps in finding the
problems :)

Note, I can provide an off-list tarball of /sys/ if that would help in
debugging anything on your end.

thanks,

greg k-h
