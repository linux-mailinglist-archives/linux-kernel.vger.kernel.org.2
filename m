Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50073FBAD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbhH3RXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbhH3RWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:22:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A011C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:21:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h1so27183287ljl.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5o5eVa/D65IWc/Wg+t5VxQlOGV9cF34rB+LJ57J/HX4=;
        b=AbT4fQMY8evNioe7bS2ZgMPICkmZO9rlEmyhbhH3DQ7H+k51ox2zQE9b3J4+71mO3w
         lJmLaifpqmNxKzP/IB+N0sXlWuJ5xdboJu2esOvhmWMZzhmN+xAONOEOqDHy436zUrtP
         1WRbVKYpcD45qWUnYvzXOgh+RmcJ8ja80XcSRXno6QccXCkLsMiXS4D0lLlTsz6BMn07
         Bg8rvVKOd8TkS0IPlIsp0lrSVaAVk/AIWeTHtcO3/mH/9/xoolvOljxm1XVichI8jnJM
         p5/hbgjP6DSlAGUCj4YuG7bnfrMd7q9bKfM5t2bXZ8HPrPYyX2/p0w7XOgPoffHOHxHQ
         KWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5o5eVa/D65IWc/Wg+t5VxQlOGV9cF34rB+LJ57J/HX4=;
        b=AQ9wU95SDUojcSU/ylNAmpMZqrlkMjD/5W8DJk226geMxAThMprlBzul9FbOSSjB6v
         RYqWZsPsuYOuwh43MafzZMg9POP1aCk4ffV4wxgxSBLNmCvb9NV7JNTe5j1Xy/2GWz8e
         UOiJGbr3JuIes+so1kM67fDCubywfp6SfZcSW7vk0oPfK5swTeUEuhZj7ru63cfcZV2r
         hg+M6ycbZth7veGshuLSswWP6gWH/WvP6QrN1NiSv2Kse+sa6jUusR52Js23WUl+hQcr
         lKOfnRP1C1CX8XqoHWX6gC+dmm4639c7+YAr7LulT0z3Ol+tVPCHle7kOhPuAQlMm8jq
         QETg==
X-Gm-Message-State: AOAM530aLb9En0jGG/YNYOpw1bV/H3sWlOo/isap2mbhHJjHYRX1UIJv
        zSSYGFK/j5d2AFXjVjW5gOVK93oLMYM47A==
X-Google-Smtp-Source: ABdhPJwe7w9zR7dTsLfXrKe0TgaGffJeGK5jHfKncxWRV5n3Z5R7VcKHIA9UP37tCJ8VQK28vqLrvQ==
X-Received: by 2002:a2e:8001:: with SMTP id j1mr21871927ljg.9.1630344117445;
        Mon, 30 Aug 2021 10:21:57 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id t19sm1449850lfr.204.2021.08.30.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 10:21:56 -0700 (PDT)
Date:   Mon, 30 Aug 2021 20:21:55 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Skyler =?utf-8?Q?M=C3=A4ntysaari?= <lists@samip.fi>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [drm/amdgpu] Driver crashes on 5.13.9 kernel
Message-ID: <20210830172155.dxwdeh6em2smg2on@kari-VirtualBox>
References: <4ada1100-fbce-44e4-b69d-0f5196f86bcb@www.fastmail.com>
 <20210829173448.3cwk4rz6wfxfxdpj@kari-VirtualBox>
 <4d3fd1cb-9b33-4598-b351-54ea455c2a6e@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d3fd1cb-9b33-4598-b351-54ea455c2a6e@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 07:15:29PM +0300, Skyler Mäntysaari wrote:
> I have tried kernel 5.13.13, without any difference and I haven't
> tried with an older kernel, as this hardware is that new that I have
> very little faith in less than 5.x kernel would even have support for
> the needed GPU.

Yeah might be. 

> What do you mean with git bisect? I have checked that the crash
> happens somewhere in the monitor connection code:

If we found some older version which work. Then with git bisect we can
track which patch made this bug. But if it never work then git bisect
won't help.

You may still want to test with 5.14 as it was released today.

