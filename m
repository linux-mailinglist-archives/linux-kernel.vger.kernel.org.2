Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8BD3A85FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhFOQFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhFOQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:05:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327EBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:03:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d7so3790235edx.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ds7scC8Pj046kGHWvqN+Gb1T/TTqW6FsBuVSLf41t9M=;
        b=eBCT9SjYcB+i7DBUkm4q6lmtBbVVxe7GY1h5mgDBvsAJEGyP1w0HnwaiP84SvrSq2C
         RlYLXGa6aUvMSwaUx48nZ2OA/c78uwpVrRWVvjW5KIqh70txCFUqLiYrSerjhAejQvex
         0lZCkl50UZmfG2Lv0vxnIi693w04iOhNzawzVl1OFctxTz6aLTbXPqU2UgVXaq2YFYhX
         EBWqO+nhYqIQVC0p7a38KkA1yK7uAuOV3E3SHeYP7cpcUWrQUq5L+M2mUROjZBxIcsIJ
         /ZWVUaVF7GYZZX3mxMO0WT1qyY/wEV0YSiMTPR2V5Ai0gncCryUBaQAAV2Wpgfr9l/RX
         gjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ds7scC8Pj046kGHWvqN+Gb1T/TTqW6FsBuVSLf41t9M=;
        b=tsW2J3eoGfkHqKQX4COLJ6gleURNuNdL3IX6iT+TMzU9q3WGTpUXWqm1qltvb7PBOi
         kgvdOm6/9yzVdW7BjXTYuYQn6ePamaJk1w7DHKjk0W/UPcDkK8tCGRUvQd6cDXJhr9ge
         8AsOOa9xhcYaByQ2HXblbtdL0gXbxV4fWDArAuZqFP030ySmZD2MBeZJLljmqSZnGQVd
         zsi71tz/BkGWa94NIvyHk5aSYrFUCO7LVySfkKHAmJAdYsA+IBf5incIqcqHFe8bvX3/
         PfonG9MFWIzxPbJWAyfBJZVNhIBCW6LVCZ7mZH05ocjHa5ASEpxUKF5vgGd3E74JQEag
         NZGw==
X-Gm-Message-State: AOAM533Vau2Ke+rSXwbypnInYxSiYEYzHanrTy3TbRbuYq1uyNvAj8zB
        UH6u+z0zNI0mJb+i4Weoe1zja4mw/esv/mvdwU3aDw==
X-Google-Smtp-Source: ABdhPJzS0kyJZM92AbMMzk0As5PtF3WFaVk1rdjdjo68Ucq1q8xo6X6hQnUYeIwJJmwC4w6saK9fIF9OihkCxTKcHRY=
X-Received: by 2002:aa7:cb45:: with SMTP id w5mr202254edt.170.1623773015755;
 Tue, 15 Jun 2021 09:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFr9PXnBb7OmOAMumDodC+0usWqRT-RXwC+YUHZ2Y43Xe_uTQQ@mail.gmail.com>
 <20210615152840.GD11724@lx2k> <CAFr9PXkeqryzutzpV6woskee_SwbDMJFgxPtspvTk0-VS6A5xA@mail.gmail.com>
In-Reply-To: <CAFr9PXkeqryzutzpV6woskee_SwbDMJFgxPtspvTk0-VS6A5xA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 15 Jun 2021 09:03:24 -0700
Message-ID: <CAOesGMiu2+dN0_q7X_5p3pc-Lz=SMGiaRQkOBag+dqH2tatZgg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: mstar for v5.14 v2
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Mohammed Billoo <mohammed.billoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 9:01 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Hi Olof,
>
> On Wed, 16 Jun 2021 at 00:31, Olof Johansson <olof@lixom.net> wrote:
> > This time it seems like you based your branch on 5.14-rc5, which is a newer -rc
> > than what we have the rest of our trees on. The general rule of thumb is to
> > base it on the oldest meaningful rc for the release (rc1 or rc2, most of the
> > time). We normally base our tree on rc2 or so, in this case I went forward to
> > rc3 earlier.
>
> Sorry, I hadn't even thought of that but it makes sense.
>
> > (Maybe you had the same base last time around, and I missed it -- my tooling
> > failed out on the S-o-b checking before I noticed)
>
> Last one was rc5 too.
>
> > To avoid another roundtrip here, I'll apply the two patches directly, but
> > please keep it in mind in the future, especially once you have more material
> > for a cycle.
>
> Thanks for doing that and the hand holding. I think I can manage to
> get it right next time. :)

Yeah, no worries. More or less every single maintainer has made
similar mistakes at some point or other, especially during ramping up.

> I have one DTS patch I would like to get into 5.14 for the watchdog
> driver that was recently accepted.
> Is it still ok to send a PR for that one or is it too late now? I
> think I read the cut off is around rc6.

You can still send it, either as a patch or as a pull request - your choice.


-Olof
