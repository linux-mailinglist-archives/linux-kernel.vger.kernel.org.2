Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C123FF08C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbhIBPz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhIBPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:55:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB2BC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 08:54:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m26so1992639pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C97kq6vMKM8/p2uZmdHpDX9cUXq65oDn2QxtZkwcQn0=;
        b=OjLJdTwclM/OVDwve59HOMUbc3UaFAGrKCvmW/xMm1bZr63jqeHf8cyE/i9ZsJrp6O
         j60jStls23sEWA0YT/DKv7mBoJjKJjnZo2+Sjy48yp/Q++0pb29DHGpFvomx7tRiCVWc
         7EK0GCBtaCUlultf2X8Qk2fl11pavMsOz7St08asBcqBi2w6yFgPnHJt5PaWY7La5JZt
         8yCFCZFpHZN1+0focAklN/ZJlyrx8+CRMzYzsdS8fkAutOe+jmkeB86158IS7HJQ7PiH
         AkEuTxxSKZMWdC0zDXccLJ+OElxUlxP1ONba9ngnedQSXOW9aaiChdw/n7jUa587Rl0T
         ci3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C97kq6vMKM8/p2uZmdHpDX9cUXq65oDn2QxtZkwcQn0=;
        b=Vd9/3nFPaEXlbFQ1oJxDREq6ghEln6n5e34t9xdE98fiT2FJ7qqNPZM4k3HpI2A/pB
         rtgZiWnJjKehzxZkEdCa7mmTnB/Yrn5ym0Pf6xMlDLr15qOK6Z++/RAlA3OtnEFD8e6f
         F+DXGgeNEDpBUqSSOZrKWuxDgDUj78HKhawfy3aVaELpecInQQvWiptUAI6frkuh+i7y
         zo0wt3k6anJoYeiyXFTfMQZXq0LmuSBfDEvCJdGdpwuIXBfzoUFvs0fswL7lg2++xmBw
         7o/ww/Uv+tFc71+whue+RAf23jr242RlMBi7MH5T+aXyKpilRnhlAU6RHnQqalMIqBqX
         aNvw==
X-Gm-Message-State: AOAM531RftPimjE8T+kzFgo4w5KxIWOoW8pgVAVyQoH428m4oLnXbyEk
        XQWGSiR8ICpt0V4w6SUD7hMABQy81uv5AA4pVAELI9t+YD0=
X-Google-Smtp-Source: ABdhPJyFbiPhlhaZ0YoTZ34Cj8OIaTGPgvH60rQ3NKALVLGhbVH2AvAC5XkzmqxZjZrLAYbQv1nuc84e18SkhFzJ3FQ=
X-Received: by 2002:a65:6642:: with SMTP id z2mr3831751pgv.240.1630598098517;
 Thu, 02 Sep 2021 08:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210831202141.13846-1-david@redhat.com> <20210831202141.13846-2-david@redhat.com>
 <16141669368a89f8304b1777094e982942d51bba.camel@intel.com> <22be7bd0-3f67-0e9c-87d4-1ec2c184cc6a@redhat.com>
In-Reply-To: <22be7bd0-3f67-0e9c-87d4-1ec2c184cc6a@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 Sep 2021 08:54:47 -0700
Message-ID: <CAPcyv4gXgK+1hbzdCVJmkw7N=SE5tBrxB2UZ5Uh-DZCOjCEN1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kernel/resource: clean up and optimize iomem_is_exclusive()
To:     David Hildenbrand <david@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 12:52 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 01.09.21 21:43, Williams, Dan J wrote:
> > On Tue, 2021-08-31 at 22:21 +0200, David Hildenbrand wrote:
> >> We end up traversing subtrees of ranges we are not interested in; let's
> >> optimize this case, skipping such subtrees, cleaning up the function a bit.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>   kernel/resource.c | 25 ++++++++++++++++++++-----
> >>   1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > That diffstat does not come across as "cleanup", and the skip_children
> > flag changing values mid-iteration feels tricky. Is there a win here,
> > the same number of entries still need to be accessed, right?
>
> Right, most of the patch changes falls under "optimize". The cleanup is
> using for_each_resource() and not using r_next(NULL, p, &l). Sure, I
> could have split this up but then I'd just introduce for_each_resource()
> to modify it immediately again.
>
>
> Let's take a look at /proc/iomem on my notebook:
>
> 00000000-00000fff : Reserved
> 00001000-00057fff : System RAM
> 00058000-00058fff : Reserved
> 00059000-0009cfff : System RAM
> 0009d000-000fffff : Reserved
>    000a0000-000bffff : PCI Bus 0000:00
>    000c0000-000c3fff : PCI Bus 0000:00
>    000c4000-000c7fff : PCI Bus 0000:00
>    000c8000-000cbfff : PCI Bus 0000:00
>    000cc000-000cffff : PCI Bus 0000:00
>    000d0000-000d3fff : PCI Bus 0000:00
>    000d4000-000d7fff : PCI Bus 0000:00
>    000d8000-000dbfff : PCI Bus 0000:00
>    000dc000-000dffff : PCI Bus 0000:00
>    000e0000-000e3fff : PCI Bus 0000:00
>    000e4000-000e7fff : PCI Bus 0000:00
>    000e8000-000ebfff : PCI Bus 0000:00
>    000ec000-000effff : PCI Bus 0000:00
>    000f0000-000fffff : PCI Bus 0000:00
>      000f0000-000fffff : System ROM
> 00100000-3fffffff : System RAM
> 40000000-403fffff : Reserved
>    40000000-403fffff : pnp 00:00
> 40400000-80a79fff : System RAM
> ...
>
> Why should we take a look at any children of "0009d000-000fffff :
> Reserved" if we can just skip these 15 items directly because the parent
> range is not of interest?

Oh I misread, it never loads the child entries into cache, so it's a
true skip and not a continue.

You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...I was going to say it should be named for_each_top_resource(), but
we can cross that bridge when / if something needs an iterator that
includes children.
