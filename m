Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC35445615
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhKDPPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:15:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhKDPPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:15:46 -0400
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7BC171EC03AD;
        Thu,  4 Nov 2021 16:13:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636038787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uIC4IVhy1UxvdSJhwUeavCRqzoU59YQQWy5qdQVSdL4=;
        b=WsrDMDJbvl65pT/ZD9DT+voSOuUCpaJvTC51nMPTefP9qMnh9kiRKfuhiZbyWVtOd3lxCL
        n+FnmxLyOm6PqbL3S+atKGdMAYFnM4Vx9wV84m0DkuIo+aixvD0+dXIIiOl5DJJMCcb2pK
        XeKOk0vr1Lwc3244v6/YP4iZB1r81lA=
Date:   Thu, 4 Nov 2021 16:13:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Message-ID: <YYP4fAgKSh4bVvgD@zn.tnic>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:21:17PM +0900, Kohei Tarumizu wrote:
> This patch series add hardware prefetch driver register/unregister
> function. The purpose of this driver is to provide an interface to
> control the hardware prefetch mechanism depending on the application
> characteristics.

This is all fine and dandy but what I'm missing in this pile of text -
at least I couldn't find it - is why do we need this in the upstream
kernel?

Is there some real-life use case that would benefit from software
fiddling with prefetchers or is this one of those, well, we have those
controls, lets expose them in the OS?

IOW, you need to sell this stuff properly first - then talk design.

>  create mode 100644 drivers/hwpf/Kconfig
>  create mode 100644 drivers/hwpf/Makefile
>  create mode 100644 drivers/hwpf/fujitsu_hwpf.c
>  create mode 100644 drivers/hwpf/hwpf.c
>  create mode 100644 drivers/hwpf/intel_hwpf.c
>  create mode 100644 include/linux/hwpf.h

I'm not sure about a wholly separate drivers/hwpf/ - it's not like there
are gazillion different hw prefetch drivers.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
