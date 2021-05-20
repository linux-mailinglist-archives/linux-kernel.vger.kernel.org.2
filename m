Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B98389A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 02:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhETAlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 20:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETAlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 20:41:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21201C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 17:40:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id df21so17395450edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 17:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7hdQ08NMXQPE2R8gCfLb3tzaWK6Vw9lVNc9/LC5lL8=;
        b=RjwtgTvhrA09Rruw+hpBJG27mBkkV5f//9ZMBigPiYsynNoyUh2g0XidITlEwpZKFx
         QHqKdKfj07TPYtZRABCdupO/PsABGHGCH3jx9UaHbUHFHL5j9x4LrZgYHb9tbR7szF5F
         1eAACvNYKh1FfZdJ4BhAvRc5yPDOWnCFhye4KDH3VXkzq//D1pjO7QF7nBRIYFNM9U+a
         ASOxI94hmxDhgtWi7ye6xiQIQJFcUCxZTtaQwGSrY0sDnj9y1ea9TN1yL80zEJDa96sJ
         FkDo/l32vPFFMfAUFqqBqdtsRSOkGtr35EXU5GS4Yc8JPgam5tQiqJOQtwzjvv31q6X9
         kE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7hdQ08NMXQPE2R8gCfLb3tzaWK6Vw9lVNc9/LC5lL8=;
        b=isLqVEnOxckGvUUc+W0QXfupOkdPQ46in4cJl68Adt2wTLPjrN3eTfdm0ybds0WBsm
         YBdVvwLTqM3qZhx18Yvj/3VK3f1vASmAB21MevpCBaR6XxQfUGqsWytCV7E2W+4fn8JI
         Y4FstBYA7KkGq30SzDJgOHtr6o2nTZys1pQli5/Dnn/ZRt/y+cVzcLeSxzSjKVR6Cgx/
         3asYE4T6kvgfPkNkt5a/tAH8orcdObDi/Q8zDNVOyoaz7yCH7aia79fayRgUbURz2Auc
         A5dzQJChSW0rGbrN0KfAUaKqoq4PgNjmKFSdrnyk+uqUadZf1Y0jFGHKQ45l+F2GNSng
         eErg==
X-Gm-Message-State: AOAM533s9otFAjLIE4xPpxnPEqnD7KbsovrQrBbnxMVN/iQvKja1y/T6
        VFxRpstjl3WIPuCUldCliAoRiOqxmENBw3zHAvCy8Q==
X-Google-Smtp-Source: ABdhPJziTVGEsb3QvUuql4AfHJaNMfFDz2Xm2esKCV9yKRXoka6pEYAOtRFo38ZdLMXHvyD0AhqSGvjSjmSrVH3jgOg=
X-Received: by 2002:a50:ff13:: with SMTP id a19mr1943551edu.300.1621471214054;
 Wed, 19 May 2021 17:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4ipWTv7yRyLHA0Un0KZDdXjpCZXMbrEn7SJXbdRhhn=jA@mail.gmail.com>
 <20210518005404.258660-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4hvFe5v72zm5+4mpmsv1u4pEizXMCcjFysKZAEkkOSrGw@mail.gmail.com>
 <861a316c-09f6-5969-6238-e402fca917db@linux.intel.com> <CAPcyv4hv4brS7Vp4rjtnPvF5z7FDuEQkCp+sQ0q6FOxpnKCYCA@mail.gmail.com>
 <a92f339b-3e37-0988-06b0-d290c656dc52@linux.intel.com>
In-Reply-To: <a92f339b-3e37-0988-06b0-d290c656dc52@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 May 2021 17:40:03 -0700
Message-ID: <CAPcyv4hpn+fmeZT+=EiD0G0Hw1iYqhUh4_cdhnT1i-BBcN_tsQ@mail.gmail.com>
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

On Wed, May 19, 2021 at 5:19 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Dan,
>
> On 5/17/21 9:08 PM, Dan Williams wrote:
> >> SYM_DATA_START_LOCAL(tr_idt)
> >>           .short  0
> >>           .quad   0
> >> SYM_DATA_END(tr_idt)
> > This format implies that tr_idt is reserving space for 2 distinct data
> > structure attributes of those sizes, can you just put those names here
> > as comments? Otherwise the .fill format is more compact.
>
> Initially its 6 bytes (2 bytes for IDT limit, 4 bytes for 32 bit linear
> start address). This patch extends it by another 4 bytes for supporting
> 64 bit mode.
>
> 2 bytes IDT limit (.short)
> 8 bytes for 64 bit IDT start address (.quad)
>
> This info is included in commit log. But I will add comment here as you
> have mentioned.

Thanks. I only read commit logs when code comments fail.

>
> Will following comment log do ?
>
> /* Use 10 bytes for IDT (in 64 bit mode), 8 bytes for IDT start address
>     2 bytes for IDT limit size */

I would clarify how the boot code uses this:

"When a bootloader hands off to the kernel in 32-bit mode an IDT with
a 2-byte limit and 4-byte base is needed. When a boot loader hands off
to a kernel 64-bit mode the base address extends to 8-bytes. Reserve
enough space for either scenario."
