Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65BC38F71E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhEYAzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEYAz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:55:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA758C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:54:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so12172119pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGkRv9yt4yQZsP5k0LjgF1wcy+P5ou/XUA10T9ay/dI=;
        b=HOJKpvUelzMeyzM0Y7R1P6kJJ1LVfiselgEVFOX0sLJMLh27ofHsnpaq9g9gJzBT1a
         kWbj6FN0MyNI1Feh8gRJdorN+PYKDH749CiWcVrysJ6HiWNVxC1YK3ep9D5bzPuXSQTI
         ouOlFs45ypBttxlLNeXLBNASCiNsviT733bQx3QHM3KoU1MfgNLioT+fN5+I04i3huOc
         wJnLw3rOoicl2T2As+T6RwwFfDMXjOC87txXy+beBWjHQbdEvMjhqJSSTOtMi+QsagTU
         nultREn2MpKUxncZArHeS+iEKdOngWZXsvaswSCUg5pSytezBDayNVpylI209KzH7mDg
         QaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGkRv9yt4yQZsP5k0LjgF1wcy+P5ou/XUA10T9ay/dI=;
        b=EzvWFIegdZYOoPGu99Ho/pdzt9qU0KBu8+dGi3xVjElkJTvAXDG0DmLwzUrril5fF4
         D3enWrG/QDJRoVfR2v/rfkHBdF9c1npcWFALpF1x66talDk1b7+HvUXQA0uugcXbaDGR
         XxCnlaB8+CFphKv3ROorQa49slSH3Hn70Kb2HtOLpCx3Ii4JbhqaR7Bb7fHmpFJttavI
         MY36IEo4+dDN07UkHGMEuJ5/CGgNn1rbwo6o3OYdBpH53Gfqg61VKcxRdc0yNTwVr0j6
         8Hc4xVORswY/Ugj5U4b7s/xcEvsFLY7BS/rSEIIMILKkzgNKi8Yq8eOnNYNxjyt9rC8T
         73NQ==
X-Gm-Message-State: AOAM530l653t9mfudl5hfQnWWKF0pDf7gQCAPr4cnfr1EopTyy3LAAk1
        YDdl44Sim6TJt0YpNwCqd67TGj/Klbxzlhb0sDIDTw==
X-Google-Smtp-Source: ABdhPJz4tqvDyFRaLHpRHdi9PERzCEaLPjuqrRa8/00nS013y8C9zr0FRAQ0+EJbj4x2ujtiC9ZUCc6NJZ/MYBI9aEI=
X-Received: by 2002:a17:90b:3709:: with SMTP id mg9mr1896972pjb.149.1621904040591;
 Mon, 24 May 2021 17:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <6d336ac9-72ad-aae5-0b4c-f30a695d198b@intel.com> <76dcb466-225b-760b-525b-6aa8f5c8aae8@linux.intel.com>
In-Reply-To: <76dcb466-225b-760b-525b-6aa8f5c8aae8@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 May 2021 17:53:54 -0700
Message-ID: <CAPcyv4hz9WFKbEymPHfMpZSi0RGn9rEv5eAx2Y+9EsfXTdv3YQ@mail.gmail.com>
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX guest
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
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

On Mon, May 24, 2021 at 5:40 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 5/24/2021 4:42 PM, Dave Hansen wrote:
> > On 5/24/21 4:32 PM, Kuppuswamy Sathyanarayanan wrote:
> >> Functionally only DMA devices can notice a side effect from
> >> WBINVD's cache flushing.
> > This seems to be trying to make some kind of case that the only visible
> > effects from WBINVD are for DMA devices.  That's flat out wrong.  It
> > might be arguable that none of the other cases exist in a TDX guest, but
> > it doesn't excuse making such a broad statement without qualification.
>
> We're describing a few sentences down that guests run with EPT
> IgnorePAT=1, which is the qualification.
>
> >
> > Just grep in the kernel for a bunch of reasons this is wrong.
> >
> > Where did this come from?
>
> Again the logic is very simple: TDX guest code is (mostly) about
> replacing KVM code with in kernel code, so we're just doing the same as
> KVM. You cannot get any more proven than that.
>

I have no problem pointing at KVM as to why the risk is mitigated, but
I do have a problem with misrepresenting the scope of the risk.
