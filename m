Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0903186D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhBKJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhBKJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:09:13 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701ADC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:08:31 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id f20so4899671ioo.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdA1Kwoq/S/LKCIqEWml1fSvv8WMuf1jYn8nBhMfcnI=;
        b=VUe+0kbaY+lBr2aOAuw3nZWDJynOj1vx+bapgsEHj20UriFRNFl8g9448c3tGnRubi
         +EvwR0jgW8sfzeMtztTntSjlCZcTr67yBraggSLDUOTlaKo5GBN06hoxX9GWra1YGQiL
         NLztfh16+p4gv4RNidsFwTb/kVDRP5dc/m0TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdA1Kwoq/S/LKCIqEWml1fSvv8WMuf1jYn8nBhMfcnI=;
        b=nBAKjIqwMBiIGxgyNUpXttbkyzjVzN63VmTHlC05a/185tvMW12C577u6eZih97FMF
         TI4PMcOo9K1LB4O4wjO/z9HsEo0DMTUzY0L2siJJRuYT8m2ibjrX5qoH3g45f+p7coQE
         OjXyjZJdS62UdjHrl1ErEI28tXj45KH+WIvr1XCslzrXYnvPr1XwIt184o6yiVcbcRfO
         7CIFWfMCpXi25ao8d2nG5hfbvhdt/IPB8V4uYnlnSN00aD0h7piB44Biy4t2D87rRu+A
         kHslpCEkmCyRT8v2qQOeyEzlfzfNVmQ76mxUtU6hMCR+UchttDBE1/RsEZwRX9X48ByC
         cVEg==
X-Gm-Message-State: AOAM530mhhb0wKOsLnDYnjifkNj2kOmxlnkwdltKRbCXfbuoZrLIaPHc
        rYOrHHySE05r0j530NuisGCJ6D8Cnri30g==
X-Google-Smtp-Source: ABdhPJwdpjACNv1zGM/ae5d5+cnbHHD+dz0gAQ/33oWYzRuYpx3PJ1iWAhl2P3HmMTJRbpR6lqS++Q==
X-Received: by 2002:a05:6638:152:: with SMTP id y18mr7745868jao.16.1613034510766;
        Thu, 11 Feb 2021 01:08:30 -0800 (PST)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id a15sm2247715ioq.2.2021.02.11.01.08.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 01:08:29 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id e1so4480975ilu.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:08:29 -0800 (PST)
X-Received: by 2002:a92:730a:: with SMTP id o10mr4922650ilc.160.1613034508965;
 Thu, 11 Feb 2021 01:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20210202095110.1215346-1-hch@lst.de> <20210207184855.GA27553@lst.de>
 <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
 <20210209082213.GA31902@lst.de> <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
 <CANiDSCvPodsmcOi1fMwvZsyMxWsRQWNT7VkbZs4=XePYXfiXow@mail.gmail.com> <20210209170217.GA10199@lst.de>
In-Reply-To: <20210209170217.GA10199@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 11 Feb 2021 10:08:18 +0100
X-Gmail-Original-Message-ID: <CANiDSCs8dXVoWuwkVs=v+=s770MpzH1xiDuj-080-98ynuz97g@mail.gmail.com>
Message-ID: <CANiDSCs8dXVoWuwkVs=v+=s770MpzH1xiDuj-080-98ynuz97g@mail.gmail.com>
Subject: Re: add a new dma_alloc_noncontiguous API v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

What are your merge plans for the uvc change?
http://git.infradead.org/users/hch/dma-mapping.git/commit/3dc47131f8aacc2093f68a9971d24c754e435520

Are you going to remove the patch on your Merge request and then send
it for review to Laurent? or merge it through your tree with a S-o-B
him?

Thanks

On Tue, Feb 9, 2021 at 6:02 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Feb 09, 2021 at 03:46:13PM +0100, Ricardo Ribalda wrote:
> > Hi Christoph
> >
> > I have tested it in both arm and x86, since there are not significant
> > changes with the previous version I did not do a performance test.
>
> I'll take this as a Tested-by.



-- 
Ricardo Ribalda
