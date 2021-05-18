Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1142387078
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 06:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244587AbhEREKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhEREKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:10:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94178C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:08:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id df21so9400594edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aB4bTQQ4pORgnOI95Z/auAi6uV/+Xm2dmhOL5NIsfaA=;
        b=ozw34U/XDqV3Cg2lRRg+OOiqrVQ3blbm40nniYzSE7gciBJZ21UK8HvcWHmrk3f8nw
         tjTqdt0XO4zNMsbD21pcEvz/fRhcHxEjrADpQDOfOb8DhEPNDKV/0PET4N/aKgnarx6Y
         uwQ51O8JdmPj/SydAG2saT4KnA309eEti2IjQgVjOT3BPSu+KwQ4sGYcK1wcs4rASWVI
         eNg+aFFt5RhuELhH0nluicqlz6fPTFqzpHrT8pBB4kI8q/M56mVV9fkmWkiM6RUoars7
         9k0mBJ99olXkSjunQCIjhk7Ywes48u4ozIuBOjcAc8a+QF2tG9mZg1W6K7WDJwy6haSe
         A+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aB4bTQQ4pORgnOI95Z/auAi6uV/+Xm2dmhOL5NIsfaA=;
        b=uf6wwaPdA5De4VKE0QDMD2utaJttxgMqyFOlF9dZQeUMdAPFpTTT5DWOirsa5gvD4j
         i/CgALmLhQOx5zQaOmvCz8tw2dPOoQF4Tbf2R5WFp7BzOgvpGdaIgMxervKgqPUKnaGS
         fsVdv5UmxUXo32iRLZ6lMbnWpXKcCY4RkbErNdUozDn/5EMIVDDq5eSg6LUEZx6R7eMv
         NuRj5pI5XE0McWzZFoUGKfHD4vTIc0uC3boBmpqpJcaY9XLj1AtDUALkf/D5PNal+ebQ
         iTL6yfeuyFkpGKULE/DP3awMoVJIYhK3GW3mXGiSG2kM0SanBg0daSk7D1UiIlBjqQ2G
         tR+Q==
X-Gm-Message-State: AOAM530lfsxJVsYQ5Mqbih8/y2EvEkdUhTZF+5pqJ1XQySJYl6xDWyMW
        vJxKYCK6soZPX1elYbS4SJSqIIOil4le1LeEZGVlKA==
X-Google-Smtp-Source: ABdhPJyx6MpHC5r3bwaLW7c0en0RZK2Nv6ZG4sTVs0C69NJoJ8UEtyQ3eZRKTKkGWz2DgotE2iUpsLL6sY9tCY/JZcY=
X-Received: by 2002:a05:6402:35c5:: with SMTP id z5mr4741243edc.210.1621310934281;
 Mon, 17 May 2021 21:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4ipWTv7yRyLHA0Un0KZDdXjpCZXMbrEn7SJXbdRhhn=jA@mail.gmail.com>
 <20210518005404.258660-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4hvFe5v72zm5+4mpmsv1u4pEizXMCcjFysKZAEkkOSrGw@mail.gmail.com> <861a316c-09f6-5969-6238-e402fca917db@linux.intel.com>
In-Reply-To: <861a316c-09f6-5969-6238-e402fca917db@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 May 2021 21:08:43 -0700
Message-ID: <CAPcyv4hv4brS7Vp4rjtnPvF5z7FDuEQkCp+sQ0q6FOxpnKCYCA@mail.gmail.com>
Subject: Re: [RFC v2-fix 1/1] x86/boot: Add a trampoline for APs booting in
 64-bit mode
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 7:53 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 5/17/21 7:06 PM, Dan Williams wrote:
> > I notice that you have [RFC v2-fix 1/1] as the prefix for this patch.
> > b4 recently gained support for partial series re-rolls [1], but I
> > think you would need to bump the version number [RFC PATCH v3 21/32]
> > and maintain the patch numbering. In this case with changes moving
> > between patches, and those other patches being squashed any chance of
> > automated reconstruction of this series is likely lost.
>
> Ok. I will make sure to bump the version in next partial re-roll.
>
> If I am fixing this patch as per your comments, do I need bump the
> patch version for it as well?

I don't think it matters too much in this case as I don't think I can
use b4 to assemble this series. So just for future reference on other
patch sets. That said, I wouldn't mind a link to your work-in-progress
branch to see all the changes together in one place.

[..]
> > I'd prefer this helper take a 'struct real_mode_header *rmh' as an
> > argument rather than assume a global variable.
>
> I am fine with it. But existing inline functions also directly read/writes
> the real_mode_header. So I just followed the same format.

I notice the SEV-ES code passes an @rmh variable around for this purpose.

[..]
> > If there is to be a comment here it should be to clarify why @tr_idt
> > is 10 bytes, not necessarily a quirk of the assembler.
>
> Got it. I will fix the comment or remove it.
>
> >
> >> +SYM_DATA_START_LOCAL(tr_idt)
> >
> > The .fill restriction is only for @size, not @repeat. So, what's wrong
> > with SYM_DATA_LOCAL(tr_idt, .fill 2, 5, 0)?
>
> Any reason to prefer above change over previous code ?

What I'm really after is capturing why this size needs to be adjusted
for future reference. Maybe it's plainly obvious to someone who has
worked with this code, but it was not immediately obvious to me.

>
> SYM_DATA_START_LOCAL(tr_idt)
>          .short  0
>          .quad   0
> SYM_DATA_END(tr_idt)

This format implies that tr_idt is reserving space for 2 distinct data
structure attributes of those sizes, can you just put those names here
as comments? Otherwise the .fill format is more compact.
