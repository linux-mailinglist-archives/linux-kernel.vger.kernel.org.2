Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5063339668
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhCLS1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:27:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36078 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233120AbhCLS05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:26:57 -0500
Received: from zn.tnic (p200300ec2f09530069bf3b114cad3bdc.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5300:69bf:3b11:4cad:3bdc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B65C1EC046C;
        Fri, 12 Mar 2021 19:26:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615573616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0NLLFaOfDBcU+Z/lo+5uOJvhFOGul6fIx8p8zXWhzMY=;
        b=XVi46yLcjUEYhsSD4LNUAePLsKfRybnWr9/dVgM/EHHapADbPkXZ/4KysPA7E1T4NeF0eZ
        18JKFAYa6krp4nkawgAbyuF58aPqBUImdcyLC5AM2JjK6lxFQTpNu/wbDbLSvjZoACJ/wL
        cw8emlTOvhUTnZLoX2aT6EuzSlKaDFY=
Date:   Fri, 12 Mar 2021 19:26:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        lkml <linux-kernel@vger.kernel.org>, x86-ml <x86@kernel.org>
Subject: Re: amdgpu, WARNING: CPU: 12 PID: 389 at
 arch/x86/kernel/fpu/core.c:129 kernel_fpu_begin_mask+0xd5/0x100
Message-ID: <20210312182654.GD22098@zn.tnic>
References: <20210312181511.GC22098@zn.tnic>
 <MN2PR12MB4488E771571F247B1E3ECEF3F76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488E771571F247B1E3ECEF3F76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:20:25PM +0000, Deucher, Alexander wrote:
> Should be fixed with these patches:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15e8b95d5f7509e0b09289be8c422c459c9f0412
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=680174cfd1e1cea70a8f30ccb44d8fbdf996018e

Looks like it. Lemme know if I should run them explicitly now or
alternatively, I'll wait until they land in -rc3. They'll get tested
eventually as that machine is a test box...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
