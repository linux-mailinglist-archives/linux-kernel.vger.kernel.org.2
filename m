Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865E8424CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbhJGGA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:00:56 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:43725 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhJGGAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:00:54 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BF70552;
        Wed,  6 Oct 2021 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633586341;
        bh=nOgEj6oE8gbBMFlEcbv3hvgl9GnR2Jao6u7dMvqj47o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfekusUzY3U/Leb1iudmihAaiQdmwfYa52eLz/QBXZHd8k/nJOpAcWulEHgwbMKXA
         cESc7KK1Ur/EaGyfx31afrYv6s9L7mdlXgnOPhZgy/6jpFqylUc1ieDFLzmc2h9tcj
         2a21j3E/T0MnYNNwTrIx1g4DOQXpoflM4ohuTGh0=
Date:   Wed, 6 Oct 2021 22:58:59 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] sysfs: add sysfs_remove_bin_file_self() function
Message-ID: <YV6Moz5eCsf6ZZWb@hatter.bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-2-zev@bewilderbeest.net>
 <YV6EVcKUQj5DNiXZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YV6EVcKUQj5DNiXZ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 10:23:33PM PDT, Greg Kroah-Hartman wrote:
>On Wed, Oct 06, 2021 at 05:09:46PM -0700, Zev Weiss wrote:
>> This is simply the bin_attribute analog to sysfs_remove_file_self().
>
>No, no binary sysfs file should be triggering a remove.
>
>binary sysfs files are "pass-through-only" from userspace to hardware,
>the kernel should not be even knowing what is read/written to them.
>
>What do you think this is needed for?
>

So, I initially set out to be able to activate/deactivate specific DT 
nodes at runtime by using the device-tree "reserved" status as defined 
in the spec (but not currently used anywhere in the kernel) to mean 
essentially "create a device for this but don't bind a driver to it" 
(leaving it to userspace to invoke bind/unbind or similar), and added 
initial support for the specific driver I'm concerned with at the moment 
(aspeed-smc) -- that was the previous patch series linked in the cover 
letter of this one.

In the discussion of that series, Rob suggested as an alternate 
approach:

> Another possibility is making 'status' writeable from userspace. It is
> just a sysfs file.

That seemed sort of appealing to me, and this seemed like the most 
obvious way to go about implementing it.  Given that DT properties are 
binary attributes, I gather you'd consider that a non-starter though?


Zev

