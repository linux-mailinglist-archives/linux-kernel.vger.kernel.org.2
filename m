Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6444F44A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhKMRKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 12:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhKMRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 12:10:02 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA59C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 09:07:09 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v11so51329694edc.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 09:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRHTN+KJ/0jakG/3S1m86FduFSvoZNR/waj5CoABhhY=;
        b=AI5EgBuhXv3ifPQ/QJGAcgXo9vjiG/by8UhhOa7KCZNrvEzzpepwyfZxQwC1UOwsTg
         3NZXmVOf8DUa+Rt2QZOWgxDJuoswYf8qCtbhrV+XAj0eYtpUMzeJaj3aEp1I532no0eE
         8qsaWz4Ud04P5QaZPk1SnPlYrcPiAhAz2LsOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRHTN+KJ/0jakG/3S1m86FduFSvoZNR/waj5CoABhhY=;
        b=PCudyzcJ+wavFZR3ONMe1JLpLK1XTrFHk799jR4EAMKrKvIRhLJ/cWNVTTRGQ5MoSm
         MygzhaPp2/ZbfMxEB93LR4BId7vlnpTG1Wa0LNWzC/3DHQe/jrBrd5+MiN0ib9fOivt4
         hrmcf8TA6C8EdI7Pxk0J+SYOXZcsqbHUOD58tT2K8aXVNMnJAOhzyRl4IXf/XduTVaqT
         6HbGx01ZtJmDWEWEg/Ut5lgmUZIfsx2rNg/xtO2vbc4/4vzo+Ctc0kDf/LSJn6JQvfDt
         JHwf1gxArp7eABoFsLA1l+02mQsE9Z16nqeJGn7WA05cRTPDEyqRenPiqc6EVDt9pkh5
         hraw==
X-Gm-Message-State: AOAM532T2eUgtANm1Lv14m0FuQSCnbkbdf078jWJptHK55qzgcmM7t6d
        D8WiZc8IpIVPqKKhJG9LBP0oAjcQv6Ohi7XT4wPRLA==
X-Google-Smtp-Source: ABdhPJwGP1iH54aBaYVC33bjqbgQctUZp4Pi4rXKBOfxyi1+bPS5kw2APZGmPTqMUBDICCtmS9pO8y+RNk0rZrzATh4=
X-Received: by 2002:a05:6402:5146:: with SMTP id n6mr24252309edd.126.1636823228182;
 Sat, 13 Nov 2021 09:07:08 -0800 (PST)
MIME-Version: 1.0
References: <CADVatmOuOk6RoZF=M9sZm2L=9NuDDsSNNCJJbAtkgScG0og1Ww@mail.gmail.com>
 <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com>
In-Reply-To: <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 09:06:57 -0800
Message-ID: <CAADWXX80QGk7MwZ7A-n+1+GHv=yrA0qrw-70Z=pFSEsc3UXfgQ@mail.gmail.com>
Subject: Re: regression with mainline kernel
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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

[ Hmm. This email was marked as spam for me. I see no obvious reason
for it being marked as spam, but it happens.. ]

On Thu, Nov 11, 2021 at 12:52 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> # first bad commit: [cd7f5ca33585918febe5e2f6dc090a21cfa775b0]
> drm/virtio: implement context init: add virtio_gpu_fence_event

Hmm. Judging from your automated screenshots, the login never appears.

> And, indeed reverting cd7f5ca33585 on top of debe436e77c7 has fixed
> the problem I was seeing on my qemu test of x86_64. The qemu image is
> based on Ubuntu.

Presumably either that commit is somehow buggy in itself - or it does
exactly what it means to do, and the new poll() semantics just
confuses the heck out of the X server (or wayland or whatever).

And honestly, if I read that thing correctly, the patch is entirely
broken. The new poll function (virtio_gpu_poll()) will unconditionally
remove the first event from the event list, and then report "Yeah, I
had events".

This is completely bogus for a few reasons:

 - poll() really should be idempotent, because the poll function gets
called multiple times

 - it doesn't even seem to check that the event that it removes is the
new VIRTGPU_EVENT_FENCE_SIGNALED_INTERNAL kind of event, so it will
unconditionally just remove random events.

 - it does seem to check the "vfpriv->ring_idx_mask" and do the old
thing if that is zero, but I see absolutely no reason for that (and
that check itself has caused problems, see below)

Honestly, my reaction to this all is that that commit is fundamentally
broken and probably should be reverted regardless as "this commit does
bad things".

HOWEVER - it has had a fix for a NULL pointer dereference in the
meantime - can you check whether the current top of tree happens to
work for you? Maybe your problem isn't due to "that commit does
unnatural things", but simply due to the bug fixed in d89c0c8322ec
("drm/virtio: Fix NULL dereference error in virtio_gpu_poll").

And if it's still broken with that commit, I'll happily revert it and
people need to go back to the drawing board.

In fact, I would really suggest that people look at that
virtio_gpu_poll() function regardless. That odd "let's unconditionally
just drop events in the poll function is really REALLY broken
behavior.

              Linus
