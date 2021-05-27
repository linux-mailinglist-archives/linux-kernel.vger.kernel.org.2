Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42593937F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 23:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhE0VcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 17:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhE0VcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 17:32:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:30:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso1244316pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8iOtQ0X/my+H1BXO/43lHQWXZDSXQklyVNvDzzmcng=;
        b=Rrqt81EL8jZO92aEa7H8trfJbdwjHhKDawyLao+RR6AeRPjzKVrO9C3KdkRXm25WQO
         GRLib1dQUkipP+mPE/Gk2Uhhdbca/odaXJS37UttXFsBxaKm2oNlVa7G6j9OYgyvscWO
         pkNAGMa8bN0tOs5asbat2etgpagQ30FOxVFJBE7LV+Xn5C6kNCmg3UTX+MKpLbLYxwmH
         RTRPldUkGo1Tzljl4F+B3iTcy3XcpfEy4v/k8YH6fwa9fPNdMv9bFxubh1zbXcrsp6Ol
         mK792pHk2tNa5wAFgKr8XgkSCNjzjbGgZpN/05GuTEQvkAnE+i+7Q7WbStCidr6xsQvo
         iuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8iOtQ0X/my+H1BXO/43lHQWXZDSXQklyVNvDzzmcng=;
        b=XwfkrGpbaCDWvzPduQnORRgXE7FG+rBSkL6eIVFCWsVQOFyd3youwW4s+4S4nMFYLj
         b/Avv1P79w6r3fb5EDCnh3H/Ufk5oI6L/bUYuuWKlpAi49fA7B5XUfSRtWRQwd7/hB4Q
         VyWdHD9H2hM3ooLEACswgOOm58Q2VWSzfsWEq7OrSiRRdWekWGcpRByfJaSZ65qbB8l4
         kWywR7xqKPKzh63LsVghWQ/ALGfyLZH6hVjRP8fOcy9FSp4Hfmn5FUm4hVRVDnyw98FA
         TNCoVdrChnyyaCxvW6WeQXsU+I6QqoSGDNAOgj5bm2HFX0JQhrSinKlxFd/HQSSjK+zO
         MTzw==
X-Gm-Message-State: AOAM530Jy7eNpVcdVtGL7PyH2UA0nvfLaEu3C9s6PL2DkkswAsHnHNZk
        eaPwSmMPMUze5vWezlWeXF7PsVaDhhyKMzI8aRcW/A==
X-Google-Smtp-Source: ABdhPJyAJFdoqNILHiLrNqqm39umrsbUXjufPPoG05dlLsB2ZffzTsq7bHfWPu5BbnwLXCnmaNLzaveNasZvSD8Sz4w=
X-Received: by 2002:a17:90b:3709:: with SMTP id mg9mr557497pjb.149.1622151042284;
 Thu, 27 May 2021 14:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210527205845.GA1421476@bjorn-Precision-5520>
In-Reply-To: <20210527205845.GA1421476@bjorn-Precision-5520>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 May 2021 14:30:31 -0700
Message-ID: <CAPcyv4j-ygPddjuZqq8PMvsN-E8rJQszc+WuUu1MBXVXiQZddg@mail.gmail.com>
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the region
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 1:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Daniel, Krzysztof, Jason, Christoph, linux-pci]
>
> On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
> > Close the hole of holding a mapping over kernel driver takeover event of
> > a given address range.
> >
> > Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> > introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
> > kernel against scenarios where a /dev/mem user tramples memory that a
> > kernel driver owns. However, this protection only prevents *new* read(),
> > write() and mmap() requests. Established mappings prior to the driver
> > calling request_mem_region() are left alone.
> >
> > Especially with persistent memory, and the core kernel metadata that is
> > stored there, there are plentiful scenarios for a /dev/mem user to
> > violate the expectations of the driver and cause amplified damage.
> >
> > Teach request_mem_region() to find and shoot down active /dev/mem
> > mappings that it believes it has successfully claimed for the exclusive
> > use of the driver. Effectively a driver call to request_mem_region()
> > becomes a hole-punch on the /dev/mem device.
>
> This idea of hole-punching /dev/mem has since been extended to PCI
> BARs via [1].
>
> Correct me if I'm wrong: I think this means that if a user process has
> mmapped a PCI BAR via sysfs, and a kernel driver subsequently requests
> that region via pci_request_region() or similar, we punch holes in the
> the user process mmap.  The driver might be happy, but my guess is the
> user starts seeing segmentation violations for no obvious reason and
> is not happy.
>
> Apart from the user process issue, the implementation of [1] is
> problematic for PCI because the mmappable sysfs attributes now depend
> on iomem_init_inode(), an fs_initcall, which means they can't be
> static attributes, which ultimately leads to races in creating them.

See the comments in iomem_get_mapping(), and revoke_iomem():

        /*
         * Check that the initialization has completed. Losing the race
         * is ok because it means drivers are claiming resources before
         * the fs_initcall level of init and prevent iomem_get_mapping users
         * from establishing mappings.
         */

...the observation being that it is ok for the revocation inode to
come on later in the boot process because userspace won't be able to
use the fs yet. So any missed calls to revoke_iomem() would fall back
to userspace just seeing the resource busy in the first instance. I.e.
through the normal devmem_is_allowed() exclusion.

>
> So I'm raising the question of whether this hole-punch is the right
> strategy.
>
>   - Prior to revoke_iomem(), __request_region() was very
>     self-contained and really only depended on the resource tree.  Now
>     it depends on a lot of higher-level MM machinery to shoot down
>     mappings of other tasks.  This adds quite a bit of complexity and
>     some new ordering constraints.
>
>   - Punching holes in the address space of an existing process seems
>     unfriendly.  Maybe the driver's __request_region() should fail
>     instead, since the driver should be prepared to handle failure
>     there anyway.

It's prepared to handle failure, but in this case it is dealing with a
root user of 2 minds.

>
>   - [2] suggests that the hole punch protects drivers from /dev/mem
>     writers, especially with persistent memory.  I'm not really
>     convinced.  The hole punch does nothing to prevent a user process
>     from mmapping and corrupting something before the driver loads.

The motivation for this was a case that was swapping between /dev/mem
access and /dev/pmem0 access and they forgot to stop using /dev/mem
when they switched to /dev/pmem0. If root wants to use /dev/mem it can
use it, if root wants to stop the driver from loading it can set
mopdrobe policy or manually unbind, and if root asks the kernel to
load the driver while it is actively using /dev/mem something has to
give. Given root has other options to stop a driver the decision to
revoke userspace access when root messes up and causes a collision
seems prudent to me.
