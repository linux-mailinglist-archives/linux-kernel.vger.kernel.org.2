Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF4341AD36
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbhI1KpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234543AbhI1KpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:45:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4842610FC;
        Tue, 28 Sep 2021 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632825822;
        bh=fkAve8tKE0y/DXgMCdT+P095PTJ4abta0bz1NSD8BBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUExyV2pfYCt4LLFGN4K7GmTM/FjjXtmxeOViCwHeos+zdYqMakULok5AyM1gzNKT
         uR4fXQYuxB9bzOqg9gbsx5giKwF7vvOmEKwtiHvgTd2mY+qSqgDHmYC8rEXIfAsxlN
         3IHJoOPN4ALWOCkkE5KAq856sPGBvlu+9h+sZPMc=
Date:   Tue, 28 Sep 2021 12:43:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] (REBASED) get_abi.pl undefined: improve precision
 and performance
Message-ID: <YVLx3KP1BeDkqV2o@kroah.com>
References: <YUyICHTRdfL8Ul7X@kroah.com>
 <cover.1632411447.git.mchehab+huawei@kernel.org>
 <YUy1oPjdLTh9rEfq@kroah.com>
 <20210927105553.105f22c5@coco.lan>
 <YVGNiPXNbWWy3CSj@kroah.com>
 <20210927153942.75bbb9cf@coco.lan>
 <YVHntS2e3FTWIjds@kroah.com>
 <20210928120304.62319fba@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210928120304.62319fba@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 12:03:04PM +0200, Mauro Carvalho Chehab wrote:
