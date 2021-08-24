Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF83F6084
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhHXOhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:37:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237745AbhHXOhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:37:35 -0400
Received: from zn.tnic (p200300ec2f11440070ccc1d7a1cb5edc.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:70cc:c1d7:a1cb:5edc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F33D41EC030F;
        Tue, 24 Aug 2021 16:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629815805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfoMF6SGFqSHpHldUajmgBFLEl1tYqX+l2KPXDR9t9E=;
        b=Qcu1fYJqbKqJ7kYnHDZVTAVyluKJX5rdTFNozSQZEZpJbShdBVDrSsV0tUagP5ekFGm1/4
        oiAZDxtrza60ZKEx5eH+f45J4eP4mstqFQt50EHDeC8FmmiYIVMu1xTeb724y+1L+24dj/
        62OLBED0ZTdaiz5THH119s4sjXcmhOk=
Date:   Tue, 24 Aug 2021 16:37:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Fix build with missing
 pm_suspend_target_state module export
Message-ID: <YSUEIriLpcQQYy2k@zn.tnic>
References: <YSP6Lv53QV0cOAsd@zn.tnic>
 <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic>
 <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
 <YSQJL0GBzO2ulEpm@zn.tnic>
 <CADnq5_N0q8Rfm++O3jK6wcbePxg_Oj3=Xx9Utw60npKrEsSp8A@mail.gmail.com>
 <YSS/F9kcQcRKlNJ5@zn.tnic>
 <94ff5309-f71a-6107-01e8-8d7d544dd4e1@amd.com>
 <YST2u5UznQjMKulE@zn.tnic>
 <1bb0baef-7924-98ab-b125-aa3c2ac405d4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bb0baef-7924-98ab-b125-aa3c2ac405d4@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 07:22:46PM +0530, Lazar, Lijo wrote:
> 'pm_suspend_target_state' is only available when CONFIG_PM_SLEEP
> is set/enabled.

pm_suspend_target_state is available only when CONFIG_SUSPEND is
enabled. The extern thing is only a forward declaration.

> OTOH, when both SUSPEND and HIBERNATION are not set,
> PM_SLEEP is not set, so this variable cannot be used.

And it will not be used.

> ../drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: In function
> ‘amdgpu_acpi_is_s0ix_active’:
> ../drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:1046:11: error:
> ‘pm_suspend_target_state’ undeclared (first use in this function); did you
> mean ‘__KSYM_pm_suspend_target_state’?
>     return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
>            ^~~~~~~~~~~~~~~~~~~~~~~
>            __KSYM_pm_suspend_target_state

That looks like the .config didn't have CONFIG_SUSPEND enabled.

> Also use shorter IS_ENABLED(CONFIG_foo) notation for checking the
> 2 config symbols.

What shorter notation?

> So it does look like that error can be extracted as well in some
> config.

Yah, when CONFIG_SUSPEND=n.

> Well, now it doesn't seem to be a better one. The original one checked
> both.

I don't see a reason for checking both.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
