Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAEE362735
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243876AbhDPRut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhDPRus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:50:48 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18220C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:50:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p12so19690580pgj.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=q/PQvuMj4MKLEkdVIYF3LGcvWoUD5fPfuukfToBYRoE=;
        b=mslIv2ACFb9btnc4Tnksaw8Uxjl/0V/MMxE3bFF/sM+qtCqFhAkXsl/qGJLx6C44K+
         gVcBCmt4O5DhzQH9x2M5EXF+3TJv9uw5xHeSgAQXXkIkk0PPtTJkpWUQ+UJFEM1cldO5
         oK0hzhJvtdHKkZd0NkP+5ddnIjvoKFuFqte8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=q/PQvuMj4MKLEkdVIYF3LGcvWoUD5fPfuukfToBYRoE=;
        b=bPmW4JOBG/ArI6bXU9EZyyo2lR3OPzHinH67gixtd9N4Rrn5GGQboiefVGfy6lJxYy
         vt5Mvzfr60AbIlEqjvGW0xKyC02HjiGSJnGzMb0/3ZSeqrwIaBnVCmXOl35LtKlcxHJR
         WYkDBvtqh0EKlCobpGKB2wbkURZsddoCRKjoeSMN8h4oyK3F3DfHMj0LjM/QTPd4QqWB
         6pPDC0bwsFkKbwe4WKdNTW7pQs/JGZzcL/DiA7dcgq5vpwCePVum71I3P8X+YFcS8xIw
         miUaWJ6dyoy5BDXmlJkaPkkITIWAr5nmBsz2/qFRL1UHgZnZnQRnHB5g0Pk1uwpyOTrR
         5Cpg==
X-Gm-Message-State: AOAM532b6PrKJO/MU1z7EvbeI/Qae/a5rGFAyxB7vunLfALqWS/NIcl/
        gbL1zS0h5pGWs1sLwoB0yn+Y6OVvXoDwoQ==
X-Google-Smtp-Source: ABdhPJwDspIQg10BMLPtJf/P5hTrhCgqkOVMq3tOZoHd9CXoQZKZNRWRpRvse0D+z90PEmh2bKYwSg==
X-Received: by 2002:a63:1125:: with SMTP id g37mr260916pgl.56.1618595421379;
        Fri, 16 Apr 2021 10:50:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:471a:ba3f:f968:15c3])
        by smtp.gmail.com with ESMTPSA id g23sm1768029pfu.142.2021.04.16.10.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:50:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPDyKFoZL6mygBQZiU329nagPJQzELPiFYjuJ0V3PfvaiJRv2w@mail.gmail.com>
References: <20210413003621.1403300-1-swboyd@chromium.org> <CAPDyKFquhnG1tGAx+GGNKM7_haThSa34FcONHGhdBwFYuryeag@mail.gmail.com> <161851496169.46595.399410018266490859@swboyd.mtv.corp.google.com> <CAPDyKFoZL6mygBQZiU329nagPJQzELPiFYjuJ0V3PfvaiJRv2w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Don't allocate IDA for OF aliases
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Apr 2021 10:50:19 -0700
Message-ID: <161859541950.46595.6083644321477114769@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ulf Hansson (2021-04-16 00:17:10)
> On Thu, 15 Apr 2021 at 21:29, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> >
> > Don't think so. The device (with the kobject inside) is removed, and
> > thus the mmc1 device will be removed, but the kobject's release function
> > is delayed due to the config. This means that
> > mmc_host_classdev_release() is called at a later time. The only thing
> > inside that function is the IDA removal and the kfree of the container
> > object. Given that nothing else is in that release function I believe it
> > is safe to skip IDA allocation as it won't be blocking anything in the
> > reserved alias case.
> >
> > Furthermore, when the device is deleted in mmc_remove_host() there could
> > be other users of the device that haven't called put_device() yet.
> > Either way, those other users are keeping the device memory alive, but
> > otherwise device_del() has unlinked it from the various driver core
> > lists and sysfs has removed it too so it's in a state where code may be
> > referencing it but it's on the way out so users of the device will not
> > be able to do much with it during this time.
>=20
> Right, but see more below.
>=20
> >
> > This sort of problem (if it exists which I don't think it does) would
> > have been there all along and can't be fixed at this level. When a
> > device that has an alias calls the mmc_alloc_host() function twice it
> > gets two different device structures created so there are two distinct
> > kobjects that will need to be released at some point. The index is
> > usually different for those two kobjects, but with aliases it turns out
> > it is the same. When it comes to registering that device with the same
> > name the second one will fail because a device with that name already
> > exists on the bus. This would be really hard to do given that it would
> > need to be the same aliased device in DT calling the mmc_add_host()
> > function without calling mmc_remove_host() for the first one it added in
> > between.
>=20
> In fact, we have a few rare corner cases that can trigger KASAN splats
> when mmc_remove_host() gets executed. Similar splats can be triggered
> by just doing a sudden card removal. It's especially related to the
> cases, where a thread holds a reference to the card/host object when
> it's being removed. I am working on patches to fix these cases, but
> haven't yet decided on the best solution.

Ok. Can you share the KASAN reports? The memory allocated for this class
object and associated index from the IDA will be unique for each call
the mmc_alloc_host() so I don't see how KASAN could be noticing
something unless a reference to the host is leaking out without the
proper get_device() call being made to keep the underlying memory from
being freed.

>=20
> That's the reason why I was thinking that maybe returning
> -EPROBE_DEFER could be an option, but certainly I need to think more
> about this.

I was hoping that you wouldn't need to think more about returning
-EPROBE_DEFER after my email. :( Returning EPROBE_DEFER looks like it's
a bandaid for bigger problems with reference counting the pointer
allocated in mmc_alloc_host(). I hope I convinced you that there isn't
any danger in reusing the IDA in the case of an alias because the only
way that is a problem is if the same device calls mmc_alloc_host() twice
without calling mmc_remove_host() in between. That should be a pretty
obvious problem in driver code? The check to see if that same device has
tried to alloc a host twice would still effectively happen after this
patch because when mmc_add_host() tries to add that second device to the
driver core it will complain about duplicate device names and fail.

Will you apply this patch?
