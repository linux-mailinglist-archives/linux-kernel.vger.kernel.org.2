Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0C349B13
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 21:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhCYUhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 16:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhCYUhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA1E061A2A;
        Thu, 25 Mar 2021 20:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616704623;
        bh=38UUAS8/YRAAI31500fuU6AXi4kkY0DXiEk73cRKSh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TGJ1W29MUEJmAn4uSZgxJzNXMin3Njkb5ZH5ZS++OpXoLHzYsv5KCgiu2NXgrNWQy
         kzBrZoMGqTSxFqudwnxaJMYsBZ4aMz8raziIjeTmjZRvnDV8uH124Ekf8hQ5hZxDHh
         4A6UAR3W9/aCoCWDIKlha6L36ZYaFTVCTAD+Zb0wZ/s0nxDKK9Zv2OsGb0ZQtlygbS
         t3a7P+GOU7jQRsxfyz1YoLHx3/kTTFj7Q4F3QTLWHRtsE5U3tmYSs0ixrrbPurcVPo
         hUFHki0nvN3WAQgwud5XyDxu5o6zGR1ORrZUSpk3WWn4vp+wjaEnp2ZqwQCiDm/8J+
         pq82w1Xk0CGhw==
Date:   Thu, 25 Mar 2021 21:36:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 0/7] Fix some issues at get_abi.pl script
Message-ID: <20210325213659.1ae03794@coco.lan>
In-Reply-To: <87lfabys5h.fsf@meer.lwn.net>
References: <cover.1616668017.git.mchehab+huawei@kernel.org>
        <87lfabys5h.fsf@meer.lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Mar 2021 13:01:14 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > This series replace this patch:
> > 	https://lore.kernel.org/linux-doc/20210324191722.08d352e4@coco.lan/T/#t
> >
> > It turns that there were multiple bugs at the get_abi.pl code that
> > create cross-references.
> >
> > Patches 1 to 6 fix those issues, and should apply cleanly on the top of
> > the docs tree (although I tested against next-20210323).
> >
> > Patch 7 is optional, and independent from the other patches. It is meant
> > to be applied against akpm's tree.  It makes the description (IMHO) 
> > clearer, while producing cross references for the two mentioned symbols.  
> 
> So perhaps this is the best solution to the problem, but I must confess
> to not being entirely happy with it.  get_abi.pl is becoming another
> unreadable perlpile like kerneldoc, and this makes it worse.  Doing RST
> parsing there seems particularly unwelcome.

Nah, it is not that complex ;-) 
It has 628 lines of code; kernel-doc has 2488. It is 1/4 the size of
kernel-doc :-D

Btw, 20 lines can be removed from it, if we drop support for --no-rst-source. 
I almost dropped it this time :-)

Ah, the entire code that outputs the rst description and does the
xref has just 34 lines (with 5 lines with comments and 5 blank lines).

It is not much, and some cleanups could be done to make it a little
shorter.

Most of the script complexity is actually at the parsing part. The
thing is that the ABI files are somewhat free-style: some files 
don't strictly follow the format, which requires some extra steps in
order to cope with some "soft" violations, as well as to report
problems when the violation is more severe.

> Should the cross-reference generation, it now occurs to me, be done in
> the automarkup module instead?  Then there's no need to interpret RST,
> and we'd get cross-references throughout the kernel docs rather than in
> just the ABI stuff.  Am I completely out to lunch here?

Yes, I guess we can move the Xref code to automarkup some day,
that is if we can ensure that get_abi.pl will run before automarkup.

There's currently an issue, though. We need first to get rid of those
duplicated symbols:

	Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:0  Documentation/ABI/testing/sysfs-bus-iio:395
	Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:1  Documentation/ABI/testing/sysfs-bus-iio:396
	Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:2  Documentation/ABI/testing/sysfs-bus-iio:397
	Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:3  Documentation/ABI/testing/sysfs-bus-iio:398
	Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:4  Documentation/ABI/testing/sysfs-bus-iio:399
	Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:5  Documentation/ABI/testing/sysfs-bus-iio:400
	Warning: /sys/bus/iio/devices/iio:deviceX/in_count0_preset is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:100  Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:0
	Warning: /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8:2  Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:8
	Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:0  Documentation/ABI/testing/sysfs-bus-iio:600
	Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:36  Documentation/ABI/testing/sysfs-bus-iio:589
	Warning: /sys/bus/iio/devices/iio:deviceX/out_currentY_raw is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als:43  Documentation/ABI/testing/sysfs-bus-iio-health-afe440x:38
	Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:0  Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:0
	Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:1  Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:1
	Warning: /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-distance-srf08:0  Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935:8
	Warning: /sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  Documentation/ABI/testing/sysfs-bus-iio:45
	Warning: /sys/class/backlight/<backlight>/l1_daylight_max is defined 2 times:  Documentation/ABI/testing/sysfs-class-backlight-adp8860:12  Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870:4
	Warning: /sys/class/leds/<led>/hw_pattern is defined 2 times:  Documentation/ABI/testing/sysfs-class-led-trigger-pattern:14  Documentation/ABI/testing/sysfs-class-led-driver-sc27xx:0
	Warning: /sys/class/leds/<led>/repeat is defined 2 times:  Documentation/ABI/testing/sysfs-class-led-trigger-pattern:28  Documentation/ABI/testing/sysfs-class-led-driver-el15203000:0
	Warning: /sys/kernel/iommu_groups/reserved_regions is defined 2 times:  Documentation/ABI/testing/sysfs-kernel-iommu_groups:15  Documentation/ABI/testing/sysfs-kernel-iommu_groups:27

Right now, get_abi.pl has some logic to allow multiple "What:" with
identical strings. It does that by adding extra random characters at
the end of the reference name, and keeping track of them on some
internal hash tables.

As the hash table is local to the script, an external script won't be
able to handle it.

Once those gets fixed, we can consider moving the xref code to
automarkup (although I suspect that this will be a way slower).

Thanks,
Mauro
