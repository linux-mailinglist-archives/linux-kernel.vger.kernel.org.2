Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC1350418
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhCaQFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhCaQEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:04:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8303AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:04:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so30896219ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/K8jhwDcWdtQO8TgpjZZoFEiAtw8FI9cBvy1a1rTDN8=;
        b=n98YQxI+8gd6h3kZzKYrEF739lerNLf9t8oyCoS2TJyNMaNFL6UJhBu/UuusrT4qiF
         4IiTkSg4USBePHxB+IYW/b9H74TqaoiTSLaPyMsY58DnwNmx1m2p2nInVBop5vaFoFqF
         1gTDhuJ2bUKv3YWP0erWmiFTAGXG7WuKr01VIR8J6Mn3aR9e3BW4qHcpjTLr/2rJ1hOy
         /SaZ0obFL7QqVEpsM0+l+1cNkCBrcElevYRJokNDUp0KeLWBDXbm2uBLsx7+M6U6K9Ar
         IJMgFpN0v9+iBI3vNt5IqaYv+CspHhLfbmjIrqkJzx+nLicb0UeJ3uECqj3eL39YZV+a
         2PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/K8jhwDcWdtQO8TgpjZZoFEiAtw8FI9cBvy1a1rTDN8=;
        b=gVim0m+1QoINELpLjZ9aj0UNWF5yYRRUP+caZcvVGVeRq8KvKoO/Ti9ImpTm7VYkZF
         FFLGAVuaGTEK15b5hhiLTFyBi+DUJvCxsJh+0cPEabPugeHFOpNOhNkjb9WYyAqeqdAX
         SAUKjRczjEYwd4spNW+cXqLfu2KN8IXB/dU1kI521zNv/bMxoVTt+PTCDhy0RMNeTnuy
         LXLXi0GHw+UVtZ1RNaZpVIR6IIus3HQHwKF1yucmPIYF3CbzZKS1MWzuIdUFDR6IU9Q8
         +SjhetLU+5ZGfevldi54wVs+ZrqO6VA3fIejqGC4BXmyHbTlSodM3MRqlAGz9TTQEHKc
         ukLA==
X-Gm-Message-State: AOAM5321JY/14YsbUt47zacaLhDW6gcMV5DafJlW5VOu8o+3h9M9TwgS
        gbfkrF0RWon3CdHhmAFbcQBSoI0v3DvNC9MdqYfVKA==
X-Google-Smtp-Source: ABdhPJx2vS46/Y5jbwBa9EENsyxfekhK0CyN/G/O6mqN+sRR/ycmUklyCtiEkx+kxNfBjLDHmIy1v6PK0IqgLLQq6+4=
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr4161716ejb.264.1617206681177;
 Wed, 31 Mar 2021 09:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161714740233.2168142.11116065966198937093.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210331130953.GG1463678@nvidia.com>
In-Reply-To: <20210331130953.GG1463678@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 31 Mar 2021 09:04:32 -0700
Message-ID: <CAPcyv4inZaSRk-eiyeRLfUOrwyD=YVLW6bdUVJ239X099n1S=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cxl/mem: Do not rely on device_add() side effects
 for dev_set_name() failures
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

On Wed, Mar 31, 2021 at 6:10 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 04:36:42PM -0700, Dan Williams wrote:
> > +static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
> > +{
> > +     struct cxl_memdev *cxlmd;
> > +     struct device *dev;
> > +     struct cdev *cdev;
> > +     int rc;
> > +
> > +     cxlmd = cxl_memdev_alloc(cxlm);
> > +     if (IS_ERR(cxlmd))
> > +             return PTR_ERR(cxlmd);
> > +
> > +     dev = &cxlmd->dev;
> > +     rc = dev_set_name(dev, "mem%d", cxlmd->id);
> > +     if (rc)
> > +             goto err;
> >
> > +     cdev = &cxlmd->cdev;
> >       cxl_memdev_activate(cxlmd, cxlm);
> >       rc = cdev_device_add(cdev, dev);
> >       if (rc)
> > -             goto err_add;
> > +             goto err;
>
> It might read nicer to have the error unwind here just call cxl_memdev_unregister()

Perhaps, but I don't think cdev_del() and device_del() are prepared to
deal with an object that was not successfully added.

>
> > -     return devm_add_action_or_reset(&pdev->dev, cxl_memdev_unregister,
> > +     return devm_add_action_or_reset(dev->parent, cxl_memdev_unregister,
> >                                       cxlmd);
>
> Since that is what the error unwind does at this point.

Right, but at this point the code knows that cdev_del() and
device_del() will receive an object in the appropriate state.

>
> >
> > -err_add:
> > +err:
> >       /*
> >        * The cdev was briefly live, shutdown any ioctl operations that
> >        * saw that state.
> >        */
> >       cxl_memdev_shutdown(cxlmd);
>
> Then this doesn't need to be a function
>
> But it is OK as is

Unless I'm missing something I think it's required to use only
put_device() to cleanup after cdev_device_add() failure, but yes I
don't like that cxl_memdev_shutdown() needs to be open coded like
this.

>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Appreciate it.
