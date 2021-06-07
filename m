Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09339E940
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 00:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhFGWDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 18:03:46 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:34697 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGWDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 18:03:44 -0400
Received: by mail-pf1-f176.google.com with SMTP id g6so14151527pfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNKMrasHpNaeqwrkhFMNAE+AW6y2Sn1+mKflF4XxOjI=;
        b=juxKJR2pYcBkxm6GQEluwpShhxejA60z1ZPl2HLmHbUEwOJS5iXYbJaq59h/t0GSGP
         EBtpna7T8KPL6XiN0ev5nb19j7lwWTi+fmq9CfcNEiDE3WNRZJu4mR4R2wHLuzsAsYjm
         eSb6kHU+KCHR6FeSpdi7rWai/CTxR/3pNVg6j0pcujQw/35Q4fT3R7fDiwKHpVgExo2c
         p9KSntyeOBMLiseLdSDnrzo18Jz9yHJ4ZcUPHVRtflxsAZRcGGvXVxr8ORVPkD9GOT8T
         XWGc/7OoO9gtXAUkbcEiQN92+MEEx8oxey3vBcVYmCf4luXGrMDt+Kd6Hal68+VBSNqp
         xmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNKMrasHpNaeqwrkhFMNAE+AW6y2Sn1+mKflF4XxOjI=;
        b=T9APFqtYKHcdkCnxoLLqfIuBmfmtjpn+wXgoQ0gAG6pFGE4LFiC+vRaJKE9ML5oyMJ
         Nsx7UkRl2OSd3/Igq1i41EtQAO/0s+VBeVFImSkhh+cbGh4CFiiQ8F9xIBf8AAKggEzW
         IQWXI+ISKlyZyL136Ypfmsw6CUHAjoIWVj89spKg50cMCW0jfRtHr/sL8cr2qtjNur2L
         tH91EP2HjOwwkopdcgaJ9NR/ecNcI78RgSPo3/ijJWRndA+yzQkMHnxqvrxf4Mnuv0T6
         T2mTMrpaZaceoxWy1Ed1LsLxZ8aS/bXMgykWUXCEnWTAcQF8WGUZ8bp8UM54jC6dvO6e
         9heQ==
X-Gm-Message-State: AOAM5331oPNfVOYWGrz20iJ74edyttJ7n8KiBvLncEdsFCGoHVXkSNZj
        +IuSucPx0GBAQqim3AE/1bk5kAmCOs1Edt54ZAZbEg==
X-Google-Smtp-Source: ABdhPJzPbGt8/wXF/96caXRzHEOcivZyfKxaqWHThUrS3ewjWNcAWLNrIi5/92hT67Wgefec7ypzix49+nJZAp3m8Uc=
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr11952006pgm.279.1623103252950;
 Mon, 07 Jun 2021 15:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
 <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210527042356.3983284-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jRCZwoJoKGP4v3e8V6u4Y+1VZo_k=umQuh-rrAoMKg4Q@mail.gmail.com>
 <ca836226-46e1-389c-e5c8-c5f1c91130ea@linux.intel.com> <CAPcyv4gmokd5YTbL0X8w3KKV6EEO0xraaB-OEFJyncjaHQUUuw@mail.gmail.com>
 <2aba694b-ec36-d57f-06e0-a269f9953bb3@linux.intel.com> <CAPcyv4iOJJjghTPTLCkvT-Y_SJOhCbfm66m_NO5Ue+eVr_0NZA@mail.gmail.com>
 <cd4983e4-a3e8-7c33-3197-dd3f7e8f7538@linux.intel.com>
In-Reply-To: <cd4983e4-a3e8-7c33-3197-dd3f7e8f7538@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Jun 2021 15:00:42 -0700
Message-ID: <CAPcyv4hBiDNOQ-2b5zxaUUyHo9k2h5UOQvM_wGtw_XTok-BmAQ@mail.gmail.com>
Subject: Re: [RFC v2-fix-v1 3/3] x86/tdx: Handle port I/O
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 2:52 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 6/7/21 10:17 AM, Dan Williams wrote:
> >> Did it answer your query?
> > Yes, all but the concern of printk recursion.
>
> I think recursion is not possible because printk will
> handle it (using console_lock). If another print is
> triggered during the current printk handling, it will
> be directed to logbuf and delayed.
>
> https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk_safe.c#L382

That depends on printk_nmi_direct_enter() to set the context, wouldn't
an equivalent printk_ve_direct_enter() context flag be needed as well?
