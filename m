Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A723D3EA920
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhHLRIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhHLRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:08:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7FFC0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:07:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bo18so10848804pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+qe7wnSyDP1IF8/0YQYj7hTk8QlP3hds+nTskAOF9Qg=;
        b=nXE55jt06ZOBG8C/chZclAPd0rwd23DPfklsIsmP9Xl8Zw1EVH09h3dn5n535cbXhO
         4VddY8JBscTrcz5XDj76dc0I57BsZdOLP00ZYxQ9zyQBHFzkD3FlsgFlhCxSarezrDIm
         asruQUUp/3d1gqxAbx2YnMjM9Gn5HRflZX3GkPHvOHEwsYIXatoCvdAumGegonUEsAsi
         2XBfjV2plsV/AVCjkugRceCq3x8DP6DLLJwbQRJf3N5nThjPotkczmCA6Q98zM/rAKth
         cIEAdMcZzTfK7DBjVjS/4QEp5SFBaURqQwsIeTzM+vmOfwnIf31rQaSfj1BNABo6kHrh
         jABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qe7wnSyDP1IF8/0YQYj7hTk8QlP3hds+nTskAOF9Qg=;
        b=VZnC7BclhdmYYzNdmRTySL2brNimmlMzYXt5JG7Cchyg+qqM/4kbeSTF18/CSQZJGu
         BxZvRNBl8TfPXizmql7MQ2DyvcoW7Q0TymiEanopv+2f9lc0ePwX4crAbIgh63ErAj4q
         qPzUYShu4z93BuoZmqow363uw7122uDsQqhqxWn/A5U0o1w/W81y2pC7jEcZr3atMCcj
         K5nbe0XCZrHNLR5gbnpaMwmdM9GEF5Ro7MDnx1NazwUZdTRYUfiHQzMaGlngBXeq9dw+
         TdH3wwloqbIK+Jnl7kvEoSGFJ6PrgA8bm2wtm/2lF/zxRVfEloNTvHMm+kPIPL1joxs7
         Vo5Q==
X-Gm-Message-State: AOAM532x3smPo/ORsFVG6zehMxGkmpOluEjPLzGtTuhKXotr6iXBSyAp
        R1dB1WwR9DVsd7l9aVoRQORKuQ==
X-Google-Smtp-Source: ABdhPJzcVBJHR9euoTFAVn+N5cE2LB2Gk/qrmMip5e9x7282WZlEE9/3KKC5/2O4iWS3txTAVhEOXg==
X-Received: by 2002:a05:6a00:1884:b029:3bb:640f:4cfc with SMTP id x4-20020a056a001884b02903bb640f4cfcmr5123498pfh.61.1628788062508;
        Thu, 12 Aug 2021 10:07:42 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o22sm3921627pfu.87.2021.08.12.10.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 10:07:41 -0700 (PDT)
Date:   Thu, 12 Aug 2021 17:07:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Don't step down in the TDP iterator
 when zapping all SPTEs
Message-ID: <YRVVWC31fuZiw9tT@google.com>
References: <20210812050717.3176478-1-seanjc@google.com>
 <20210812050717.3176478-3-seanjc@google.com>
 <CANgfPd8HSYZbqmi21XQ=XeMCndXJ0+Ld0eZNKPWLa1fKtutiBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd8HSYZbqmi21XQ=XeMCndXJ0+Ld0eZNKPWLa1fKtutiBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021, Ben Gardon wrote:
> On Wed, Aug 11, 2021 at 10:07 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > Set the min_level for the TDP iterator at the root level when zapping all
> > SPTEs so that the _iterator_ only processes top-level SPTEs.  Zapping a
> > non-leaf SPTE will recursively zap all its children, thus there is no
> > need for the iterator to attempt to step down.  This avoids rereading all
> > the top-level SPTEs after they are zapped by causing try_step_down() to
> > short-circuit.
> >
> > Cc: Ben Gardon <bgardon@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> This change looks functionally correct, but I'm not sure it's worth
> adding more code special cased on zap-all for what seems like a small
> performance improvement in a context which shouldn't be particularly
> performance sensitive.

Yeah, I was/am on the fence too, I almost included a blurb in the cover letter
saying as much.  I'll do that for v2 and let Paolo decide.

Thanks!

> Change is a correct optimization though and it's not much extra code,
> so I'm happy to give a:
> Reviewed-by: Ben Gardon <bgardon@google.com>
