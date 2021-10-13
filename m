Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0274342CD90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhJMWMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhJMWMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:12:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C9C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:10:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 66so3631443pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ueFCf5T8Bg/YvAT2Irg4dCLqPcpMWw3L37AGd4LH77U=;
        b=ddB5dJguEn3AgeR8395if1R9x3C4WiiCEHEcLvuAwFd69ToBSZMQrYK0rFuAgGH7jj
         LxbackalERaHCzi17YPTTva5EdkoIy7y9odkfcQr2WlqoErVDYKZBlYyO0aBnL6OPstJ
         ECTcb3yW3fVsFehOqRy1jlToBYF4XsvOcOhE2jCsUPTkarAINfPRKHvfSmMdK4ZnKrlj
         f/0ju2P1R77N0Wra6jhyEzuEXawq+KKPUyUMT0wAzYCRoW4LkNETvrEJnSKmWjTIPdMM
         4pKa0/D2MvpqkkbL4VgY8slUh+VCAla+m5bvZXO9ZQV6N4/IRLRTTWPs3Ml170oSPN2z
         RFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ueFCf5T8Bg/YvAT2Irg4dCLqPcpMWw3L37AGd4LH77U=;
        b=6iLv3nZP6NrBhzf20VqQz7a/sK7rajvXgO7xxGiFSUn9nKsAfx5xLd7qUIAP9N+1VP
         yDlEL1rnLBsnDy8mSbNQIz5zPkP0KyJoeZm5yzb8LWKDDG/6EtReouVD9mtcso+mnlgB
         Fbbt6DwwRxSH3e9b7n3jjkgEiZ9N98i6nYJjI9IvuJmtqs2MApNAAOJqpVRzljzr9puq
         oJoN7EDB+YX7v+wB4Yji1mFJ/R67f7IdhMEs/nmsXMv6D/jj+5hI50/RsJ8j3sLKLDPV
         xitRFywZ+1Ua3LoHNpaF3+T+0US8E827o6C46lEy233n8OKsYCWrTyt74+wfk5IDuM9s
         Bsjw==
X-Gm-Message-State: AOAM533Hc76HTY0ztoi5Vt544c+yolIX1z02EzIjD2rtR1Oo7BCWFqAq
        s/gx7FHrWGM+90Q16eFTZVaIAA==
X-Google-Smtp-Source: ABdhPJyOsn/Qy+slP5sYwji6knnMfIk70CbncfyHR8vuoYubpw8pbf8X2wfltlhjNumK/GzkJzAi7Q==
X-Received: by 2002:a62:3102:0:b0:44b:63db:fc88 with SMTP id x2-20020a623102000000b0044b63dbfc88mr1856516pfx.75.1634163031545;
        Wed, 13 Oct 2021 15:10:31 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z68sm445168pgz.90.2021.10.13.15.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:10:30 -0700 (PDT)
Date:   Wed, 13 Oct 2021 22:10:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part2 v5 39/45] KVM: SVM: Introduce ops for the post gfn
 map and unmap
Message-ID: <YWdZUrpn5/JCz39R@google.com>
References: <20210820155918.7518-1-brijesh.singh@amd.com>
 <20210820155918.7518-40-brijesh.singh@amd.com>
 <YWYm/Gw8PbaAKBF0@google.com>
 <94128da2-c9f7-d990-2508-5a56f6cf16e7@amd.com>
 <YWc9KL8gghEiI48h@google.com>
 <a7a541ba-129a-1083-3517-c30e9f9cd7c7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a541ba-129a-1083-3517-c30e9f9cd7c7@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021, Brijesh Singh wrote:
> 
> On 10/13/21 1:10 PM, Sean Christopherson wrote:
> > Side topic, what do you think about s/assigned/private for the "public" APIs, as
> > suggested/implied above?  I actually like the terminology when talking specifically
> > about the RMP, but it doesn't fit the abstractions that tend to be used when talking
> > about these things in other contexts, e.g. in KVM.
> 
> I can float the idea to see if docs folks is okay with the changes but
> generally speaking we all have been referring the assigned == private in
> the Linux SNP support patch.

Oh, I wasn't suggesting anything remotely close to an "official" change, it was
purely a suggestion for the host-side patches.  It might even be unique to this
one helper.
