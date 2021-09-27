Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF1419176
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhI0JZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233587AbhI0JZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:25:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B51FD61157;
        Mon, 27 Sep 2021 09:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632734603;
        bh=C+3W9J7B6ZG7F8nbyDNhMaUe9/T5jR1uVU7Ci2T0nno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0LWq/vs/7g7LXEctYGdAq207EPtS+ElzMiUA4M38O7xG9DtIGssFpTHbhTlM0vD4v
         iUt1rmimgksduewoe7lAm8ryEAu1dJpFZ/BAocLdVx0uji0J1AbMS7OB8WdCKGDXeQ
         ck1kbTVVwToq/9ZM7aXfpJ8IWRmn5891mYKcFxTc=
Date:   Mon, 27 Sep 2021 11:23:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] (REBASED) get_abi.pl undefined: improve precision
 and performance
Message-ID: <YVGNiPXNbWWy3CSj@kroah.com>
References: <YUyICHTRdfL8Ul7X@kroah.com>
 <cover.1632411447.git.mchehab+huawei@kernel.org>
 <YUy1oPjdLTh9rEfq@kroah.com>
 <20210927105553.105f22c5@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927105553.105f22c5@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:55:53AM +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 23 Sep 2021 19:13:04 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Thu, Sep 23, 2021 at 05:41:11PM +0200, Mauro Carvalho Chehab wrote:
> > > Hi Greg,
> > > 
> > > As requested, this is exactly the same changes, rebased on the top of
> > > driver-core/driver-core-next.
> > > 
> > > -
> > > 
> > > It follows a series of improvements for get_abi.pl. it is on the top of driver-core/driver-core-next.
> > > 
> > > With such changes, on my development tree, the script is taking 6 seconds to run 
> > > on my desktop:
> > > 
> > > 	$ !1076
> > > 	$ time ./scripts/get_abi.pl undefined |sort >undefined_after && cat undefined_after| perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|sort|uniq -c|sort -nr >undefined_symbols; wc -l undefined_after undefined_symbols
> > > 
> > > 	real	0m6,292s
> > > 	user	0m5,640s
> > > 	sys	0m0,634s
> > > 	  6838 undefined_after
> > > 	   808 undefined_symbols
> > > 	  7646 total
> > > 
> > > And 7 seconds on a Dell Precision 5820:
> > > 
> > > 	$ time ./scripts/get_abi.pl undefined |sort >undefined && cat undefined| perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|sort|uniq -c|sort -nr >undefined_symbols; wc -l undefined; wc -l undefined_symbols
> > > 
> > > 	real	0m7.162s
> > > 	user	0m5.836s
> > > 	sys	0m1.329s
> > > 	6548 undefined
> > > 	772 undefined_symbols
> > > 
> > > Both tests were done against this tree (based on today's linux-next):
> > > 
> > > 	$ https://git.kernel.org/pub/scm/linux/kernel/git/mchehab/devel.git/log/?h=get_abi_undefined-latest
> > > 
> > > It should be noticed that, as my tree has several ABI fixes,  the time to run the
> > > script is likely less than if you run on your tree, as there will be less symbols to
> > > be reported, and the algorithm is optimized to reduce the number of regexes
> > > when a symbol is found.
> > > 
> > > Besides optimizing and improving the seek logic, this series also change the
> > > debug logic. It how receives a bitmap, where "8" means to print the regexes
> > > that will be used by "undefined" command:
> > > 
> > > 	$ time ./scripts/get_abi.pl undefined --debug 8 >foo
> > > 	real	0m17,189s
> > > 	user	0m13,940s
> > > 	sys	0m2,404s
> > > 
> > > 	$wc -l foo
> > > 	18421939 foo
> > > 
> > > 	$ cat foo
> > > 	...
> > > 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/in_voltage.*_scale_available$)$/
> > > 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/out_voltage.*_scale_available$)$/
> > > 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/out_altvoltage.*_scale_available$)$/
> > > 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/in_pressure.*_scale_available$)$/
> > > 	...
> > > 
> > > On other words, on my desktop, the /sys match is performing >18M regular 
> > > expression searches, which takes 6,2 seconds (or 17,2 seconds, if debug is 
> > > enabled and sent to an area on my nvme storage).  
> > 
> > Better, it's down to 10 minutes on my machine now:
> > 
> > 	real	10m39.218s
> > 	user	10m37.742s
> > 	sys	0m0.775s
> 
> A lot better, but not clear why it is still taking ~40x more than here...
> It could well be due to the other ABI changes yet to be applied
> (I'll submit it probably later today), but it could also be related to
> something else. Could this be due to disk writes?

Disk writes to where for what?  This is a very fast disk (nvme raid
array)  It's also a very "big" system, with lots of sysfs files:

	$ find /sys/devices/ -type f | wc -l
	44334

compared to my laptop that only has 17k entries in /sys/devices/

I'll run this updated script on my laptop later today and give you some
numbers.  And any Documentation/ABI/ updates you might have I'll gladly
take as well.

thanks,

greg k-h
