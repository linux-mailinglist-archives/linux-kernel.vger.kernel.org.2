Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DF434ED23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhC3QGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhC3QFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:05:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73047C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:05:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y6so18881367eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTeGm2gnR8rNNn47/dNZEpSnzYBxYfRGyQZfWrQAsf8=;
        b=ZHb2TD+dgtwnji5LAsp1IhPENr4lacW1qnMOoxxbfM8YGefGbHlkmsJHTCWm1Isc5h
         3dFj0DO6y6Gc2SzCYGgRr1YFNXi5A/sfDbDnhYQc/BJ2kEpYduz19pqbzdRPLonIexz3
         4t1/bo+XgyL5ftEk2ptbdOE5MCYw3uk1gZxxS8m3z1VBxRbVPudJeBWoTZmCqvGZ8M8H
         BEg9QvtmmX17wEzjoLRwtBxRAx5FoU4cFzt/7ZRI29dgyUP1fLLepm9+41F2ObBUek3f
         +P7CbC2B0Z0+bOnyg/hKIED4IJ55vmPFa0WeksGzn8ifI78PacfWREbtUAT4dGpW722E
         q45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTeGm2gnR8rNNn47/dNZEpSnzYBxYfRGyQZfWrQAsf8=;
        b=DdxTUzzGbCnnnBKQLJZ6AbBSkydbovpVei4cTguQg1OL362z3WNMrKQlnk/lVVDv0w
         o2r3pG3+w5+Nb1nRrDHy/xsRBQxhrg2+abb2dIDHTufgYyOcjTQTQ/YzbWeCMQwC0Suo
         J4Rg06Y2Qs2eBhE27c6pcNpwAfsWERXM6MP/5legXr+BwZ2ZCHiEpakJ835RJn6rduCv
         9igoRnkSKMvaGbT82cTYr5GSQrtDIvkZymL1cOKzMWAtgvUYp8y3GdtsFKcrn12cvmeI
         4ZB7S4ahBf81aDd0mgz0L7WhvhO98rrqOgQlVOawwkNU93b8OaQCIrYrrzSlQhkcaK6n
         BFGA==
X-Gm-Message-State: AOAM531jFCxnUYN/+ZgNV1GX3EH83lCiDUNRUKv+uy0dh2E9Ee5OaBDm
        SsiXwuPJXlsPrRyN7NnYOPFZJndMkoZ4N8MgRneEHw==
X-Google-Smtp-Source: ABdhPJxC7G1pNlaBw24vWX+kFubWjOR+3cklTPNbBUUSYS6/zQNmx3KnYPbP+NBgGCk3VhAePo3/FV4g1Rh06wRFstE=
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr34511651edw.348.1617120339206;
 Tue, 30 Mar 2021 09:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com> <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com>
In-Reply-To: <20210330154712.GR2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Mar 2021 09:05:29 -0700
Message-ID: <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 8:47 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 08:37:19AM -0700, Dan Williams wrote:
> > On Tue, Mar 30, 2021 at 4:16 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Mon, Mar 29, 2021 at 07:47:49PM -0700, Dan Williams wrote:
> > >
> > > > @@ -1155,21 +1175,12 @@ static void cxlmdev_unregister(void *_cxlmd)
> > > >       struct cxl_memdev *cxlmd = _cxlmd;
> > > >       struct device *dev = &cxlmd->dev;
> > > >
> > > > -     percpu_ref_kill(&cxlmd->ops_active);
> > > >       cdev_device_del(&cxlmd->cdev, dev);
> > > > -     wait_for_completion(&cxlmd->ops_dead);
> > > > +     synchronize_srcu(&cxl_memdev_srcu);
> > >
> > > This needs some kind of rcu protected pointer for SRCU to to
> > > work.. The write side has to null the pointer and the read side has to
> > > copy the pointer to the stack and check for NULL.
> > >
> > > Otherwise the read side can't detect when the write side is shutting
> > > down.
> > >
> > > Basically you must use rcu_derference(), rcu_assign_pointer(), etc
> > > when working with RCU.
> >
> > If the shutdown path was not using synchronize_rcu() then I would
> > agree with you. This usage of srcu is also used to protect dax device
> > shutdown after talking through rwsem vs srcu in this thread with Jan
> > and Paul [1]. The syncrhonize_rcu() guarantees that all read-side
> > critical sections have had at least one chance to quiesce.
> >
> > So this could either use rcu pointer accessors and call_srcu to free
> > the object in a quiescent state, or it can use synchronize_srcu()
> > relative to a condition that aborts usage of the pointer.
>
> synchronize_rcu doesn't stop the read side from running it. It only
> guarentees that all running or future read sides will see the *write*
> performed prior to synchronize_rcu.
>
> If you can't clearly point to the *data* under RCU protection it is
> being used wrong.

Agree.

The data being protected is the value of dev->kobj.state_in_sysfs. The
read-side is allowed to keep running, and the syncrhonize_rcu()
guarantees that any read-side that saw state_in_sysfs == 1 has had a
chance to complete. Future reads terminate the ioctl at the
device_is_registered() check.

> Same as if you can't point to the *data* being protected by a rwsem it
> is probably being used wrong.
>
> We are not locking code.

Agree.
