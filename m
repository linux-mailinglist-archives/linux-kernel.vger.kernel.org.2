Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C30315F33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhBJF4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhBJF4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:56:42 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C908CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 21:54:33 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id k25so799794oik.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 21:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qgANdcq5N8qP4d1NY8NNYMErgrK0eAIg2O+i409ixbw=;
        b=Rxu6dLKFRYT7W7JCua9JtUyy9Uo4BoyyBK4oAA9jXFDbDAcYRJCEJ/FVeQSHfRkjre
         FSQqmokfLElcslPJEfBwfgzAVgDajHWMvDmyzMGxfye6rFTMTiLt3mllSt7XMbtqrYhA
         4TkOnXejozQeoXwcRpsDBmBEpsryndjO6CUUBwMSYn9VFpffxTq6oYqaPFXZp8OnzD6+
         4rpEgF8R/e5Oj8+jFPLZBnIgcSNkUxMMaYX2eus6TkaUv+GpFAs7Gf7/SWIyZY3GdltP
         tUZvE981NrZYsODVMFUPmP8a84GPbKQB/PFE512RwHyaueWzTQFy7jK+BM1A6U+M/aKO
         sbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qgANdcq5N8qP4d1NY8NNYMErgrK0eAIg2O+i409ixbw=;
        b=m43GU1P4d+76DDTGG8cnxfPfCYi60Pzoy6Hcd5+VxebjGA0md85EuGlXsaiezvlI9S
         TygsBxA4VFXVgQ13CDywHWA3jvArH6IVnwqXbt+szZngEZqyG9KcB05bY7b/xT0SmOhL
         CI5xtzuVIa4onohvV4iHxfukvLRM+KpEwTi8WyRIraJL4XvOlRjGIyw/CsbrsnyAVJLo
         NzzpF7233dUiSsNkQOZlY3Uy6AR3z9EEP5bBr/IfF7tborBVKxBzhQfH7Z9hBs8bv/d3
         TBqhu3vPvS1NWGedNArj5xCG+CmzjlVM5t6ZOOZU20psoCqqEkOdaqgLED1bHUGGdJHf
         gkPA==
X-Gm-Message-State: AOAM5325SdxgU4YX2HcC14nf/w0QfGaTxjbDnnBr1P4sBrsC/DFysork
        dEmQCb3HVllC/jVuKOWm6+A=
X-Google-Smtp-Source: ABdhPJzg6MxyTy6EwoKHFJTy97j+eEAPfng4T9FriUrlkOim4P9swmQ9JeM/tG2WnA1GEVqn07wDhQ==
X-Received: by 2002:aca:dc56:: with SMTP id t83mr1022824oig.75.1612936472925;
        Tue, 09 Feb 2021 21:54:32 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x201sm251881oix.2.2021.02.09.21.54.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 21:54:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Feb 2021 21:54:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
Message-ID: <20210210055430.GA73123@roeck-us.net>
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218031703.3053753-6-saravanak@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 07:17:03PM -0800, Saravana Kannan wrote:
> Cyclic dependencies in some firmware was one of the last remaining
> reasons fw_devlink=on couldn't be set by default. Now that cyclic
> dependencies don't block probing, set fw_devlink=on by default.
> 
> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> only for systems with device tree firmware):
> * Significantly cuts down deferred probes.
> * Device probe is effectively attempted in graph order.
> * Makes it much easier to load drivers as modules without having to
>   worry about functional dependencies between modules (depmod is still
>   needed for symbol dependencies).
> 
> If this patch prevents some devices from probing, it's very likely due
> to the system having one or more device drivers that "probe"/set up a
> device (DT node with compatible property) without creating a struct
> device for it.  If we hit such cases, the device drivers need to be
> fixed so that they populate struct devices and probe them like normal
> device drivers so that the driver core is aware of the devices and their
> status. See [1] for an example of such a case.
> 
> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This patch breaks nios2 boot tests in qemu. The system gets stuck when
trying to reboot. Reverting this patch fixes the problem. Bisect log
is attached.

It may also break a variety of other boot tests, but with 115 of 430
boot tests failing in -next it is difficult to identify all culprits.

Guenter

---
Bisect log:

# bad: [a4bfd8d46ac357c12529e4eebb6c89502b03ecc9] Add linux-next specific files for 20210209
# good: [92bf22614b21a2706f4993b278017e437f7785b3] Linux 5.11-rc7
git bisect start 'HEAD' 'v5.11-rc7'
# good: [a8eb921ba7e8e77d994a1c6c69c8ef08456ecf53] Merge remote-tracking branch 'crypto/master'
git bisect good a8eb921ba7e8e77d994a1c6c69c8ef08456ecf53
# good: [21d507c41bdf83f6afc0e02976e43c10badfc6cd] Merge remote-tracking branch 'spi/for-next'
git bisect good 21d507c41bdf83f6afc0e02976e43c10badfc6cd
# bad: [30cd4c688a3bcf324f011d7716044b1a4681efc1] Merge remote-tracking branch 'soundwire/next'
git bisect bad 30cd4c688a3bcf324f011d7716044b1a4681efc1
# good: [c43d2173d3eb4047bb62a7a393a298a1032cce18] Merge remote-tracking branch 'drivers-x86/for-next'
git bisect good c43d2173d3eb4047bb62a7a393a298a1032cce18
# bad: [4dd66c506de68a592f2dd4ef64cc9b0d7c0f3117] Merge remote-tracking branch 'usb-chipidea-next/for-usb-next'
git bisect bad 4dd66c506de68a592f2dd4ef64cc9b0d7c0f3117
# good: [29b01295a829fba7399ee84afff4e64660e49f04] usb: typec: Add typec_partner_set_pd_revision
git bisect good 29b01295a829fba7399ee84afff4e64660e49f04
# bad: [dac8ab120e531bf7c358b85750338e1b3d3ca0b9] Merge remote-tracking branch 'usb/usb-next'
git bisect bad dac8ab120e531bf7c358b85750338e1b3d3ca0b9
# good: [678481467d2e1460a49e626d8e9ba0c7e9742f53] usb: dwc3: core: Check maximum_speed SSP genXxY
git bisect good 678481467d2e1460a49e626d8e9ba0c7e9742f53
# good: [5d3d0a61479847a8729ffdda33867f6b3443c15f] Merge remote-tracking branch 'ipmi/for-next'
git bisect good 5d3d0a61479847a8729ffdda33867f6b3443c15f
# bad: [e13f5b7a130f7b6d4d34be27a87393890b5ee2ba] of: property: Add fw_devlink support for "gpio" and "gpios" binding
git bisect bad e13f5b7a130f7b6d4d34be27a87393890b5ee2ba
# good: [b0e2fa4f611bb9ab22928605d5b1c7fd44e73955] driver core: Handle cycles in device links created by fw_devlink
git bisect good b0e2fa4f611bb9ab22928605d5b1c7fd44e73955
# bad: [0fab972eef49ef8d30eb91d6bd98861122d083d1] drivers: core: Detach device from power domain on shutdown
git bisect bad 0fab972eef49ef8d30eb91d6bd98861122d083d1
# bad: [e590474768f1cc04852190b61dec692411b22e2a] driver core: Set fw_devlink=on by default
git bisect bad e590474768f1cc04852190b61dec692411b22e2a
# good: [c13b827927112ba6170bea31c638a8573c127461] driver core: fw_devlink_relax_cycle() can be static
git bisect good c13b827927112ba6170bea31c638a8573c127461
# first bad commit: [e590474768f1cc04852190b61dec692411b22e2a] driver core: Set fw_devlink=on by default
