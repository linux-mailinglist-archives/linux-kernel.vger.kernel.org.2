Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABC4429B25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhJLBul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhJLBuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634003318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OE4BpcPUL/+4NL3fF1YxxjxaT7QzlRidmwL0xj0Wr5s=;
        b=K4LP7zqAejhBmmzGmWiLYOg6EpRCNkrKoMSarkCFhHGRe9NrCY1fS0ztNHyrPkPaDc1cB8
        nvkzjUn5GesE4cH5gOaggrZ9yyG5nh37YOOurJxQsJ0zGWaNxYaVXLecFMABjVmV0wcVX0
        GI3rrUHuBYV620ZxhAby2swKVUNJAHs=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-mBDcogsWPMCj9XVQruMJGw-1; Mon, 11 Oct 2021 21:48:37 -0400
X-MC-Unique: mBDcogsWPMCj9XVQruMJGw-1
Received: by mail-ot1-f69.google.com with SMTP id o23-20020a9d7197000000b0054e537c6628so7200491otj.14
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OE4BpcPUL/+4NL3fF1YxxjxaT7QzlRidmwL0xj0Wr5s=;
        b=mxWTTjzKSMqyVDVTehjPHVYYsImSDL8OyIzZ+z9IQ2CkYeCO8cM7jjA+khWgYKEAFH
         zvDbBYVHL2u9qmS3ziU97KMUo5Ba7s75ntGc1XtI8LC/Z4n4sp1cey6UGjH4+OOaVt1H
         OZ9fc79HXTEAC7R+AazuOTYaVHukFYp+3lHWZ2cHBtwHChPEizM6cdXlII3fEy7o7nmp
         bpFqZy/mb3UXhR81I1SvD3Ng5DePR9TX7ejSd6ai2SZnD7tkUEsTxmejxemlSf0f1xDk
         sRBydyuPa+kZh3x4ITMLLoypk1ZZeiX7/aPrcCazEqxZszHSo1MUQUufXOZcy75okIRF
         APHw==
X-Gm-Message-State: AOAM532Ks1w+k66JGERYgMe9mDQkrfNIrdG2R4fLgLc+c4IgNK9QhIQP
        P3W7azENr66RsZBIie6U+iylvISWdW4hqyCevj29SretKWRD5ZFsQ6J8NIXCWp111X0jejEUabX
        4lQjzSP0zr1LP2Pf+IeQb3zue2M1Rzf5W3mjvRhxe
X-Received: by 2002:a9d:189:: with SMTP id e9mr23685531ote.243.1634003316180;
        Mon, 11 Oct 2021 18:48:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0wjmU6qu0OKfix9B+u70tXguRr1Ws9yRlyrxW9wd6RRK26qY3EuemBKrlvcwkNxO1V6S7eHXRLoRLEwGkDBU=
X-Received: by 2002:a9d:189:: with SMTP id e9mr23685522ote.243.1634003315958;
 Mon, 11 Oct 2021 18:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <0f7871be-9ca6-5ae4-3a40-5db9a8fb2365@amd.com> <a6d2d16c-173f-d49b-ec54-defd6be2bb0c@amd.com>
In-Reply-To: <a6d2d16c-173f-d49b-ec54-defd6be2bb0c@amd.com>
From:   David Airlie <airlied@redhat.com>
Date:   Tue, 12 Oct 2021 11:48:24 +1000
Message-ID: <CAMwc25o9wSPd4PgS56j7GApcFYE=ZY9LHpiFvtE6RVgdQKzBFA@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in enqueue_timer+0x4f/0x1e0
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Ainux <ainux.wang@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        airlied <airlied@linux.ie>, "Vetter, Daniel" <daniel@ffwll.ch>,
        sterlingteng@gmail.com, chenhuacai@kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 2:07 AM Kim Phillips <kim.phillips@amd.com> wrote:
>
> Hi,
>
> On 10/5/21 1:10 PM, Kim Phillips wrote:
> > Hi, I occasionally see the below trace with Linus' master on an
> > AMD Milan system:
> >
> > [   25.657322] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > [   25.665097] #PF: supervisor instruction fetch in kernel mode
> > [   25.671448] #PF: error_code(0x0010) - not-present page
> <snip>
> > That bisection led to this commit:
> >
> > commit aae74ff9caa8de9a45ae2e46068c417817392a26
> > Author: Ainux <ainux.wang@gmail.com>
> > Date:   Wed May 26 19:15:15 2021 +0800
> >      drm/ast: Add detect function support
> <snip>
> > I confirmed that if I revert it from v5.15-rc4 (after reverting
> > its dependent 572994bf18ff "drm/ast: Zero is missing in detect
> > function"), the problem goes away.
> >
> > Full .config, dmesg attached.
> >
> > I can test any possible fixes...
>
>
> Ping - if no fixes are in the works, can the offending commit(s)
> be reverted?

tzimmermann?

Dave.

