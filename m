Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423C941AEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbhI1M3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240528AbhI1M3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:29:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BB6160F21;
        Tue, 28 Sep 2021 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632832063;
        bh=c3sbUhnBR2XdRVf9xR/ijhK7PEwq5FoMQnG2dvdQTak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WDAynM0HmXvjAWyY9K1FKzSM+UIU4HihEqsU6Eqbj/0LBYPNDMOzSPhQXc9VFnGS5
         a5an7KgNuBk0KX+8uLYQP95doIXiLtbSR/xSAHP5v4C33CHlFpP75TUbi1QlLBoO0v
         L3pKhw5PWx3cuPfKO9zgPeshCA7YTMGS3NfAGhkk8OeeLITwrRWGD5GNyBbwSqmQvl
         xbLqrdLqaLYhtNGB36wstmoeaVUh0img6tWSAlU1GrQUrAlF2gda5dcv8H5Mb9wCd9
         /HigAdBCz3JmZRvBJbttfatkugnHPD+lfDB9OTk+N4Zg/uDp8W2cX2Nxrqc1q1HNWB
         tUO3V+SduXsfQ==
Date:   Tue, 28 Sep 2021 14:27:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/3] get_abi: improve message output and fix a
 regression
Message-ID: <20210928142739.2ffe380b@coco.lan>
In-Reply-To: <YVL2trHQzxG59nXf@kroah.com>
References: <cover.1632823172.git.mchehab+huawei@kernel.org>
        <YVL2trHQzxG59nXf@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 28 Sep 2021 13:04:22 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Tue, Sep 28, 2021 at 12:14:01PM +0200, Mauro Carvalho Chehab wrote:
> > Hi Greg,
> > 
> > As promised on
> > 
> > 	https://lore.kernel.org/lkml/20210928120304.62319fba@coco.lan/T/#u
> > 
> > I'm adding progress info when  get_abi.pl is checking for undefined ABI symbols
> > on patches 1 and 2.
> > 
> > That will help not only to identify what is causing delays on the script, but also
> > to notify the user that processing it could take some time on some systems.
> > 
> > If you run it on your big server with:
> > 
> >   scripts/get_abi.pl undefined 2>logs
> > 
> > The "logs" file will contain timestamps relative to the time the script started to
> > do the regex matches for sysfs files. It should be printing one line every
> > time the progress completes 1% or one second after the last progress output.  
> 
> Adding more debugging and tweaking the script a bit to show the file it
> is about to check, not the one it finished checking,

Feel free to modify the script and add such debug/tweaks if you find
it useful. 

> I got the following
> debug output that seems to pinpoint the problem file.
> 
> The sysfs file that is causing problems is:
> 	/sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap
> 
> and here's some debugging output for the regex it needs to search for
> this:
> 
> /sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
> /sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
> /sys/devices/pci0000:40/0000:40:00.2/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/
> /sys/devices/pci0000:40/0000:40:07.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
> /sys/devices/pci0000:40/0000:40:07.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
> /sys/devices/pci0000:40/0000:40:07.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:02/device:7a/physical_node/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:02/device:7a/physical_node/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:02/device:7a/physical_node/iommu/ivhd1/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/
> /sys/devices/pci0000:40/0000:40:01.3/0000:4a:00.0/0000:4b:0a.0/0000:50:00.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/amd\-iommu/cap$)$/
> /sys/devices/pci0000:40/0000:40:01.3/0000:4a:00.0/0000:4b:0a.0/0000:50:00.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/class/iommu/.*/intel\-iommu/cap$)$/
> /sys/devices/pci0000:40/0000:40:01.3/0000:4a:00.0/0000:4b:0a.0/0000:50:00.0/iommu/amd-iommu/cap =~ /^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/

Hmm... interesting. Perhaps the problem is on regexes like this:

	/^(?^:^/sys/devices/pci.*.*.*.*\:.*.*/0000\:.*.*\:.*.*..*/dma/dma.*chan.*/quickdata/cap$)$/

Which actually represents this What:
	/sys/devices/pciXXXX:XX/0000:XX:XX.X/dma/dma<n>chan<n>/quickdata/cap

The script could have done a better job escaping "." character on
it (but that is not too trivial) and grouping altogether ".*" 
repetitions, although, in this specific case, probably the best
regex would be, instead:

	/sys/devices/pci[\da-f:\.]+/dma/dma\d+chan\d+/quickdata/cap

One possible long-term solution would be to directly use regexes 
directly on "What" fields inside Documentation/ABI, but on some parts
this would require some changes, like, for instance:

	/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/kone/roccatkone<minor>/weight

Ok, we could likely use capture groups like:

	(?<NAME>pattern)

but IMO that would make it a lot harder to be understood by humans.


> And sometimes this thing finishes in 20 seconds, and others, many many
> minutes.  It's not deterministic at all, which is odd.  Is the sysfs
> tree being sorted so that this should always have the same search order?

No, because it uses a lot of hashes in order to speed it up. Yet,
it shouldn't be hard - nor it would significantly affect the processing
time - to make it more deterministic. See the enclosed path.

> Anyway, I've applied this series as well, this helps in finding the
> problems :)

Thanks!

> Note, I can provide an off-list tarball of /sys/ if that would help in
> debugging anything on your end.

Yeah, that can help. Feel free to send it to me.

Btw, I just got an arm64 server with 128 CPUs for testing. I'm trying
to allocate also a big x86 server here, but I'm not sure if it is AMD or
Intel.

Thanks,
Mauro

[PATCH] scripts: get_abi.pl: make undefined search more deterministic

Sort keys on hashes during undefined search, in order to
make the script more deterministic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 841d889747c0..d32dcd7cca5d 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -775,6 +775,8 @@ sub check_undefined_symbols {
 	my $next_i = 0;
 	my $start_time = times;
 
+	@files = sort @files;
+
 	my $last_time = $start_time;
 
 	# When either debug or hint is enabled, there's no sense showing
@@ -909,16 +911,16 @@ sub undefined_symbols {
 		}
 	}
 	# Compile regexes
-	foreach my $l (keys %leaf) {
+	foreach my $l (sort keys %leaf) {
 		my @expr;
-		foreach my $w(split /\xac/, $leaf{$l}->{what}) {
+		foreach my $w(sort split /\xac/, $leaf{$l}->{what}) {
 			push @expr, qr /^$w$/;
 		}
 		$leaf{$l}->{expr} = \@expr;
 	}
 
 	# Take links into account
-	foreach my $link (keys %aliases) {
+	foreach my $link (sort keys %aliases) {
 		my $abs_file = $aliases{$link};
 		graph_add_link($abs_file, $link);
 	}

