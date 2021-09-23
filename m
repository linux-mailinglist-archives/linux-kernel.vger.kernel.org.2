Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA875416443
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhIWRVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235318AbhIWRVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:21:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFFFE60F24;
        Thu, 23 Sep 2021 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632417618;
        bh=DR0FN25Ug9Xy3RR+UsMr2wZWKepCxowsNunAN/DFPFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bt7r94vi16o2Xp+T11fAie2jHr5vwktiVtCK3DekEUVn3V19CMKqd2jAj6+eaYnVs
         hA7JTH8K66U8ghfgdraPsMZgiWeCOeWkOZ5zIgCSY2MriktuCyq4usBuLCu3QsN3MS
         yEeRkcANZoTXvbDlHmoxlE1TkusL21QxvyHTwWzA=
Date:   Thu, 23 Sep 2021 19:13:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] (REBASED) get_abi.pl undefined: improve precision
 and performance
Message-ID: <YUy1oPjdLTh9rEfq@kroah.com>
References: <YUyICHTRdfL8Ul7X@kroah.com>
 <cover.1632411447.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1632411447.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 05:41:11PM +0200, Mauro Carvalho Chehab wrote:
> Hi Greg,
> 
> As requested, this is exactly the same changes, rebased on the top of
> driver-core/driver-core-next.
> 
> -
> 
> It follows a series of improvements for get_abi.pl. it is on the top of driver-core/driver-core-next.
> 
> With such changes, on my development tree, the script is taking 6 seconds to run 
> on my desktop:
> 
> 	$ !1076
> 	$ time ./scripts/get_abi.pl undefined |sort >undefined_after && cat undefined_after| perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|sort|uniq -c|sort -nr >undefined_symbols; wc -l undefined_after undefined_symbols
> 
> 	real	0m6,292s
> 	user	0m5,640s
> 	sys	0m0,634s
> 	  6838 undefined_after
> 	   808 undefined_symbols
> 	  7646 total
> 
> And 7 seconds on a Dell Precision 5820:
> 
> 	$ time ./scripts/get_abi.pl undefined |sort >undefined && cat undefined| perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|sort|uniq -c|sort -nr >undefined_symbols; wc -l undefined; wc -l undefined_symbols
> 
> 	real	0m7.162s
> 	user	0m5.836s
> 	sys	0m1.329s
> 	6548 undefined
> 	772 undefined_symbols
> 
> Both tests were done against this tree (based on today's linux-next):
> 
> 	$ https://git.kernel.org/pub/scm/linux/kernel/git/mchehab/devel.git/log/?h=get_abi_undefined-latest
> 
> It should be noticed that, as my tree has several ABI fixes,  the time to run the
> script is likely less than if you run on your tree, as there will be less symbols to
> be reported, and the algorithm is optimized to reduce the number of regexes
> when a symbol is found.
> 
> Besides optimizing and improving the seek logic, this series also change the
> debug logic. It how receives a bitmap, where "8" means to print the regexes
> that will be used by "undefined" command:
> 
> 	$ time ./scripts/get_abi.pl undefined --debug 8 >foo
> 	real	0m17,189s
> 	user	0m13,940s
> 	sys	0m2,404s
> 
> 	$wc -l foo
> 	18421939 foo
> 
> 	$ cat foo
> 	...
> 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/in_voltage.*_scale_available$)$/
> 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/out_voltage.*_scale_available$)$/
> 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/out_altvoltage.*_scale_available$)$/
> 	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/in_pressure.*_scale_available$)$/
> 	...
> 
> On other words, on my desktop, the /sys match is performing >18M regular 
> expression searches, which takes 6,2 seconds (or 17,2 seconds, if debug is 
> enabled and sent to an area on my nvme storage).

Better, it's down to 10 minutes on my machine now:

	real	10m39.218s
	user	10m37.742s
	sys	0m0.775s

thanks!

greg k-h
