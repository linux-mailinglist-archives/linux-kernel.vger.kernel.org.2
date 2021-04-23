Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A785E3695E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhDWPQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhDWPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:16:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D847BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:15:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 10so25376400pfl.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/+Be0VUCv5FT9JYrmSUWSTyE9+VURZVMlH0ZOeX/wI4=;
        b=PG2/yBlJ1Cudu1hU0tZ66Dx1SUjOeat02OY1FpsuGjeTyR1LJrpyXlkBMXHICF1vn6
         kHymQLUYuP28XTtkE/38mQff6G8zNzfcfpVNq9JRDKU39EvUHHfLpftgqon0Nvb59Ibz
         cU1lXH6YZQ0c3Ol1EGOnuTeJkgpEkavIWuog2f41BZUOzVV4zJNUCgIL3rcp3uOZEQ2b
         JidO4keb5oLzkuv5hlO4twsatNNTXL/U+yGnAXky3fkSxm3ncd6VCS7Guy7BKJVazzYU
         r2WF5lbWeujgVKKRLh227Fic9NR4pbtXbn6qkbiVCKnyyovDi4PJMKZwyIEu7BXw0DbS
         pfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/+Be0VUCv5FT9JYrmSUWSTyE9+VURZVMlH0ZOeX/wI4=;
        b=dH25OrL5YbAIcIviw9wmFMiZ5WMah5fY8Bc7qegW0ZzSPcEome4wliidm4P1vs0nE5
         LDEiYnHZIxAKBIyJ4Wv08Pdn0v+QBqiCQsgfNB3y23hS32+exxZI1GoJDLNxgtgtkTQ0
         byQ683RgSa6kMXdnSdwk5L3Aw6ad+VEzQiQHS2Ml3gCqTRyFUKohd0/v8PBfvbiXxdfg
         SoHTCMz7TrqDCwElFpFPI4RKnCr+iEV/VbhdGFEU5/ZXPx6EXru81EEiK91++7dX9Sod
         OxllL4qQnXc2V0k0Yik6aXvhHzcIa1RpQDFYlw/aieMczArywK0bH+1BrnkKsjkKx88N
         M5Ew==
X-Gm-Message-State: AOAM531ITRZh5zMRJVzloIeGpafVmUcBKRod3iu9q2vZ6EWEBizbP4ob
        bFOe9AKCP1wbyfT5PRuJWaZlew==
X-Google-Smtp-Source: ABdhPJyZzRwVBJQvqfE+wERfK1eIznaBzr9npxU5gIYEvHgNEOuTmZDtXnJ8bAM7BiikuHR7P7AQzg==
X-Received: by 2002:a62:63c7:0:b029:251:4c9a:5744 with SMTP id x190-20020a6263c70000b02902514c9a5744mr4451562pfb.39.1619190940122;
        Fri, 23 Apr 2021 08:15:40 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id d4sm4515181pfv.76.2021.04.23.08.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:15:39 -0700 (PDT)
Date:   Fri, 23 Apr 2021 15:15:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
Message-ID: <YILkl3C4YjGPM5Jr@google.com>
References: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
 <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
 <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
 <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
 <d99941db-6ee6-267e-dece-6220af0ea305@intel.com>
 <9161efc0-fd25-d239-32b7-5d2c726579b0@linux.intel.com>
 <4ac4ed35-212b-f7ad-55f4-937946ffec1a@intel.com>
 <20210423013546.GK1401198@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210423013546.GK1401198@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021, Andi Kleen wrote:
> On Thu, Apr 22, 2021 at 06:21:07PM -0700, Dave Hansen wrote:
> > On 4/22/21 6:09 PM, Kuppuswamy, Sathyanarayanan wrote:
> > > But let me try to explain it here. What I meant by complication is,
> > > for in/out instruction, we use alternative_io() to substitute in/out
> > > instructions with tdg_in()/tdg_out() assembly calls. So we have to ensure
> > > that we don't corrupt registers or stack from the substituted instructions
> > > 
> > > If you check the implementation of tdg_in()/tdg_out(), you will notice
> > > that we have added code to preserve the caller registers. So, if we use
> > > C wrapper for this use case, there is a chance that it might mess
> > > the caller registers or stack.
> > > 
> > >     alternative_io("in" #bwl " %w2, %" #bw "0",            \
> > >             "call tdg_in" #bwl, X86_FEATURE_TDX_GUEST,    \

Has Intel "officially" switched to "tdg" as the acronym for TDX guest?  As much
as I dislike having to juggle "TDX host" vs "TDX guest" concepts, tdx_ vs tdg_
isn't any better IMO.  The latter looks an awful lot like a typo, grepping for
"tdx" to find relevant code will get fail (sometimes), and confusion seems
inevitable as keeping "TDX" out of guest code/comments/documentation will be
nigh impossible.

If we do decide to go with "tdg" for the guest stuff, then _all_ of the guest
stuff, file names included, should use tdg.  Maybe X86_FEATURE_TDX_GUEST could
be left as a breadcrumb for translating TDX->TDG.

> > >             "=a"(value), "d"(port))
> > 
> > Are you saying that calling C functions from inline assembly might
> > corrupt the stack or registers?  Are you suggesting that you simply
> 
> It's possible, but you would need to mark a lot more registers clobbered
> (the x86-64 ABI allows to clobber many registers)
> 
> I don't think the stack would be messed up, but there might be problems
> with writing the correct unwind information (which tends to be tricky)
> 
> Usually it's better to avoid it.

For me, the more important justification is that, if calling from alternative_io,
the input parameters will be in the wrong registers.  The OUT wrapper would be
especially gross as RAX (the value to write) isn't an input param, i.e. shifting
via "ignored" params wouldn't work.

But to Dave's point, that justfication needs to be in the changelog.
