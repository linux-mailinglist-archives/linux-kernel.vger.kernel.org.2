Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE69030828D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhA2Aku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhA2AkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:40:00 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DC1C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 16:39:19 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id h6so8135725oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 16:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jukk9ug596/8oaymt9jnz0ohX/k6g1hZOmyfE6uDoEg=;
        b=unACxiuWGGp8BAhRfEOchDgTG+qixVQ4ldPXC+mCTlihhw95KGVvk6EV10/xYRwLbi
         cayIzz9H7yYuso9p6HLIZ1RsxRuZONNj9lWiqZ2x84zjXWYCjuDhEzLczbPoNrSxiEow
         a29PGo92V8oNefwKwFAeP6OMWlWLMbImTbmGaSuX0T/ngVJnMM5+Cd/LHN+VIvpEfjNl
         EWab49aIDtUwTjRkvICcV0DbWSZZbgdpNFjl8MvTja9e5JDpKKZqXfSu49zXYYIGBzKt
         FAR2NJ83uwUz34U+koTVqMm0pS4cqxOO4VdVbLzlIfTWIHwqQaZ2gpZuYay8WtFBrr9j
         UqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jukk9ug596/8oaymt9jnz0ohX/k6g1hZOmyfE6uDoEg=;
        b=XP+MF2/ofKmQJpfItNfBpyPE2MpzCVxm/7EIgm6XvJGJwydKS343eeEY2b2o9fC2NS
         zQV8lkZVxgvTd37rfd6CFqo5qIMtzhDHNLx6Hrs/4Wx145o9iYdpZuZ17s4VWy6pvDx4
         wkokN5KF4gbu6Doh6Ix92YcBdpNu/JL2bfL2xSJefFZ09KpkZhzonpAmhJzfxRAeKI6c
         mp+LiB2c6INPTsZ1i0fpKb/itaOQljYoQlgCLIEkD+Nhxlux4GBONz5QaXwkASyGddWb
         UDINbRZ+DxE53OEdSBKI6Nz4TPjUq+h2tICXozyyxuM1+tifc8hJJ00tVzEwuvQwXYOG
         qmHg==
X-Gm-Message-State: AOAM532YkAvFRWhrc4B65jG8vLBE7KAsA0A7BUzADAQSieyBlpW5AOvz
        Pmt5kOTTUWU+FfRZnsCiOBG++P7ud0Z/YPzAAxH8l94JzMiO8g==
X-Google-Smtp-Source: ABdhPJx424NkUncAgPeTJ3zdeF39P+c1I/zagH2BUt7XDVRUz1VDkmMGt2R2ga7rK+uvdYWcNI7NF7mLo2hWu52e354=
X-Received: by 2002:a05:6808:8ec:: with SMTP id d12mr1182764oic.34.1611880759168;
 Thu, 28 Jan 2021 16:39:19 -0800 (PST)
MIME-Version: 1.0
References: <2nft2kipqg.fsf@aragorn.infrastructure.cah> <983b87d6-edb8-21ea-7d6f-f653f5c0d048@oracle.com>
In-Reply-To: <983b87d6-edb8-21ea-7d6f-f653f5c0d048@oracle.com>
From:   Michael Labriola <michael.d.labriola@gmail.com>
Date:   Thu, 28 Jan 2021 19:39:08 -0500
Message-ID: <CAOQxz3ybREqE0s11g3sghFba2NUTxUEkKTKGgjwrgrT+uBZt-A@mail.gmail.com>
Subject: Re: Problems starting Xen domU after latest stable update
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 7:03 PM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
>
> On 1/28/21 6:52 PM, Michael D Labriola wrote:
> > Hey, everyone.  I've run into problems starting up my Xen domUs as of
> > the latest batch of stable updates.  Whenever I try to create one, I
> > get a bunch of block device errors like this:
> >
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:unable to add device with path /local/domain/0/backend/vbd/4/51712
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:unable to add device with path /local/domain/0/backend/vbd/4/51728
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:unable to add device with path /local/domain/0/backend/vbd/4/51744
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:unable to add device with path /local/domain/0/backend/vbd/4/51760
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:unable to add device with path /local/domain/0/backend/vbd/4/51776
> > libxl: error: libxl_create.c:1452:domcreate_launch_dm: Domain 4:unable to add disk devices
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:unable to remove device with path /local/domain/0/backend/vbd/4/51712
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:unable to remove device with path /local/domain/0/backend/vbd/4/51728
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:unable to remove device with path /local/domain/0/backend/vbd/4/51744
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:unable to remove device with path /local/domain/0/backend/vbd/4/51760
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:unable to remove device with path /local/domain/0/backend/vbd/4/51776
> > libxl: error: libxl_domain.c:1290:devices_destroy_cb: Domain 4:libxl__devices_destroy failed
> > libxl: error: libxl_domain.c:1177:libxl__destroy_domid: Domain 4:Non-existant domain
> > libxl: error: libxl_domain.c:1131:domain_destroy_callback: Domain 4:Unable to destroy guest
> > libxl: error: libxl_domain.c:1058:domain_destroy_cb: Domain 4:Destruction of domain failed
> >
> > I'm using Xen 4.13.1 on the box I've been testing with.
> >
> > I bisected down to this commit, and reverting it does indeed fix my
> > problem.  Well, this commit upstream and it's cherry-picked variants
> > on linux-5.4.y and linux-5.10.y.
>
>
> You most likely need 5f46400f7a6a4fad635d5a79e2aa5a04a30ffea1. It hit Linus tree a few hours ago.

Indeed!  That commit fixes my problem when cherry-picked onto master
and the 5.4 and 5.10 stable branches.

Is that commit already headed to the stable/longterm branches or do we
have to make a bit more noise?

Thanks!

-Mike
