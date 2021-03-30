Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53D234EF88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhC3Rb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhC3Rb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:31:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E79C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 10:31:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z1so19165043edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCBIVqvfgxaF1YfBYLDN7JqUVslSSW/Boru1WpFdoTc=;
        b=nfotVrj7OqnLetyZFzqpRRMkGUuwvkuuRkyiZR8STNsHR3gwtnndBEt1+gaDLL7SNe
         yGi3B1sK/JbtVrmiOrvGjD0+4nE8NjKYe+F9Pj8PCkJ+EO7ZSDmH1YlOh+w1LZnkRh84
         pxp/qSnxdxg41NBaPKvG2zm1pyGsYJeKRIvRAjLlrQSxRHS+spHWGoLTkSxwr95tYk6X
         r+o+nmGeOrvCJ2oo/TtOGbUAq6Bm9RT7TB9HRT9pT2uoH3sutsl5AeW4zyqhpbJcXcC4
         eja6qxxWHv3F+1KVOEbfiZSfeTNWG3PvpdikFFgZbZXCYTwMrCUxascBfXzTMYdhypEn
         HUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCBIVqvfgxaF1YfBYLDN7JqUVslSSW/Boru1WpFdoTc=;
        b=AUvUX65AWIl7RQkfz1GsZ+ztNPa+t0XBgeLRdA8hvB993M5tvfUak5nu5zbRa806Ln
         Fl8J8SZoHiuHaNpd7EplqxbyOl+wBR/u11C5Df4nEWlU3imCT2L7z5LB0YY5zFTsTtKY
         dGpJHLOg+LspJH6SEJPtlUaZ+Vs86eixKIxjRCSnm0yZyiTSR40PxpdAqcwdwNXGW8PM
         f/3RPkOq2w9jiXoWZ69RyoFV7IkllSwZdv0pZkqJa2BE0l5nOK1huqhoJLcjxYAQoccO
         SbBG8CJvkEldDuiXqNkavmVS90kxfqiDYlvgnNNKMwszKCDamETshA47x+DMkRbNzXHO
         xD1A==
X-Gm-Message-State: AOAM533/Rhh7gR4RtJOxSFVATX14Y1NbTqosTHkWnSWK3/YIW4pzFsGv
        RvzZKhUrLl2GYi5+5fyibAPJFJprnzjBgP/TEYu88Q==
X-Google-Smtp-Source: ABdhPJxUyZgfJzpTqVJMJqnUf9yXQ4xYQNsN4auVji2tGa9c/lwSsVFd6BRHcmE5uRnmmfFvQcem0OyODK1LIcTGKug=
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr34824354edu.52.1617125485198;
 Tue, 30 Mar 2021 10:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com> <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com> <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
 <20210330170253.GU2356281@nvidia.com>
In-Reply-To: <20210330170253.GU2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Mar 2021 10:31:15 -0700
Message-ID: <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
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

On Tue, Mar 30, 2021 at 10:03 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 09:05:29AM -0700, Dan Williams wrote:
>
> > > If you can't clearly point to the *data* under RCU protection it is
> > > being used wrong.
> >
> > Agree.
> >
> > The data being protected is the value of
> > dev->kobj.state_in_sysfs. The
>
> So where is that read under:
>
> +       idx = srcu_read_lock(&cxl_memdev_srcu);
> +       rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
> +       srcu_read_unlock(&cxl_memdev_srcu, idx);
>
> ?

device_is_registered() inside __cxl_memdev_ioctl().

> It can't read the RCU protected data outside the RCU critical region,
> and it can't read/write RCU protected data without using the helper
> macros which insert the required barriers.

The required barriers are there. srcu_read_lock() +
device_is_registered() is paired with cdev_device_del() +
synchronize_rcu().

> IMHO this can't use 'dev->kobj.state_in_sysfs' as the RCU protected data.

This usage of srcu is functionally equivalent to replacing
srcu_read_lock() with down_read() and the shutdown path with:

cdev_device_del(...);
down_write(...):
up_write(...);

...to flush readers that read ->state_in_sysfs == 1.
