Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5468F3CF3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbhGTEJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 00:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhGTEJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 00:09:27 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFA5C061574;
        Mon, 19 Jul 2021 21:50:05 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id m13so6302765qvh.8;
        Mon, 19 Jul 2021 21:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0KCwtqt8RPVa9Eso0xhcH4+MB0ahASHIwEqiB7n7a5w=;
        b=ExI7ENB8ukgzr77elToDWB2SrFD+/7IpNkujhpKZ/NwPI8Cj/HIfW3NlevvRab/BoT
         w1fXFkSe2SfyzTTPSXu+ZQpdENhH6mRNVmg7VgyQI3v9kL0ei/WdXVIArAeTVhI6XIV8
         L3ykF77PVYLT1sbvYUUkyyLO4urakqbXLQ4sL5kL94Vpu0hMLqG1v136oP8R/HfGBB9j
         TB+jm4PbHkxwxmkUjQvUHDzMp7fhXYre81tkRGiepga+k1DUhPOomBNm+TzSzhWErtFG
         Awhvix0xUFYKmBdp+MTlvHtv+mwFCZ4XNITdjy6+XJ72hwlvoXxxFhCZUiX6qFagV6ho
         nCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0KCwtqt8RPVa9Eso0xhcH4+MB0ahASHIwEqiB7n7a5w=;
        b=R5e3BU+0MpNFOHDtOuryN/2lvES5Y2GegKmrgnqWA/8bNV64jhToEppsdZu/0lweLb
         HHfO96lQahT7zGtwPH1NvtglHOjDr8UNAoj9n80X07d30/4Z9v+mYmpX3OgjXEuUyV6s
         JXQr0PXIG4wknV9jam+/Dp8amjo3kei31MBwCtKCoD7r3tfabTxXFxcKkFv7TcI1FfZz
         SHtaILZZkEFOcpbOUsB+i8NWQgShEBPFHgFiItu5YjBwAWCw6kaGJk5OHuyOtHpWe8CM
         MWMG6yo7/y8zkwQvBg0ggLsJNYOCcLzN3kiCVbLWd5SHg9gfKyV5kyi8xSsHA43DX5y5
         rwbw==
X-Gm-Message-State: AOAM532ZeQBkx1GTBcRAUCkcFZu46bNKl5OiXaw5m1VSR5l6/oM5WyOt
        OPzxvwf2OP5i32NYkAItxg==
X-Google-Smtp-Source: ABdhPJzJ/HSVQtDEoPufiQVTlUd2sIL/teMWpjnl+pDgn+wffBEi8kgB5TVz4FpJRbcttbM1qHq6ew==
X-Received: by 2002:a0c:db8a:: with SMTP id m10mr28459995qvk.29.1626756604256;
        Mon, 19 Jul 2021 21:50:04 -0700 (PDT)
Received: from PWN (104-9-124-193.lightspeed.sntcca.sbcglobal.net. [104.9.124.193])
        by smtp.gmail.com with ESMTPSA id h66sm2791863qkc.47.2021.07.19.21.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 21:50:03 -0700 (PDT)
Date:   Tue, 20 Jul 2021 00:50:00 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Zefang Han <hanzefang@gmail.com>,
        Wei Lin Chang <r09922117@csie.ntu.edu.tw>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: x86: Remove obsolete information about x86_64
 vmalloc() faulting
Message-ID: <20210720045000.GA2211@PWN>
References: <20210622031910.141262-1-yepeilin.cs@gmail.com>
 <20210716060958.GA2197@PWN>
 <YPVxV/KdDBqgTaqE@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPVxV/KdDBqgTaqE@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Mon, Jul 19, 2021 at 02:34:31PM +0200, Joerg Roedel wrote:
> On Fri, Jul 16, 2021 at 02:09:58AM -0400, Peilin Ye wrote:
> > This information is out-of-date, and it took me quite some time of
> > ftrace'ing before I figured it out...  I think it would be beneficial to
> > update, or at least remove it.
> > 
> > As a proof that I understand what I am talking about, on my x86_64 box:
> > 
> >   1. I allocated a vmalloc() area containing linear address `addr`;
> >   2. I manually pagewalked `addr` in different page tables, including
> >      `init_mm.pgd`;
> >   3. The corresponding PGD entries for `addr` in different page tables,
> >      they all immediately pointed at the same PUD table (my box uses
> >      4-level paging), at the same physical address;
> >   4. No "lazy synchronization" via page fault handling happened at all,
> >      since it is the same PUD table pre-allocated by
> >      preallocate_vmalloc_pages() during boot time.
> 
> Yes, this is the story for x86-64, because all PUD/P4D pages for the vmalloc
> area are pre-allocated at boot. So no faulting or synchronization needs
> to happen.
> 
> On x86-32 this is a bit different. Pre-allocation of PMD/PTE pages is
> not an option there (even less when 4MB large-pages with 2-level paging
> come into the picture).
> 
> So what happens there is that vmalloc related changes to the init_mm.pgd
> are synchronized to all page-tables in the system. But this
> synchronization is subject to race conditions in a way that another CPU
> might vmalloc an area below a PMD which is not fully synchronized yet.
> 
> When this happens there is a fault, which is handled as a vmalloc()
> fault on x86-32 just as before. So vmalloc faults still exist on 32-bit,
> they are just less likely as they used to be.

Thanks a lot for the information!  I will improve my commit message and
send a v2 soon.

I think for this patch, removing that out-of-date statement is
sufficient, since mm.rst is x86-64-specific, but maybe we should
document this behavior for x86-32 somewhere as well...

Thank you,
Peilin Ye

