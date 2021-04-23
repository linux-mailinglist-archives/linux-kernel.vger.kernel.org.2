Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CED36962A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhDWP3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhDWP33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:29:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD95C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:28:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mh2so52906644ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sr6A7l2GWikEQ1JwQseVp4B3pRaoy23y5rVwAdarryM=;
        b=DafoGvqFkaI7NAtS8gAXr8lReGi2dzdBo4FpiO+nzR1dKLIdVD0MnbtIMeHhzh/YVY
         aLPxYoueKZvVYue+QJXZprxuQLc+RBhDzoFw19DUOFHIBvreowxD88j6np2NrzhR4Ox7
         6rySVqI2tbF+Eg07Hy1Ub7UfXxqu3MaoK6mO41sGH5PA4kPlPBObX6h/Vz31032+S+1M
         VHlPzxrdmRFt/gI6QldMT5R6jqr4u3W4SNXPwwOZNr1E+ViydPmGtdksbgVdr5qgApZw
         /he+O8BRfLhpXcLjkF1BE/lv/HfA/VBUrQLQm3QV+45BcdFnOS1voRAB0pKUDA2CYOEC
         p06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sr6A7l2GWikEQ1JwQseVp4B3pRaoy23y5rVwAdarryM=;
        b=HqdFgb8vx57WSAInpm9OGKR5CORaPu73Q7hXeThp8qIq6CInRiAmdg6fCFKffHCftJ
         hmJ0SMJ346pQfEioXaf7IeINmFnzJqGmEdrzELbZj2SD/+aYiYAsnJAUzXu3k29F19tq
         Pz8+64HDSMhFcb0hTsb/QEK3MhcRifl0KJukpbJhx61a8ODCHryaFlmMTjOpY+0UM22M
         i7U9noUKOgK4cEBOEmnXziFTBSl8jQr6IvnaRO2G+LJbTTrfHVHXqOfTCVJHHc3eqV6y
         0bXbZHYJEcyHn1fOKzvtUFl9bP6TFyZjjhFyOVPVIRa7cqJ9IMdWgJBFyJBC6OYEzz+5
         FOjg==
X-Gm-Message-State: AOAM530ts2w7z05Rx/5YxPxkmSZp23ChvO8cW4hDebgO0vhxpF5bp1o6
        8K5glH2L3bq3/4BPcKIDjIuCk+s977VJS8hyrNepnw/f9bo=
X-Google-Smtp-Source: ABdhPJxH9XWYsZMTJ94qfaM2sWjCxmqvWWUGIXdAtIt0WRVHxjC+soqb7qy8HDa8cQ88S6WAS/y82beb19rmR5BMFbA=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr4848899ejc.418.1619191731238;
 Fri, 23 Apr 2021 08:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
 <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com> <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com> <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
 <d99941db-6ee6-267e-dece-6220af0ea305@intel.com> <9161efc0-fd25-d239-32b7-5d2c726579b0@linux.intel.com>
 <4ac4ed35-212b-f7ad-55f4-937946ffec1a@intel.com> <20210423013546.GK1401198@tassilo.jf.intel.com>
 <YILkl3C4YjGPM5Jr@google.com>
In-Reply-To: <YILkl3C4YjGPM5Jr@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 23 Apr 2021 08:28:45 -0700
Message-ID: <CAPcyv4gwDeLzG98CegHQs8AAAdctD4vLrAzncu=ciVMyBSDxAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper functions
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 8:15 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Apr 22, 2021, Andi Kleen wrote:
> > On Thu, Apr 22, 2021 at 06:21:07PM -0700, Dave Hansen wrote:
> > > On 4/22/21 6:09 PM, Kuppuswamy, Sathyanarayanan wrote:
> > > > But let me try to explain it here. What I meant by complication is,
> > > > for in/out instruction, we use alternative_io() to substitute in/out
> > > > instructions with tdg_in()/tdg_out() assembly calls. So we have to ensure
> > > > that we don't corrupt registers or stack from the substituted instructions
> > > >
> > > > If you check the implementation of tdg_in()/tdg_out(), you will notice
> > > > that we have added code to preserve the caller registers. So, if we use
> > > > C wrapper for this use case, there is a chance that it might mess
> > > > the caller registers or stack.
> > > >
> > > >     alternative_io("in" #bwl " %w2, %" #bw "0",            \
> > > >             "call tdg_in" #bwl, X86_FEATURE_TDX_GUEST,    \
>
> Has Intel "officially" switched to "tdg" as the acronym for TDX guest?  As much
> as I dislike having to juggle "TDX host" vs "TDX guest" concepts, tdx_ vs tdg_
> isn't any better IMO.  The latter looks an awful lot like a typo, grepping for
> "tdx" to find relevant code will get fail (sometimes), and confusion seems
> inevitable as keeping "TDX" out of guest code/comments/documentation will be
> nigh impossible.
>
> If we do decide to go with "tdg" for the guest stuff, then _all_ of the guest
> stuff, file names included, should use tdg.  Maybe X86_FEATURE_TDX_GUEST could
> be left as a breadcrumb for translating TDX->TDG.
>
> > > >             "=a"(value), "d"(port))
> > >
> > > Are you saying that calling C functions from inline assembly might
> > > corrupt the stack or registers?  Are you suggesting that you simply
> >
> > It's possible, but you would need to mark a lot more registers clobbered
> > (the x86-64 ABI allows to clobber many registers)
> >
> > I don't think the stack would be messed up, but there might be problems
> > with writing the correct unwind information (which tends to be tricky)
> >
> > Usually it's better to avoid it.
>
> For me, the more important justification is that, if calling from alternative_io,
> the input parameters will be in the wrong registers.  The OUT wrapper would be
> especially gross as RAX (the value to write) isn't an input param, i.e. shifting
> via "ignored" params wouldn't work.
>
> But to Dave's point, that justfication needs to be in the changelog.

It's not clear to me that in()/out() need to be inline asm with an
alternative vs out-of-line function calls with a static branch?
