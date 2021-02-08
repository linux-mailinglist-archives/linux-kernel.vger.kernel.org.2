Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38891314237
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhBHVsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbhBHVbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:31:05 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18302C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 13:30:25 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id q85so3727817qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 13:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9qkflY5nbnrf1GydCZmzRH2mO9Zc9djQTfZafbwHa/g=;
        b=n+Mx8XiSpZIp2bzSh2g6O0jcWjTGzzEPa5DiVzraCS1z3aCBR7wlO4ojyvJXShXJqo
         dErGhsLjKKXGxEO4udDchIYBWbjDTcQIGFEXN/foR//8dLWzKZFOSVsJPe9ZU60Gz3ku
         ALAVbytloLtwAOoVkuyDyiODB5zBwwa/R5CnRGsiJbwztjwgeQ0miNWzM368nevWNycx
         Z0eWTWRLO+N+Oz19f9i7ogGrDu3DLRq3e08oV4K7/TmaG0lH5CTxMMzdEtlcX8Jgplyz
         K6PyW8JX+anGM6F7IruuNGlOi7PcrSYVM9d2Cfb6AG3AzVpw85b7UgE0KO478IIrv4L7
         2t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qkflY5nbnrf1GydCZmzRH2mO9Zc9djQTfZafbwHa/g=;
        b=kb7BU2OtmwHuGeHSVD5ue8969J386ofXP1v7tWG0HF0OBHVGM5zk57Q5K428xXVvM+
         6lyKoUR+A7isJPf+fcwvdQYFiu6xGggCPUXRiYUiuYOmqiJZXonMYCh6knf9M1W1gqku
         lKo/xRJSt+C+vMfJJ1lDS1QUt6iO6u9jEayRBhpaII+zQCMP9Y3m3aj1mMkht/ZWZ2Ou
         Bw0dr5dXeFTAH7m/xHrLEfq0+9asdXuNW2hLuz98GdPZVtC4JPb4N89f/f6M7hLWmFKU
         RbgvIjtEN8IQbzdvQdoiXVceh+cmTkLgBcY0zyf49UEwBIp0PocnrrGTwE2tEb/S0f7B
         DhAQ==
X-Gm-Message-State: AOAM530NlvG2xLQklvUNDo2ZNAItvaG4USmlrXWYPNjxate2Obz8NFSc
        IuG/cVpWdyFQtEmYzr6VrRke0A==
X-Google-Smtp-Source: ABdhPJzFdGa04wz/eyZ4j9hhnXsbH3wCkpiuKEtnZzgfxA85nq9G/2jkn8TOldhN5jopR+fvtidBWA==
X-Received: by 2002:a37:bc45:: with SMTP id m66mr4594058qkf.86.1612819824350;
        Mon, 08 Feb 2021 13:30:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id c63sm14340966qkf.8.2021.02.08.13.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:30:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9E6x-00560h-7w; Mon, 08 Feb 2021 17:30:23 -0400
Date:   Mon, 8 Feb 2021 17:30:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Message-ID: <20210208213023.GZ4718@ziepe.ca>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 08:35:31PM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> > Sent: Tuesday, February 9, 2021 7:34 AM
> > To: David Hildenbrand <david@redhat.com>
> > Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; linux-kernel@vger.kernel.org;
> > iommu@lists.linux-foundation.org; linux-mm@kvack.org;
> > linux-arm-kernel@lists.infradead.org; linux-api@vger.kernel.org; Andrew
> > Morton <akpm@linux-foundation.org>; Alexander Viro <viro@zeniv.linux.org.uk>;
> > gregkh@linuxfoundation.org; Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com>; kevin.tian@intel.com;
> > jean-philippe@linaro.org; eric.auger@redhat.com; Liguozhu (Kenneth)
> > <liguozhu@hisilicon.com>; zhangfei.gao@linaro.org; chensihang (A)
> > <chensihang1@hisilicon.com>
> > Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
> > pin
> > 
> > On Mon, Feb 08, 2021 at 09:14:28AM +0100, David Hildenbrand wrote:
> > 
> > > People are constantly struggling with the effects of long term pinnings
> > > under user space control, like we already have with vfio and RDMA.
> > >
> > > And here we are, adding yet another, easier way to mess with core MM in the
> > > same way. This feels like a step backwards to me.
> > 
> > Yes, this seems like a very poor candidate to be a system call in this
> > format. Much too narrow, poorly specified, and possibly security
> > implications to allow any process whatsoever to pin memory.
> > 
> > I keep encouraging people to explore a standard shared SVA interface
> > that can cover all these topics (and no, uaccel is not that
> > interface), that seems much more natural.
> > 
> > I still haven't seen an explanation why DMA is so special here,
> > migration and so forth jitter the CPU too, environments that care
> > about jitter have to turn this stuff off.
> 
> This paper has a good explanation:
> https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7482091
> 
> mainly because page fault can go directly to the CPU and we have
> many CPUs. But IO Page Faults go a different way, thus mean much
> higher latency 3-80x slower than page fault:
> events in hardware queue -> Interrupts -> cpu processing page fault
> -> return events to iommu/device -> continue I/O.

The justifications for this was migration scenarios and migration is
short. If you take a fault on what you are migrating only then does it
slow down the CPU.

Are you also working with HW where the IOMMU becomes invalidated after
a migration and doesn't reload?

ie not true SVA but the sort of emulated SVA we see in a lot of
places?

It would be much better to work improve that to have closer sync with the
CPU page table than to use pinning.

Jason
