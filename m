Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C2E3DC844
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 23:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhGaVge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhGaVgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 17:36:32 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A653C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:36:26 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t128so18917431oig.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpEgoANb95kLZ1B0ubUvGwiEQUfZz4kQSRm7QPVeBYk=;
        b=pgDfbxs+zMvZMZyZ22s+4+TtYs12GGI1QvSYxdwOSOIQuwSbW+C/6Q1UeZnyrqr/qf
         KX+/0blc6QU6SHi829yqWemQ3Sjjd6ob464xqhOjxyrjs/Njt6ZWCBgYMjl34i8mPDJI
         5K5AXOMNbmmqfsbUbg/e1+vJmdW2Aa4O9Wr9wm2fiXe+kgPrjnq3+JSMv1BpfM0F1FUD
         02IGgY2+SXJ8DFAJx7lNiSTemWFlrD5NQH7cb31EbUS2rfoyVXf6+7ilBIWEQ9M+B+86
         ud7aUhug7TSdC0fxmlUeZj0hXKJfQPTymC/wCcFYWxy/+bmStjGf/RxxAPGZVV1+G198
         Soow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpEgoANb95kLZ1B0ubUvGwiEQUfZz4kQSRm7QPVeBYk=;
        b=IL69i9icVwrH+iaWXsxv/rIRCsFKd9PuNeE2pZ0Lw8Jihb0w8hqN/piprbwXjziD0X
         evDhQP17pUVOrEtm21bYBlmDqEPyPS8jYNH32n5Sd9ThMZZCTSjmT5Lj5be3gxD2KcOs
         Q7z1Jz1N1Sb+mREzbscIlACXqAL8eD6oNc3QOypqEEA03PGpbqYGi+kLcygzlAitWe1l
         xWkiX0CN4JZa69v9RSvEWGM1z4/vA1H2zxWTg/h3fHpF0c5rwGI9LXuVv94D77LVsuHq
         GGWy+koYghpi64tqfu1MmsYRP3Vp7BNIwLu+uqI/f6qgs7IDgKM+vb5o7x1CIkmTdvGA
         6JFA==
X-Gm-Message-State: AOAM533q310r4LYWcWD8ix8Q7bu01A844+/qbQwvdCN3ihIBYOzUzNMC
        964PKp1j54QIPJQgYs31kH64Jb9mK4E1RF2kSBP3kfOR
X-Google-Smtp-Source: ABdhPJwd38bs/Rhk06eC+12Bfx+etMnnlUFDIfzDSFnEf9vI/zQW1SOE6iiPL0mB0kL4zWlUx7bmMq1ukwPCx+xl//w=
X-Received: by 2002:aca:c343:: with SMTP id t64mr5944212oif.67.1627767385425;
 Sat, 31 Jul 2021 14:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210722201929.3585671-1-djrscally@gmail.com> <20210722201929.3585671-2-djrscally@gmail.com>
 <YPq28BNOmqZPdRqq@smile.fi.intel.com> <acf4838d-3c70-20c1-5fce-ee36765b06c4@gmail.com>
 <YQPjxzpfGn0csS+S@smile.fi.intel.com>
In-Reply-To: <YQPjxzpfGn0csS+S@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Date:   Sat, 31 Jul 2021 22:36:14 +0100
Message-ID: <CAFLoDVHB0ywv6LYXXUM26KHB8spp3phkPGADXqhps6Z0cre0QA@mail.gmail.com>
Subject: Re: [PATCH 1/2] device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 23, 2021 at 02:04:59PM +0100, Daniel Scally wrote:
> >
> > On 23/07/2021 13:32, Andy Shevchenko wrote:
> > > On Thu, Jul 22, 2021 at 09:19:28PM +0100, Daniel Scally wrote:
> > >> Sensor drivers often check for an endpoint to make sure that they're
> > >> connected to a consuming device like a CIO2 during .probe(). Some of
> > >> those endpoints might be in the form of software_nodes assigned as
> > >> a secondary to the device's fwnode_handle. Account for this possibility
> > >> in fwnode_graph_get_next_endpoint() to avoid having to do it in the
> > >> sensor drivers themselves.
> > > ...
> > >
> > >> +  ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
> > >> +
> > >> +  if (IS_ERR_OR_NULL(ep) && !IS_ERR_OR_NULL(parent) &&
> > >> +      !IS_ERR_OR_NULL(parent->secondary))
> > > Nit-pick, I would put it like:
> > >
> > >     if (!IS_ERR_OR_NULL(parent->secondary) && !IS_ERR_OR_NULL(parent) &&
> > >         IS_ERR_OR_NULL(ep))
> > >
> > > or
> > >
> > >     if (IS_ERR_OR_NULL(ep) &&
> > >         !IS_ERR_OR_NULL(parent->secondary) && !IS_ERR_OR_NULL(parent))
> > >
> > > for the sake of logical split.
> >
> >
> > OK; I'll do the second one, feel like it's better to have ep as the
> > first check.
>
> Fine, but also I have just noticed that parent should be checked before
> parent->secondary.
>
> Something like this
>
>         if (IS_ERR_OR_NULL(ep) &&
>             !IS_ERR_OR_NULL(parent) && IS_ERR_OR_NULL(parent->secondary))
>
> > >> +          ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);

Yes, no problem. I'll send a v2 when I can, It will likely be another
week or so though, my computer's in a cardboard box.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
