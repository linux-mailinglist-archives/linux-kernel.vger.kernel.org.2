Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09BD32BCEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447516AbhCCPD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843081AbhCCKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:25:27 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C24DC08EE15
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:21:07 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4A7F422235;
        Wed,  3 Mar 2021 11:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614766865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ovRaT0cMQJATpmHeLIaL4rd4D7WfXonnr8fXYuL68LI=;
        b=A/JaY8uMOAVb7W0O7+LyP0NbMzhPaJRQVPcIQ5GpCdDJIs6kxd65sYfQGor5d0bS0lRXeK
        C7o8Suq7krnQ3BkRkvVtNfB+PnJtFq3h56QZqN1q36r/xtdqZV6dcNzC7UebyFFKxhagfG
        xfGOief5rEfOTled6yJOh1V7MYcrlAM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Mar 2021 11:21:05 +0100
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
In-Reply-To: <CAGETcx8hAX2iv3KakM+pXeBPu_RFsUFLBBZvwDVxG95mAY=woA@mail.gmail.com>
References: <20210302211133.2244281-1-saravanak@google.com>
 <b2dd44c2720fb96093fc4feeb64f0f4e@walle.cc>
 <CAGETcx_xCpid3QW0gQJWLL6ZfT-VJJq-SYX4tG09GRQWucw=qg@mail.gmail.com>
 <CAGETcx__oG2XrQ8RwZ57cVgV+Ukfni4qUQCe11kbL8E1U+4a_g@mail.gmail.com>
 <12f31a46e8dc3f0e53c1a7440a4ce087@walle.cc>
 <CAGETcx8hAX2iv3KakM+pXeBPu_RFsUFLBBZvwDVxG95mAY=woA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <85f883921c73a9ac77b8263b958a5c71@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-03 10:28, schrieb Saravana Kannan:
> On Wed, Mar 3, 2021 at 12:59 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2021-03-02 23:47, schrieb Saravana Kannan:
>> > On Tue, Mar 2, 2021 at 2:42 PM Saravana Kannan <saravanak@google.com>
>> > wrote:
>> >>
>> >> On Tue, Mar 2, 2021 at 2:24 PM Michael Walle <michael@walle.cc> wrote:
>> >> >
>> >> > Am 2021-03-02 22:11, schrieb Saravana Kannan:
>> >> > > I think Patch 1 should fix [4] without [5]. Can you test the series
>> >> > > please?
>> >> >
>> >> > Mh, I'm on latest linux-next (next-20210302) and I've applied patch 3/3
>> >> > and
>> >> > reverted commit 7007b745a508 ("PCI: layerscape: Convert to
>> >> > builtin_platform_driver()"). I'd assumed that PCIe shouldn't be working,
>> >> > right? But it is. Did I miss something?
>> >>
>> >> You need to revert [5].
>> >
>> > My bad. You did revert it. Ah... I wonder if it was due to
>> > fw_devlink.strict that I added. To break PCI again, also set
>> > fw_devlink.strict=1 in the kernel command line.
>> 
>> Indeed, adding fw_devlink.strict=1 will break PCI again. But if
>> I then apply 1/3 and 2/3 again, PCI is still broken. Just to be clear:
>> I'm keeping the fw_devlink.strict=1 parameter.
> 
> Thanks for your testing! I assume you are also setting fw_devlink=on?

I've applied patch 3/3 and added nothing to the commandline, so yes.

> Hmmm... ok. In the working case, does your PCI probe before IOMMU? If
> yes, then your results make sense.

Yes that was the conclusion last time. That the probe is deferred and
the __init section is already discarded when there might a second
try of the probe.

So I guess, Patch 1/3 and Patch 2/3 doesn't fix that and the drivers
still need to be converted to builtin_platform_driver(), right?

> If your PCI does probe after IOMMU and uses IOMMU, then I'm not sure
> what else could be changing the order of the device probing. In any
> case, glad that the default case works and we have a fix merged even
> for .strict=1.
> 
> -Saravana

-michael
