Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D55E440B7F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 21:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhJ3Tee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 15:34:34 -0400
Received: from smtpq3.tb.ukmail.iss.as9143.net ([212.54.57.98]:46246 "EHLO
        smtpq3.tb.ukmail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230016AbhJ3Tec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 15:34:32 -0400
X-Greylist: delayed 2372 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Oct 2021 15:34:32 EDT
Received: from [212.54.57.96] (helo=smtpq1.tb.ukmail.iss.as9143.net)
        by smtpq3.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1mgtSw-0002k6-Ba
        for linux-kernel@vger.kernel.org; Sat, 30 Oct 2021 20:52:30 +0200
Received: from [212.54.57.110] (helo=csmtp6.tb.ukmail.iss.as9143.net)
        by smtpq1.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1mgtSv-0004W6-3o
        for linux-kernel@vger.kernel.org; Sat, 30 Oct 2021 20:52:29 +0200
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id gtSum6ufX24zogtSumoVFb; Sat, 30 Oct 2021 20:52:29 +0200
X-Originating-IP: [81.97.236.130]
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=K8YxogaI c=1 sm=1 tr=0 ts=617d946d cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10 a=zd2uoN0lAAAA:8 a=fejykaqomOrPDjmAGWoA:9
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1635619949;
        bh=Mtv6lKw5E1vB6hN+mBoVb6x6nB77iGkZfN2R1gwt/+4=;
        h=Date:From:To:Cc:Subject;
        b=WFFzM9iVhdNwTg1mxXJ+bR6lSiUOWTEnXPuh1yDUMY6+9iPqZ8/T+xZHSYr1k+dL5
         VOgfs7HaUaTiOSwHkkrJQvHdTqbooFYNICKHda6dxXdhv4DiuFEsb3PzbEAJw2sD2b
         EO44OQSnOnk9sbiD8mb3OS6OoSIav+bCR+SwTz7iPZvTKBF6oLB7/5EN3WgJ3HM5xO
         V69zXLCzGgqkmac5zhkaHCsyrJoifVI7X5TJnYG1LregoBlB4QkbVFHw+2yrIdg1bh
         FHYgU52fXJqwF+jMcDLDw0Fg/3XGrjoVh8VAyRZi7RZnzpzpck0BIEPZkrRkCfONLo
         zLIRUfgIsZq2A==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 53EAF60C4C; Sat, 30 Oct 2021 19:52:28 +0100 (BST)
Date:   Sat, 30 Oct 2021 19:52:28 +0100
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        James Zhu <James.Zhu@amd.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: amdgpu hang on picasso
Message-ID: <YX2UbO4jlKZqUBWd@llamedos.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.1.3 (2021-09-10)
X-CMAE-Envelope: MS4xfFXhllc4f8D7xCGZc+5QwTEhL2tqf00GAl0vkQiGQH73TAIJb+s0U+1mAi9D6gtJgwKCb1IK6nB3YB9fd3830c4DXWc1Tp+UXogU8PThtL6iViLgUzeN
 enJ21dI6+67AgZctS79V1zUwbIgw+gki2NDMmNAb8QJ/yjBL1kAH8um8mLXggIcXYwHVVP7OttAIB5zSmXcEffStfkFB/Df+0XP0Ss0+xVyqxuXjtRY8SYOT
 qWpgoGrfj2UALnImBV1uAKT9WqxzxiwJpYf9zkGAzKrXhXJS4nm2fflQOB8skAsZtNmLJvnMksHvhuK6WCgjAL7JN1D+y/msOQPVAorOY3Y=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried 5.15-rc7 on my picasso APU (Ryzen 5 3400G), trying to
run 'startx' (I'm using X11 and logging in to a tty) the output
messages from X11 stopped after a few lines (normally, the desktop
shows before I can read anything) and keyboard/mouse were
inoperative - had to use Magic SysRQ to sync and reboot.

The log showed
Oct 28 03:02:21 deluxe klogd: [   31.347235] amdgpu 0000:09:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
Oct 28 03:02:34 deluxe klogd: [   44.280185] amdgpu 0000:09:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706

I started bisecting after confireming that linus' tree with head at
f25a5481af12 still showed the problem.  That identified the
following commit, which reverts cleanly and allows Xorg to start:

commit 714d9e4574d54596973ee3b0624ee4a16264d700
Author: Yifan Zhang <yifan1.zhang@amd.com>
Date:   Tue Sep 28 15:42:35 2021 +0800

    drm/amdgpu: init iommu after amdkfd device init
    
    This patch is to fix clinfo failure in Raven/Picasso:
    
    Number of platforms: 1
      Platform Profile: FULL_PROFILE
      Platform Version: OpenCL 2.2 AMD-APP (3364.0)
      Platform Name: AMD Accelerated Parallel Processing
      Platform Vendor: Advanced Micro Devices, Inc.
      Platform Extensions: cl_khr_icd cl_amd_event_callback
    
      Platform Name: AMD Accelerated Parallel Processing Number of devices: 0
    
    Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
    Reviewed-by: James Zhu <James.Zhu@amd.com>
    Tested-by: James Zhu <James.Zhu@amd.com>
    Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

I've got a laptop with raven, I'll try to find time to test it that
also shows he problem in the next few days.

ĸen
-- 
 A capitalist society is one where individuals own and acquire
property, at least for a few months until cooler objects come out.
                                    -- Late Night Mash
