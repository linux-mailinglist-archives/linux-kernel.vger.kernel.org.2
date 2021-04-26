Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2736B211
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhDZLKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:10:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52726 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232878AbhDZLKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:10:17 -0400
Received: from zn.tnic (p200300ec2f074a004d23913e27e5ccbf.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:4a00:4d23:913e:27e5:ccbf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E21441EC01A8;
        Mon, 26 Apr 2021 13:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619435374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CHC8NRKX4UYeAuEI103O40JwXweNlUCZHygYxtOvqKM=;
        b=Shl58S8Plz4TTJCXz2c6hxIdMB1rariZgaIpeB7MY+eD5VTYbu5gnp+rdMs2+Ats/4J1cv
        wV3eVE4FGpMBV2lbbNPJDNYBxgub4+S5Pdbhi4uGTAucb2JEGxSLFu561vBsHbG12Cnk5c
        DDTv4WC6wnlqn4Kdk2n59JgHIc6mHWQ=
Date:   Mon, 26 Apr 2021 13:09:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     xuyihang <xuyihang@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/apic: Force logial APIC ID in range from 0 to 8
Message-ID: <YIafakDQEU7Fu26y@zn.tnic>
References: <20210423075324.133463-1-xuyihang@huawei.com>
 <87czulwg55.ffs@nanos.tec.linutronix.de>
 <7ceb2fd5f8b3453b8ff5cf47e998ff03@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ceb2fd5f8b3453b8ff5cf47e998ff03@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 02:09:59AM +0000, xuyihang wrote:
> Hi, I realize this problem only occur on kernel 3.10, and not on 4.18. Which leads me to this patch
> (https://lore.kernel.org/patchwork/patch/855026/). flat_init_apic_ldr should not be called in this case.
> 

This is not the first time people from Huawei are sending patches for
some old kernel to the *upstream* kernel mailing list.

You do know that we take patches only for the *upstream* kernel old
kernels are someone else's problem, right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
