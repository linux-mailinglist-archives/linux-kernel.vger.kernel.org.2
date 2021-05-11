Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378FC379B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEKAWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhEKAWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:22:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0EEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:21:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n25so20782369edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmqQHamBWKF2KK1CSpJZAYhmnOwKSYe9EM0AwwcGsyc=;
        b=rN2e1ATHqRN75z5KQ+yHv/lMXSNSgx9nBUQuRsS8KrRtB4hZvYgr1KctWg9kzwkxJ6
         XMi6NUtDBSCgxCvElvZ8bJ/EJgDE6MZnalHOCZz3H/QvBR87SMiKA3gQ2bjEuK7Kb5kd
         7Vslgwzq6u/pFxFtfZKGxHWvwPzc5pAXpuqbgCQ4ZDhjrK0qLZDvIdXbb6LaDcwka8sl
         DUSvpQQYFaGrhzNX2rsrhZyI189Mk5VpL7gFse2gkC2+IfKihWlovslP/dWlJwAGaR+j
         bQ1RedCTvDeNB0oTQgwzQWlpiwLwrQYjZUHmiQQ5pxx9733C2gJxjvhAsGKTbOeu7qAq
         GeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmqQHamBWKF2KK1CSpJZAYhmnOwKSYe9EM0AwwcGsyc=;
        b=hRYhakoyjbGGNZgLscTc7H1etf7BxI2XdgMcaT0ZLRbL5vXSuvM9XKUuciVhL7ir+j
         WKoYZUDHsLMMlvaahdgNDLSxr2de6l9D9Z8eRWZrf8DZzmkHCQ9xon16HK37kuZtEmbX
         9t0IxRmwdID9avrzH+8Q2f2E+e8hEapo60DBBrxuqy8gE57FhKbRxvRzwazSLvR40JTB
         9yYwQ3WttwopFli0gJRjpLvueuzTEGhVWdBR2brxKXy2ie8YoMAW0fLiiSaGJ3RhT1JM
         4SDSk34g/wJwrorGuJjk69utKEnrHmA81dN5OK8SaSkZ3DmLjYKMYJRw/IrvpLdpxsmA
         a7ag==
X-Gm-Message-State: AOAM533Rnlr6agJgnTx+rWmGW5g/xyxgLLhwNe0yUIVnCjgQPWJ2eaJB
        ZKMQ5CqMTMK7fy1LxOlv6IDH9/x2zKD/sOZZDpwtYQ==
X-Google-Smtp-Source: ABdhPJwS7EtgNJHngxx1EHLzt1kz+EzplmNMev1g9f9ZrSMG3CVqqfmX+TKi9L5fHB1rNgT1QSOAg8lHigumlhf5q58=
X-Received: by 2002:a05:6402:54e:: with SMTP id i14mr33637872edx.210.1620692486832;
 Mon, 10 May 2021 17:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com>
 <e8ac31bc-e307-f277-f928-24ebba4cbca7@linux.intel.com> <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
 <20210511000119.GV4032392@tassilo.jf.intel.com>
In-Reply-To: <20210511000119.GV4032392@tassilo.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 May 2021 17:21:16 -0700
Message-ID: <CAPcyv4iwaUmiL-qwxvTxyKatxD+uFza8fvkFQxokHBy=a9=p4A@mail.gmail.com>
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 5:01 PM Andi Kleen <ak@lin
[..]
> > I.e. shouldn't port-io instruction escapes
> > that would cause #VE be precluded at build-time?
>
> You mean in objtool? That would seem like overkill for a more theoretical
> problem.

Oh, sorry, no, I was not implying objtool overkill, just that the
mainline kernel should not be surprised by spurious instruction usage.
