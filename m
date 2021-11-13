Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86B744F584
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 22:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhKMViZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 16:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhKMViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 16:38:22 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D61C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 13:35:30 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id y3so34125109ybf.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 13:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSXJ3uMUoVuuhGKC/oVSm8bEZNFwZL8IbH9GMbqinz8=;
        b=dkaTRJTRIi4ZifpY9ICa/j7nErEweW4HufoKRtFVlWbkDqfE4ttOCtu7D5UAdvMdgM
         PWs9pViYlrbvAtah2pdcHABvOMfIs0sZlVgdDFdbzbzPz2qxb5Zc5BAnRhtc2vU8s2u4
         f96KLpJKEmp/G/mmEkgTXD+UJ8eZ7EO9ENCU8FuPCqr0uhYFEf59rUGKutg4J8bXgU0V
         fkW4Tdf4cC2QgTk941IQoGtpRpl2n+7AXMqSRU1jm6y8Or5cHZ+XM4AK6Y9OW6xlu57r
         4yTL12Ous6bHQraMdkCLQTtwlIRAY7mxzuOlGD00jNimEmG7l3bwEIUnk1bDoAA8R86T
         xFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSXJ3uMUoVuuhGKC/oVSm8bEZNFwZL8IbH9GMbqinz8=;
        b=oBkbHi8hLvFwQFzcujD4NPQdUENWuyMMW4USnHhmdS/PCcEs638EjAKK+AsWmDvguL
         dwoGdGoiGxExCl05Nnl9CoP1Vk63dnO7+3eYS66neKs8odd9h2mHgDbhAZ3+dpR3Hsa+
         e1e2AfGsqV5ISLo6oMNOcrSbSRRPNPc/8Gn4XYajFw9WT9ARPZPOMSGETd05hqAlGwMX
         gqNy6Sf7hSCT68e74fEmQLOLyWcvNYlvkU4iZ41IBIZrFUT1sKBWiDeaAFHChHse8DAc
         ADny8CQLEzpD65bbyPVQidRZ40JPFCCaNuJK+0NtFUW1piTj5CR/H9Bav0FrgkPt1EI/
         RNmg==
X-Gm-Message-State: AOAM530XihHKa3GFvpE0b1FKPMUIelpL8dCLucH9yDPO9iPfw4s0EP7v
        X74gJyLtFD3/2tgLKV7/ohDAdRkDHrfS1hohrnvEiO+2PuM=
X-Google-Smtp-Source: ABdhPJxiyniWoK2HoBAw4yOk/7IK6gECxvBOuNXSV39rmBpeaxcPXsgNhCEjQ1hAuKN5hNQecWTsHtNVolyHlBLYX3w=
X-Received: by 2002:a25:488:: with SMTP id 130mr27073299ybe.346.1636839329289;
 Sat, 13 Nov 2021 13:35:29 -0800 (PST)
MIME-Version: 1.0
References: <CADVatmOuOk6RoZF=M9sZm2L=9NuDDsSNNCJJbAtkgScG0og1Ww@mail.gmail.com>
 <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com> <CAADWXX80QGk7MwZ7A-n+1+GHv=yrA0qrw-70Z=pFSEsc3UXfgQ@mail.gmail.com>
In-Reply-To: <CAADWXX80QGk7MwZ7A-n+1+GHv=yrA0qrw-70Z=pFSEsc3UXfgQ@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 13 Nov 2021 21:34:53 +0000
Message-ID: <CADVatmN7rQYhWJQao3qXz7TZxz5piN+kN4g4tV_wYC4=uxtgtA@mail.gmail.com>
Subject: Re: regression with mainline kernel
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Nicholas Verne <nverne@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, Nov 13, 2021 at 5:07 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Hmm. This email was marked as spam for me. I see no obvious reason
> for it being marked as spam, but it happens.. ]
>
> On Thu, Nov 11, 2021 at 12:52 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > # first bad commit: [cd7f5ca33585918febe5e2f6dc090a21cfa775b0]
> > drm/virtio: implement context init: add virtio_gpu_fence_event
>
> Hmm. Judging from your automated screenshots, the login never appears.
>

<snip>

>
> HOWEVER - it has had a fix for a NULL pointer dereference in the
> meantime - can you check whether the current top of tree happens to
> work for you? Maybe your problem isn't due to "that commit does
> unnatural things", but simply due to the bug fixed in d89c0c8322ec
> ("drm/virtio: Fix NULL dereference error in virtio_gpu_poll").
>
> And if it's still broken with that commit, I'll happily revert it and
> people need to go back to the drawing board.

I sent another mail yesterday which is now at
https://lore.kernel.org/lkml/CADVatmOOzCxAgLhCu1tTz=44sgRDXds5-oMZ3V0w4f5kLCLKrw@mail.gmail.com/
I will just pase that here for you.

Last night's test on 66f4beaa6c1d worked fine. So I guess this has now
been fixed.

I have not done a bisect to see what has fixed it, but looking at the
log I think it will be that NULL pointer fix.


-- 
Regards
Sudip
