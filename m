Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EF63DDF58
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhHBSg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:36:27 -0400
Received: from omta016.useast.a.cloudfilter.net ([34.195.253.207]:54303 "EHLO
        omta016.useast.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhHBSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:36:26 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 14:36:26 EDT
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.147])
        by cmsmtp with ESMTP
        id AbZlmx2F9MRfUAcgUmM0Dp; Mon, 02 Aug 2021 18:29:06 +0000
Received: from ws ([24.255.45.226])
        by cmsmtp with ESMTPSA
        id AcgSmMZ2YUuJWAcgTmiQl4; Mon, 02 Aug 2021 18:29:06 +0000
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=j.duncan@cox.net
X-Authority-Analysis: v=2.4 cv=cO0lDnSN c=1 sm=1 tr=0 ts=61083972
 a=rsvNbDP3XdDalhZof1p64w==:117 a=rsvNbDP3XdDalhZof1p64w==:17
 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=G4gGlADBVhTulWZLwAIA:9 a=CjuIK1q_8ugA:10
Date:   Mon, 2 Aug 2021 11:29:04 -0700
From:   Duncan <j.duncan@cox.net>
To:     mikpelinux@gmail.com
Cc:     daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        jason@jlekstrand.net, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED] 5.14.0-rc4 broke drm/ttm when !CONFIG_DEBUG_FS
Message-ID: <20210802112904.110028a4@ws>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-pc-linux-gnu)
In-Reply-To: <CAM43=SNDAcS952MZpsiD2Z-WU9Bd0EPv=7Z86i7FGdvDtsSXdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKOHvzWWmenb48sQIRdupwA5msxYl4omOjmeMvA8D0vxAtj2OhZKoOJ8REd3ujvkJ3Cfxi465To0ng2WLaRfFGIk0WfOwOX4rSvuYheg+HSiRRzqQZHk
 UVuQhEW9RskCZvTiP8kMocVMUfBik45ijgE/gSKQl8/dqKZuwZv+MyXfXSMEmrckcMhU8qZTBBAsCrncJQMmB24/dllnTa2RzE4zBpZ9xSB/8kj6DC0vReiR
 mbmDc82G/XSvPRkqMc48NviC99EXTmiO++noA77BUVhEoIW+Si6428uV6bCBe+TJsspDujbv88H3hgE32VFk19FbIkDUHoKS6heKF8c4kU4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Not subscribed so please CC me.  Manual quoting after using lore's
in-reply-to functionality.  First time doing that so hope I got it
right.]

Mikael Pettersson <mikpelinux@gmail.com> wrote...
> Booting 5.14.0-rc4 on my box with Radeon graphics breaks with
> 
> [drm:radeon_ttm_init [radeon]] *ERROR* failed initializing buffer
> object driver(-19).
> radeon 0000:01:00.0: Fatal error during GPU init

Seeing this here too.  amdgpu on polaris-11, on an old amd-fx6100
system.

> after which the screen goes black for the rest of kernel boot
> and early user-space init.

*NOT* seeing that.  However, I have boot messages turned on by default
and I see them as usual, only it stays in vga-console mode instead of
switching to framebuffer after early-boot. I'm guessing MP has a
high-res boot-splash which doesn't work in vga mode, thus the
black-screen until the login shows up.

> Once the console login shows up the screen is in some legacy low-res
> mode and Xorg can't be started.
>
> A git bisect between v5.14-rc3 (good) and v5.14-rc4 (bad) identified
> 
> # first bad commit: [69de4421bb4c103ef42a32bafc596e23918c106f]
> drm/ttm: Initialize debugfs from ttm_global_init()
> 
> Reverting that from 5.14.0-rc4 gives me a working kernel again.
> 
> Note that I have
> # CONFIG_DEBUG_FS is not set

That all matches here, including the unset CONFIG_DEBUG_FS and
confirming the revert on 5.14.0-rc4 works.

-- 
Duncan - HTML messages treated as spam
"They that can give up essential liberty to obtain a little
temporary safety, deserve neither liberty nor safety."
Benjamin Franklin
