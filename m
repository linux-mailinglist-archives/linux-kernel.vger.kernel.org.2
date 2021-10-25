Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E807439DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhJYRxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbhJYRxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:53:48 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C13C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:51:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so673427pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5prfJR+SMuTNMmFlD4bpo+k6mYbGEspWL5jfk2x5rH0=;
        b=XOE89h3ulpAhTyvxVCcfsW2KXYLgsMV1TzlwgrULwsnmzjvi9cp+/YSdP1OTeMTiNl
         TPbYNfa5ROftjN2crbZ81MkCcF8qtDPowfnAwBNUYTbQPXhVgbvWpij4h9zt0kfrpvAw
         RdWh6uJ+T5mBiDl9q7YeOCNoMu8eDZlK50ItCFiaxCWc+rHv2hTD7Fq5OThg3x2pjJ8T
         wKKiZM/22kY1twjTYE1qB8pUpsSxXu7M86AJwdnqvetN5+VxqP8C5UbgfZAYBOODZOsp
         CJAabm4eafSwkQhI5wqACR9ruzEiECStILXJ8POEjcNjz6GV53fPh8H1pRUNzP63MiI9
         p/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5prfJR+SMuTNMmFlD4bpo+k6mYbGEspWL5jfk2x5rH0=;
        b=G2lxeapAPbtsm+hnlQpAXJ9PMWj1O8VySHb9mY1tl/+ph7mxXkgBAmZYWBWu0Lj9hX
         ouslsAdC+ZMU1xOc6/r4kEDNZ2Ogp8RodXSqItUpBlsdoVDtK+40IiREWRQ6xl4UZWXi
         P8JAIdRxh9t8JCi3aEr4Cu7hLOymhxzlHc2X6QSyet2UJTufxkkVBkp6tKRCbkw/5fln
         YTXVg5Ug3c8wuDTxTYJNh2uNM6CsfQGsZL/ee0S/OE//hRfVhq2m1D5i6ujpDtMv+CuT
         ++lEovN2IzrMcLP0SatdLQQJbUWwAAk8tRM1/ssp8Df4bCEug9lv/pt0Isu3JYZ5y48t
         Xqxw==
X-Gm-Message-State: AOAM533O71Msg3+WC498+ShiGYa/vZE/j1zZLsN1Sotw090pbAHYUgQm
        +6E1OzVCGuwePUy9+QSKsMs=
X-Google-Smtp-Source: ABdhPJynPJ46C+m9CLd0aPXIL0s6BAYJ67YbZfQdsAFU2IOZlM4xpN/K1yiHLCkbbjPPtNouTEwsQQ==
X-Received: by 2002:a17:902:ce82:b0:140:266e:df73 with SMTP id f2-20020a170902ce8200b00140266edf73mr18069201plg.0.1635184284100;
        Mon, 25 Oct 2021 10:51:24 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id i12sm17141581pgd.56.2021.10.25.10.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 10:51:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 3/5] x86/mm: check exec permissions on fault
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <37d0b84c-f6ca-15cb-8d78-b6b5a9496da7@intel.com>
Date:   Mon, 25 Oct 2021 10:51:21 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C30DF7E3-98B9-4985-B83B-E4FCD86A1663@gmail.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-4-namit@vmware.com>
 <e55875fa-1264-7e08-3bb8-ed984f6ea5b3@intel.com>
 <00C2DC4B-A77D-4B32-B7F7-2291830BC2D2@gmail.com>
 <37d0b84c-f6ca-15cb-8d78-b6b5a9496da7@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 25, 2021, at 10:45 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> 
> On 10/25/21 9:19 AM, Nadav Amit wrote:
>> That was my first version, but I was concerned that perhaps there is
>> some strange scenario in which both X86_PF_WRITE and X86_PF_INSN can
>> be set. That is the reason that Peter asked you whether this is
>> something that might happen.
>> 
>> If you confirm they cannot be both set, I would the version you just
>> mentioned.
> 
> I'm pretty sure they can't be set together on any sane hardware.  A
> bonkers hypervisor or CPU could do it of course, but they'd be crazy.
> 
> BTW, feel free to add a WARN_ON_ONCE() if WRITE and INSN are both set.
> That would be a nice place to talk about the assumption.
> 

I can do that. But be aware that if the assumption is broken, it might
lead to the application getting stuck in an infinite loop of
page-faults instead of receiving SIGSEGV.

