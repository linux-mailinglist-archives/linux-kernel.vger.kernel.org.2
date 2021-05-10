Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD2379A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhEJWyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhEJWyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:54:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49249C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:52:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h7so9889841plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9QxSMRHzlDhZ9U0+8yCtSZ7rUqQVkksbcCRH1G1XZHM=;
        b=l98RuRFF2h71cEBdSp9Tg23S0PuVkeCdjghVUNvN3lb+sEhhwwxxfBqDu1EbHNzGTO
         W4g4oYqJD77Kvi49VoW2a50GgQLOS2bzm/xSawKq+eQ5qnae1g1oNOU2obGs2BGrkoLy
         jVvi1knsiMy837piVMY1jZisVWdSyG7u5Z0QOPF7OnS/k7CLOZryHh9J7+3o4EGQpi0O
         YYO9GtB8rvopB1UkH3zNruTZXucad8RyzxzHqcetqpqSNvNIIunaf6zWQ+fp0LjVaJHw
         Oxa7BxLVMLq16EVW6XVb0/iLG25XuxwRMv/5APE+D+N7m6zkDaW7Np56HGDIngXt13/O
         vU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9QxSMRHzlDhZ9U0+8yCtSZ7rUqQVkksbcCRH1G1XZHM=;
        b=C/7dWfJjwiR1NfuKvKK0pSjzNV4bJGgK8Aj+AILtobSw5LdNuP1m2yq3fpi55v131a
         xx+La7Jz+L7sZWtMBB3+fCS1txD7xmcrh2ebytV8mzLTdsKGgpf4vIhGvd080Xeayv5y
         YiTq4aJglPT8r9b8PNumKepCyK34mHhhreTVeVe/LxcB1Ns3wT0I3K5/QXXTn0KEXyJZ
         hMNEYKW+/xCaiOly43aGoGVaskxeYQKw7b/5P+unrH8pYF72UuTa8yXJ+YJbzJm14Lpu
         N6msChTr+q0vmCA9qqYK4XyMoSqbCjTAmkQW5Sgr31d8kmXc7ooBxUAByvQ4M9OcbK1v
         JiOg==
X-Gm-Message-State: AOAM533Ho/gKDp0r6f3/zAenv8iH9DOM0Sa41bfRWX5L0GtERdNtZ2eY
        ranqQu0u/UV9sWEgh+bjX+5bQQ==
X-Google-Smtp-Source: ABdhPJw1hU0q5No8fkRrif/z5O2M2dEsdBAKnI/tlL/DSZJn/eH5wQuDYEeTGede/Hw3c9PeBNetqA==
X-Received: by 2002:a17:90b:4b45:: with SMTP id mi5mr1639408pjb.197.1620687173578;
        Mon, 10 May 2021 15:52:53 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id a185sm11916519pfd.70.2021.05.10.15.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 15:52:52 -0700 (PDT)
Date:   Mon, 10 May 2021 22:52:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
Message-ID: <YJm5QY8omAvdpBO9@google.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
 <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
 <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Boris, who has similar opinions on sev_active().

On Mon, May 10, 2021, Dave Hansen wrote:
> On 5/10/21 3:23 PM, Kuppuswamy, Sathyanarayanan wrote:
> >>>>
> >>>> -    if (!sev_active())
> >>>> +    if (!sev_active() && !is_tdx_guest())
> >>>>           return 0;
> >>> I think it's time to come up with a real name for all of the code that's
> >>> under: (sev_active() || is_tdx_guest()).
> >>>
> >>> "encrypted" isn't it, for sure.
> >>
> >> I called it protected_guest() in some other patches.
> > 
> > If you are also fine with above mentioned function name, I can include it
> > in this series. Since we have many use cases of above condition, it will
> > be useful define it as helper function.
> 
> FWIW, I think sev_active() has a horrible name.  Shouldn't that be
> "is_sev_guest()"?  "sev_active()" could be read as "I'm a SEV host" or
> "I'm a SEV guest" and "SEV is active".

I can't find the thread offhand, but Boris proposed something along the lines of
cpu_has(), but specific to a given flavor of protected guest.  IIRC, it was
sev_guest_has(SEV_ES) or something like that.

I 100% agree that we should have actual feature bits somewhere for the various
protected guest flavors.

> protected_guest() seems fine to cover both, despite the horrid SEV
> naming.  It'll actually be nice to banish it from appearing in many of
> its uses. :)
