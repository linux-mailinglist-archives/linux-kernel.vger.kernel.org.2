Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36373803F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhENHHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:07:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53954 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhENHG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:06:58 -0400
Received: from zn.tnic (p200300ec2f0b2c00f343c5c4aba7bf62.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2c00:f343:c5c4:aba7:bf62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53A011EC04DA;
        Fri, 14 May 2021 09:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620975946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ksvjS+87xkTe7D27QtQxqyp950apFsTl5xWaEGXi3kc=;
        b=qhnrjx2G/KZbOulEdl4/k8AjV0q1t3cStG639U1CPcyXvIcykEZabxBIxbDnMwIBRzYxQJ
        S0LV/8jrTZmKnQfyHo3SAUtpT20f9XKZPDzwX0XwRbkyTXwt48kwrthR+Cfo4mhUgAICel
        abDNIIwC6BEOp0iaJUzHpLZ0G4FBWmw=
Date:   Fri, 14 May 2021 09:05:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Joshi, Mukul" <Mukul.Joshi@amd.com>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJ4hS/SJYmCC9Rpd@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <DM4PR12MB5263A719B11C6DF8EF9F3A4BEE519@DM4PR12MB5263.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5263A719B11C6DF8EF9F3A4BEE519@DM4PR12MB5263.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 11:10:34PM +0000, Joshi, Mukul wrote:
> That's probably not the best example to look at.

Oh, it is the *perfect* example but...

> smca_get_long_name() is used in drivers/edac/mce_amd.c and this file
> doesn't get compiled when CONFIG_X86_MCE_AMD is not defined.
>
> And amdgpu driver has no dependency on CONFIG_X86_MCE_AMD.

... maybe this will make you see it the right way: how much of the
amdgpu RAS functionality you're adding, is going to even function
without CONFIG_X86_MCE_AMD?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
