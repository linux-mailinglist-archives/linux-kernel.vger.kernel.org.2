Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82C63F5F57
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhHXNkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhHXNkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:40:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86716C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 06:39:39 -0700 (PDT)
Received: from zn.tnic (p200300ec2f11440070ccc1d7a1cb5edc.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:70cc:c1d7:a1cb:5edc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90B541EC0301;
        Tue, 24 Aug 2021 15:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629812373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KhZnrCbHmTF3ENFK7VChdGhm2Al0V/hwScF3WSxjTeA=;
        b=loOgUEuoOhmwqRJAWfu86mkJCl/utqbe5xx1JCKrpqPue6MtGZsaieMkbJmYPVVZ+tuTdh
        4ETMeJaseeWgZ4ubbOXnCDi6aTt7qTdpIgWN0AjXsSouGaP3kXkALiNwSKOhpnK6evW6us
        iAqyPNpiVS1GYZ5a3T5LRZ6DtMStGdM=
Date:   Tue, 24 Aug 2021 15:40:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Fix build with missing
 pm_suspend_target_state module export
Message-ID: <YST2u5UznQjMKulE@zn.tnic>
References: <YSP6Lv53QV0cOAsd@zn.tnic>
 <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic>
 <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
 <YSQJL0GBzO2ulEpm@zn.tnic>
 <CADnq5_N0q8Rfm++O3jK6wcbePxg_Oj3=Xx9Utw60npKrEsSp8A@mail.gmail.com>
 <YSS/F9kcQcRKlNJ5@zn.tnic>
 <94ff5309-f71a-6107-01e8-8d7d544dd4e1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94ff5309-f71a-6107-01e8-8d7d544dd4e1@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 06:38:41PM +0530, Lazar, Lijo wrote:
> Without CONFIG_PM_SLEEP and with CONFIG_SUSPEND

Can you even create such a .config?

> I remember giving a reviewed-by for this one, looks like it never got in.
> https://www.spinics.net/lists/amd-gfx/msg66166.html

A better version of that one got in:

5706cb3c910c ("drm/amdgpu: fix checking pmops when PM_SLEEP is not enabled")

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
