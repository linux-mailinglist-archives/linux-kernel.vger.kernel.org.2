Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5E8416249
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbhIWPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241995AbhIWPnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E92961029;
        Thu, 23 Sep 2021 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632411692;
        bh=NyG6vfojY+44meObcI6XOgQLJOli3jGUvl+tK4Z6BMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5Bjmp/3pzHwvMHK7fmsUd03ZPHIkciQ7h0H2p4eqsY58D82PJ49l+tlUw6/BDOyz
         vRd4S896aTGHI2JuIzY59aN9jqoK1E+PtDo9X67agsWPDSV0xxCU2z8GwTnS3zHLOK
         S4sRpaqfvQqYFmBfkf8Gq5l5Uyz1lzWDHCbEI19KeepCO47ckVWhvGFjWqIEeQ0AGl
         kDJzV4atoO0tWFn1PW0Mo8/b8R8IXCMPNqQgMeglGQyhTNigpxWw29l20qYlcLOD0Q
         yfBAJgDcJ3FGLm4NOLGMkh6GF1TM3DH5P9QNCKKN1K1ke/o6jGTsgvwoekqf3QsLeW
         wFVO81N3vx0fA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTQqo-000p65-1p; Thu, 23 Sep 2021 17:41:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     #@kernel.org, YUyICHTRdfL8Ul7X@kroah.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/8] (REBASED) get_abi.pl undefined: improve precision and performance
Date:   Thu, 23 Sep 2021 17:41:11 +0200
Message-Id: <cover.1632411447.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YUyICHTRdfL8Ul7X@kroah.com>
References: <YUyICHTRdfL8Ul7X@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As requested, this is exactly the same changes, rebased on the top of
driver-core/driver-core-next.

-

It follows a series of improvements for get_abi.pl. it is on the top of driver-core/driver-core-next.

With such changes, on my development tree, the script is taking 6 seconds to run 
on my desktop:

	$ !1076
	$ time ./scripts/get_abi.pl undefined |sort >undefined_after && cat undefined_after| perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|sort|uniq -c|sort -nr >undefined_symbols; wc -l undefined_after undefined_symbols

	real	0m6,292s
	user	0m5,640s
	sys	0m0,634s
	  6838 undefined_after
	   808 undefined_symbols
	  7646 total

And 7 seconds on a Dell Precision 5820:

	$ time ./scripts/get_abi.pl undefined |sort >undefined && cat undefined| perl -ne 'print "$1\n" if (m#.*/(\S+) not found#)'|sort|uniq -c|sort -nr >undefined_symbols; wc -l undefined; wc -l undefined_symbols

	real	0m7.162s
	user	0m5.836s
	sys	0m1.329s
	6548 undefined
	772 undefined_symbols

Both tests were done against this tree (based on today's linux-next):

	$ https://git.kernel.org/pub/scm/linux/kernel/git/mchehab/devel.git/log/?h=get_abi_undefined-latest

It should be noticed that, as my tree has several ABI fixes,  the time to run the
script is likely less than if you run on your tree, as there will be less symbols to
be reported, and the algorithm is optimized to reduce the number of regexes
when a symbol is found.

Besides optimizing and improving the seek logic, this series also change the
debug logic. It how receives a bitmap, where "8" means to print the regexes
that will be used by "undefined" command:

	$ time ./scripts/get_abi.pl undefined --debug 8 >foo
	real	0m17,189s
	user	0m13,940s
	sys	0m2,404s

	$wc -l foo
	18421939 foo

	$ cat foo
	...
	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/in_voltage.*_scale_available$)$/
	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/out_voltage.*_scale_available$)$/
	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/out_altvoltage.*_scale_available$)$/
	/sys/kernel/kexec_crash_loaded =~ /^(?^:^/sys/.*/iio\:device.*/in_pressure.*_scale_available$)$/
	...

On other words, on my desktop, the /sys match is performing >18M regular 
expression searches, which takes 6,2 seconds (or 17,2 seconds, if debug is 
enabled and sent to an area on my nvme storage).

Regards,
Mauro


Mauro Carvalho Chehab (8):
  scripts: get_abi.pl: Fix get_abi.pl search output
  scripts: get_abi.pl: call get_leave() a little late
  scripts: get_abi.pl: improve debug logic
  scripts: get_abi.pl: Better handle leaves with wildcards
  scripts: get_abi.pl: ignore some sysfs nodes earlier
  scripts: get_abi.pl: stop check loop earlier when regex is found
  scripts: get_abi.pl: precompile what match regexes
  scripts: get_abi.pl: ensure that "others" regex will be parsed

 scripts/get_abi.pl | 109 +++++++++++++++++++++++++++++++--------------
 1 file changed, 76 insertions(+), 33 deletions(-)

-- 
2.31.1


