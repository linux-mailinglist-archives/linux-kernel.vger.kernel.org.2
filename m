Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B1435049C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhCaQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbhCaQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:32:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3B3C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:32:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so23043012eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHPIYKHoPm42PJqRafvNC/a4AmdvyTkfRdJZanKsttc=;
        b=Ze09H/ipxnE52y77onOvZNVnO1ZeGvC0Yi9b4ae0sab0pUNI+jokYDzSPOaXTa9YDT
         dDXxL0tcbaXqYlhkCdvYDOedPKdEQxMfuexxU7as+Swq4liGpxbAH/tSS6Dl7rCl2at9
         UjqOScOuWmtgvOTp3uP6oQdkOgzmOhBitMhIYaKlA3iGDC3Vzu9PmGg1PKYKJvlbExL1
         gqMV+LGeXOB3C8S0h99TW3x2w1U10Dt+pkZ1SLbopu5tGTjHz3bdSpw/eOCjuU4f1Vzx
         Avb9/a/OBXDmsZmaN6gIwzGt/YDyUCo4JUBo27pIoTOhdDixfatv1LqfFCbNsV1BVeb5
         j7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHPIYKHoPm42PJqRafvNC/a4AmdvyTkfRdJZanKsttc=;
        b=aN6VH0iC7I94AjVR6lsNytzRTTWt4/tgQwXzu9terjhARKJilwqZFqXHzMq8ljX40g
         MaOmcvr4NcV0n7yijXwBJR3BQZ+AGcPa6CqLq4zZGXlYr+kdI3k/BdFKRKK48Cfe+bWx
         X4tglIbNG6p/M7qubd/DTyof5lE6NMwW1u1DCi/t+BxEYapMXZ0oiAytlPNsFdVzxFOA
         OXcv+VKCBUN7tbXhMt6yAXJQQ2DrD9GnuQlxIVkzoCtPLxEONUrJnWE50lwuQltoJSlI
         /usAeObmf0IPkmXy2CN1QLUmgd4zF1fZ0+n3N6xcaZ9T1/NHjeSaTKOszXSN/uvRml6W
         h/vQ==
X-Gm-Message-State: AOAM532oQgqdJQBUwry3rkt4S5AmHMhIQP1hLfFnNrMLTDgj94RwL7wS
        CCGSXYzed+vGbddmfOJY65fB2C1351CS0mCRWgFeZA==
X-Google-Smtp-Source: ABdhPJyBprJbezpGENvbhxRA2rM1vf5H+tyMGJVzBEGN7CJQywUpCe81M/bE+CulTOb+hMN8uqePj6nL3QDudP1BwUE=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr4975928edc.210.1617208356600;
 Wed, 31 Mar 2021 09:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161714740233.2168142.11116065966198937093.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210331130953.GG1463678@nvidia.com> <CAPcyv4inZaSRk-eiyeRLfUOrwyD=YVLW6bdUVJ239X099n1S=Q@mail.gmail.com>
 <20210331161759.GL1463678@nvidia.com>
In-Reply-To: <20210331161759.GL1463678@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 31 Mar 2021 09:32:28 -0700
Message-ID: <CAPcyv4ifsy+e2j6EPRgy2+cBpm_8ggvaT_GPnwEQKqto+x5YYQ@mail.gmail.com>
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

On Wed, Mar 31, 2021 at 9:18 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Mar 31, 2021 at 09:04:32AM -0700, Dan Williams wrote:
> > On Wed, Mar 31, 2021 at 6:10 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Tue, Mar 30, 2021 at 04:36:42PM -0700, Dan Williams wrote:
> > > > +static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
> > > > +{
> > > > +     struct cxl_memdev *cxlmd;
> > > > +     struct device *dev;
> > > > +     struct cdev *cdev;
> > > > +     int rc;
> > > > +
> > > > +     cxlmd = cxl_memdev_alloc(cxlm);
> > > > +     if (IS_ERR(cxlmd))
> > > > +             return PTR_ERR(cxlmd);
> > > > +
> > > > +     dev = &cxlmd->dev;
> > > > +     rc = dev_set_name(dev, "mem%d", cxlmd->id);
> > > > +     if (rc)
> > > > +             goto err;
> > > >
> > > > +     cdev = &cxlmd->cdev;
> > > >       cxl_memdev_activate(cxlmd, cxlm);
> > > >       rc = cdev_device_add(cdev, dev);
> > > >       if (rc)
> > > > -             goto err_add;
> > > > +             goto err;
> > >
> > > It might read nicer to have the error unwind here just call cxl_memdev_unregister()
> >
> > Perhaps, but I don't think cdev_del() and device_del() are prepared to
> > deal with an object that was not successfully added.
>
> Oh, probably not, yuk yuk yuk.
>
> Ideally cdev_device_add should not fail in a way that allows an open,
> I think that is just an artifact of it being composed of smaller
> functions..
>
> For instance if we replace the kobj_map with xarray then we can
> use xa_reserve and xa_store to avoid this condition.
>
> This actually looks like a good fit because the dev_t has pretty
> "lumpy" allocations and this isn't really performance sensitive.
>
> A clever person could then make the dev_t self allocating and solve
> another pain point with this interface. Hum..
>

...not a bad idea.

/me bookmarks this thread for future consideration.
