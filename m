Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F183F234B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhHSWjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:39:09 -0400
Received: from omta016.useast.a.cloudfilter.net ([34.195.253.207]:46559 "EHLO
        omta016.useast.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhHSWjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:39:08 -0400
Received: from cxr.smtp.a.cloudfilter.net ([10.0.16.208])
        by cmsmtp with ESMTP
        id GefKmBbEQMRfUGqgBm8hw3; Thu, 19 Aug 2021 22:38:31 +0000
Received: from ws ([24.255.45.226])
        by cmsmtp with ESMTPSA
        id Gqg7mujOYGuc7Gqg9mu6bO; Thu, 19 Aug 2021 22:38:31 +0000
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=j.duncan@cox.net
X-Authority-Analysis: v=2.4 cv=fKP8YbWe c=1 sm=1 tr=0 ts=611edd67
 a=rsvNbDP3XdDalhZof1p64w==:117 a=rsvNbDP3XdDalhZof1p64w==:17
 a=kj9zAlcOel0A:10 a=1fMUTEkdAAAA:8 a=pGLkceISAAAA:8 a=kviXuzpPAAAA:8
 a=GrN4TtxLF5UlEiDcx2YA:9 a=CjuIK1q_8ugA:10 a=kXTuJJ3fruM0IRz_0_AM:22
 a=qrIFiuKZe2vaD64auk6j:22
Date:   Thu, 19 Aug 2021 15:38:26 -0700
From:   Duncan <j.duncan@cox.net>
To:     lnx7586@gregdf.com
Cc:     mikpelinux@gmail.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, jason@jlekstrand.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ttm: allow debugfs_create_file() to fail in
 ttm_global_init()
Message-ID: <20210819153826.460b9c11@ws>
In-Reply-To: <20210816143046.3320-1-lnx7586@gregdf.com>
References: <CAM43=SNDAcS952MZpsiD2Z-WU9Bd0EPv=7Z86i7FGdvDtsSXdQ@mail.gmail.com>
        <20210816143046.3320-1-lnx7586@gregdf.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCtUxm8u7SxW4XPKllZefbNT+mD/lU+MRYFCROUjQvA3TCyuPsw6R/VZUY5w//Uw6HGgSaUHc9IDPNtXKgkkXGGwWIb7vdw5oH43KLhM4WbXX2codFuj
 c/M5tnvlEMFRxVD+/sds4NrKxQQkvTHPQF0Yy4upOzT1DJSS2zhecwr7NldSBjOpbT2pfgVZP79E4FGebFB0/djb5bd+tTWHXlJtkw8hbJv3k8YKjyMfvFBF
 pehxLvpQ9BXppshs+0Ca3u4s/8gmuvmiYFyz4wl4BsqgHiV/MH+87UBmp+hvjHCtPHiaL8iy2PiU3IArQOBhAw4Lb5qwlwRmFIf9uLxCkB5R/p0+in67zz1p
 AnvdkiaH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 16:30:46 +0200
lnx7586@gregdf.com wrote:

> From: Greg Depoire--Ferrer <lnx7586@gregdf.com>
> 
> Commit 69de4421bb4c ("drm/ttm: Initialize debugfs from
> ttm_global_init()") unintentionally made ttm_global_init() return
> early with an error when debugfs_create_file() fails. When
> CONFIG_DEBUG_FS is disabled, debugfs_create_file() returns a ENODEV
> error so the TTM device would fail to initialize.
> 
> Instead of returning early with the error, print it and continue.
> ENODEV can be ignored because it just means that CONFIG_DEBUG_FS is
> disabled.
> 
> Fixes: 69de4421bb4c ("drm/ttm: Initialize debugfs from ttm_global_init()")
> Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
> Reported-by: Duncan <j.duncan@cox.net>
> Signed-off-by: Greg Depoire--Ferrer <lnx7586@gregdf.com>
> ---
> Hi, I had this bug as well with the nouveau driver after updating.
> This patch fixes it for me.
> 
>  drivers/gpu/drm/ttm/ttm_device.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

This fixes the problem here, too.  Running it now.

Tested-by: Duncan <j.duncan@cox.net>

-- 
Duncan - HTML messages treated as spam
"They that can give up essential liberty to obtain a little
temporary safety, deserve neither liberty nor safety."
Benjamin Franklin