If that does not work then I cannot help more. It is still very
important to know if it is also broken in 5.14. Hopefully someone will
able to help you. 

  Argillander

> [ 9605.269927] Call Trace:
> [ 9605.269931]  core_link_enable_stream+0x746/0x870 [amdgpu]
> [ 9605.270038]  dce110_apply_ctx_to_hw+0x519/0x560 [amdgpu]
> [ 9605.270146]  dc_commit_state+0x2f6/0xa50 [amdgpu]
> [ 9605.270249]  amdgpu_dm_atomic_commit_tail+0x569/0x26a0 [amdgpu]
> [ 9605.270326]  ? kfree+0xc3/0x460
> [ 9605.270329]  ? dcn30_validate_bandwidth+0x11f/0x270 [amdgpu]
> [ 9605.270402]  ? dcn30_validate_bandwidth+0x11f/0x270 [amdgpu]
> [ 9605.270469]  ? dm_plane_helper_prepare_fb+0x19c/0x250 [amdgpu]
> [ 9605.270542]  ? __cond_resched+0x16/0x40
> [ 9605.270544]  ? __wait_for_common+0x3b/0x160
> [ 9605.270545]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
> [ 9605.270548]  commit_tail+0x94/0x130 [drm_kms_helper]
> [ 9605.270557]  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
> [ 9605.270562]  drm_atomic_helper_set_config+0x70/0xb0 [drm_kms_helper]
> [ 9605.270568]  drm_mode_setcrtc+0x1d3/0x6d0 [drm]
> [ 9605.270582]  ? drm_mode_getcrtc+0x180/0x180 [drm]
> [ 9605.270590]  drm_ioctl_kernel+0xaa/0xf0 [drm]
> [ 9605.270600]  drm_ioctl+0x220/0x3c0 [drm]
> [ 9605.270609]  ? drm_mode_getcrtc+0x180/0x180 [drm]
> [ 9605.270618]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> [ 9605.270673]  __x64_sys_ioctl+0x83/0xb0
> [ 9605.270675]  do_syscall_64+0x40/0xb0
> [ 9605.270677]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> 
> On Sun, Aug 29, 2021, at 20:34, Kari Argillander wrote:
> > On Sun, Aug 29, 2021 at 06:38:39PM +0300, Skyler Mäntysaari wrote:
> > > Hello everyone on the list,
> > 
> > This is universal kernel list and it is not read by many. I have added
> > hopefully right list (amd-gfx@lists.freedesktop.org).
> > 
> > > Subject: Re: [drm/amdgpu] Driver crashes on 5.13.9 kernel
> > 
> > I have no influence or knowledge about this driver, but I still try to
> > help because it seems good bug report. Have you test with 5.13.13 or
> > 5.14-rc7. Does this work with some other kernel? If needed can you git
> > bisect if needed? You will probably get some support for it if needed.
> > 
> > Argillander
> > 
> > > I thought that this should probably be discussed here,  so I came
> > > across weird issue to me which is driver crashing while trying to get
> > > one of my monitors working on Gentoo.  I would like to ask here how
> > > that would happen that the Display appears to jump from DisplayPort-6
> > > (physical port) to DisplayPort-7 (which doesn't exist physically)? Has
> > > anyone else experienced this?
> > > 
> > > It seems that the driver sees a rather large amount of inputs for the
> > > GPU, even though I only have 4, 3 of which are DisplayPort, and the
> > > issue monitor is also on DisplayPort. 
> > > 
> > > Hardware:
> > > CPU: AMD Ryzen 5800X
> > > GPU: AMD Radeon RX 6800
> > > System Memory: 32GB of DDR4 3200Mhz
> > > Display(s): BenQ Zowie XL2430 (1080p), DELL U2414H (1080p), DELL U2415 (1920x1200)
> > > Type of Diplay Connection: All are connected via Display-Port
> > > 
> > > Related DRM issue:
> > > https://gitlab.freedesktop.org/drm/amd/-/issues/1621 which includes
> > > logs too.
> > > 
> > > 
> > > Best regards,
> > > Skyler Mäntysaari
