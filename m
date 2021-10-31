Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4038440C91
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 04:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhJaDDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 23:03:44 -0400
Received: from smtpq1.tb.ukmail.iss.as9143.net ([212.54.57.96]:59586 "EHLO
        smtpq1.tb.ukmail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229887AbhJaDDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 23:03:42 -0400
Received: from [212.54.57.110] (helo=csmtp6.tb.ukmail.iss.as9143.net)
        by smtpq1.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1mh15q-0006yG-8f
        for linux-kernel@vger.kernel.org; Sun, 31 Oct 2021 04:01:10 +0100
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id h15pm8NKE24zoh15pmofcb; Sun, 31 Oct 2021 04:01:09 +0100
X-Originating-IP: [81.97.236.130]
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=K8YxogaI c=1 sm=1 tr=0 ts=617e06f5 cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10 a=zd2uoN0lAAAA:8 a=1mUNueIcj1jfD_gS2Y8A:9
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1635649269;
        bh=nzrHVr9ePpgkU1Jcj27TkiVxAjRumcJcZOa7DN1zh6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=G3c6xQhdFOOJElsRZsXonQnuQdpV0W0caGduKcr+yQOOE6i0s6rRMNalcVmR0NbkZ
         TJgUrESPWns1W7nKmewmesBcZwt4CZXCrA9rfxlZEBs++XW+z4byPJPAYG3V/ClZyr
         DuFNQdxIaeMtyTbMUQ7qc+PIH/ffYre5Awc2IfxZN6WKZUzk5cvIW59KwyovKeloxR
         KLUfhPvjzI1XuIo2AftQTtZoa6xLShYNkA/5O3IDS955fDVNlVLv1co6uVUVOCs8Pj
         aFAy+kq071ethYQWUJp7OQ6FUvVC04kWGN3bk1qUdRtOAwMhfWlcIHQY3ROK3ynzLn
         YW7R8zYWoCxPQ==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 3C90260C5B; Sun, 31 Oct 2021 03:01:09 +0000 (GMT)
Date:   Sun, 31 Oct 2021 03:01:09 +0000
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        James Zhu <James.Zhu@amd.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: amdgpu hang on picasso
Message-ID: <YX4G9YVhw65ps3gC@llamedos.localdomain>
References: <YX2UbO4jlKZqUBWd@llamedos.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <YX2UbO4jlKZqUBWd@llamedos.localdomain>
User-Agent: Mutt/2.1.3 (2021-09-10)
X-CMAE-Envelope: MS4xfJX4FJamZwh+mr4p3aC+yxBq1fCJUuMebk578YsemcwkIaKYWo+uyNiLC1FLxppFSQWqQMxm9UzPqqZh3AAEe8yq/+q82MLmLQgnFWKpvT1Ru7YBfvT1
 mnHqEcjbMjijy0N7dX12HW6fKXx05rYrbmRU8tVC5VS/iNVBDw5spKicw54gjWqXmuBfF4KvUwZeYLrsv7BvI7PKkkcpXhh7nzUXG+8SvnTOu8PfSxsIoTj1
 aDVaCi54ScbMyiNwGSF5RZ/MN3g2sBJw9Z7DKClEiyHhYb2G/QteZdJfQVuvWE8bjPkqZ8ue3i9yVFhenJxI8mRd4yD2NyKdbEIyY0Zbl/k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 07:52:28PM +0100, Ken Moffat wrote:
> When I tried 5.15-rc7 on my picasso APU (Ryzen 5 3400G), trying to
> run 'startx' (I'm using X11 and logging in to a tty) the output
> messages from X11 stopped after a few lines (normally, the desktop
> shows before I can read anything) and keyboard/mouse were
> inoperative - had to use Magic SysRQ to sync and reboot.
> 
> The log showed
> Oct 28 03:02:21 deluxe klogd: [   31.347235] amdgpu 0000:09:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
> Oct 28 03:02:34 deluxe klogd: [   44.280185] amdgpu 0000:09:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
> 
> I started bisecting after confireming that linus' tree with head at
> f25a5481af12 still showed the problem.  That identified the
> following commit, which reverts cleanly and allows Xorg to start:
> 
> commit 714d9e4574d54596973ee3b0624ee4a16264d700
> Author: Yifan Zhang <yifan1.zhang@amd.com>
> Date:   Tue Sep 28 15:42:35 2021 +0800
> 
>     drm/amdgpu: init iommu after amdkfd device init
>     
>     This patch is to fix clinfo failure in Raven/Picasso:
>     
>     Number of platforms: 1
>       Platform Profile: FULL_PROFILE
>       Platform Version: OpenCL 2.2 AMD-APP (3364.0)
>       Platform Name: AMD Accelerated Parallel Processing
>       Platform Vendor: Advanced Micro Devices, Inc.
>       Platform Extensions: cl_khr_icd cl_amd_event_callback
>     
>       Platform Name: AMD Accelerated Parallel Processing Number of devices: 0
>     
>     Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>     Reviewed-by: James Zhu <James.Zhu@amd.com>
>     Tested-by: James Zhu <James.Zhu@amd.com>
>     Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> I've got a laptop with raven, I'll try to find time to test it that
> also shows he problem in the next few days.
> 
The laptop (AMD Ryzen 5 2500U with Radeon Vega Mobile Gfx) works
fine without reverting that patch, only the picasso has the problem.

ĸen
-- 
 A capitalist society is one where individuals own and acquire
property, at least for a few months until cooler objects come out.
                                    -- Late Night Mash
