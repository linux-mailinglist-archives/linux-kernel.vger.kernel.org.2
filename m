Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D778041B4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbhI1RVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241944AbhI1RVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:21:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27336128B;
        Tue, 28 Sep 2021 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632849564;
        bh=DhJnlcf2PJ4wfNINiTaX892A9f1YLWCQtWU26+osXfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyVVuMMUe57i8uX7kgT0NopzDD13mMg/l6OZyiv3TbAo8Qx7Qu4Ksq5N+fSvaTowF
         iWHD5xXw9sx9Axe7UM65Rvw1Bsjpvh8BOAz5Av9TlscvtehpzDG8CkuRE8UOoBQd5f
         YykwFw8bzqQpdOBumjGn/l/CKbKB0HSLzpsP4yso=
Date:   Tue, 28 Sep 2021 19:19:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/3] get_abi: improve message output and fix a regression
Message-ID: <YVNOmoM7DZfJ2BoJ@kroah.com>
References: <cover.1632823172.git.mchehab+huawei@kernel.org>
 <YVL2trHQzxG59nXf@kroah.com>
 <20210928142739.2ffe380b@coco.lan>
 <20210928154353.2e6656bb@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928154353.2e6656bb@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 03:43:53PM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 28 Sep 2021 14:27:39 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
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
> > 
> > Btw, I just got an arm64 server with 128 CPUs for testing. I'm trying
> > to allocate also a big x86 server here, but I'm not sure if it is AMD or
> > Intel.
> 
> Some tests on a Gigabyte R182-Z91-00 server, equipped with AMD EPYC 7352 
> 24-Core Processors (total 96 threads):
> 
> 	$ find /sys |wc -l
> 	233981
> 
> 	$ time ./scripts/get_abi.pl undefined >undefined 2>logs
> 
> 	real	0m38.917s
> 	user	0m34.554s
> 	sys	0m4.292s
> 
> PS.: this machine doesn't have anything at /sys/class/iommu.
> 
> On a Huawei TaiShan 200 (Model 2280) with 128 ARM cores:
> 
> 	$ find /sys |wc -l
> 	99362
> 	$ time ./scripts/get_abi.pl undefined >undefined 2>logs
> 
> 	real	0m29.311s
> 	user	0m26.173s
> 	sys	0m3.061s
> 
> Both machines are using Perl 5.26.

Try it with your sorting patch, that fixed it for me and now it runs in
10 seconds.

crazy.

