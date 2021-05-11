Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C037AB01
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhEKPpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhEKPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:45:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CB1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:44:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f24so30466331ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+izgIxCefJB4G4VdFMpn06wW/mU/26rnT9TPpicrH4=;
        b=WcK2Te/+yNhv2y/wmAZmVq+IdBcJiYzMSnW3QybM5DPuWIau+5AAp72JfNVgsiVjxA
         oDrPIvSoQwNSgiJKA3Zv2UlumK9gEoDuINsWqd/vlbpOS4jD/HPVmsdWhI6MHBpK+MA8
         sYEPMq1Xg5pk/eP/WeeLLu73ALNCxH2+gJGKvmqGb119yjz7SV7xlCyrou/WPaw15YIR
         hyMoYqRyW1isSjZJmTfQSasXeLfcwmOLJl/iD3+nbftnhdw4k7OGhNgHYoH+m2/ewbyF
         2zUENTTaqovSAwfq6j2WG/uH12oFCPLD/pp1CBcpC0yT97xNOIe+gziCMqkFIco5jViU
         kEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+izgIxCefJB4G4VdFMpn06wW/mU/26rnT9TPpicrH4=;
        b=OIwIfbB5FRXtMmyyA12U9JWmZRhYKNcC3QVCqhTtNmCxtpqzqHZLiiAV6ci+7Ruu01
         KUknNXEKqA7/JjuWY4DJ0Mry1aUJY1rRUEdjRKgNDKZCgGqfP4MYutPbMKN2Yo0FaiRC
         QFO8291w7q1ei0gd5R5cHSndAl7HZ1FimWi1OBgYa30JnQAeT8RRszTCDVbqvrE3savj
         k9Cv21Z1tdth+4qd0etFgdH6OZvbOkRZBOSvX/2UfYr2q2v45OGwfIBrBH6Y1yujKCI6
         9ORJj5lM2KbELwogOn4Q0gJ6LpN7FFHpbQ42n7DIfX7bSWCgUpOAPwHFuO3WBuN8w3Us
         99pA==
X-Gm-Message-State: AOAM532AwESjs/vd5+5F1ZnrHN4O7ixlBZ61HtCQeyihoGQsVpIM2YBB
        lkc6QVusveZDTx7F3s2K08c0FnwZNzV2Pypm1I07EA==
X-Google-Smtp-Source: ABdhPJwkaD5DAxWiSGDZCYOcy3RNAX0/xxBEBlOhS7rCwlAaWTBCbh9b0QkPlIJqaAq/209AUzWgwhTBwxthrqK00CE=
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr32692130ejy.323.1620747849976;
 Tue, 11 May 2021 08:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com> <6ea92e98-a243-ef7c-4263-bafb8946feef@intel.com>
In-Reply-To: <6ea92e98-a243-ef7c-4263-bafb8946feef@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 May 2021 08:43:59 -0700
Message-ID: <CAPcyv4hiSiW8V2G70UpmYiN1DHJ1jXz98-5Wp=s5TMPBgC5dNA@mail.gmail.com>
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
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

On Tue, May 11, 2021 at 8:36 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/10/21 2:57 PM, Dan Williams wrote:
> >> Decompression code uses port IO for earlyprintk. We must use
> >> paravirt calls there too if we want to allow earlyprintk.
> > What is the tradeoff between teaching the decompression code to handle
> > #VE (the implied assumption) vs teaching it to avoid #VE with direct
> > TDVMCALLs (the chosen direction)?
>
> To me, the tradeoff is not just "teaching" the code to handle a #VE, but
> ensuring that the entire architecture works.
>
> Intentionally invoking a #VE is like making a function call that *MIGHT*
> recurse on itself.  Sure, you can try to come up with a story about
> bounding the recursion.  But, I don't see any semblance of that in this
> series.
>
> Exception-based recursion is really nasty because it's implicit, not
> explicit.  That's why I'm advocating for a design where the kernel never
> intentionally causes a #VE: it never intentionally recurses without bounds.

Thanks Dave, this really helps.
