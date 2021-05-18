Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251FB387D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350595AbhERQY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbhERQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:24:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55DCC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:23:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b7so1222313plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q4D2XFgEAj1BhNrNo2lFSglWPsdouq2uNHG7Lv+ctok=;
        b=Z6s3NnonKJEwf5rrQDiDmxH3c6liP3P7W2F76e6nLdTjFeWDS74JBATG/hLMzhfvZA
         KUdNOaXBnb0f3GU24iOJq8lNssvD4ZBF0dmrQ0b4Kh/XHg5cEg/kkGdaLm902m7Cq5GA
         mO81+pu0x7SBI7kEeLQuFjYFfVEL+YslU2994myUTZGGCeHe2mkkocqqieOu7Fc9rQ1z
         Y7ynA2hykse41yLsmrttyu5ffI+Mdb97XWavCfuZGf77cjUp9Zi5UKsyLh/4WqR8sSOF
         tetOCWbCnwfnSEQp9ezW8lGGxrEz33uhjg86i5qN+KM4gYiDcojF5pa0mGZn7HVgyc8X
         kEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q4D2XFgEAj1BhNrNo2lFSglWPsdouq2uNHG7Lv+ctok=;
        b=QJb6XiXn12TcFW54nX7oj0B5xvdpFPBwCw8wOL71cnQtcGW1rU9O15RJ8Wjle7Yegt
         pfTxCJ2OFInVEHmBipgMwPSYZbGVML/l/QlXqHOSabomGOFyMzbXvEu/vAlNggMgFcPT
         sAopp+4u8KQyzj4FnuSvE4bwGjrxnqqoTz1Ll0LJ0lcN0ukMWYw+UNMcpNuh2ukXVR6w
         ijuK2kGu6Wehrbl+Gg0Vj/BHEE1es/ajUS3qt9xenttEahiYkBa6l9iGZPbE6bqmI91s
         XRJW2+C1O5cs5g80Nl0l9jwUmJD36m+NX5CvcrhHexYIMkjGw+sKOz80nE8oeUK/HhNM
         K8+g==
X-Gm-Message-State: AOAM533abnop3hROEXCKOiFxzBxDj9mm3j0oN4VhVfvPoj2tZiSavxBF
        8tM5wtqvB9HTSqkyaUpqNFygUA==
X-Google-Smtp-Source: ABdhPJw/1djl7Vba2/JVPpZFYLh9GNSpJ87x5rMxb0SZx931psP16/c+EHnp3H9O4GEF/mLfRvaT8g==
X-Received: by 2002:a17:90a:2:: with SMTP id 2mr5982777pja.107.1621354987057;
        Tue, 18 May 2021 09:23:07 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 15sm13512580pjt.17.2021.05.18.09.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 09:23:06 -0700 (PDT)
Date:   Tue, 18 May 2021 16:23:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Wire up KVM hypercalls
Message-ID: <YKPp5gNtCgWo0khu@google.com>
References: <2a4e9702-5407-aa95-be9b-864775bbaabd@intel.com>
 <20210518001551.258126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f9bbc6b2-c7ac-3f36-08e3-9c4da68a6a9d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9bbc6b2-c7ac-3f36-08e3-9c4da68a6a9d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Dave Hansen wrote:
> Question for KVM folks: Should all of these guest patches say:
> "x86/tdx/guest:" or something?

x86/tdx is fine.  The KVM convention is to use "KVM: xxx:" for KVM host code and
"x86/kvm" for KVM guest code.  E.g. for KVM TDX host code, the subjects will be
"KVM: x86:", "KVM: VMX:" or "KVM: TDX:".

The one I really don't like is using "tdg_" as the acronym for guest functions.
I find that really confusion and grep-unfriendly.
