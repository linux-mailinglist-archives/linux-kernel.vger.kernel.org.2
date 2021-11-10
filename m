Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3644BCF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhKJIhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhKJIg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:36:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310EDC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:34:12 -0800 (PST)
Received: from zn.tnic (p200300ec2f111e004e08fd5d8baa7a9c.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1e00:4e08:fd5d:8baa:7a9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DEA101EC0567;
        Wed, 10 Nov 2021 09:34:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636533250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SPZmtZcn45Qf/3yC2FzsLNHIF0feCAyEo3hwMKuUAV8=;
        b=ONWoLaWOjvvhzyhXot+EKqczHNF73MO9bnkB7fJ9q9RLfhBy4fQaWDFVNgYy/UMApazUmD
        XPl+A2ttQ54n41pG5oxwMRh4AsgCDxSE2XZ8sUPKZyiHhMKv2y4v7rf7SP3SDEfJScU1TK
        NJT2upULS0+QJT/ybkE9NOqWm+jR99w=
Date:   Wed, 10 Nov 2021 09:34:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Message-ID: <YYuD+jRPUQrsmAkD@zn.tnic>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
 <YYP4fAgKSh4bVvgD@zn.tnic>
 <OSBPR01MB20370518F9296BA4302FF7DC80919@OSBPR01MB2037.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OSBPR01MB20370518F9296BA4302FF7DC80919@OSBPR01MB2037.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 02:17:43AM +0000, tarumizu.kohei@fujitsu.com wrote:
> The following performance improvements have been reported for some
> Intel processors.
> https://github.com/xmrig/xmrig/issues/1433#issuecomment-572126184

Yes, I know about that use case.

> For these reasons, we would like to add this interface to the
> upstream kernel.

So put all those justifications at the beginning of your 0th message
when you send a patchset so that it is clear to reviewers *why* you're
doing this. The "why" is the most important - everything else comes
after.

> > I'm not sure about a wholly separate drivers/hwpf/ - it's not like there are
> > gazillion different hw prefetch drivers.
> 
> We created a new directory to lump multiple separate files into one
> place. We don't think this is a good way. If there is any other
> suitable way, we would like to change it.

Well, how many prefetcher drivers will be there?

On x86 there will be one per vendor, so 2-3 the most...

Also, as dhansen points out, we have already

  /sys/devices/system/cpu/cpu*/cache

so all those knobs belong there on x86.

Also, I think that shoehorning all these different cache architectures
and different prefetcher knobs which are available from each CPU, into a
common sysfs hierarchy is going to cause a lot of ugly ifdeffery if not
done right.

Some caches will have control A while others won't - they will have
control B so people will wonder why control A works on box B_a but not
on box B_b...

So we have to be very careful what we expose to userspace because it
becomes an ABI which we have to support for an indefinite time.

Also, if you're going to give the xmrig example, then we should involve
the xmrig people and ask them whether the stuff you're exposing to
userspace is good for their use case.

And so on and so on...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
