Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523B4426D36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbhJHPGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:06:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60972 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhJHPGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:06:46 -0400
Received: from zn.tnic (p200300ec2f0d56009dfdde09d9680a98.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5600:9dfd:de09:d968:a98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2908D1EC04B9;
        Fri,  8 Oct 2021 17:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633705490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Cz57FOFg63Lj0EwkOKwsVpScuzDedURHLHaB/VHh19c=;
        b=MqjjB/WUC5O1IfxNhx5abf1FWfknWxwnFaiQZyToCZdJVsGI5pjrUz5P16lg/Xgsw4X0+l
        ZdP9PHYZx1YzTn4AClsuARYfZYCqDWB795z86CRibXlRk+vbYsFmVZbvYMQVM7CLcgOJlZ
        iD2nDQafvQPkHGZgaNdi4ndby6laxT0=
Date:   Fri, 8 Oct 2021 17:04:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Quan, Evan" <Evan.Quan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>
Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Message-ID: <YWBeD7fd2sYSSTyc@zn.tnic>
References: <YV81vidWQLWvATMM@zn.tnic>
 <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 10:45:47AM -0400, Alex Deucher wrote:
> I don't have a CZ system handy at the moment.

I could test patches on mine here, if that would help...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