> Em Mon, 27 Sep 2021 17:48:05 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Mon, Sep 27, 2021 at 03:39:42PM +0200, Mauro Carvalho Chehab wrote:
> > > Em Mon, 27 Sep 2021 11:23:20 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > >   
> > > > On Mon, Sep 27, 2021 at 10:55:53AM +0200, Mauro Carvalho Chehab wrote:  
> > > > > Em Thu, 23 Sep 2021 19:13:04 +0200
> > > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > > > >     
> > > > > > On Thu, Sep 23, 2021 at 05:41:11PM +0200, Mauro Carvalho Chehab wrote:    
> > > > > > > Hi Greg,
> > > > > > > 
> > > > > > > As requested, this is exactly the same changes, rebased on the top of
> > > > > > > driver-core/driver-core-next.
> > > > > > > 
> > > > > > > -
> > > > > > > 
> > > > > > > It follows a series of improvements for get_abi.pl. it is on the top of driver-core/driver-core-next.
> > > > > > > 
> > > > > > > With such changes, on my development tree, the script is taking 6 seconds to run 
> > > > > > > on my desktop:
> > > > > > > 
> > > > > > > 	$ !1076
> > > > > > > 	$ time ./scripts/get_abi.pl undefined |sort >undefined_after && cat undefined_after| perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|sort|uniq -c|sort -nr >undefined_symbols; wc -l undefined_after undefined_symbols
> > > > > > > 
> > > > > > > 	real	0m6,292s
> > > > > > > 	user	0m5,640s
> > > > > > > 	sys	0m0,634s
> > > > > > > 	  6838 undefined_after
> > > > > > > 	   808 undefined_symbols
> > > > > > > 	  7646 total
> > > > > > > 
> > > > > > > And 7 seconds on a Dell Precision 5820:
> > > > > > > 
> > > > > > > 	$ time ./scripts/get_abi.pl undefined |sort >undefined && cat undefined| perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|sort|uniq -c|sort -nr >undefined_symbols; wc -l undefined; wc -l undefined_symbols
> > > > > > > 
> > > > > > > 	real	0m7.162s
> > > > > > > 	user	0m5.836s
> > > > > > > 	sys	0m1.329s
> > > > > > > 	6548 undefined
> > > > > > > 	772 undefined_symbols
> > > > > > > 
> > > > > > > Both tests were done against this tree (based on today's linux-next):
> > > > > > > 
> > > > > > > 	$ https://git.kernel.org/pub/scm/linux/kernel/git/mchehab/devel.git/log/?h=get_abi_undefined-latest
> > > > > > > 
> > > > > > > It should be noticed that, as my tree has several ABI fixes,  the time to run the
> > > > > > > script is likely less than if you run on your tree, as there will be less symbols to
> > > > > > > be reported, and the algorithm is optimized to reduce the number of regexes
> > > > > > > when a symbol is found.
> > > > > > > 
> > > > > > > Besides optimizing and improving the seek logic, this series also change the
> > > > > > > debug logic. It how receives a bitmap, where "8" means to print the regexes
> > > > > > > that will be used by "undefined" command:
> > > > > > > 
> > > > > > > 	$ time ./scripts/get_abi.pl undefined --debug 8 >foo
> > > > > > > 	real	0m17,189s
> > > > > > > 	user	0m13,940s
> > > > > > > 	sys	0m2,404s
> > > > > > > 
> > > > > > > 	$wc -l foo
> > > > > > > 	18421939 foo
> > > > > > > 
> > > > > > > 	$ cat foo
> > > > > > > 	...
> > > > > > > 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/in_voltage.*_scale_available$)$/
> > > > > > > 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/out_voltage.*_scale_available$)$/
> > > > > > > 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/out_altvoltage.*_scale_available$)$/
> > > > > > > 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/in_pressure.*_scale_available$)$/
> > > > > > > 	...
> > > > > > > 
> > > > > > > On other words, on my desktop, the /sys match is performing >18M regular 
> > > > > > > expression searches, which takes 6,2 seconds (or 17,2 seconds, if debug is 
> > > > > > > enabled and sent to an area on my nvme storage).      
> > > > > > 
> > > > > > Better, it's down to 10 minutes on my machine now:
> > > > > > 
> > > > > > 	real	10m39.218s
> > > > > > 	user	10m37.742s
> > > > > > 	sys	0m0.775s    
> > > > > 
> > > > > A lot better, but not clear why it is still taking ~40x more than here...
> > > > > It could well be due to the other ABI changes yet to be applied
> > > > > (I'll submit it probably later today), but it could also be related to
> > > > > something else. Could this be due to disk writes?    
> > > > 
> > > > Disk writes to where for what?  This is a very fast disk (nvme raid
> > > > array)  It's also a very "big" system, with lots of sysfs files:
> > > > 
> > > > 	$ find /sys/devices/ -type f | wc -l
> > > > 	44334  
> > > 
> > > Ok. Maybe that partially explains why it is taking so long, as the
> > > number of regex to compare will increase (not linearly).  
> > 
> > No idea.  I just ran it on my laptop and it took only 5 seconds.
> 
> Ok, 5 seconds is similar to what I got here on the machines I
> tested so far. I'm waiting for a (shared) big machine to be available
> in order to be able to do some tests on it.
> 
> > Hm, you aren't reading the values of the sysfs files, right?
> 
> No. Just retrieving the directory contents. That part is actually
> fast: it takes less than 2 seconds here to read all ABI + traverse
> sysfs directories. Also, from your past logs, the time is spent
> later on, when it is handling the regex. On that time, there are
> just the regex parsing and printing the results. 
> 
> > Anything I can do to run to help figure out where the script is taking
> > so long?
> 
> Not sure if it is worth the efforts. I mean, the relationship
> between the number of processed sysfs nodes and the number of regex
> to be tested (using big-oh and big-omega notation) should be between
> Ω(n . log(n)) and O(n^2 . log(n)). There's not much space left for
> optimizing it, I guess.
> 
> So, I would expect that a big server would take a log more time to
> process, it, due to the larger number of sysfs entries.
> 
> Also, if one wants to speedup on a big machine, it could either
> exclude some pattern, like:
> 
> 	# Won't parse any PCI devices
> 	$time ./scripts/get_abi.pl undefined --search-string '^(?!.*pci)' |wc -l
> 	8438
> 
> 	real	0m3,494s
> 	user	0m2,829s
> 	sys	0m0,658s

That only takes 8 seconds on this box:
	$ time ./scripts/get_abi.pl undefined  --search-string '^(?!.*pci)' |wc -l
	18872

	real	0m8.026s
	user	0m7.300s
	sys	0m0.726s

> or (more likely) just search for an specific part of the ABI:
> 
> 	# Seek ABI only for PCI devices
>  	$ ./scripts/get_abi.pl undefined --search-string pci

This takes much longer, I didn't want to wait the 10 minutes :)

> ---
> 
> After sleeping on it, I opted to implement some progress information.
> 
> That will help to identify any issues that might be causing the
> script to take so long to finish.
> 
> I'll send the patches on a new series.

Thanks, I'll go try those now...

greg k-h
