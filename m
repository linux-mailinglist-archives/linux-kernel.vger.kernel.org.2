Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155B731A641
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhBLUzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLUzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:55:05 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E086C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:54:25 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id u143so250919pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VFVcUbqW9ODUjW7JoMiKL18vrWLkMw7IHiYH3kRT6FQ=;
        b=NndTPWbOgdo4Ef3RGwHTw+AUnRCHheazquBkzOvgdQs1sxZPdyJAYNXdwLwgXYGbyk
         OGOofTYHsn4uRRj5Kksrq58cjiufjhtsgs8W7zuXVhrWGaekhLqtlURFkaH5xNytZgNW
         jUnZPQqbJqc2kfPo8FNT5bOpxXx8T8sm51tNAMOyX1RLkyeCZs/lAd7VxaHtHZainOQX
         9EApc5THUPgugpmvFK81DF7WjmEvtjgdlqNRKd/5pZa5mKGt9qnkmh0W0rbWHTyG/yod
         FiUFZjH6gZwc+wLCUdC5DGz8IhRedi4Vl4NRXWbFxY90zBOsYS4apRuqkcogDHgewn/e
         jt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VFVcUbqW9ODUjW7JoMiKL18vrWLkMw7IHiYH3kRT6FQ=;
        b=sLczVikBxITdOz7nnojjuOC7eEeR6oqgVBUgnvGB8IsB88u3HjK4+IqyFvrnm1j9zX
         +BWxvtlZWnnG5IpoDn4/mrx0sUDCJ8Jfm1YU1fnD/E8OxI2kLrH6wUezXk+s/md4Th7i
         dAhE2OtVLku5low6jAp25MOunGntYoK2pJzdCobZaSAvnt8HZEymIUEVCC754+McX6Zk
         u/twsx7bvHtYVfUmqMN7phRU+oSdVPLxOvbUPr+noAbVz/bpxdTr1/2cFSBKOFlRJZVL
         OjdSBA4i3LH1C2bee9xsrS0LmggvWXSUcVA881iYQCEvZ/f2j5QSRpLzA48DmHRLgHmJ
         sdpA==
X-Gm-Message-State: AOAM533oekTXBVJPX1fWRmZz5i56E4Pj2ko/4H7mV2qL666tI7DMYlu/
        5h4/rs/BquhMhBtVQJV9JATBew==
X-Google-Smtp-Source: ABdhPJyDqb54mTRRCYec/jSC5GzFP/HBU6/nZvB6fnCkp5aHXuxeWGemDpZ2+BKXgtRVqJ54uyVXjQ==
X-Received: by 2002:aa7:9987:0:b029:1d9:f115:6f3b with SMTP id k7-20020aa799870000b02901d9f1156f3bmr4698607pfh.50.1613163264304;
        Fri, 12 Feb 2021 12:54:24 -0800 (PST)
Received: from google.com ([2620:15c:f:10:b407:1780:13d2:b27])
        by smtp.gmail.com with ESMTPSA id h1sm10526523pgj.59.2021.02.12.12.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 12:54:23 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:54:17 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YCbq+UEMIsE0NIWI@google.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CALCETrWPCTmoeFBEJvw98zwNpw316Xii_16COZAWoYNC=obF+w@mail.gmail.com>
 <YCbfyde9jl7ti0Oz@google.com>
 <8c23bbfd-e371-a7cf-7f77-ec744181547b@intel.com>
 <YCbm/umiGUS7UuVb@google.com>
 <514734d9-d8be-03ee-417e-4d0ad2f56276@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514734d9-d8be-03ee-417e-4d0ad2f56276@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021, Dave Hansen wrote:
> On 2/12/21 12:37 PM, Sean Christopherson wrote:
> > There needs to be a mechanism for lazy/deferred/on-demand acceptance of pages.
> > E.g. pre-accepting every page in a VM with hundreds of GB of memory will be
> > ridiculously slow.
> > 
> > #VE is the best option to do that:
> > 
> >   - Relatively sane re-entrancy semantics.
> >   - Hardware accelerated.
> >   - Doesn't require stealing an IRQ from the guest.
> 
> TDX already provides a basic environment for the guest when it starts
> up.  The guest has some known, good memory.  The guest also has a very,
> very clear understanding of which physical pages it uses and when.  It's
> staged, of course, as decompression happens and the guest comes up.
> 
> But, the guest still knows which guest physical pages it accesses and
> when.  It doesn't need on-demand faulting in of non-accepted pages.  It
> can simply decline to expose non-accepted pages to the wider system
> before they've been accepted.
> 
> It would be nuts to merrily free non-accepted pages into the page
> allocator and handle the #VE fallout as they're touched from
> god-knows-where.
> 
> I don't see *ANY* case for #VE to occur inside the guest kernel, outside
> of *VERY* narrow places like copy_from_user().  Period.  #VE from ring-0
> is not OK.
> 
> So, no, #VE is not the best option.  No #VE's in the first place is the
> best option.

Ah, I see what you're thinking.

Treating an EPT #VE as fatal was also considered as an option.  IIUC it was
thought that finding every nook and cranny that could access a page, without
forcing the kernel to pre-accept huge swaths of memory, would be very difficult.
It'd be wonderful if that's not the case.
