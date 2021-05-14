Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54457380BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhENOjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:39:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41236 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232520AbhENOja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:39:30 -0400
Received: from zn.tnic (p200300ec2f0b2c001b1c8d89a706f2ca.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2c00:1b1c:8d89:a706:f2ca])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 202691EC0537;
        Fri, 14 May 2021 16:38:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621003098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=56UXFskDRro/v9sxWzMI7cd2EQdQ1g/Ab6XrYnboPHY=;
        b=l6ulfs7RoVDOCFi04UqltMLII+y7afq7VEDMQQhzJJPZPFDp6UHaD/pm7/7eODbSlyEhaI
        IK0IZk+2mBuk8WS0N5i28eS2uqsDJ2kq2vKTIoxz1v1fzTBaYZyhaPeh+NPIT3TnQc1gwB
        opRwOpFGOAq43qMhE700hrizvFOpRfs=
Date:   Fri, 14 May 2021 16:38:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Joshi, Mukul" <Mukul.Joshi@amd.com>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJ6LVqYTwQHReffu@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <DM4PR12MB5263A719B11C6DF8EF9F3A4BEE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJ4hS/SJYmCC9Rpd@zn.tnic>
 <DM4PR12MB52634855954DCE456D244288EE509@DM4PR12MB5263.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR12MB52634855954DCE456D244288EE509@DM4PR12MB5263.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 01:06:33PM +0000, Joshi, Mukul wrote:
> We have RAS functionality in other ASICs that is not dependent on
> CONFIG_X86_MCE_AMD. So, I don't think we would want to do that just
> for one ASIC.

Lemme try again: you said that those errors do get reported through a
deferred interrupt. Which is likely amd_deferred_error_interrupt().

If it is that interrupt and you don't have CONFIG_X86_MCE_AMD enabled,
then you won't get any errors reported and your RAS functionality will
simply sit there inactive.

So if that above is true - something to which I'm still not getting
an answer but maybe one fine day... - so if that above is true, your
RAS functionality *needs* CONFIG_X86_MCE_AMD to be enabled in order to
*actually* function.

So you *must* make your RAS functionality depend on CONFIG_X86_MCE_AMD
- otherwise no deferred interrupts and no errors reported. It is that
simple.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
