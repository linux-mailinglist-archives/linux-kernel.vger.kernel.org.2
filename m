Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5EF38C113
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhEUHz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhEUHzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:55:55 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:54:31 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id q6so5698609vsp.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yA7Lkm/nXDMCfmn4EBtAJW5GRrIK88MdQhqjgo97iYc=;
        b=C18mRKWikKVx1cic8io2JbRa79yx/52/8m0xFuj1FZsu7EuOsgMlp9RDIqjkJ+sDKC
         1POBz/VL0Z4NxyJd14bYcBLpZn4v8THFtAPLJ+E2T4udz4+QjiUwEUyd9zjffvf160LC
         cDP3k4gS2MBFFOQBoNEmuTWqlLYwdQrXg1XDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yA7Lkm/nXDMCfmn4EBtAJW5GRrIK88MdQhqjgo97iYc=;
        b=PI+OZhj0aqc3cZyiImd83DaLxV50hhZtIUtgZf0D9TsdLBldvOJ9AQ/HExMhZTmtq1
         7TdrDzZ4BgonyiQ/2rZhSUdXRfeTkM5hxTShHRozFW2sgOueTs1jo1f33q7O+gzlnhue
         tH5j6g/87eMY86mprTzUPmMrPUrUuSZRVM+bxhr2Cz0Ump1YQeNL3w00wPNyUR1BVPtx
         H141Wh1cDhEGPD5Sf2UO/LyjHTCQZ5QPVC8crBSgbkUhOwcRSy8fVeIscViBjl2KFjUj
         BYjVF76KClvc5K45tgNCzNZwQ7YHWCi/3riEzVc4LCLDtMbmg+fJ6IqVOAHe0/19FioJ
         4WEg==
X-Gm-Message-State: AOAM533LyM7KNBDSQNxUqeU5G1CjaHhbt+f/BFPmBHltvnDVsb+fGoQO
        uV5p8wNbULWXMTesd8bgV0af2bo4XRmAskobHpNBig==
X-Google-Smtp-Source: ABdhPJwHx/FKMoZFaVW7VqWkqliu9Li95xQWM99p2HAvSRFx8ZjGMbpLHEgoCCMXb32SC/WfuuuWfF1ROQUYrmO6eGc=
X-Received: by 2002:a05:6102:b06:: with SMTP id b6mr8147911vst.21.1621583670705;
 Fri, 21 May 2021 00:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154654.1791183-1-groug@kaod.org> <20210520154654.1791183-2-groug@kaod.org>
 <YKa8SZ8s6QeKZ4XP@zeniv-ca.linux.org.uk>
In-Reply-To: <YKa8SZ8s6QeKZ4XP@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 May 2021 09:54:19 +0200
Message-ID: <CAJfpegvFUasy_8djyvo-fpyboOLGwRV9k_CL-e1nqxcXHkvzOg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] fuse: Fix leak in fuse_dentry_automount() error path
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kurz <groug@kaod.org>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 at 21:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, May 20, 2021 at 05:46:50PM +0200, Greg Kurz wrote:
> > Some rollback was forgotten during the addition of crossmounts.
>
> Have you actually tested that?  Because I strongly suspect that
> by that point the ownership of fc and fm is with sb and those
> should be taken care of by deactivate_locked_super().

Not quite.  Patch looks correct because destruction of fm is done in
fuse_put_super(), which only gets called if the sb initialization gets
as far as setting up sb->s_root, which only happens after the
successful fuse_fill_super_submount() call in this case.

Doing the destruction from the various ->kill_sb() instances instead
of from ->put_super() would also fix this, but I'm not quite sure that
that would be any cleaner.

Thanks,
Miklos
