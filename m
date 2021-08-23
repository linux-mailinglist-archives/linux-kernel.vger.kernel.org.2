Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73943F525F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhHWUqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:46:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbhHWUqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:46:50 -0400
Received: from zn.tnic (p200300ec2f07d9005f98ffa3f2e7b729.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d900:5f98:ffa3:f2e7:b729])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B1121EC04D6;
        Mon, 23 Aug 2021 22:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629751562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PIB4j/WEiXBLu85hP2fKs6OKyZssTGp4ZdswSX0HeSs=;
        b=CDw6P1KZVOTOyZddT+qu63UmR5fgjwsSwsqKcsxPNWZL4YxN3UucrUP995SXj07WbvXo8H
        xx/wWHPVHjnkt254Qpd4MwsK2vdWNPwlEfYKiy7kW+0tkWPPZ4nOBl/ldpmhFsIzb8Emo9
        2s+JV+eWYpo3JWOSQirlJi4uBCvm3uc=
Date:   Mon, 23 Aug 2021 22:46:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <Lijo.Lazar@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ERROR: modpost: "pm_suspend_target_state"
 [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
Message-ID: <YSQJL0GBzO2ulEpm@zn.tnic>
References: <YSP6Lv53QV0cOAsd@zn.tnic>
 <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic>
 <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 04:31:42PM -0400, Alex Deucher wrote:
> Thanks. I think that should do the trick. Care to send that as a
> formal patch?

Sure, but let me run it through the randconfigs tests first to make sure
nothing else breaks. It is late here so if I don't manage now I'll send
you a formal version tomorrow morning, CET, the latest.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
