Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365783BEC9D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhGGQzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:55:55 -0400
Received: from ms.lwn.net ([45.79.88.28]:49252 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhGGQzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:55:53 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4D8712ED;
        Wed,  7 Jul 2021 16:53:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4D8712ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1625676793; bh=NU6pxymzIOHVZOQa1GPt0kRKMecnwHyGTXT88ycy8Fw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IVV5T/wj2sN6OZU/jjAolJnJ/isgZDLVxyh1P/BFD9cw8N+HtYk4tFaXvtplvvceO
         XzI9EyIJV1y1setrZooyvnToG0sjfhimt8nEjEJDgVBeYvmDuTOOhH9PCSIeF/bzEe
         FXC1v5fXN1sCosYrj9gHVwQnjZ0fbtwevPZQMFxMi2K9Ue7D9ML26latKb6XAaWvVb
         ZNmRl0wBxhYs43c//t4Cbxl/VFW592QSMQL9ImJMv8g+qacJNVWgTb0xenXnfN3H9+
         Dtn7xX4XuO/5aekErT0TxhThT/Hp9YS9a9wqoEfUDD4wYFNR2fdWLiQHc/jCjQ2P6t
         O9dTsynxFcqzw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Rahul T R <r-ravikumar@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] scripts/spdxcheck.py: Lets strictly read license files
 in utf-8
In-Reply-To: <87h7h6qz0w.ffs@nanos.tec.linutronix.de>
References: <20210703012128.27946-1-nm@ti.com>
 <87h7h6qz0w.ffs@nanos.tec.linutronix.de>
Date:   Wed, 07 Jul 2021 10:53:12 -0600
Message-ID: <87y2aiukuf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Nishanth,
> On Fri, Jul 02 2021 at 20:21, Nishanth Menon wrote:
>> Commit bc41a7f36469 ("LICENSES: Add the CC-BY-4.0 license")
>> unfortunately introduced LICENSES/dual/CC-BY-4.0 in UTF-8 Unicode text
>
> Sigh. Why are people adding such things w/o running this script in the
> first place.

I have a guess on that front ... there is nothing in our documentation
that says anybody should run it, and the script itself gives no
indication of what it does, when it should be run, or how to run it.
That might just reduce uptake a little bit...:)

I increasingly believe that anything we add to scripts/ should start
with a "usage" header describing why it exists and how to make it do its
thing.  That would be a welcome addition to spdxcheck.py.  Adding
something to Documentation/process/license-rules.html would be a nice
bonus.

Thanks,

jon
